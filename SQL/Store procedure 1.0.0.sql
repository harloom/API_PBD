create procedure getLoginTask 
@id char(10) ,
@noHandphone varchar(15)
AS BEGIN
	select *from v_dataLoginTask where no_handphone = @noHandphone OR id_ktp = @id;
END;

create procedure getUser 
@idktp  char(16)
AS BEGIN
	select *from users where id_ktp  = @idktp;
END;


create procedure getUsers 
AS BEGIN
	select *from users ;
END;

create procedure save_user 
@id_ktp char(16),
@nama varchar(50),
@tempat_lahir varchar(25),
@tanggal_lahir date,
@alamat varchar(100),
@jenis_kelamin varchar(15),
@pekerjan varchar(25),
@no_handphone varchar(15)
AS BEGIN
	insert into users values (@id_ktp,@nama,@tempat_lahir,@tanggal_lahir,@alamat,@jenis_kelamin
				,@pekerjan,@no_handphone);
	select *from users ;
	
END;

create procedure saveUsersLoginTask
@id_login char(10),
@id_ktp char(16),
@password_login varchar(200),
@timestamp_login datetime
AS BEGIN
	insert into login_users values (@id_login,@id_ktp,@password_login,@timestamp_login);
END;

create procedure delete_user 
@id_ktp char(16)
AS BEGIN
	delete from users where id_ktp = @id_ktp;
END;

/* -----------------------------  products  --------------------------------  */

create procedure getProducts 
AS

BEGIN
	select *from data_products ;
END;

create procedure getProduct @idkamera char(5)
AS
BEGIN
	select *from  data_products where id_kamera = @idkamera;
END;

create procedure searchProductsByName @name varchar(25)
AS BEGIN
	select *from data_products where nama_kamera LIKE '%'+@name+'%' AND stok > 0 ORDER BY harga desc;
END

create procedure save_product
@idkamera char(5),
@nama varchar(25),
@harga int ,
@stok int, 
@satuan varchar(25)
AS	BEGIN
	SET @satuan = 'Unit';
	insert into data_products values (@idkamera,@nama,@harga,@stok,@satuan);
	execute getProducts;
END;

/* execute save_product 'C0001','Cannon V1',124000,100,''; */

create procedure delete_product
@id_kamrea char(5)
AS BEGIN
	delete from data_products where id_kamera = @id_kamrea;
	execute getProducts;
END;

create procedure edit_product 
@id_kamera char(5) ,
@nama varchar(25),
@harga int ,
@stok int, 
@satuan varchar(25)
AS 
BEGIN
	set @satuan = 'Unit';
	UPDATE data_products set nama_kamera = @nama ,
	harga = @harga,
	stok = @stok,
	satuan = @satuan where id_kamera = @id_kamera ;
END;


/* -----------------------------  charts  --------------------------------  */
create procedure getChart
@kode_ktp char(16)
AS BEGIN
	select *from charts where @kode_ktp = @kode_ktp;
END

create procedure delete_chart_product
@kode_ktp char(16),
@id_kamera char(5)
AS BEGIN
	delete from charts where id_kamera =@id_kamera AND @kode_ktp =@kode_ktp;
	execute getChart @kode_ktp;
END;

create procedure deleteChartAllByUser
@kode_ktp char(16)
AS BEGIN
	delete from charts where  @kode_ktp =@kode_ktp;
	execute getChart @kode_ktp;
END

create procedure jumlahProductChart 
@kode_ktp char(16),
@id_kamera char(5),
@jumlah_pinjam int
AS BEGIN
	UPDATE charts set jumlah_pinjam = @jumlah_pinjam 
	where id_kamera = @id_kamera AND @kode_ktp =@kode_ktp;

	execute getChart @kode_ktp;
END

create procedure save_chart
@kode_ktp char(16),
@id_kamera char(5),
@jumlah_pinjam int
AS BEGIN
	insert into charts values (	@kode_ktp,@id_kamera,@jumlah_pinjam);
	execute getChart @kode_ktp;
END;


/*----------------------------------------SERVICE-----------------------------*/

create procedure getServices
AS BEGIN
	select *from type_service;
END;

create procedure getService
@id_service char(5)
AS BEGIN
	select *from type_service where id_service = @id_service;
END;

create procedure edit_service 
@id_service char(5),
@nama_pelayanan varchar(25) ,
@ppn real
AS
BEGIN
	UPDATE type_service set nama_pelayanan  = @nama_pelayanan ,
	ppn = @ppn where id_service = @id_service;
END;


/* ------------------------------------kwitansi------------------------------*/
create procedure getViewKwitansi 
AS
BEGIN
	select *from v_kwitansi;
END;

create procedure getKwitansiUser
@id_ktp char(16)
AS
BEGIN
	select *from v_kwitansi where id_ktp = @id_ktp order by CONVERT(date,tanggal) ASC;
END;


create procedure getViewDetailKwitansi 
AS
BEGIN
	select *from v_detail_kwitansi;
END;

create procedure save_kwitansi 
@no_kwitansi char(10),
@id_ktp char(16),
@lama_pinjam int,
@tanggal date,
@id_service char(5)
AS BEGIN
		insert into kwitansi VALUES (@no_kwitansi,@lama_pinjam,@tanggal,@id_ktp,@id_service);
		SELECT *from kwitansi;
END;

create procedure delete_kwitansi
@no_kwitansi char(10)
AS BEGIN
	delete from kwitansi where no_kwitansi = @no_kwitansi;
	SELECT *FROM kwitansi;
END;

create procedure save_detail_kwitansi 
@no_kwitansi char(10),
@id_kamera char(5),
@Jumlah_pinham int
AS BEGIN
	INSERT INTO detail_kwitansi VALUES (@no_kwitansi,@id_kamera,@Jumlah_pinham);
	SELECT *FROM detail_kwitansi
END;

create procedure delete_detail_kwitansi 
@no_kwitansi char(10),
@id_kamera char(5)
AS BEGIN
	delete from detail_kwitansi where no_kwitansi = @no_kwitansi AND id_kamera = @id_kamera;
	SELECT *FROM detail_kwitansi;
END;



