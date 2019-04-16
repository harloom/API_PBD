const dbconfig = require('../utils/connnection_sql');
const mssql = require('mssql')


async function  getPool (){
  return await new mssql.ConnectionPool(dbconfig).connect();
}

const getService = async (callback) => {
  try {
      let pool =  await getPool();
      let result2 = await pool.request()
        .execute('getServices')
      await  callback(result2);
      await mssql.close();

  
  } catch (err) {
    console.log(err);
    mssql.close();
  }
}

const d_service = async (_id , callback) =>{
  try {
    let pool = await getPool();
    let res = await  pool.request().
    input('id_service', mssql.Char(5) , _id)
    .execute('getService');
    await callback(res);
    await mssql.close();

  } catch (error) {
    await callback (error);
    mssql.close();
  }
}

module.exports.service = d_service;
module.exports.getServices = getService;