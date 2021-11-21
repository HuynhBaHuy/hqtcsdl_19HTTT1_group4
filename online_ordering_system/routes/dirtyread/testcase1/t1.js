const express = require('express');
const router = express.Router();

const t1Controller = require('../../../app/controllers/dirtyread/testcase1/T1Controller');


router.get('/', t1Controller.show);

module.exports = router;