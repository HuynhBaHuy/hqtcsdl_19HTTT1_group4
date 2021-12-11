const orderService = require('../services/orderService');
const productService = require('../services/productService');

class partnerController {
    //[GET]  /

    async loadOrders(req, res) {
        const order = await orderService.loadOrders();
        res.render('partnerOrder', {order});
    }

    async loadProducts(req, res) {
        const product = await productService.loadProducts();
        res.render('partnerProduct', {product});
    }
}

module.exports = new partnerController();