const dbconfig = require('../utils/connnection_sql');
const mssql = require('mssql')
const bcrypt = require('bcrypt')
const key = require('../security/KeyApi');
const Joi = require('joi');
const Chart = require('../Objects/Charts');
const randomstring = require("randomstring");

async function getPool() {
  return await new mssql.ConnectionPool(dbconfig).connect();
}

function getValidKeyAPI(id_ktp,keyAPI) {
  return new Promise(resolve => {
    key(id_ktp,keyAPI, (_response) => {
      resolve(_response);
    });
  });

}

function getCompareChart(flag, _key) {
  return new Promise((resolve, reject) => {
    Chart.getChart(flag, _key, (_response) => {
      console.log( _response.recordset )
      if (_response.recordset == null) {
        reject(false);
      } else {
        resolve(_response);
      }
    });
  });
}

const save_kwintasi = async (_key, Kwin, callback) => {
  try {
    const resultCompare = await getCompareChart(Kwin.id_ktp, _key);
    let valid = await getValidKeyAPI(Kwin.id_ktp,_key);
    if (valid) {
      let pool = await getPool();
      const _nokwitansi = randomKwintasi();
      let result = await pool.request()
        .input('no_kwitansi', mssql.Char(10), _nokwitansi)
        .input('id_ktp', mssql.Char(16), Kwin.id_ktp)
        .input('lama_pinjam', mssql.Int, Kwin.lama)
        .input('id_service', mssql.Char(5), Kwin.id_service)
        .input('alamat_antar', mssql.VarChar(200), Kwin.alamat_antar)
        .execute('save_kwitansi');
      // await callback(result.recordset[0].no_kwitansi);

      if (result) {
        try {

          console.dir(resultCompare);
          //ngambil di carts
          for (let i = 0; i < resultCompare.recordset.length; i++) {
            var resultDetailKwintasi = await pool.request()
              .input('no_kwitansi', mssql.Char(10), _nokwitansi)
              .input('id_kamera', mssql.Char(5), resultCompare.recordset[i].id_kamera)
              .input('jumlah_pinjam', mssql.Int, resultCompare.recordset[i].jumlah_pinjam)
              .execute('save_detail_kwitansi');
          }

          await callback(resultDetailKwintasi);
          const clear = await pool.request()
            .input('kode_ktp', mssql.Char(16), Kwin.id_ktp)
            .execute('deleteChartAllByUser');

          await mssql.close();

        } catch (error) {
          await callback(error)
          await mssql.close();
        }
      } else {
        callback(false)
      }
      await mssql.close();
    }



  } catch (error) {
    console.log(error);
    await callback(error);
    await mssql.close();
  }

}

const getViewKwitansi = async (_key, id_ktp, callback) => {
  try {
    let valid = await getValidKeyAPI(id_ktp,_key);
    if (valid) {
      let pool = await getPool();
      let result = await pool.request()
        .input('id_ktp', mssql.Char(16), id_ktp)
        .execute('getViewKwitansi');
      if (result.rowsAffected > 0) {
        // await callback(result.recordset);
        try {
          const _detail = 'detail';
          for (let i = 0; i < result.recordset.length; i++) {
            let resultdetail = await detail(_key, result.recordset[i].no_kwitansi,id_ktp);
            result.recordset[i][_detail] = resultdetail;
          }
        await callback(result.recordset);
        await mssql.close();
        } catch (error) {
          await console.log(error);
          await mssql.close();
        }

      } else {
        await callback(false);
        await mssql.close();
      }

    }
  } catch (error) {
    console.log(error);
    await callback(error);
    await mssql.close();
  }

}


const getViewDetailKwitansi = async (id_ktp,_key, id, callback) => {
  try {
    let valid = await getValidKeyAPI(id_ktp,_key);
    if (valid) {
      let pool = await getPool();
      let result = await pool.request()
        .input('no_kwitansi', mssql.Char(10), id)
        .execute('getViewDetailKwitansi');
      if (result.rowsAffected > 0) {
        await callback(result.recordset);
        await mssql.close();
      } else {
        await callback(false);
        await mssql.close();
      }
    }
  } catch (error) {
    console.log(error);
    await callback(error);
    await mssql.close();
  }

}

function detail(_key, _no_kwitansi,id_ktp) {
  return new Promise(resolve => {
    getViewDetailKwitansi(id_ktp, _key, _no_kwitansi, (result) => {
      resolve(result);
    })
  });
}

function randomKwintasi(){
  return no_kwitansi = randomstring.generate({
    length:10,
    charset: 'numeric'
  });
  
}


module.exports.getDetail = getViewDetailKwitansi;
module.exports.getViewKwitansi = getViewKwitansi;
module.exports.PostKwin = save_kwintasi;