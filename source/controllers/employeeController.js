const contractService = require('../services/contractService');
class employeeController {
    //[GET]  /

    async listContract(req, res) {
        const contract = await contractService.listContract();
        res.render('employee/contract', {contract});
    }

    async listExpiredContract(req, res) {
        const contract = await contractService.listExpiredContract();
        res.render('employee/expiredContract', {contract});
    }
}

module.exports = new employeeController();