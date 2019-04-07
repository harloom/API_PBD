const dbconfig = require('../utils/connnection_sql');
const mssql = require('mssql')
const bcrypt = require('bcrypt')
const key = require('../security/KeyApi');
const Joi = require('joi');

async function  getPool (){
  return await new mssql.ConnectionPool(dbconfig).connect();
}

const getProducts = async (callback) => {
  try {
      let pool =  await getPool();
      let result2 = await pool.request()
        .execute('getProducts')
      await  callback(result2);
      await mssql.close();

  
  } catch (err) {
    console.log(err);
  }
}

module.exports.getProducts = getProducts;