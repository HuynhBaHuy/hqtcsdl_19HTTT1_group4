const orderService = require('../services/orderService');
class driverController {

    async listOrder(req, res) {
        if(!req.user){
            res.redirect('/');
        }
        const order = await orderService.listOrderByRegion(req.user.id);
        res.render('driver/order', {order});
    }

    async listDeliveringOrder(req, res) {
        if(!req.user){
            res.redirect('/');
        }
        const order = await orderService.listDeliveringOrder(req.user.id);
        res.render('driver/deliveringOrder', {order});
    }
    //[POST] /driver/accept-order
    async acceptOrder(req, res) {
        if(!req.user){
            res.redirect('/');
        }
        const formData = req.body;
        formData.driverId = req.user.id;
        const ack = await orderService.acceptOrder(formData)
        res.send(ack);
    }
    //[POST] /driver/update-order-status
    async updateStatus(req, res) {
        if(!req.user){
            res.redirect('/');
        }
        const formData = req.body;
        formData.driverId = req.user.id;
        const ack = await orderService.updateOrderStatus(formData)
        res.send(ack);
    }
}

module.exports = new driverController();