const homeRouter = require('./home');
const propertyRouter = require('./property');
const authRouter = require('./auth');

function route(app){
  app.use('/', authRouter);
  app.use('/property', propertyRouter);
  app.use('/',homeRouter);
}

module.exports = route;
