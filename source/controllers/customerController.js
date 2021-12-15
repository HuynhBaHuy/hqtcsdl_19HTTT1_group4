const customerService = require('../services/customerService');

class customerController {
    //[GET]  /


    async loadProducts(req, res) {
        const product = await customerService.loadProducts(req.params.partnerId, req.query.spFixed);
        res.render('customer/product', {product});
    }

    async loadPartners(req, res) {
        const partner = await customerService.loadPartners();
        res.render('customer/partnerList', {partner});
    }

}

module.exports = new customerController();