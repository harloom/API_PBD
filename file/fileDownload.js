const expess = require('express');
const router = expess.Router();
const path = require('path')
const Joi = require('joi');
const SchemaKey = require('../utils/nyaw')


router.get('/img/:id', (req, res) => {
  const validHeaders = Joi.validate(req.headers.key_api,SchemaKey,{escapeHtml:true});
  if(validHeaders.error){
    res.status(401).send({massage : "401 Unauthorized"});
  }else{
    console.log("Donwload")
    if(req.params.id =='1'){
      let fileImage = __dirname+'/img/lupia.png';
      res.download(fileImage);

    }
   }
});

module.exports = router;