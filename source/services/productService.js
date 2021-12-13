const sql = require("mssql");

module.exports.loadProducts = (partnerId) => {
    return new Promise((resolve, reject) => {
        // create Request object
        const request = new sql.Request();
        const query = `SELECT sp.MaSP as id, sp.TenSanPham as name, l.TenLoai as category, sp.Gia as price FROM SAN_PHAM sp JOIN CHI_NHANH cn ON(sp.MaCN = cn.MaCN) JOIN LOAI_HANG l ON(sp.Loai = l.MaLoai) WHERE cn.MaDT = '${partnerId}'`
        // query to the database and get the records
        request.query(query, function (err, recordset) {
            if (err) {
                reject(err)
            }
            else {
                // send records as a response
                resolve(recordset.recordset);
            }
        });
    });
}

module.exports.loadProductById = (id) => {
    return new Promise((resolve, reject) => {
        // create Request object
        const request = new sql.Request();
        const query = `SELECT sp.TenSanPham as name, l.TenLoai as category, sp.Gia as price FROM SAN_PHAM sp JOIN LOAI_HANG l ON(sp.Loai = l.MaLoai) WHERE sp.MaSP = '${id}'`
        // query to the database and get the records
        request.query(query, function (err, recordset) {
            if (err) {
                reject(err)
            }
            else {
                // send records as a response
                resolve(recordset.recordset[0]);
            }
        });
    });
}

module.exports.editProductStatus = (formData) => {
    return new Promise(async (resolve, reject) => {
        try {
            var spName = 'sp_dirtyread_tc3_T1';
            const demoCase = formData.demoCase;

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