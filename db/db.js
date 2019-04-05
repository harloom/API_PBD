const dbconfig = require('../utiils/connnection_sql');
const mssql = require('mssql')


async function executeSQL(sql, callback) {
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
async function executeProcedure(sql, callback) {
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




}




module.exports.executeSQL = executeSQL;
module.exports.executePro = executeProcedure;







// new mssql.ConnectionPool(dbconfig).connect()
// .then(pool => {


// // Stored procedure
// return pool.request()
// .input(User.id_ktp, mssql.Char(16))
// .input(User.nama, mssql.VarChar(50))
// .input(User.tempat_lahir, mssql.VarChar(25))
// .input(User.tanggal_lahir, mssql.Date)
// .input(User.alamat, mssql.VarChar(100))
// .input(User.jenis_kelamin, mssql.VarChar(15))
// .input(User.pekerjaan, mssql.VarChar(25))
// .input(User.no_handphone, mssql.VarChar(15))
// .execute('save_user')
//   // return pool.request().query(`Select *from users where id_ktp = ${User.id_ktp}`)
// }).then(result => {
//   console.log('QUERY OK')
//   callback(result.recordset);
//   mssql.close();
// }).catch(err => {
//   callback(err);
//   mssql.close();
// });



