const userService = require('../services/productService');

const passport = require('passport')
  , LocalStrategy = require('passport-local').Strategy;

passport.use(new LocalStrategy({
  passReqToCallback: true
},
  async function(req, username, password, done) {
    const user = {
      username: username,
      password: password
    }

    if(username != "partner" && username != "driver" && username != "employee" && username != "customer") {
        return done(null, false, { messages: req.flash('errorMsg', 'Incorrect username') });
    }
    if (password != "123") {
      return done(null, false, { messages: req.flash('errorMsg', 'Incorrect password') });
    }
    return done(null, user);
  }
));

passport.serializeUser(function(user, done) {
  done(null, user.username);
});

passport.deserializeUser(function(username, done) {
  done(null, username);
});

module.exports = passport;