const dbconfig  = require('../utiils/connnection_sql');
const mssql = require('mssql')


async function executeSQL(sql ,callback) {
  new mssql.ConnectionPool(dbconfig).connect()
    .then(pool => {
      return pool.request().query(sql)
    }).then(result => {
      let rows = result.recordset;
        callback(rows);
      mssql.close();
    }).catch(err => {
      callback(err);
      mssql.close();
    });



} 
async function executeProcedure(sql ,callback) {
  new mssql.ConnectionPool(dbconfig).connect()
    .then(pool => {
      return pool.request().execute(sql)
    }).then(result => {
      let rows = result.recordset;
        callback(rows);
      mssql.close();
    }).catch(err => {
      callback(err);
      mssql.close();
    });

async function executeSaveUserTASK(sql ,User ,callback){
  new mssql.ConnectionPool(dbconfig).connect()
  .then(pool=>{
    return pool.request().query(`execute save_user ${User}`)
  }).then(result=>{
      callback('OK')
      mssql.close();
  }).catch(err=>{
    callback(err);
    mssql.close();
  });
}



} 

module.exports.executeSQL = executeSQL;
module.exports.executePro = executeProcedure;
module.exports.executeUsers = executeSaveUserTASK;


