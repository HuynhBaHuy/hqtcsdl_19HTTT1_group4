class SiteController {
    home(req, res, next) {
        res.render('site');
    }
}
module.exports = new SiteController();