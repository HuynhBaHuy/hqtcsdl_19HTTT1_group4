const express = require('express');
const router = express.Router();

const partnerController = require('../controllers/partnerController');

router.get('/order', partnerController.loadOrders);
router.get('/product', partnerController.loadProducts);

module.exports = router;