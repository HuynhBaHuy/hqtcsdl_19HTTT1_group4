const productService = require('../services/productService');
const customerService = require('../services/customerService');

class customerController {
    //[GET]  /


    async loadProducts(req, res) {
        console.log(req.params.partnerId);
        const product = await customerService.loadProducts(req.params.partnerId);
        console.log(product);
        res.render('customer/product', {product});
    }

    async loadPartners(req, res) {
        const partner = await customerService.loadPartners();
        res.render('customer/partnerList', {partner});
    }

}

module.exports = new customerController();