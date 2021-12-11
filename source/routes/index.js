const partnerRouter = require('./partner');
const authRouter = require('./auth');

function route(app){
  app.use('/', authRouter);
  app.use('/partner',partnerRouter);
}

module.exports = route;
