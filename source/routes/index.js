const partnerRouter = require('./partner');
const customerRouter = require('./customer');
const authRouter = require('./auth');

function route(app){
  app.use('/partner',partnerRouter);
  app.use('/customer',customerRouter);
  app.use('/', authRouter);
}

module.exports = route;
