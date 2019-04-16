const dbconfig = require('../utils/connnection_sql');
const mssql = require('mssql')
const bcrypt = require('bcrypt')
const key = require('../security/KeyApi');
const Joi = require('joi');

async function getPool() {
  return await new mssql.ConnectionPool(dbconfig).connect();
}

function getValidKeyAPI(keyAPI) {
  return new Promise(resolve => {
    key(keyAPI, (_response) => {
      resolve(_response);
    });
  })
  
}

const save_kwintasi   = ()=>{
  
}
















