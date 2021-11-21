const siteRouter = require('./site');
const dr_tc1_t1Router = require('./dirtyread/testcase1/t1');
function route(app) {
  
  app.use('/dirty-read/test-case-1/t1',dr_tc1_t1Router);
  app.use('/', siteRouter);
}

module.exports = route;
