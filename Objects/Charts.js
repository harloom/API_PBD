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
const getChart = async (id_ktp, keyAPI, callback) => {
  try {

    let valid = await getValidKeyAPI(keyAPI);
    if (valid) {
      let pool = await getPool();
      let result2 = await pool.request()
        .input('kode_ktp', mssql.Char(16), id_ktp)
        .execute('getChart')
      await callback(result2);
      await mssql.close();
    }else{
      callback(false);
    }



  } catch (err) {
    console.log(err);

  }

  const saveChart = async ()=>{
    
  }



}
module.exports.getChart = getChart;