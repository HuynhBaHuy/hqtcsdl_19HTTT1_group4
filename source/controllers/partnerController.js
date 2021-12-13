const orderService = require('../services/orderService');
const productService = require('../services/productService');

class partnerController {
    //[GET]  /

    async loadOrders(req, res) {
        const order = await orderService.loadOrders(req.user.id);
        res.render('partnerOrder', {order});
    }

    async loadOrderStatus(req, res) {
        const orderStatus = await orderService.loadOrderStatus(req.params.id);
        res.send(orderStatus);
    }

    async editOrderStatus(req, res) {
        const formData = {
            partnerId: req.user.id,
            demoCase: req.body.demoCase,
            orderId: req.params.id,
            newOrderStatus: req.body.newOrderStatus,
            spFixed: req.body.spFixed
        }
        const ack = await orderService.editOrderStatus(formData);
        res.send(ack);
    }

    async loadProducts(req, res) {
        const product = await productService.loadProducts();
        res.render('partnerProduct', {product});
    }
}

module.exports = new partnerController();