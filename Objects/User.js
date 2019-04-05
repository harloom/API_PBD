const dbconfig = require('../utiils/connnection_sql');
const mssql = require('mssql')
const bcrypt = require('bcrypt')
const randomstring = require("randomstring");
const saltRounds = 10;
function saveUserTASK(User, callback) {
  try {
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
        try {
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
                callback({
                  massage: "Account is Registered"
                });
              } else {

                let row = result.recordset;
                callback({
                  massage: "Registrasi Success",
                  row
                });


                ps.unprepare(err => {
                  console.log(err);
                  connection.close(err => {
                    console.log("Connection : " + err);
                  })
                })

              }
            })
        } catch (error) {
          callback(error);
        }


      })


    });

  } catch (error) {
    callback(error);
  }






}

let saveUsers  = async (id_ktp,plainText,callback) => {
  try {
    // let date = new Date().getTime();
    // console.log(date);
    let salt = await bcrypt.genSaltSync(saltRounds);
    let hash = await bcrypt.hashSync(plainText, salt);
      const pool = await mssql.connect(dbconfig)
      const result2 = await pool.request()
        .input('id', mssql.VarChar(15), randomstring.generate(7))
        .input('id_ktp', mssql.Char(16) ,id_ktp)
        .input('password', mssql.VarChar(200) ,hash)
        .execute('loginTask')
  
       callback(result2);

  
  } catch (err) {
    console.log(err);
  }
}


module.exports.saveUser = saveUserTASK;
module.exports.savePassword = saveUsers;