const dbconfig = require('../utils/connnection_sql');
const mssql = require('mssql')
const bcrypt = require('bcrypt')
const randomstring = require("randomstring");
const saltRounds = 10;
const ResponErrors = require('../utils/errorUtils');

function getError(code  , massage){
  return error = new ResponErrors(code,massage);
}


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
      ps.prepare("execute save_user @id_ktp,@nama,@tempat_lahir,@tanggal_lahir,@alamat,@jenis_kelamin,@pekerjaan,@no_handphone", err => {
          ps.execute({
              id_ktp: User.id_ktp,
              nama: User.nama,
              tempat_lahir: User.tempat_lahir,
              tanggal_lahir: User.tanggal_lahir,
              alamat: User.alamat,
              jenis_kelamin: User.jenis_kelamin,
              pekerjaan: User.pekerjaan,
              no_handphone: User.no_handphone
            },(err, result) => {
              // console.dir(err);
              if (err) {
                callback(getError('400','User is Registered'));
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
        } )


    });

  } catch (error) {
    console.log(error);
  }



}

async function  getPool (){
  return await new mssql.ConnectionPool(dbconfig).connect();
}
const saveUsers  = async (id_ktp,plainText,callback) => {
  try {

    let salt = await bcrypt.genSaltSync(saltRounds);
    let hash = await bcrypt.hashSync(plainText, salt);
      const pool =  await getPool();
      const result2 = await pool.request()
        .input('id', mssql.VarChar(15), randomstring.generate(7))
        .input('id_ktp', mssql.Char(16) ,id_ktp)
        .input('password', mssql.VarChar(200) ,hash)
        .input('key',mssql.VarChar(200),randomstring.generate(100))
        .execute('loginTask')
  
      await callback(getError('200','Rigestered is Success'));
      await  mssql.close();
  
  } catch (err) {
    console.log(err);
  }
}

const getUser = async (id_ktp,callback) => {
  try {

      let pool =  await getPool();
      let result2 = await pool.request()
        .input('idktp', mssql.Char(16) ,id_ktp)
        .execute('getUser')
      await  callback(result2);
      await mssql.close();

  
  } catch (err) {
    console.log(err);
  }
}


const cek_login = async (id_ktp,no_hp,plainText,callback) => {
  try {
    // let date = new Date().getTime();
      const pool = await getPool();
      const result2 = await pool.request()
        .input('id_ktp', mssql.Char(16) ,id_ktp)
        .input('no_hp',mssql.VarChar(5),no_hp)
        .execute('getLoginTask')
      if(result2.rowsAffected == 1){
        let verify = await bcrypt.compareSync(plainText,result2.recordset[0].password_login);
        if(verify){
          const resAPI = await pool.request()
          .input('id',mssql.VarChar(15),result2.recordset[0].id)
          .execute('getKeyApi')
          await callback(resAPI.recordset[0]);
          await mssql.close();
        }else{

          callback(getError(401,"ID/PASSWORD ANDA SALAH"));
        }
      }else{
        callback(getError(401,"ID/PASSWORD ANDA SALAH"));
      }
        

  
  } catch (err) {
    console.log(err);
  }
}


module.exports.saveUser = saveUserTASK;
module.exports.savePassword = saveUsers;
module.exports.getUser = getUser;
module.exports.cek_login = cek_login;
