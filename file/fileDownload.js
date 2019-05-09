const expess = require('express');
const router = expess.Router();
const path = require('path')
const Joi = require('joi');
const SchemaKey = require('../utils/nyaw')


router.get('/img/:id', (req, res) => {
    console.log("Donwload")
      let fileImage = __dirname+'/img/'+req.params.id ;
      res.download(fileImage);
    
});



module.exports = router;