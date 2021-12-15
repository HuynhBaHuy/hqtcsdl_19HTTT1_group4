const employeeRouter = require('./employee');
const driverRouter = require('./driver');
const partnerRouter = require('./partner');
const customerRouter = require('./customer');
const authRouter = require('./auth');

function route(app){
  app.use('/employee',employeeRouter )
  app.use('/driver',driverRouter);
  app.use('/partner',partnerRouter);
  app.use('/customer',customerRouter);
  app.use('/', authRouter);
}

module.exports = route;
