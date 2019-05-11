const dbconfig = require('../utils/connnection_sql');
const mssql = require('mssql')
const bcrypt = require('bcrypt')
const key = require('../security/KeyApi');
const Joi = require('joi');

async function getPool() {
  return await new mssql.ConnectionPool(dbconfig).connect();
}

function getValidKeyAPI(id_ktp, keyAPI) {
  return new Promise(resolve => {
    key(id_ktp, keyAPI, (_response) => {
      resolve(_response);
    });
  })

}

function getTotal(result, _lama) {
  return new Promise(resolve => {
    let totalbayar = 0;
    let totalpajak = 0;
    for (let i = 0; i < result.recordset.length; i++) {
      totalbayar += result.recordset[i].jumlah_bayar;
      totalpajak += result.recordset[i].pajak;
    }
    let _pTotal = 'total_bayar';
    const _pajak = 'total_pajak';
    _lama > 1 ? totalbayar = totalbayar * _lama : totalbayar * 1;
    result[_pTotal] = totalbayar;
    result[_pajak] = totalpajak;
    resolve(result);

  })
}

function deleteChartItem(Chart, _key) {
  return new Promise((resolve, reject) => {
    delete_chart(Chart, _key, (result) => {
      !result ? reject(false) : resolve(result);
    })
  });
}


const getChart = async (id_ktp, keyAPI, callback) => {
  try {

    let valid = await getValidKeyAPI(id_ktp, keyAPI);
    if (valid) {
      console.log(valid);
      let pool = await getPool();
      let result2 = await pool.request()
        .input('kode_ktp', mssql.Char(16), id_ktp)
        .execute('getChart')
      if (result2.rowsAffected > 0) {
        let resulta = await getTotal(result2, 1);
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
    let valid = await getValidKeyAPI(Chart.id_ktp, _key);
    if (valid) {
      let pool = await getPool();
      let result = await pool.request()
        .input('kode_ktp', mssql.Char(16), Chart.id_ktp)
        .input('id_kamera', mssql.Char(5), Chart.id_kamera)
        .input('jumlah_pinjam', mssql.Int, parseInt(Chart.jumlah))
        .input('service', mssql.Char(5), Chart.service)
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
    let valid = await getValidKeyAPI(Chart.id_ktp, _key);
    if (valid) {

      let pool = await getPool();
      let result = await pool.request()
        .input('kode_ktp', mssql.Char(16), Chart.id_ktp)
        .input('id_kamera', mssql.Char(5), Chart.id_kamera)
        .execute('delete_chart_product');
      // console.log(result);

      if (result.recordset[0] != null) {
        let resulta = await getTotal(result, Chart.lama);
        await callback(resulta);
        await mssql.close();
      } else {
        await callback(false);
        await mssql.close();
      }

    }
  } catch (error) {
    callback(false);
  }
}

const edit_chart = async (Chart, _key, callback) => {
  try {
    let valid = await getValidKeyAPI(Chart.id_ktp, _key);

    if (valid) {
      if (parseInt(Chart.jumlah) < 1) {
        try {
            let resultDelete = await  deleteChartItem(Chart,_key);
            callback(resultDelete);
        } catch (error) {
          callback(error);
        }
      } else {

        let pool = await getPool();
        let result = await pool.request()
          .input('kode_ktp', mssql.Char(16), Chart.id_ktp)
          .input('id_kamera', mssql.Char(5), Chart.id_kamera)
          .input('jumlah_pinjam', mssql.Int, parseInt(Chart.jumlah))
          .input('service', mssql.Char(5), Chart.service)
          .execute('jumlahProductChart');
        if (result.recordset[0] != null) {
          // console.log(result.rowsAffected.length);
          let resulta = await getTotal(result, Chart.lama);
          await callback(resulta);

        } else {
          await callback(false);
        }

        await mssql.close();
      }
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

    let valid = await getValidKeyAPI(id_ktp, keyAPI);
    if (valid) {
      let pool = await getPool();
      let result2 = await pool.request()
        .input('kode_ktp', mssql.Char(16), id_ktp)
        .execute('deleteChartAllByUser')

      if (result2.recordset[0] == null) {
        await callback(true);
      } else {
        await callback(false);
      }

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