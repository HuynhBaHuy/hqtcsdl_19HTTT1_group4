const express = require('express');
const router = express.Router();

const driverController = require('../controllers/driverController');

router.get('/list/order', driverController.listOrder);
router.get('/delivering-order', driverController.listDeliveringOrder);

module.exports = router;