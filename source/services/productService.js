const sql = require("mssql");

module.exports.loadProducts = () => {
    return new Promise((resolve, reject) => {
        // create Request object
        const request = new sql.Request();
        const query = "SELECT MaSP as id, TenSanPham as name, Loai as category, Gia as price FROM SAN_PHAM"
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