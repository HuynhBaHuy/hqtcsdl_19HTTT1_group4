const userService = require('../services/productService');

const passport = require('passport')
  , LocalStrategy = require('passport-local').Strategy;

passport.use(new LocalStrategy({
  passReqToCallback: true
},
  async function(req, username, password, done) {
    let user;
    if(username!== 'employee2') {
      user = {
        id: '001',
        username: username,
        password: password
      }
    }
    else{
      user = {
        id: '002',
        username: username,
        password: password
      }
    }
    

    if(username != "partner" && username != "driver" && username != "employee1" && username != "employee2"  && username != "customer") {
        return done(null, false, { messages: req.flash('errorMsg', 'Incorrect username') });
    }
    if (password != "123") {
      return done(null, false, { messages: req.flash('errorMsg', 'Incorrect password') });
    }
    return done(null, user);
  }
));

passport.serializeUser(function(user, done) {
  done(null, {username: user.username, id: user.id});
});

passport.deserializeUser(function(user, done) {
  done(null, {username: user.username, id: user.id});
});

module.exports = passport;