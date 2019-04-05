function Users (id_ktp,nama,tempat_lahir,tanggal_lahir,alamat,jenis_kelamin,pekerjaan,no_hp){
  this.id_ktp = id_ktp;
  this.nama = nama;
  this.tempat_lahir = tempat_lahir;
  this.tanggal_lahir = tanggal_lahir;
  this.alamat = alamat;
  this.jenis_kelamin = jenis_kelamin;
  this.pekerjaan = pekerjaan;
  this.no_hp = no_hp;

}

module.exports = Users;