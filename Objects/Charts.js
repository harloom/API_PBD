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

function getTotal(result){
  return new Promise(resolve =>{
      let totalbayar = 0;
      for (let i = 0; i < result.recordset.length; i++) {
        totalbayar += result.recordset[i].jumlah_bayar;
      }
      let _pTotal = 'total_bayar';
      result[_pTotal] = totalbayar;
      resolve(result);
  
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

      if (result2.recordset) {
        let resulta = await getTotal(result2);
        await callback(resulta);

      } else {
        callback(false);
      }
      await mssql.close();
    } else {
      callback(false);
    }



  } catch (err) {
    console.log(err);

  }


}

const saveChart = async (Chart, _key, callback) => {
  try {

    let valid = await getValidKeyAPI(_key);

    if (valid) {

      let pool = await getPool();
      let result = await pool.request()
        .input('kode_ktp', mssql.Char(16), Chart.id_ktp)
        .input('id_kamera', mssql.Char(5), Chart.id_kamera)
        .input('jumlah_pinjam', mssql.Int, parseInt(Chart.jumlah))
        .execute('save_chart');

  
      await callback(result.recordset);
      await mssql.close();
    } else {
      callback(false);

    }
  } catch (error) {
    callback(false)
  }

}

const delete_chart = async (Chart, _key, callback) => {
  try {
    let valid = await getValidKeyAPI(_key);
    if (valid) {

      let pool = await getPool();
      let result = await pool.request()
        .input('kode_ktp', mssql.Char(16), Chart.id_ktp)
        .input('id_kamera', mssql.Char(5), Chart.id_kamera)
        .execute('delete_chart_product');
      // console.log(result);
      await callback(result.recordset);
      await mssql.close();
    }
  } catch (error) {
    callback(false);
  }
}

const edit_chart = async (Chart, _key, callback) => {
  try {
    let valid = await getValidKeyAPI(_key);

    if (valid) {
      let pool = await getPool();
      let result = await pool.request()
        .input('kode_ktp', mssql.Char(16), Chart.id_ktp)
        .input('id_kamera', mssql.Char(5), Chart.id_kamera)
        .input('jumlah_pinjam', mssql.Int, parseInt(Chart.jumlah))
        .execute('jumlahProductChart');

        if (result.recordset) {
          let resulta = await getTotal(result);
          await callback(resulta);
        } else {
          await callback(false);
        }
    
      await mssql.close();
    } else {
      await callback(false);
      mssql.close();
    }

  } catch (error) {
    console.log(error);
    callback(false);
  }
}

const delete_all = async (id_ktp, keyAPI, callback) => {
  try {

    let valid = await getValidKeyAPI(keyAPI);
    if (valid) {
      let pool = await getPool();
      let result2 = await pool.request()
        .input('kode_ktp', mssql.Char(16), id_ktp)
        .execute('deleteChartAllByUser')
      await callback(result2);
      await mssql.close();
    } else {
      callback(false);
      mssql.close();
    }



  } catch (err) {
    console.log(err);
    callback(false);
  }
}

module.exports.getChart = getChart;
module.exports.saveChart = saveChart;
module.exports.deleteChart = delete_chart;
module.exports.edit_chart = edit_chart;
module.exports.delete_all = delete_all;