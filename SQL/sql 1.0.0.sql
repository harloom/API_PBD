/* SQL TABLE*/
/* table users*/
create table users (
	id_ktp char(16) primary key,
	nama_ varchar(50) not null,
	tempat_lahir varchar(25)  not null,
	tanggal_lahir date  not null,
	alamat varchar(100)  not null,
	jenis_kelamin varchar(15)  not null,
	pekerjaan varchar(25)  not null
)

/*  table login */
create table login_users (
	id_login char(10) primary key,
	id_ktp char(16)	not null foreign key references users(id_ktp),
	password_login varchar(200) not null,
	timestamp_login DateTIME not null	 

)

/*  table barang*/
create table data_products (
	id_kamera char(5) primary key,
	nama_kamera varchar (25) not null,
	harga int  not null,
	stok int  not null,
	satuan varchar(25) not null
	
) 

create table type_service ( 
	id_service char(5) primary key,
	nama_pelayanan varchar(25)  not null,
	ppn REAL not null
)

create table kwitansi (
	no_kwitansi char(10) primary key,
	lama_pinjam int  not null  ,
	tannga_pinjam date   not null,
	id_ktp char(16)	not null foreign key references users(id_ktp),
	id_service char(5) foreign key references type_service(id_service)
)

create table detail_kwitansi (
	no_kwitansi char(10) foreign key references   kwitansi(no_kwitansi) ON UPDATE CASCADE  ,
	id_kamera char(5) 	foreign key references data_products(id_kamera) ON UPDATE CASCADE ,
	jumlah_pinjam int not null ,
	
)


create table detail_kwintasi_simpan(
	id int IDENTITY(1,1) PRIMARY KEY,
	no_kwitansi char(10) not null  foreign key references  kwitansi(no_kwitansi),
	id_kamera char(5 )not null foreign key references data_products(id_kamera)  ,
	id_ktp char(16) not null,
	jumlah_pinjam int not null ,
	
)

create table charts (
	id_ktp char(16) foreign key references   users(id_ktp)  ,
	id_kamera char(5) 	foreign key references data_products(id_kamera),
	jumlah_pinjam int not null ,
	
)



