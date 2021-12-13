const createError = require('http-errors');
const express = require('express');
const path = require('path');
const app = express();
const route = require('./routes');
const session = require("express-session");
const passport = require('passport');
const bodyParser = require('body-parser');
const flash = require('connect-flash');
// view engine setup
app.set('views', path.join(__dirname, 'views'));


app.set('view engine', 'hbs');

// parse application/json
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));



//session setup
app.use(session({ secret: "cat", resave: true, saveUninitialized: true }));
app.use(passport.initialize());
app.use(passport.session());


// setup flash msg
app.use(flash());

// make req.user locally in views
app.use(function (req, res, next) {
  res.locals.user = req.user
  next()
})

app.use('/public', express.static('public'))

//Config template engine
app.set('views', path.join(__dirname, 'resources', 'views'));

//routes init
route(app);

// catch 404 and forward to error handler
app.use(function(req, res, next) {
  next(createError(404));
});


// error handler
app.use(function(err, req, res, next) {
  // set locals, only providing error in development
  res.locals.message = err.message;
  res.locals.error = req.app.get('env') === 'development' ? err : {};

  // render the error page
  res.status(err.status || 500);
  res.render('error');
});

module.exports = app;
