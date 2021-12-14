const orderService = require('../services/orderService');
const productService = require('../services/productService');

class partnerController {
    //[GET]  /

    async loadOrders(req, res) {
        const order = await orderService.loadOrders(req.user.id);
        res.render('partner/order', {order});
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
        const product = await productService.loadProducts(req.user.id);
        res.render('partner/product', {product});
    }

    async loadProductById(req, res) {
        const product = await productService.loadProductById(req.params.id);
        res.send(product);
    }

    async editProductStatus(req, res) {
        const formData = {
            partnerId: req.user.id,
            productId: req.params.id,
            productName: req.body.productName,
            productCategory: req.body.productCategory,
            productPrice: req.body.productPrice,
            spFixed: req.body.spFixed
        }
        const ack = await productService.editProductStatus(formData);
        res.send(ack);
    }
}

module.exports = new partnerController();