const sql = require("mssql");

module.exports.loadOrders = (partnerId) => {
    return new Promise((resolve, reject) => {
        // create Request object
        const request = new sql.Request();
        const query = `SELECT dh.MaDH as id, kh.TenKH as customerName, CONCAT(dh.TenDuong, ',', kv.Quan, ',', kv.Tinh) as address, dh.TongPhiSP as totalPrice, dh.TinhTrangDH as status FROM DON_HANG dh JOIN KHACH_HANG kh ON(dh.MaKH = kh.MaKH) JOIN KHU_VUC kv ON(dh.MaKV = kv.MaKV) WHERE dh.MaDT='${partnerId}'`
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

module.exports.loadOrderStatus = (id) => {
    return new Promise((resolve, reject) => {
        // create Request object
        const request = new sql.Request();
        const query = `SELECT TinhTrangDH as orderStatus FROM DON_HANG WHERE MaDH = '${id}'`
        // query to the database and get the records
        request.query(query, function (err, recordset) {
            if (err) {
                reject(err)
            }
            else {
                // send records as a response
                resolve(recordset.recordset[0].orderStatus);
            }
        });
    });
}

module.exports.editOrderStatus = (formData) => {
    return new Promise(async (resolve, reject) => {
        try {
            var spName = '';
            const demoCase = formData.demoCase;

            // Choose which stored procedure to run based on demo cases
            if(demoCase == 'Unrepeatable Read')
                spName = 'spUpdateOrderStatusForPartner_T2';
            else if(demoCase == 'Deadlock')
                spName = 'sp_deadlock_tc1_T1';

            if(formData.spFixed)
                spName += '_fixed'
            else
                spName += '_error'
            
            let results = await new sql.Request()
                .input('madt', sql.VarChar(20), formData.partnerId)
                .input('madh', sql.VarChar(20), formData.orderId)
                .input('ttdh', sql.NVarChar(50), formData.newOrderStatus)
                .execute(spName)

            resolve('success');
        } catch (err) {
            reject(err);
        }
    });
}