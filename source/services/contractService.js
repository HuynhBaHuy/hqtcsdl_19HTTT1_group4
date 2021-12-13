const sql = require("mssql");

module.exports.listContract = () => {
    return new Promise((resolve, reject) => {
        // create Request object
        const request = new sql.Request();
        const query = "SELECT hd.MaHD as contractId, dt.MaDT as partnerId, dt.TenDT as namePartner, hd.TG_HieuLucHD as expiredTime FROM HOP_DONG hd JOIN DOI_TAC dt ON(hd.MaDT = dt.MaDT)"
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

module.exports.listExpiredContract = () => {
    return new Promise((resolve, reject) => {
        // create Request object
        const request = new sql.Request();
        const query = "SELECT hd.MaHD as contractId, dt.MaDT as partnerId, dt.TenDT as namePartner, hd.TG_HieuLucHD as expiredTime FROM HOP_DONG hd JOIN DOI_TAC dt ON(hd.MaDT = dt.MaDT) WHERE CAST( GETDATE() AS Date ) > hd.TG_HieuLucHD"
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