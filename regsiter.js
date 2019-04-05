const express = require('express');
const router = express.Router();
const Joi = require('joi');
// const dbconfig  = require('./utiils/connnection_sql');
// const mssql = require('mssql');
const db = require('./db/db');
router.post('/', (req, res) => {

  const resultValidate = Joi.validate(req.body, SchemaUser, {
    escapeHtml: true
  });
  if (resultValidate.error) {
    res.status(400).send(resultValidate.error.details[0].message);
  }
  let values = resultValidate.value;
  db.executeUsers(values,(result)=>{
    res.status(200).send(result);
  });

});



const SchemaUser = {
  id_ktp: Joi.string().min(16).required(),
  nama: Joi.string().min(5).max(50).required(),
  tempat_lahir: Joi.string().min(3).max(25).required(),
  tanggal_lahir: Joi.date().min('1-1-1974').max('now').required(),
  alamat: Joi.string().min(3).max(100).required(),
  jenis_kelamin: Joi.any().valid(['Male', 'Female']).required(),
  pekerjaan: Joi.string().min(3).max(25).required(),
  no_handphone: Joi.string().min(11).max(15).required()

}
module.exports = router;