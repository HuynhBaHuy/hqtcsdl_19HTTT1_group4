const sql = require("mssql");

module.exports.loadOrders = () => {
    return new Promise((resolve, reject) => {
        // create Request object
        const request = new sql.Request();
        const query = "SELECT dh.MaDH as id, kh.TenKH as customerName, CONCAT(dh.TenDuong, ',', kv.Quan, ',', kv.Tinh) as address, dh.TongPhiSP as totalPrice, dh.TinhTrangDH as status FROM DON_HANG dh JOIN KHACH_HANG kh ON(dh.MaKH = kh.MaKH) JOIN KHU_VUC kv ON(dh.MaKV = kv.MaKV)"
        // query to the database and get the records
        request.query(query, function (err, recordset) {
            if (err) {
                reject(err)
                sql.close();
            }
            else {
                // send records as a response
                resolve(recordset.recordset);
            }
        });
    });
}

// list Order by region for specified driver
exports.listOrderByRegion = function(driverId){
    return new Promise(function (resolve, reject) {
        // create Request object
        const request = new sql.Request();
        const query = `SELECT dh.MaDH as id, kh.TenKH as customerName, CONCAT(dh.TenDuong, N', quận ', kv.Quan, ', ', kv.Tinh) as address, dh.TongPhiSP as totalPrice, dh.TinhTrangDH as status FROM DON_HANG dh JOIN KHU_VUC kv ON(dh.MaKV = kv.MaKV) JOIN KHACH_HANG kh ON(dh.MaKH = kh.MaKH) JOIN TAI_XE tx ON(kv.MaKV = tx.MaKV) WHERE tx.MaTX = ${driverId} AND dh.TinhTrangDH LIKE  N'Nhập kho quận ' + kv.Quan + ', ' + kv.Tinh`
        // query to the database and get the records
        request.query(query, function (err, recordset) {
            if (err) {
                reject(err)
                sql.close();
            }
            else {
                // send records as a response
                resolve(recordset.recordset);
            }
        });
    })
}

// list delivering order of specified driver
exports.listDeliveringOrder = function(driverId){
    return new Promise(function (resolve, reject) {
        // create Request object
        const request = new sql.Request();
        const query = `SELECT dh.MaDH as id, kh.TenKH as customerName, CONCAT(dh.TenDuong, N', quận ', kv.Quan, ', ', kv.Tinh) as address, dh.TongPhiSP as totalPrice, dh.TinhTrangDH as status FROM DON_HANG dh JOIN KHU_VUC kv ON(dh.MaKV = kv.MaKV) JOIN KHACH_HANG kh ON(dh.MaKH = kh.MaKH) JOIN GIAO_HANG gh ON(dh.MaDH = gh.MaDH) WHERE gh.MaTX = ${driverId}`
        // query to the database and get the records
        request.query(query, function (err, recordset) {
            if (err) {
                reject(err)
                sql.close();
            }
            else {
                // send records as a response
                resolve(recordset.recordset);
            }
        });
    })
}

// accept order
exports.acceptOrder = function (formData){
    return new Promise(async (resolve, reject) => {
        try {
            let spName = 'sp_deadlock_tc1_T2';

            if(formData.spFixed)
                spName += '_fixed'
            else
                spName += '_error'
            
            let results =  new sql.Request();
            results.input('madh', sql.VarChar(20), formData.orderId)
            results.input('ttdh', sql.NVarChar(50), formData.orderStatus)
            results.input('matx',sql.VarChar(20),formData.driverId)
            await results.execute(spName)
            resolve('success');
        } catch (err) {
            console.log(err);
            reject(err);
        }
    })
}

// update order status
exports.updateOrderStatus = function(formData){
    return new Promise(async (resolve, reject) => {
        try {
            let spName = 'spUpdateOrderStatusForDriver_T1';

            if(formData.spFixed)
                spName += '_fixed'
            else
                spName += '_error'
            
            let results =  new sql.Request();
            results.input('madh', sql.VarChar(20), formData.orderId)
            results.input('ttdh', sql.NVarChar(50), formData.newOrderStatus)
            results.input('matx',sql.VarChar(20),formData.driverId)
            await results.execute(spName)
            resolve('success');
        } catch (err) {
            console.log(err);
            reject(err);
        }
    })
}
