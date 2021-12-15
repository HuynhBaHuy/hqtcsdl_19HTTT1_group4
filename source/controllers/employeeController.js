const contractService = require('../services/contractService');
class employeeController {
    //[GET]  /

    async listContract(req, res) {
        if(!req.user){
            res.redirect('/')
        }
        const contract = await contractService.listContract();
        res.render('employee/contract', {contract});
    }

    async listExpiredContract(req, res) {
        if(!req.user){
            res.redirect('/')
        }
        const contract = await contractService.listExpiredContract();
        res.render('employee/expiredContract', {contract});
    }
    //[POST] /employee/extend-contract-time
    async extendContractTime (req, res) {
        if(!req.user){
            res.redirect('/')
        }
        const formData = req.body;
        if(req.user.id==="001"){
            formData.trans = "T1"
        }
        else{
            formData.trans = "T2"
        }
        const ack = await contractService.extendContractTime(formData)
        res.send(ack);
    }
    //[POST] /employee/delete-contract
    async deleteContract(req, res){
        if(!req.user){
            res.redirect('/')
        }
        const formData = req.body;
        if(req.user.id==="001"){
            formData.trans = "T1"
        }
        else{
            formData.trans = "T2"
        }
        const ack = await contractService.deleteContract(formData)
        res.send(ack);
    }
}

module.exports = new employeeController();