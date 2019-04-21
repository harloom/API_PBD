const dbconfig = require('../utils/connnection_sql');
const mssql = require('mssql')
const bcrypt = require('bcrypt')
const key = require('../security/KeyApi');
const Joi = require('joi');

async function getPool() {
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

const d_product = async (_id , callback) =>{
  try {
    let pool = await getPool();
    let res = await  pool.request().
    input('idkamera', mssql.Char(5) , _id)
    .execute('getProduct');
    await callback(res);
    await mssql.close();

  } catch (error) {
    await callback (error);
  }
}

module.exports.getProducts = getProducts;
module.exports.product = d_product ;