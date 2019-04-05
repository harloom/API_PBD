const express = require('express');
const router = express.Router();
const dbconfig  = require('./utiils/connnection_sql');
const mssql = require('mssql');
const db = require('./db/db');
router.post('/', (req, res) => {
 
  // db.executePro('getUsers',(data,err)=>{
  //   if(err){
  //     res.status(500).send({ message: {err}})
  //   }else{
  //     res.status(200).send(data);
  //   }
  // });
  const User = {}

  db.executeUsers('save_user',)


});




module.exports = router;