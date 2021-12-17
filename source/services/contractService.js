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
        const query = "SELECT hd.MaHD as contractId, dt.MaDT as partnerId, dt.TenDT as namePartner, hd.TG_HieuLucHD as expiredTime, hd.PhanTramHoaHong as fee, dt.MaSoThue as tax FROM HOP_DONG hd JOIN DOI_TAC dt ON(hd.MaDT = dt.MaDT) WHERE CAST( GETDATE() AS Date ) > hd.TG_HieuLucHD"
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

exports.extendContractTime = function(formData){
    return new Promise(async function (resolve, reject) {
        try {
            let spName = 'sp_lostupdate_tc1'
            spName += '_' + formData.trans;
            if(formData.spFixed)
                spName += '_fixed'
            else
                spName += '_error'

            let results =  await new sql.Request()
                    .input('masothue', sql.VarChar(20), formData.tax)
                    .input('tg_hlhd',sql.Date,formData.expiredTime)
                    .input('pthh',sql.Float,formData.fee)
                    .execute(spName)
            if(formData.trans === 'T1' && formData.spFixed){
                resolve(results.recordsets[1][0]);
            }
            else{
                resolve('success')
            }
        } catch (err) {
            console.log(err);
            reject(err);
        }
    })
}

exports.deleteContract = function(formData){
    return new Promise(async function (resolve, reject) {
        try {
            let spName = 'sp_phantom_tc1'
            spName += '_' + formData.trans;
            if(formData.spFixed)
                spName += '_fixed'
            else
                spName += '_error'
            let results =  await new sql.Request()
                .input('madt', sql.VarChar(20), formData.partnerId)
                .execute(spName)
            if(formData.spFixed){
                if(formData.trans==='T1'){
                    resolve('success');
                }
                else{
                    resolve('not exist');
                }
            }
            else{
                if(results.rowsAffected[1]==0 && results.rowsAffected[2] ==0){
                    resolve('rollback');
                }
                else{
                    resolve('success');
                }
            }
            
        } catch (err) {
            console.log(err);
            reject(err);
        }
    })
}