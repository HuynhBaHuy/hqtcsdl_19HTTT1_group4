const express = require('express');
const router = express.Router();

const customerController = require('../controllers/customerController');

router.get('/partner-list', customerController.loadPartners);
router.get('/product/:partnerId', customerController.loadProducts);

module.exports = router;