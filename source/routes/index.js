const employeeRouter = require('./employee');
const driverRouter = require('./driver');
const partnerRouter = require('./partner');
const authRouter = require('./auth');

function route(app){
  app.use('/employee',employeeRouter )
  app.use('/driver',driverRouter);
  app.use('/partner',partnerRouter);
  app.use('/', authRouter);
  app.use('/partner',partnerRouter);
}

module.exports = route;
