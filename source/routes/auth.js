const express = require('express');
const router = express.Router();
const passport = require('../passport/passport');
const authController = require('../controllers/authController');

router.get('/', authController.showLogin);

router.get('/logout', function(req, res){
  req.logout();
  res.redirect('/');
});

// router.post('/', passport.authenticate('local', (err, user, info) => { 
//   successRedirect: '/partner',
//   failureRedirect: '/?wrong-password',
//   failureFlash: true
// }));

router.post('/',
passport.authenticate('local'),
function(req, res) {
  if(req.user.username == "partner")
    res.redirect('/partner/order')
  else if(req.user.username == "driver"){
    res.redirect('/driver/list/order');
  }
  else if (req.user.username == "employee1"){
    res.redirect('/employee/list/contract')
  }
  else if (req.user.username == "employee2"){
    res.redirect('/employee/list/contract')
  }
  else if(req.user.username == "customer")
    res.redirect('/customer/partner-list')
});

module.exports = router;
