/* select detail_kwitansi.no_kwitansi ,
	kwitansi.tanggal,users.nama ,detail_kwitansi.id_kamera,data_products.nama_kamera
	,data_products.harga,data_products.satuan,detail_kwitansi.jumlah_pinjam,
	type_service.id_service, type_service.nama_pelayanan ,type_service.ppn
	FROM detail_kwitansi JOIN kwitansi 
		ON kwitansi.no_kwitansi = detail_kwitansi.no_kwitansi
		JOIN data_products 
		ON data_products.id_kamera = detail_kwitansi.id_kamera
		JOIN users
		ON users.id_ktp = kwitansi.id_ktp
		JOIN type_service
		ON type_service.id_service = kwitansi.id_service; */

create View v_kwintasi AS
select detail_kwitansi.no_kwitansi ,
	kwitansi.tanggal,users.nama ,detail_kwitansi.id_kamera,data_products.nama_kamera
	,data_products.harga,data_products.satuan,detail_kwitansi.jumlah_pinjam,
	type_service.id_service, type_service.nama_pelayanan ,type_service.ppn
	FROM detail_kwitansi JOIN kwitansi 
		ON kwitansi.no_kwitansi = detail_kwitansi.no_kwitansi
		JOIN data_products 
		ON data_products.id_kamera = detail_kwitansi.id_kamera
		JOIN users
		ON users.id_ktp = kwitansi.id_ktp
		JOIN type_service
		ON type_service.id_service = kwitansi.id_service;


/* select detail_kwitansi.no_kwitansi,detail_kwitansi.id_kamera ,detail_kwitansi.jumlah_pinjam,
		type_service.ppn,
		data_products.harga * detail_kwitansi.jumlah_pinjam AS total,
		data_products.harga * type_service.ppn AS diskon,
		data_products.harga* detail_kwitansi.jumlah_pinjam - data_products.harga* type_service.ppn 
		AS total_bayar
		FROM data_products
		inner Join detail_kwitansi ON data_products.id_kamera = detail_kwitansi.id_kamera
		inner join kwitansi ON detail_kwitansi.no_kwitansi = kwitansi.no_kwitansi
		join type_service ON type_service.id_service = kwitansi.id_service; */

create view v_detail_kwitansi AS
select detail_kwitansi.no_kwitansi,detail_kwitansi.id_kamera ,detail_kwitansi.jumlah_pinjam,
		type_service.ppn,
		data_products.harga * detail_kwitansi.jumlah_pinjam AS total,
		data_products.harga * type_service.ppn AS diskon,
		data_products.harga* detail_kwitansi.jumlah_pinjam - data_products.harga* type_service.ppn 
		AS total_bayar
		FROM data_products
		inner Join detail_kwitansi ON data_products.id_kamera = detail_kwitansi.id_kamera
		inner join kwitansi ON detail_kwitansi.no_kwitansi = kwitansi.no_kwitansi
		join type_service ON type_service.id_service = kwitansi.id_service;
