const partnerRouter = require('./partner');
const authRouter = require('./auth');

function route(app){
  app.use('/partner',partnerRouter);
  app.use('/', authRouter);
}

module.exports = route;
