const orderService = require('../services/orderService');
class driverController {
    //[GET]  /

    async listOrder(req, res) {
        const order = await orderService.listOrderByRegion(req.user.id);
        res.render('driver/order', {order});
    }

    async listDeliveringOrder(req, res) {
        const order = await orderService.listDeliveringOrder(req.user.id);
        res.render('driver/deliveringOrder', {order});
    }
}

module.exports = new driverController();