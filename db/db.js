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


async function saveUserTASK(User, callback) {
  let connection = new mssql.ConnectionPool(dbconfig, function (err) {
    const ps = new mssql.PreparedStatement(connection);
    ps.input('id_ktp', mssql.Char(16));
    ps.input('nama', mssql.VarChar(50));
    ps.input('tempat_lahir', mssql.VarChar(25));
    ps.input('tanggal_lahir', mssql.Date);
    ps.input('alamat', mssql.VarChar(100));
    ps.input('jenis_kelamin', mssql.VarChar(15));
    ps.input('pekerjaan', mssql.VarChar(25));
    ps.input('no_handphone', mssql.VarChar(15));
    ps.prepare("execute save_user  @id_ktp, @nama, @tempat_lahir,  @tanggal_lahir,  @alamat,@jenis_kelamin, @pekerjaan, @no_handphone", err => {
      ps.execute({
          id_ktp: User.id_ktp,
          nama: User.nama,
          tempat_lahir: User.tempat_lahir,
          tanggal_lahir: User.tanggal_lahir,
          alamat: User.alamat,
          jenis_kelamin: User.jenis_kelamin,
          pekerjaan: User.pekerjaan,
          no_handphone: User.no_handphone
        },
        (err, result) => {
          if (err) {
            callback({massage : "Account is Registered"});
          }
          else  {
            callback({massage : "Registrasi Success"});
            ps.unprepare(err => {
              console.log(err);
            })

          }
        })

    })


  });




}

module.exports.executeSQL = executeSQL;
module.exports.executePro = executeProcedure;
module.exports.executeUsers = saveUserTASK;







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



