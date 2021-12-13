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
        const query = `SELECT dh.MaDH as id, kh.TenKH as customerName, CONCAT(dh.TenDuong, ',', kv.Quan, ',', kv.Tinh) as address, dh.TongPhiSP as totalPrice, dh.TinhTrangDH as status FROM DON_HANG dh JOIN KHU_VUC kv ON(dh.MaKV = kv.MaKV) JOIN KHACH_HANG kh ON(dh.MaKH = kh.MaKH) JOIN TAI_XE tx ON(kv.MaKV = tx.MaKV) WHERE tx.MaTX = ${driverId}`
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
        const query = `SELECT dh.MaDH as id, kh.TenKH as customerName, CONCAT(dh.TenDuong, ',', kv.Quan, ',', kv.Tinh) as address, dh.TongPhiSP as totalPrice, dh.TinhTrangDH as status FROM DON_HANG dh JOIN KHU_VUC kv ON(dh.MaKV = kv.MaKV) JOIN KHACH_HANG kh ON(dh.MaKH = kh.MaKH) JOIN GIAO_HANG gh ON(dh.MaDH = gh.MaDH) WHERE gh.MaTX = ${driverId}`
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
