class T1Controller {
    //[GET] /dirty-read/test-case-1/t1
    show(req, res, next) {
        res.render('\dirtyread\\testcase1\\t1');
    }
}
module.exports = new T1Controller();