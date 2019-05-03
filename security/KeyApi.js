const express = require('express');
const dbconfig = require('../utils/connnection_sql');
const mssql = require('mssql')
const Joi = require('joi');



const cekKeyAPI  = async (id,_keyAPI,callback) => {
  try {
      const pool = await new mssql.ConnectionPool(dbconfig).connect();
      const result2 = await pool.request()
        .input('keyAPI', mssql.VarChar(200), _keyAPI)
        .input('id_ktp' , mssql.Char(16),id)
        .execute('checkKey')
      if(result2.returnValue ==1){
        await callback(true)
        await  mssql.close();
  
      }else{
        callback(false);
        await  mssql.close();
      }
    
  
  } catch (err) {
    console.log(err);
  }
}


const Schema = {
  key: Joi.string().required()

}

module.exports  = cekKeyAPI;
module.exports.Schema = Schema;