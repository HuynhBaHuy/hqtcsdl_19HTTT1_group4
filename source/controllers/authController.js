const userService = require('../services/productService');
class authController {
  //[GET] /login
  showLogin(req, res) {
    const errorMsg = req.flash('errorMsg');
    res.render('login', { errorMsg, layout: false });
  }
}
module.exports = new authController();
