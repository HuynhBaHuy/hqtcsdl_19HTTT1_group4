const express = require('express');
const router = express.Router();

const employeeController = require('../controllers/employeeController');

router.get('/list/expired-contract', employeeController.listExpiredContract);
router.get('/list/contract', employeeController.listContract);

module.exports = router;