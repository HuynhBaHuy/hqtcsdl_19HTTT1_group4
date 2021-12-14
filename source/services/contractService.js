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
            let results =  new sql.Request();
            results.input('masothue', sql.VarChar(20), formData.tax)
            results.input('mahd', sql.VarChar(20), formData.contractId)
            results.input('madt',sql.VarChar(20),formData.partnerId)
            results.input('tghlhd',sql.Date,formData.expiredTime)
            results.input('pthh',sql.Float,formData.fee)
            await results.execute(spName)
            resolve('success');
        } catch (err) {
            console.log(err);
            reject(err);
        }
    })
}

exports.deleteContract = function(formData){
    return new Promise(async function (resolve, reject) {
        try {
            let spName = 'sp_DeleteContract'
            spName += '_' + formData.trans;
            if(formData.spFixed)
                spName += '_fixed'
            else
                spName += '_error'
                let results =  new sql.Request();
                results.input('madt', sql.VarChar(20), formData.partnerId)
                await results.execute(spName)
                resolve('success');
        } catch (err) {
            console.log(err);
            reject(err);
        }
    })
}