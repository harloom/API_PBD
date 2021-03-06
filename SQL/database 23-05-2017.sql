USE [db_developer]
GO
/****** Object:  User [zero]    Script Date: 23/05/2019 04:12:23 ******/
CREATE USER [zero] FOR LOGIN [zero] WITH DEFAULT_SCHEMA=[db_datareader]
GO
/****** Object:  StoredProcedure [dbo].[batalkanPesanan]    Script Date: 23/05/2019 04:12:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[batalkanPesanan] 
@no_kwitansi char(10),
@id_ktp varchar(16)
AS
BEGIN
execute deleteDetailKwintasiAll @no_kwitansi;
delete from detail_kwitansi_simpan where no_kwitansi = @no_kwitansi;
execute delete_kwitansi @no_kwitansi,@id_ktp;
execute getViewKwitansi @id_ktp;

END;
GO
/****** Object:  StoredProcedure [dbo].[batalkanPesananSecuirty]    Script Date: 23/05/2019 04:12:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[batalkanPesananSecuirty] 
@no_kwitansi char(10)
AS
BEGIN
select no_kwitansi,statusB from v_kwitansi where no_kwitansi = @no_kwitansi and statusB ='Pinjam';

END
GO
/****** Object:  StoredProcedure [dbo].[checkKey]    Script Date: 23/05/2019 04:12:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[checkKey] 
@keyAPI varchar(200),
@id_ktp char(16)
As  
Begin  
   
Declare @Exist bit = 0 ; 
 
IF EXISTS( Select id From login_users Where keyAPI=@keyAPI AND id_ktp = @id_ktp Collate SQL_Latin1_General_CP1_CS_AS) 
	SET @Exist = 1;
    return @Exist;
end   
GO
/****** Object:  StoredProcedure [dbo].[delete_chart_product]    Script Date: 23/05/2019 04:12:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[delete_chart_product]
@kode_ktp char(16),
@id_kamera char(5)
AS BEGIN
	delete from charts where id_kamera =@id_kamera AND @kode_ktp =@kode_ktp;
	execute getChart @kode_ktp;
END;
GO
/****** Object:  StoredProcedure [dbo].[delete_detail_kwitansi]    Script Date: 23/05/2019 04:12:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[delete_detail_kwitansi] 
@no_kwitansi char(10),
@id_kamera char(5)
AS BEGIN
	delete from detail_kwitansi where no_kwitansi = @no_kwitansi AND id_kamera = @id_kamera;
	SELECT *FROM detail_kwitansi where no_kwitansi = @no_kwitansi AND id_kamera = @id_kamera;
END;
GO
/****** Object:  StoredProcedure [dbo].[delete_kwitansi]    Script Date: 23/05/2019 04:12:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[delete_kwitansi]
@no_kwitansi char(10),
@id_ktp char(16)
AS BEGIN
	delete from kwitansi where no_kwitansi = @no_kwitansi and id_ktp = @id_ktp ;
END;
GO
/****** Object:  StoredProcedure [dbo].[delete_product]    Script Date: 23/05/2019 04:12:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[delete_product]
@id_kamrea char(5)
AS BEGIN
	delete from data_products where id_kamera = @id_kamrea;
	execute getProducts;
END;
GO
/****** Object:  StoredProcedure [dbo].[delete_user]    Script Date: 23/05/2019 04:12:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[delete_user] 
@id_ktp char(16)
AS BEGIN
	delete from users where id_ktp = @id_ktp;
END;

GO
/****** Object:  StoredProcedure [dbo].[deleteChartAllByUser]    Script Date: 23/05/2019 04:12:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[deleteChartAllByUser]
@kode_ktp char(16)
AS BEGIN
	delete from charts where  @kode_ktp =@kode_ktp;
	execute getChart @kode_ktp;
END
GO
/****** Object:  StoredProcedure [dbo].[deleteDetailKwintasiAll]    Script Date: 23/05/2019 04:12:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[deleteDetailKwintasiAll]
@no_kwitansi char(10)
AS BEGIN  
delete from detail_kwitansi where no_kwitansi = @no_kwitansi ;
END;
GO
/****** Object:  StoredProcedure [dbo].[edit_product]    Script Date: 23/05/2019 04:12:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[edit_product] 
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
GO
/****** Object:  StoredProcedure [dbo].[edit_service]    Script Date: 23/05/2019 04:12:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[edit_service] 
@id_service char(5),
@nama_pelayanan varchar(25) ,
@ppn real
AS
BEGIN
	UPDATE type_service set nama_pelayanan  = @nama_pelayanan ,
	ppn = @ppn where id_service = @id_service;
END;
GO
/****** Object:  StoredProcedure [dbo].[getChart]    Script Date: 23/05/2019 04:12:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[getChart]
@kode_ktp char(16)
AS BEGIN
	select *from v_charts where id_ktp = @kode_ktp;
END
GO
/****** Object:  StoredProcedure [dbo].[getDetailHistory]    Script Date: 23/05/2019 04:12:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[getDetailHistory]
@no_kwitansi char(10)
AS
BEGIN
select *from v_detail_history where no_kwitansi = @no_kwitansi;
END;
GO
/****** Object:  StoredProcedure [dbo].[getHistory]    Script Date: 23/05/2019 04:12:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[getHistory] 
@id_ktp char(16)
AS 
BEGIN
select *from v_kwitansi where id_ktp = @id_ktp AND statusB='Dikembalikan' ORDER BY tanggal DESC ;
END;
GO
/****** Object:  StoredProcedure [dbo].[getKeyApi]    Script Date: 23/05/2019 04:12:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[getKeyApi] @id varchar(15)
AS BEGIN
	select keyAPI from login_users where id= @id;
END
GO
/****** Object:  StoredProcedure [dbo].[getKwitansiUser]    Script Date: 23/05/2019 04:12:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[getKwitansiUser]
@id_ktp char(16)
AS
BEGIN
	select *from v_kwitansi where id_ktp = @id_ktp order by CONVERT(date,tanggal) ASC;
END;

GO
/****** Object:  StoredProcedure [dbo].[getLoginTask]    Script Date: 23/05/2019 04:12:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[getLoginTask] 
@id_ktp char(16) ,
@no_hp varchar(15)
AS BEGIN
	select id,password_login from v_getLogin where no_handphone = @no_hp OR id_ktp =@id_ktp ;
END;
GO
/****** Object:  StoredProcedure [dbo].[getProduct]    Script Date: 23/05/2019 04:12:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[getProduct] @idkamera char(5)
AS
BEGIN
	select *from  data_products where id_kamera = @idkamera;
END;
GO
/****** Object:  StoredProcedure [dbo].[getProducts]    Script Date: 23/05/2019 04:12:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[getProducts] 
AS

BEGIN
	select *from data_products ;
END;
GO
/****** Object:  StoredProcedure [dbo].[getService]    Script Date: 23/05/2019 04:12:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[getService]
@id_service char(5)
AS BEGIN
	select *from type_service where id_service = @id_service;
END;
GO
/****** Object:  StoredProcedure [dbo].[getServices]    Script Date: 23/05/2019 04:12:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[getServices]
AS BEGIN
	select *from type_service;
END;
GO
/****** Object:  StoredProcedure [dbo].[getUser]    Script Date: 23/05/2019 04:12:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[getUser] 
@idktp  char(16)
AS BEGIN
	select *from users where id_ktp  = @idktp;
END;
GO
/****** Object:  StoredProcedure [dbo].[getUsers]    Script Date: 23/05/2019 04:12:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[getUsers] 
AS BEGIN
	select *from users ;
END;
GO
/****** Object:  StoredProcedure [dbo].[getViewDetailKwitansi]    Script Date: 23/05/2019 04:12:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[getViewDetailKwitansi] 
@no_kwitansi char(10)
AS
BEGIN
	select *from v_detail_kwitansi where no_kwitansi = @no_kwitansi ;
END;
GO
/****** Object:  StoredProcedure [dbo].[getViewKwitansi]    Script Date: 23/05/2019 04:12:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[getViewKwitansi] 
@id_ktp char(16)
AS
BEGIN
	select *from v_kwitansi where id_ktp = @id_ktp AND (statusB='Pinjam' OR statusB='Terima') ORDER BY tanggal DESC ;
END;
GO
/****** Object:  StoredProcedure [dbo].[jumlahProductChart]    Script Date: 23/05/2019 04:12:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[jumlahProductChart] 
@kode_ktp char(16),
@id_kamera char(5),
@jumlah_pinjam int,
@service char(5)

AS BEGIN
	UPDATE charts set jumlah_pinjam = @jumlah_pinjam ,id_service =@service
	where id_kamera = @id_kamera AND @kode_ktp =@kode_ktp;

		select *from v_charts where id_ktp = @kode_ktp ;
END
GO
/****** Object:  StoredProcedure [dbo].[loginTask]    Script Date: 23/05/2019 04:12:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[loginTask]
@id varchar(15),
@id_ktp char(16),
@password varchar(200),
@key varchar(200)
AS BEGIN
	insert into login_users Values (@id,@id_ktp,@password,GETDATE(),@key);
END;
GO
/****** Object:  StoredProcedure [dbo].[save_chart]    Script Date: 23/05/2019 04:12:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[save_chart]
@kode_ktp char(16),
@id_kamera char(5),
@jumlah_pinjam int,
@service char(5)
AS BEGIN
	insert into charts values (	@kode_ktp,@id_kamera,@jumlah_pinjam,@service);
	execute getChart @kode_ktp;
END;
GO
/****** Object:  StoredProcedure [dbo].[save_detail_kwitansi]    Script Date: 23/05/2019 04:12:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[save_detail_kwitansi] 
@no_kwitansi char(10),
@id_kamera char(5),
@Jumlah_pinjam int
AS BEGIN
	INSERT INTO detail_kwitansi VALUES (@no_kwitansi,@id_kamera,@Jumlah_pinjam);
	SELECT *FROM v_detail_kwitansi where no_kwitansi = @no_kwitansi;
END;
GO
/****** Object:  StoredProcedure [dbo].[save_kwitansi]    Script Date: 23/05/2019 04:12:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[save_kwitansi] 
@no_kwitansi char(10),
@id_ktp char(16),
@lama_pinjam int,
@id_service char(5),
@alamat_antar varchar(200)
AS BEGIN
		insert into kwitansi VALUES (@no_kwitansi,@lama_pinjam,GETDATE(),@id_ktp,@id_service,@alamat_antar,DATEADD(DAY,@lama_pinjam,GETDATE()),'');
		select no_kwitansi from kwitansi where no_kwitansi = @no_kwitansi;
END;
GO
/****** Object:  StoredProcedure [dbo].[save_product]    Script Date: 23/05/2019 04:12:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[save_product]
@idkamera char(5),
@nama varchar(25),
@harga int ,
@stok int, 
@url varchar(200),
@satuan varchar(25)
AS	BEGIN
	SET @satuan = 'Unit';
	insert into data_products values (@idkamera,@nama,@harga,@stok,@url,@satuan);
	execute getProducts;
END;
GO
/****** Object:  StoredProcedure [dbo].[save_user]    Script Date: 23/05/2019 04:12:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[save_user] 
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
	execute getUser @id_ktp ;
	
END;
GO
/****** Object:  StoredProcedure [dbo].[searchProductsByName]    Script Date: 23/05/2019 04:12:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[searchProductsByName] @name varchar(25)
AS BEGIN
	select *from data_products where nama_kamera LIKE '%'+@name+'%' AND stok > 0 ORDER BY harga desc;
END
GO
/****** Object:  StoredProcedure [dbo].[updateStatus]    Script Date: 23/05/2019 04:12:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[updateStatus] @no_kwitansi char(10), @status varchar(20)
AS 
BEGIN
	Update kwitansi set statusB = @status where no_kwitansi = @no_kwitansi;
END;
GO
/****** Object:  Table [dbo].[charts]    Script Date: 23/05/2019 04:12:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[charts](
	[id_ktp] [char](16) NOT NULL,
	[id_kamera] [char](5) NOT NULL,
	[jumlah_pinjam] [int] NOT NULL,
	[id_service] [char](5) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id_ktp] ASC,
	[id_kamera] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[data_products]    Script Date: 23/05/2019 04:12:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[data_products](
	[id_kamera] [char](5) NOT NULL,
	[nama_kamera] [varchar](25) NOT NULL,
	[harga] [int] NOT NULL,
	[stok] [int] NOT NULL,
	[url_image] [varchar](200) NULL,
	[satuan] [varchar](25) NOT NULL,
 CONSTRAINT [PK__data_pro__D3CB262C3E814B23] PRIMARY KEY CLUSTERED 
(
	[id_kamera] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[detail_kwitansi]    Script Date: 23/05/2019 04:12:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[detail_kwitansi](
	[no_kwitansi] [char](10) NULL,
	[id_kamera] [char](5) NULL,
	[jumlah_pinjam] [int] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[detail_kwitansi_simpan]    Script Date: 23/05/2019 04:12:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[detail_kwitansi_simpan](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[no_kwitansi] [char](10) NOT NULL,
	[id_kamera] [char](5) NOT NULL,
	[jumlah_pinjam] [int] NOT NULL,
	[tanggal_dikembalikan] [datetime] NOT NULL,
 CONSTRAINT [PK__detail_k__3213E83F04B35F2C] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[kwitansi]    Script Date: 23/05/2019 04:12:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[kwitansi](
	[no_kwitansi] [char](10) NOT NULL,
	[lama_pinjam] [int] NOT NULL,
	[tanggal] [datetime] NOT NULL,
	[id_ktp] [char](16) NOT NULL,
	[id_service] [char](5) NOT NULL,
	[alamat_antar] [varchar](200) NOT NULL,
	[tanggal_expire] [datetime] NOT NULL,
	[statusB] [varchar](20) NULL,
 CONSTRAINT [PK__kwitansi__9B4C90FA02B69764] PRIMARY KEY CLUSTERED 
(
	[no_kwitansi] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[login_users]    Script Date: 23/05/2019 04:12:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[login_users](
	[id] [varchar](15) NOT NULL,
	[id_ktp] [char](16) NOT NULL,
	[password_login] [varchar](200) NOT NULL,
	[timestamp_login] [datetime] NULL,
	[keyAPI] [varchar](200) NOT NULL,
 CONSTRAINT [PK__login_us__1DEA7BADABDF3B6D] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[type_service]    Script Date: 23/05/2019 04:12:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[type_service](
	[id_service] [char](5) NOT NULL,
	[nama_pelayanan] [varchar](25) NOT NULL,
	[ppn] [real] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id_service] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[users]    Script Date: 23/05/2019 04:12:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[users](
	[id_ktp] [char](16) NOT NULL,
	[nama] [varchar](50) NOT NULL,
	[tempat_lahir] [varchar](25) NOT NULL,
	[tanggal_lahir] [date] NOT NULL,
	[alamat] [varchar](100) NOT NULL,
	[jenis_kelamin] [varchar](15) NOT NULL,
	[pekerjaan] [varchar](25) NOT NULL,
	[no_handphone] [varchar](15) NOT NULL,
 CONSTRAINT [PK__users__D496DA062E2EF741] PRIMARY KEY CLUSTERED 
(
	[id_ktp] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  View [dbo].[v_charts]    Script Date: 23/05/2019 04:12:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[v_charts]
AS
SELECT        dbo.users.id_ktp, dbo.data_products.id_kamera, dbo.data_products.nama_kamera, dbo.data_products.harga, dbo.charts.jumlah_pinjam, dbo.data_products.satuan, dbo.data_products.url_image, dbo.users.nama, 
                         dbo.data_products.harga * dbo.charts.jumlah_pinjam AS jumlah_bayar, dbo.type_service.id_service, dbo.data_products.harga * dbo.charts.jumlah_pinjam AS total, dbo.data_products.harga * dbo.type_service.ppn AS pajak
FROM            dbo.charts INNER JOIN
                         dbo.users ON dbo.charts.id_ktp = dbo.users.id_ktp INNER JOIN
                         dbo.data_products ON dbo.charts.id_kamera = dbo.data_products.id_kamera INNER JOIN
                         dbo.type_service ON dbo.charts.id_service = dbo.type_service.id_service

GO
/****** Object:  View [dbo].[v_detail_history]    Script Date: 23/05/2019 04:12:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[v_detail_history]
AS
SELECT        dbo.detail_kwitansi_simpan.no_kwitansi, dbo.detail_kwitansi_simpan.id_kamera, dbo.detail_kwitansi_simpan.jumlah_pinjam, dbo.detail_kwitansi_simpan.tanggal_dikembalikan, dbo.type_service.ppn, 
                         dbo.data_products.harga * dbo.detail_kwitansi_simpan.jumlah_pinjam AS total, dbo.data_products.harga * dbo.type_service.ppn AS pajak, 
                         dbo.data_products.harga * dbo.detail_kwitansi_simpan.jumlah_pinjam + dbo.data_products.harga * dbo.type_service.ppn AS total_bayar, dbo.data_products.harga, dbo.data_products.url_image, dbo.data_products.satuan
FROM            dbo.detail_kwitansi_simpan INNER JOIN
                         dbo.data_products ON dbo.detail_kwitansi_simpan.id_kamera = dbo.data_products.id_kamera INNER JOIN
                         dbo.kwitansi ON dbo.detail_kwitansi_simpan.no_kwitansi = dbo.kwitansi.no_kwitansi INNER JOIN
                         dbo.type_service ON dbo.kwitansi.id_service = dbo.type_service.id_service

GO
/****** Object:  View [dbo].[v_detail_kwitansi]    Script Date: 23/05/2019 04:12:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[v_detail_kwitansi]
AS
SELECT        dbo.detail_kwitansi.no_kwitansi, dbo.detail_kwitansi.id_kamera, dbo.data_products.nama_kamera, dbo.data_products.harga, dbo.detail_kwitansi.jumlah_pinjam, dbo.type_service.ppn, 
                         dbo.data_products.harga * dbo.detail_kwitansi.jumlah_pinjam AS total, dbo.data_products.harga * dbo.type_service.ppn AS pajak, 
                         dbo.data_products.harga * dbo.detail_kwitansi.jumlah_pinjam + dbo.data_products.harga * dbo.type_service.ppn AS total_bayar, dbo.data_products.url_image, dbo.data_products.satuan
FROM            dbo.data_products INNER JOIN
                         dbo.detail_kwitansi ON dbo.data_products.id_kamera = dbo.detail_kwitansi.id_kamera INNER JOIN
                         dbo.kwitansi ON dbo.detail_kwitansi.no_kwitansi = dbo.kwitansi.no_kwitansi INNER JOIN
                         dbo.type_service ON dbo.type_service.id_service = dbo.kwitansi.id_service

GO
/****** Object:  View [dbo].[v_getLogin]    Script Date: 23/05/2019 04:12:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[v_getLogin]
AS
SELECT        dbo.login_users.id, dbo.login_users.id_ktp, dbo.users.no_handphone, dbo.login_users.password_login, dbo.login_users.timestamp_login
FROM            dbo.users INNER JOIN
                         dbo.login_users ON dbo.users.id_ktp = dbo.login_users.id_ktp

GO
/****** Object:  View [dbo].[v_kwitansi]    Script Date: 23/05/2019 04:12:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[v_kwitansi]
AS
SELECT        dbo.kwitansi.tanggal, dbo.kwitansi.tanggal_expire, dbo.users.id_ktp, dbo.users.nama, dbo.type_service.nama_pelayanan, dbo.kwitansi.no_kwitansi, dbo.kwitansi.lama_pinjam, dbo.kwitansi.statusB, 
                         dbo.kwitansi.alamat_antar
FROM            dbo.kwitansi INNER JOIN
                         dbo.users ON dbo.users.id_ktp = dbo.kwitansi.id_ktp INNER JOIN
                         dbo.type_service ON dbo.type_service.id_service = dbo.kwitansi.id_service

GO
INSERT [dbo].[charts] ([id_ktp], [id_kamera], [jumlah_pinjam], [id_service]) VALUES (N'0000000000000010', N'C0001', 7, N'S0001')
INSERT [dbo].[data_products] ([id_kamera], [nama_kamera], [harga], [stok], [url_image], [satuan]) VALUES (N'C0001', N'Cannon V1', 124000, 82, N'C0001.jpg', N'Unit')
INSERT [dbo].[data_products] ([id_kamera], [nama_kamera], [harga], [stok], [url_image], [satuan]) VALUES (N'C0002', N'Cannon V2040', 200000, 70, N'C0001.jpg', N'Unit')
INSERT [dbo].[detail_kwitansi] ([no_kwitansi], [id_kamera], [jumlah_pinjam]) VALUES (N'9901528480', N'C0001', 1)
INSERT [dbo].[detail_kwitansi] ([no_kwitansi], [id_kamera], [jumlah_pinjam]) VALUES (N'9901528480', N'C0002', 1)
INSERT [dbo].[detail_kwitansi] ([no_kwitansi], [id_kamera], [jumlah_pinjam]) VALUES (N'6873679039', N'C0001', 1)
INSERT [dbo].[detail_kwitansi] ([no_kwitansi], [id_kamera], [jumlah_pinjam]) VALUES (N'6873679039', N'C0002', 1)
INSERT [dbo].[detail_kwitansi] ([no_kwitansi], [id_kamera], [jumlah_pinjam]) VALUES (N'9504437865', N'C0001', 1)
SET IDENTITY_INSERT [dbo].[detail_kwitansi_simpan] ON 

INSERT [dbo].[detail_kwitansi_simpan] ([id], [no_kwitansi], [id_kamera], [jumlah_pinjam], [tanggal_dikembalikan]) VALUES (2057, N'1686394561', N'C0001', 1, CAST(0x0000AA4F0032ABB0 AS DateTime))
INSERT [dbo].[detail_kwitansi_simpan] ([id], [no_kwitansi], [id_kamera], [jumlah_pinjam], [tanggal_dikembalikan]) VALUES (2075, N'6864882439', N'C0002', 1, CAST(0x0000AA5000E48612 AS DateTime))
SET IDENTITY_INSERT [dbo].[detail_kwitansi_simpan] OFF
INSERT [dbo].[kwitansi] ([no_kwitansi], [lama_pinjam], [tanggal], [id_ktp], [id_service], [alamat_antar], [tanggal_expire], [statusB]) VALUES (N'1686394561', 1, CAST(0x0000AA4E013B2653 AS DateTime), N'0000000000000010', N'S0001', N'Meteo', CAST(0x0000AA4F013B2653 AS DateTime), N'Dikembalikan')
INSERT [dbo].[kwitansi] ([no_kwitansi], [lama_pinjam], [tanggal], [id_ktp], [id_service], [alamat_antar], [tanggal_expire], [statusB]) VALUES (N'6864882439', 5, CAST(0x0000AA5000E3C9D3 AS DateTime), N'0000000000000002', N'S0001', N'palapa', CAST(0x0000AA5500E3C9D3 AS DateTime), N'Dikembalikan')
INSERT [dbo].[kwitansi] ([no_kwitansi], [lama_pinjam], [tanggal], [id_ktp], [id_service], [alamat_antar], [tanggal_expire], [statusB]) VALUES (N'6873679039', 1, CAST(0x0000AA4F00F0F384 AS DateTime), N'0000000000000010', N'S0001', N'ss', CAST(0x0000AA5000F0F384 AS DateTime), N'Terima')
INSERT [dbo].[kwitansi] ([no_kwitansi], [lama_pinjam], [tanggal], [id_ktp], [id_service], [alamat_antar], [tanggal_expire], [statusB]) VALUES (N'9504437865', 1, CAST(0x0000AA4E00FD0470 AS DateTime), N'1812345678912345', N'S0001', N'jl.za pagar alam no. 10, balam', CAST(0x0000AA4F00FD0470 AS DateTime), N'Pinjam')
INSERT [dbo].[kwitansi] ([no_kwitansi], [lama_pinjam], [tanggal], [id_ktp], [id_service], [alamat_antar], [tanggal_expire], [statusB]) VALUES (N'9901528480', 1, CAST(0x0000AA4D01793B92 AS DateTime), N'9999999999999999', N'S0001', N'Antar', CAST(0x0000AA4E01793B92 AS DateTime), N'Pinjam')
INSERT [dbo].[login_users] ([id], [id_ktp], [password_login], [timestamp_login], [keyAPI]) VALUES (N'5l3ucvh', N'9999999999999992', N'$2b$10$ICUb/3irJH.mdLPYDmL1oep//G6l3xXqrF1Z8.tZh1Gj0yzud6iK6', CAST(0x0000AA4000EF758C AS DateTime), N'KSSAwsA8RRcTbYwoVTks5FaiyorAjZ6L1prn4FsfpqlTruOg610sq2UF43dnHRnCLHF1gEUq4fwXsuBnNPPwOHJVoGAPSmPMpkpm')
INSERT [dbo].[login_users] ([id], [id_ktp], [password_login], [timestamp_login], [keyAPI]) VALUES (N'8Ciic3S', N'1852369785857412', N'$2b$10$30cHgs39nxlIC4RxuaPpeOEh4ejO2/Mg2iBw2ar26uQMtQz/aXKQa', CAST(0x0000AA4E00FB6AE2 AS DateTime), N'L0LZYMSyjuzApT0u3nc2neTtfL5fgwB0BjYPMHRotIXSOVjgM1WkMz0NfwEEHMGy8lBe8CtjGoAbDqafIx9Hr3bR3yfVietcxzwz')
INSERT [dbo].[login_users] ([id], [id_ktp], [password_login], [timestamp_login], [keyAPI]) VALUES (N'8y17LCh', N'1234567890123456', N'$2b$10$pYiouHlBSTnkdFYRiUYz2.7XWCwqPz.S3zCrNa4FKCge/jgHmC2dC', CAST(0x0000AA4E00FEFE65 AS DateTime), N'SJTtaa4Ah1xjwoa0XLOybjaQwP3aZdMCC6Q1jEZcdHojSeqXFS7Yx0k0Uddo3OaWglMaWrRSTjQQ0VcMVA4nslFHd3XIw0Aib1WY')
INSERT [dbo].[login_users] ([id], [id_ktp], [password_login], [timestamp_login], [keyAPI]) VALUES (N'BvifMLk', N'7755446655113345', N'$2b$10$vTQpgLsa0RdYwLICHDvziOCyAVX/2/DlEKDNrXrWaI9c0nlCXvjCO', CAST(0x0000AA4E00FE3B9A AS DateTime), N'f65O0JQNZhfE2bmB74ke3UoNIiJq8w8smzmkBeaqmxLNN6lnDdTHr0nmkx7uUi4nKDbkTnTUhT2UBUwBhiqeF8b6ROTRApSGdoTi')
INSERT [dbo].[login_users] ([id], [id_ktp], [password_login], [timestamp_login], [keyAPI]) VALUES (N'bzsG9Mi', N'1000000000000000', N'$2b$10$aiYoxHnTQKSUGG2NFez7eeFWp5l1839YVrpTsxkyhDey6ofg.1Tla', CAST(0x0000AA2700E0C53A AS DateTime), N'W5Z21firY0uwq81YcDievlDWGaYUe3XIf0sWUnV7X3blT1us709ZbWY521Fl2BeLob1PSqlpsp3nAzOeCtjzgFiZzbrlZNhbTjtG')
INSERT [dbo].[login_users] ([id], [id_ktp], [password_login], [timestamp_login], [keyAPI]) VALUES (N'ExRW2Ka', N'0000000000000001', N'$2b$10$Q0nphtEMrug1ry84Jhi/CO0Xp9l3wIad/dof9yjaaDo3r.sgGJ/nO', CAST(0x0000AA2700D8AFD0 AS DateTime), N'pEu4BnBOwInSNMF6Pncj')
INSERT [dbo].[login_users] ([id], [id_ktp], [password_login], [timestamp_login], [keyAPI]) VALUES (N'Gu4Wl5D', N'1812345678912345', N'$2b$10$5KXI5Kho0dpjuZLzo1dkGuCfNOaaJ36BSlrRvQooZAqijBICp/10C', CAST(0x0000AA4E00FC9002 AS DateTime), N'UvSFY2ZwrbshishGpBFZHBLavO7c6DyO8jVspNPbU5jfWSOK1MKZiXXjgk1ynnFJ7aZVvafe1U3aYhXcVP0LDalqOgKZ4PbcvtC5')
INSERT [dbo].[login_users] ([id], [id_ktp], [password_login], [timestamp_login], [keyAPI]) VALUES (N'GVREmvV', N'2000000000000000', N'$2b$10$I69hbX6DHNHUr3/y.3FqJOWS6RSvxyDmH5ywNEppMeVEE3lkCunS.', CAST(0x0000AA2800D7D95B AS DateTime), N'7qBNUbF8xldqql3c62xjaLW4wN1x79DSdyt9RQHyH3jhKdLyW1Oas6Z2tVg4ehN72LFkLNpbz7TWx8UB93IEQ7TXa3fzhFpSi3dl')
INSERT [dbo].[login_users] ([id], [id_ktp], [password_login], [timestamp_login], [keyAPI]) VALUES (N'IsryLaO', N'0000000000000000', N'$2b$10$UcmF3UxyGtPJndopMiDMQOlux8gvWDEQuKzavxTB/ceHPUqMj27Ue', CAST(0x0000AA2700084A96 AS DateTime), N'KN5gE6C6M5luFXdFMWl8')
INSERT [dbo].[login_users] ([id], [id_ktp], [password_login], [timestamp_login], [keyAPI]) VALUES (N'lu8EQ76', N'9999999999999112', N'$2b$10$qm4/JS7UoJXHm6ywH0smdeggea867pRqdItMiZbjXZp.LltYMvY.C', CAST(0x0000AA400100EEC8 AS DateTime), N'H2z1xiOuKjWor7mIFERJf41e4b4oXfn2vRfgp0VwmAzC4TqIdhX3C2sKu36T6Gygtd0fOlzPwCUehgOKaGNWqOigiqYnGyVT2b8H')
INSERT [dbo].[login_users] ([id], [id_ktp], [password_login], [timestamp_login], [keyAPI]) VALUES (N'mSEXrze', N'0000000000000010', N'$2b$10$Q3MHvokdBJ1g8d.fcTXKD.YAytucXvEee9eQ7CGnZC.B5ybS92jWq', CAST(0x0000AA4E011DC174 AS DateTime), N'iYHjqEFBdsoofIIUayMyUuSb0tiDkJbgE5JleMqHHRQxEDsGX6qtAKeIq1PyHtMJzaqd53AzQrUMKr5rueres5Z8Shh7zgqmlEIp')
INSERT [dbo].[login_users] ([id], [id_ktp], [password_login], [timestamp_login], [keyAPI]) VALUES (N'mYfOXAR', N'1234123412341234', N'$2b$10$NpjgbJeMlaz0awyYRnGMSOXAkqO7FZrmBBKWlwe667EMQC0O5jJQS', CAST(0x0000AA4200F12FDE AS DateTime), N'DGivnpeKS4rIJGyRy3Kz3I1vjtR5pq9p5QHIb7KQqDxtuLedYvk3xyOxeEi6MO6Az0bo1AE7tfTH2yNhzwTwJKTpa11kVY67IIIh')
INSERT [dbo].[login_users] ([id], [id_ktp], [password_login], [timestamp_login], [keyAPI]) VALUES (N'OUtdUiL', N'9999999999999991', N'$2b$10$DAEifRnFvcsD0mRrFWUb/Oww.WgHQyyLUKSyS8AGgI1tIqhFnhPTe', CAST(0x0000AA3C016D6100 AS DateTime), N'bOK60q0D6UkCWk0jdLqMo6gFGu5fGuDoJB3MwtQXObZEA3OlunaB31vH3VPC1VY5ReHEnFJ1QHRYSbb3vPXLSlhSi3C0qBCIS90x')
INSERT [dbo].[login_users] ([id], [id_ktp], [password_login], [timestamp_login], [keyAPI]) VALUES (N'OycZgGr', N'9999999999999111', N'$2b$10$9M.zlEvZdrxubkK8Hy2wY.7ABMRrHtYxGgpZpTEX9NcF6iL632wOe', CAST(0x0000AA4000F2E151 AS DateTime), N'od8Lo8gU8FPWDJZ3uVFouQ6zUHr275RA0Z0sm2bXKIKcboDrRQzHLw2W3sWcmBaexC5pPTIGmDShG75HSacTnSZIYZarjgZGNIjI')
INSERT [dbo].[login_users] ([id], [id_ktp], [password_login], [timestamp_login], [keyAPI]) VALUES (N'pRwmPxV', N'9999999999999988', N'$2b$10$xq8wxOTqjmnFoWnfHBy0Weh2QNuT/h0YcgMHMGvumSBL2nWD5Ps5.', CAST(0x0000AA4000F102A0 AS DateTime), N'CSsM2kq7dUhKBNHAE80IYyNyDiVlgWivCNweu56E4KgPN8eXQOft1ioAZC6hASptl9vNxtymNrZgsph9vRDpQ6zs1OkCA5iQXwsM')
INSERT [dbo].[login_users] ([id], [id_ktp], [password_login], [timestamp_login], [keyAPI]) VALUES (N'Rsqbyg1', N'0831706919203331', N'$2b$10$3DAtjlqomvjbYnFvYeUzsuq/IdFn5mMdZmHhWEYPV5G.8lR0pvCTK', CAST(0x0000AA5000E67122 AS DateTime), N'1XO8nWo1Hkzir1ONXsHoooK5iVdfBF49KSspBbxSFEqrVU8yxtwCluuo2arikxPagfsl5dM6dL1Upk2FkRtj1GWgPt5WyYmk8ccV')
INSERT [dbo].[login_users] ([id], [id_ktp], [password_login], [timestamp_login], [keyAPI]) VALUES (N'uupXNLG', N'9999999999999999', N'$2b$10$2fN5pcqrv2c.nxTvydQAWuH.i4MFhsALp0xYsPA24gVqiu7kRkthS', CAST(0x0000AA2900E145CC AS DateTime), N'OJJhqgv3pBifWiYSUXLPwyN5so3RPucG4ZdbK9ytWboktkoIPK94XxN5RSt2KpCf0U1OhHl0tFei676EpRekphvVtKBEhzL47gBm')
INSERT [dbo].[login_users] ([id], [id_ktp], [password_login], [timestamp_login], [keyAPI]) VALUES (N'VaVf6Ov', N'1111111111111111', N'$2b$10$0wQAutDDV27zAK3a7Xsgoevdkbtnnd0XQ2mC274GWXP/Qr7V0T98a', CAST(0x0000AA4100F25257 AS DateTime), N'ZM6VtwyOIW6sbTlPFNHyFHm7QQd9hCSxX0WjzSFVA0IZqmqFkkcZ16Ntbuww7BttaLYFECwPZnJrX3Q60rcJy1gXTGo9TOcfymvY')
INSERT [dbo].[login_users] ([id], [id_ktp], [password_login], [timestamp_login], [keyAPI]) VALUES (N'w9i8aKF', N'0000000000000100', N'$2b$10$Kw1woXkyz5F395TsvEg9A.QrbKT/EuFgdToeblPsJWhOCYOftpC5i', CAST(0x0000AA2700E04248 AS DateTime), N'RFPf59ZjS5Bv7SPImlM0')
INSERT [dbo].[login_users] ([id], [id_ktp], [password_login], [timestamp_login], [keyAPI]) VALUES (N'zvgll7T', N'0000000000000002', N'$2b$10$VI8waAsm6N8x0C5/I2mf6ORdojw2nPhjesIAljOc9tesoSA2rHMjW', CAST(0x0000AA5000E33DC1 AS DateTime), N'llRM26Tz1X6Nx0uj5Vwrjo2CHPoRMEJEf5X3dRj1K0GOcySE9XItNWCan739pBYBXUNMR0lvs0vxV54ExPXz9CuauFYO412nX2QW')
INSERT [dbo].[type_service] ([id_service], [nama_pelayanan], [ppn]) VALUES (N'S0001', N'Antar', 0.1)
INSERT [dbo].[type_service] ([id_service], [nama_pelayanan], [ppn]) VALUES (N'S0002', N'Ambil', 0)
INSERT [dbo].[users] ([id_ktp], [nama], [tempat_lahir], [tanggal_lahir], [alamat], [jenis_kelamin], [pekerjaan], [no_handphone]) VALUES (N'0000000000000000', N'ilham', N'Metro', CAST(0xA2220B00 AS Date), N'Jalan Khaibras', N'Male', N'Mahasiswa', N'082307304530')
INSERT [dbo].[users] ([id_ktp], [nama], [tempat_lahir], [tanggal_lahir], [alamat], [jenis_kelamin], [pekerjaan], [no_handphone]) VALUES (N'0000000000000001', N'Kuhaku', N'Metro', CAST(0xA2220B00 AS Date), N'Jalan Khaibras', N'Male', N'Mahasiswa', N'082307304530')
INSERT [dbo].[users] ([id_ktp], [nama], [tempat_lahir], [tanggal_lahir], [alamat], [jenis_kelamin], [pekerjaan], [no_handphone]) VALUES (N'0000000000000002', N'yurir', N'lampung', CAST(0xAB3F0B00 AS Date), N'lampung', N'Male', N'lecturer', N'085669933306')
INSERT [dbo].[users] ([id_ktp], [nama], [tempat_lahir], [tanggal_lahir], [alamat], [jenis_kelamin], [pekerjaan], [no_handphone]) VALUES (N'0000000000000010', N'Admin', N'Bandar Lampung', CAST(0xA93F0B00 AS Date), N'Bandar Lampung', N'Male', N'Full stack', N'082307604530')
INSERT [dbo].[users] ([id_ktp], [nama], [tempat_lahir], [tanggal_lahir], [alamat], [jenis_kelamin], [pekerjaan], [no_handphone]) VALUES (N'0000000000000100', N'shiro', N'Kyoto', CAST(0xA2220B00 AS Date), N'Jalan Khaibras', N'Male', N'Mahasiswa', N'082307304530')
INSERT [dbo].[users] ([id_ktp], [nama], [tempat_lahir], [tanggal_lahir], [alamat], [jenis_kelamin], [pekerjaan], [no_handphone]) VALUES (N'0831706919203331', N'Nando', N'Wakanda', CAST(0xAB3F0B00 AS Date), N'Wakanda', N'Male', N'Ngangur', N'88888888881')
INSERT [dbo].[users] ([id_ktp], [nama], [tempat_lahir], [tanggal_lahir], [alamat], [jenis_kelamin], [pekerjaan], [no_handphone]) VALUES (N'1000000000000000', N'Megumin', N'Kyoto', CAST(0xA2220B00 AS Date), N'Jalan Khaibras', N'Male', N'Mahasiswa', N'082307304530')
INSERT [dbo].[users] ([id_ktp], [nama], [tempat_lahir], [tanggal_lahir], [alamat], [jenis_kelamin], [pekerjaan], [no_handphone]) VALUES (N'1111111111111111', N'development', N'metro', CAST(0x9B3F0B00 AS Date), N'lampung', N'Male', N'Digital', N'081379161613')
INSERT [dbo].[users] ([id_ktp], [nama], [tempat_lahir], [tanggal_lahir], [alamat], [jenis_kelamin], [pekerjaan], [no_handphone]) VALUES (N'1234123412341234', N'kakaa', N'metro', CAST(0x303F0B00 AS Date), N'indo', N'Male', N'fullstack developer', N'08230738453030')
INSERT [dbo].[users] ([id_ktp], [nama], [tempat_lahir], [tanggal_lahir], [alamat], [jenis_kelamin], [pekerjaan], [no_handphone]) VALUES (N'1234567890123456', N'saya wibu', N'tokyo', CAST(0xBC210B00 AS Date), N'saitama', N'Male', N'pedofil', N'08642546721')
INSERT [dbo].[users] ([id_ktp], [nama], [tempat_lahir], [tanggal_lahir], [alamat], [jenis_kelamin], [pekerjaan], [no_handphone]) VALUES (N'1812345678912345', N'hai bro', N'durian runtuh', CAST(0xA83F0B00 AS Date), N'there', N'Male', N'freelance', N'085764623655')
INSERT [dbo].[users] ([id_ktp], [nama], [tempat_lahir], [tanggal_lahir], [alamat], [jenis_kelamin], [pekerjaan], [no_handphone]) VALUES (N'1852369785857412', N'i dont know', N'village', CAST(0xA93F0B00 AS Date), N'here', N'Male', N'freelancer', N'02179102676')
INSERT [dbo].[users] ([id_ktp], [nama], [tempat_lahir], [tanggal_lahir], [alamat], [jenis_kelamin], [pekerjaan], [no_handphone]) VALUES (N'2000000000000000', N'KAZUMA', N'Kyoto', CAST(0xA2220B00 AS Date), N'Jalan Khaibras', N'Male', N'Mahasiswa', N'082307304530')
INSERT [dbo].[users] ([id_ktp], [nama], [tempat_lahir], [tanggal_lahir], [alamat], [jenis_kelamin], [pekerjaan], [no_handphone]) VALUES (N'7755446655113345', N'agung prayuda', N'Lampung tengah', CAST(0x4F230B00 AS Date), N'jln a yani', N'Male', N'mahasiswa', N'089628747979')
INSERT [dbo].[users] ([id_ktp], [nama], [tempat_lahir], [tanggal_lahir], [alamat], [jenis_kelamin], [pekerjaan], [no_handphone]) VALUES (N'9999999999999111', N'Nanda', N'Akihabara', CAST(0xA3220B00 AS Date), N'Jalan Khaibras', N'Male', N'Mahasiswa', N'082307304530')
INSERT [dbo].[users] ([id_ktp], [nama], [tempat_lahir], [tanggal_lahir], [alamat], [jenis_kelamin], [pekerjaan], [no_handphone]) VALUES (N'9999999999999112', N'Nanda', N'Akihabara', CAST(0xA3220B00 AS Date), N'Jalan Khaibras', N'Male', N'Mahasiswa', N'082307304530')
INSERT [dbo].[users] ([id_ktp], [nama], [tempat_lahir], [tanggal_lahir], [alamat], [jenis_kelamin], [pekerjaan], [no_handphone]) VALUES (N'9999999999999988', N'Nanda', N'Akihabara', CAST(0xA3220B00 AS Date), N'Jalan Khaibras', N'Male', N'Mahasiswa', N'082307304530')
INSERT [dbo].[users] ([id_ktp], [nama], [tempat_lahir], [tanggal_lahir], [alamat], [jenis_kelamin], [pekerjaan], [no_handphone]) VALUES (N'9999999999999991', N'Ilham', N'Akihabara', CAST(0xA3220B00 AS Date), N'Jalan Khaibras', N'Male', N'Mahasiswa', N'082307304530')
INSERT [dbo].[users] ([id_ktp], [nama], [tempat_lahir], [tanggal_lahir], [alamat], [jenis_kelamin], [pekerjaan], [no_handphone]) VALUES (N'9999999999999992', N'Nanda', N'Akihabara', CAST(0xA3220B00 AS Date), N'Jalan Khaibras', N'Male', N'Mahasiswa', N'082307304530')
INSERT [dbo].[users] ([id_ktp], [nama], [tempat_lahir], [tanggal_lahir], [alamat], [jenis_kelamin], [pekerjaan], [no_handphone]) VALUES (N'9999999999999999', N'Ilham Solehudin', N'Akihabara', CAST(0xA3220B00 AS Date), N'Jalan Khaibras', N'Male', N'Mahasiswa', N'082307304530')
ALTER TABLE [dbo].[charts]  WITH CHECK ADD  CONSTRAINT [FK_charts_data_products] FOREIGN KEY([id_kamera])
REFERENCES [dbo].[data_products] ([id_kamera])
GO
ALTER TABLE [dbo].[charts] CHECK CONSTRAINT [FK_charts_data_products]
GO
ALTER TABLE [dbo].[charts]  WITH CHECK ADD  CONSTRAINT [FK_charts_users] FOREIGN KEY([id_ktp])
REFERENCES [dbo].[users] ([id_ktp])
GO
ALTER TABLE [dbo].[charts] CHECK CONSTRAINT [FK_charts_users]
GO
ALTER TABLE [dbo].[detail_kwitansi]  WITH CHECK ADD  CONSTRAINT [FK__detail_kw__id_ka__412EB0B6] FOREIGN KEY([id_kamera])
REFERENCES [dbo].[data_products] ([id_kamera])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[detail_kwitansi] CHECK CONSTRAINT [FK__detail_kw__id_ka__412EB0B6]
GO
ALTER TABLE [dbo].[detail_kwitansi]  WITH CHECK ADD  CONSTRAINT [FK__detail_kw__no_kw__403A8C7D] FOREIGN KEY([no_kwitansi])
REFERENCES [dbo].[kwitansi] ([no_kwitansi])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[detail_kwitansi] CHECK CONSTRAINT [FK__detail_kw__no_kw__403A8C7D]
GO
ALTER TABLE [dbo].[detail_kwitansi_simpan]  WITH CHECK ADD  CONSTRAINT [FK_detail_kwintasi_simpan_data_products] FOREIGN KEY([id_kamera])
REFERENCES [dbo].[data_products] ([id_kamera])
GO
ALTER TABLE [dbo].[detail_kwitansi_simpan] CHECK CONSTRAINT [FK_detail_kwintasi_simpan_data_products]
GO
ALTER TABLE [dbo].[detail_kwitansi_simpan]  WITH CHECK ADD  CONSTRAINT [FK_detail_kwintasi_simpan_kwitansi] FOREIGN KEY([no_kwitansi])
REFERENCES [dbo].[kwitansi] ([no_kwitansi])
GO
ALTER TABLE [dbo].[detail_kwitansi_simpan] CHECK CONSTRAINT [FK_detail_kwintasi_simpan_kwitansi]
GO
ALTER TABLE [dbo].[kwitansi]  WITH CHECK ADD  CONSTRAINT [FK__kwitansi__id_ser__1A14E395] FOREIGN KEY([id_service])
REFERENCES [dbo].[type_service] ([id_service])
GO
ALTER TABLE [dbo].[kwitansi] CHECK CONSTRAINT [FK__kwitansi__id_ser__1A14E395]
GO
ALTER TABLE [dbo].[kwitansi]  WITH CHECK ADD  CONSTRAINT [FK_kwitansi_users] FOREIGN KEY([id_ktp])
REFERENCES [dbo].[users] ([id_ktp])
GO
ALTER TABLE [dbo].[kwitansi] CHECK CONSTRAINT [FK_kwitansi_users]
GO
ALTER TABLE [dbo].[login_users]  WITH CHECK ADD  CONSTRAINT [FK_login_users_users] FOREIGN KEY([id_ktp])
REFERENCES [dbo].[users] ([id_ktp])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[login_users] CHECK CONSTRAINT [FK_login_users_users]
GO
/****** Object:  Trigger [dbo].[afterDelete_detail_kwitansi]    Script Date: 23/05/2019 04:12:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE trigger  [dbo].[afterDelete_detail_kwitansi]
ON [dbo].[detail_kwitansi]
AFTER DELETE
AS
BEGIN
	DECLARE
		@jumlah int ,@id_kamera char(5),@no_kwitansi char(10)
		select @jumlah = jumlah_pinjam,@no_kwitansi = no_kwitansi ,
		@id_kamera = id_kamera from deleted
		UPDATE data_products set data_products.stok =
		data_products.stok + @jumlah where data_products.id_kamera = @id_kamera;
		
		UPDATE detail_kwitansi_simpan set detail_kwitansi_simpan.tanggal_dikembalikan =
		GETDATE()  where detail_kwitansi_simpan.no_kwitansi = @no_kwitansi; 
		
		execute updateStatus @no_kwitansi , 'Dikembalikan';
		insert into detail_kwitansi_simpan values (@no_kwitansi,@id_kamera,@jumlah,GETDATE());
END;

GO
/****** Object:  Trigger [dbo].[afterInsert_detail_kwitansi]    Script Date: 23/05/2019 04:12:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE trigger [dbo].[afterInsert_detail_kwitansi]
ON [dbo].[detail_kwitansi]
AFTER INSERT
AS BEGIN
	DECLARE
		@jumlah int ,@id_kamera char(5),@no_kwitansi char(10)
		select @jumlah = jumlah_pinjam,@no_kwitansi = no_kwitansi ,
		@id_kamera = id_kamera from inserted
		UPDATE data_products set data_products.stok =
		data_products.stok - @jumlah where data_products.id_kamera = @id_kamera;

	

END;

GO
/****** Object:  Trigger [dbo].[AfterInsertKwitansi]    Script Date: 23/05/2019 04:12:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create trigger [dbo].[AfterInsertKwitansi]
on [dbo].[kwitansi]
After insert
AS begin
  declare @no_kwitansi char(10)
	select @no_kwitansi = no_kwitansi from inserted
	update kwitansi set statusB = 'Pinjam' where no_kwitansi = @no_kwitansi;
END;

GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[41] 4[21] 2[26] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "users"
            Begin Extent = 
               Top = 14
               Left = 20
               Bottom = 144
               Right = 190
            End
            DisplayFlags = 280
            TopColumn = 4
         End
         Begin Table = "data_products"
            Begin Extent = 
               Top = 31
               Left = 497
               Bottom = 161
               Right = 667
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "type_service"
            Begin Extent = 
               Top = 170
               Left = 388
               Bottom = 283
               Right = 566
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "charts"
            Begin Extent = 
               Top = 22
               Left = 267
               Bottom = 135
               Right = 437
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
   ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'v_charts'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'   End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'v_charts'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'v_charts'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[41] 4[21] 2[16] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "detail_kwitansi_simpan"
            Begin Extent = 
               Top = 6
               Left = 246
               Bottom = 147
               Right = 451
            End
            DisplayFlags = 280
            TopColumn = 1
         End
         Begin Table = "data_products"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 2
         End
         Begin Table = "type_service"
            Begin Extent = 
               Top = 6
               Left = 489
               Bottom = 119
               Right = 667
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "kwitansi"
            Begin Extent = 
               Top = 6
               Left = 705
               Bottom = 136
               Right = 875
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 12
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
   ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'v_detail_history'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'      Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'v_detail_history'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'v_detail_history'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[41] 4[9] 2[32] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "data_products"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 2
         End
         Begin Table = "detail_kwitansi"
            Begin Extent = 
               Top = 6
               Left = 246
               Bottom = 119
               Right = 416
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "kwitansi"
            Begin Extent = 
               Top = 120
               Left = 246
               Bottom = 250
               Right = 416
            End
            DisplayFlags = 280
            TopColumn = 4
         End
         Begin Table = "type_service"
            Begin Extent = 
               Top = 138
               Left = 38
               Bottom = 251
               Right = 216
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 12
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
        ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'v_detail_kwitansi'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N' Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'v_detail_kwitansi'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'v_detail_kwitansi'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "users"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 4
         End
         Begin Table = "login_users"
            Begin Extent = 
               Top = 6
               Left = 246
               Bottom = 136
               Right = 424
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'v_getLogin'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'v_getLogin'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[35] 4[26] 2[16] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = -288
      End
      Begin Tables = 
         Begin Table = "kwitansi"
            Begin Extent = 
               Top = 20
               Left = 597
               Bottom = 150
               Right = 767
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "users"
            Begin Extent = 
               Top = 45
               Left = 865
               Bottom = 175
               Right = 1035
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "type_service"
            Begin Extent = 
               Top = 154
               Left = 393
               Bottom = 267
               Right = 571
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 16
         Width = 284
         Width = 2700
         Width = 2235
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'v_kwitansi'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'v_kwitansi'
GO
