
const express = require('express');
const router = express.Router();
const User = require('./Objects/User');
const Joi = require('joi');
router.post('/', (req, res) => {
    if(req.headers.key =="ktp"){
  
    const valid = Joi.validate(req.body,ScemaCekLoginKTP,{escapeHtml: true});
    if(valid.error){
      res.status(400).send(valid.error);
    }else{
  
      User.cek_login(valid.value.id_ktp,"null",valid.value.plaintext , (result)=>{
        if(result){
          res.status(200).send(result);
        }
      });
    }
  }else
  if(req.headers.key =="hp"){
    const valid = Joi.validate(req.body,ScemaCekLoginNoHP,{escapeHtml: true});
    if(valid.error){
      res.status(400).send(valid.error);
    }else{
      User.cek_login(valid.value.id_ktp,"",valid.value.plaintext , (result)=>{
      
          res.status(200).send(result[0]);
   
      });
    }
  }

  }
 );
const ScemaCekLoginKTP ={
  id_ktp : Joi.string().min(15).max(16).required(),
  plaintext : Joi.string().min(8).max(30).required()
}

const ScemaCekLoginNoHP ={
  no_hp : Joi.string().min(11).max(15).required(),
  plaintext : Joi.string().min(8).max(30).required()
}
module.exports = router;