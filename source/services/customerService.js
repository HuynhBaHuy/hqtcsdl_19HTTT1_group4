const sql = require("mssql");

module.exports.loadProducts = (partnerId, spFixed) => {
    return new Promise(async (resolve, reject) => {
        // // create Request object
        // const request = new sql.Request();
        // const query = `SELECT sp.MaSP as id, sp.TenSanPham as name, l.TenLoai as category, sp.Gia as price FROM SAN_PHAM sp JOIN CHI_NHANH cn ON(sp.MaCN = cn.MaCN) JOIN LOAI_HANG l ON(sp.Loai = l.MaLoai) WHERE cn.MaDT = '${partnerId}'`
        // // query to the database and get the records
        // request.query(query, function (err, recordset) {
        //     if (err) {
        //         reject(err)
        //     }
        //     else {
        //         // send records as a response
        //         resolve(recordset.recordset);
        //     }
        // });
        try {
            var spName = 'sp_dirtyread_tc3_T2';
            if(spFixed === 'true')
                spName += '_fixed'
            else
                spName += '_error'
            
            console.log(spName);
            let results = await new sql.Request()
                .input('madt', sql.VarChar(20), partnerId)
                .execute(spName)
            const productList = results.recordset.map((product) => {
                return {
                    id: product.MaSP,
                    name: product.TenSanPham,
                    category: product.Loai,
                    price: product.Gia
                }
            });
            resolve(productList);
        } catch (err) {
            reject(err);
        }
    });
}

module.exports.loadPartners = () => {
    return new Promise((resolve, reject) => {
        // create Request object
        const request = new sql.Request();
        const query = "SELECT dt.MaDT as id, dt.TenDT as name, lh.TenLoai as category, dt.NguoiDaiDien as spokesman, CONCAT(dt.DiaChiKD, N', Quận ', kv.Quan, ', ', kv.Tinh) as address, dt.SoDT as phoneNumber, dt.Email as email FROM DOI_TAC dt JOIN LOAI_HANG lh ON (dt.MaLoai = lh.MaLoai) JOIN KHU_VUC kv ON(dt.MaKV = kv.MaKV)"
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
