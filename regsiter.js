const express = require('express');
const router = express.Router();
const Joi = require('joi');
const User = require('./Objects/User');
router.post('/', (req, res) => {

  const resultValidate = Joi.validate(req.body, SchemaUser, {
    escapeHtml: true
  });
  if (resultValidate.error) {
    res.status(400).send(resultValidate.error.details[0].message);
  } else {
    let values = resultValidate.value;
    User.saveUser(values, (result) => {
      if(result.row){
        User.savePassword(result.row[0].id_ktp,values.password,(flag)=>{
          res.status(200).send({massage : true });
        })
      }else{
        res.status(400).send(result);
      }


    }); 

  }


});



const SchemaUser = {
  id_ktp: Joi.string().min(16).required(),
  nama: Joi.string().min(5).max(50).required(),
  tempat_lahir: Joi.string().min(3).max(25).required(),
  tanggal_lahir: Joi.date().min('1-1-1974').max('now').required(),
  alamat: Joi.string().min(3).max(100).required(),
  jenis_kelamin: Joi.any().valid(['Male', 'Female']).required(),
  pekerjaan: Joi.string().min(3).max(25).required(),
  no_handphone: Joi.string().min(11).max(15).required(),
  password: Joi.string().min(8).max(200).required()

}
module.exports = router;