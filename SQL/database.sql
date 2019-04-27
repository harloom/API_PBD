USE [master]
GO
/****** Object:  Database [db_developer]    Script Date: 27/04/2019 17:56:38 ******/
CREATE DATABASE [db_developer]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'db_developer', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.SQLEXPRESS\MSSQL\DATA\db_developer.mdf' , SIZE = 3072KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'db_developer_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.SQLEXPRESS\MSSQL\DATA\db_developer_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [db_developer] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [db_developer].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [db_developer] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [db_developer] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [db_developer] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [db_developer] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [db_developer] SET ARITHABORT OFF 
GO
ALTER DATABASE [db_developer] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [db_developer] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [db_developer] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [db_developer] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [db_developer] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [db_developer] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [db_developer] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [db_developer] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [db_developer] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [db_developer] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [db_developer] SET  DISABLE_BROKER 
GO
ALTER DATABASE [db_developer] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [db_developer] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [db_developer] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [db_developer] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [db_developer] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [db_developer] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [db_developer] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [db_developer] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [db_developer] SET  MULTI_USER 
GO
ALTER DATABASE [db_developer] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [db_developer] SET DB_CHAINING OFF 
GO
ALTER DATABASE [db_developer] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [db_developer] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
USE [db_developer]
GO
/****** Object:  User [zero]    Script Date: 27/04/2019 17:56:39 ******/
CREATE USER [zero] FOR LOGIN [zero] WITH DEFAULT_SCHEMA=[db_datareader]
GO
/****** Object:  StoredProcedure [dbo].[checkKey]    Script Date: 27/04/2019 17:56:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[checkKey] 
@keyAPI varchar(200)
As  
Begin  
   
Declare @Exist bit = 0 ; 
 
IF EXISTS( Select id From login_users Where keyAPI=@keyAPI Collate SQL_Latin1_General_CP1_CS_AS)
	SET @Exist = 1;
    return @Exist;
end   
GO
/****** Object:  StoredProcedure [dbo].[delete_chart_product]    Script Date: 27/04/2019 17:56:39 ******/
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
/****** Object:  StoredProcedure [dbo].[delete_detail_kwitansi]    Script Date: 27/04/2019 17:56:39 ******/
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
/****** Object:  StoredProcedure [dbo].[delete_kwitansi]    Script Date: 27/04/2019 17:56:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[delete_kwitansi]
@no_kwitansi char(10)
AS BEGIN
	delete from kwitansi where no_kwitansi = @no_kwitansi;
	SELECT *FROM kwitansi;
END;

GO
/****** Object:  StoredProcedure [dbo].[delete_product]    Script Date: 27/04/2019 17:56:39 ******/
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
/****** Object:  StoredProcedure [dbo].[delete_user]    Script Date: 27/04/2019 17:56:39 ******/
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
/****** Object:  StoredProcedure [dbo].[deleteChartAllByUser]    Script Date: 27/04/2019 17:56:39 ******/
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
/****** Object:  StoredProcedure [dbo].[deleteDetailKwintasiAll]    Script Date: 27/04/2019 17:56:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[deleteDetailKwintasiAll]
@no_kwitansi char(10)
AS BEGIN  
delete from detail_kwitansi where no_kwitansi = @no_kwitansi ;
SELECT *FROM detail_kwitansi;
END;

GO
/****** Object:  StoredProcedure [dbo].[edit_product]    Script Date: 27/04/2019 17:56:39 ******/
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
/****** Object:  StoredProcedure [dbo].[edit_service]    Script Date: 27/04/2019 17:56:39 ******/
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
/****** Object:  StoredProcedure [dbo].[getChart]    Script Date: 27/04/2019 17:56:39 ******/
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
/****** Object:  StoredProcedure [dbo].[getKeyApi]    Script Date: 27/04/2019 17:56:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[getKeyApi] @id varchar(15)
AS BEGIN
	select keyAPI from login_users where id= @id;
END
GO
/****** Object:  StoredProcedure [dbo].[getKwitansiUser]    Script Date: 27/04/2019 17:56:39 ******/
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
/****** Object:  StoredProcedure [dbo].[getLoginTask]    Script Date: 27/04/2019 17:56:39 ******/
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
/****** Object:  StoredProcedure [dbo].[getProduct]    Script Date: 27/04/2019 17:56:39 ******/
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
/****** Object:  StoredProcedure [dbo].[getProducts]    Script Date: 27/04/2019 17:56:39 ******/
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
/****** Object:  StoredProcedure [dbo].[getService]    Script Date: 27/04/2019 17:56:39 ******/
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
/****** Object:  StoredProcedure [dbo].[getServices]    Script Date: 27/04/2019 17:56:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[getServices]
AS BEGIN
	select *from type_service;
END;
GO
/****** Object:  StoredProcedure [dbo].[getUser]    Script Date: 27/04/2019 17:56:39 ******/
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
/****** Object:  StoredProcedure [dbo].[getUsers]    Script Date: 27/04/2019 17:56:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[getUsers] 
AS BEGIN
	select *from users ;
END;
GO
/****** Object:  StoredProcedure [dbo].[getViewDetailKwitansi]    Script Date: 27/04/2019 17:56:39 ******/
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
/****** Object:  StoredProcedure [dbo].[getViewKwitansi]    Script Date: 27/04/2019 17:56:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[getViewKwitansi] 
@id_ktp char(16)
AS
BEGIN
	select *from v_kwitansi where id_ktp = @id_ktp ORDER BY tanggal DESC ;
END;
GO
/****** Object:  StoredProcedure [dbo].[jumlahProductChart]    Script Date: 27/04/2019 17:56:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[jumlahProductChart] 
@kode_ktp char(16),
@id_kamera char(5),
@jumlah_pinjam int

AS BEGIN
	UPDATE charts set jumlah_pinjam = @jumlah_pinjam 
	where id_kamera = @id_kamera AND @kode_ktp =@kode_ktp;

		select *from v_charts where id_ktp = @kode_ktp ;
END
GO
/****** Object:  StoredProcedure [dbo].[loginTask]    Script Date: 27/04/2019 17:56:39 ******/
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
/****** Object:  StoredProcedure [dbo].[save_chart]    Script Date: 27/04/2019 17:56:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[save_chart]
@kode_ktp char(16),
@id_kamera char(5),
@jumlah_pinjam int
AS BEGIN
	insert into charts values (	@kode_ktp,@id_kamera,@jumlah_pinjam);
	execute getChart @kode_ktp;
END;

GO
/****** Object:  StoredProcedure [dbo].[save_detail_kwitansi]    Script Date: 27/04/2019 17:56:39 ******/
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
/****** Object:  StoredProcedure [dbo].[save_kwitansi]    Script Date: 27/04/2019 17:56:39 ******/
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
/****** Object:  StoredProcedure [dbo].[save_product]    Script Date: 27/04/2019 17:56:39 ******/
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
/****** Object:  StoredProcedure [dbo].[save_user]    Script Date: 27/04/2019 17:56:39 ******/
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
/****** Object:  StoredProcedure [dbo].[searchProductsByName]    Script Date: 27/04/2019 17:56:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[searchProductsByName] @name varchar(25)
AS BEGIN
	select *from data_products where nama_kamera LIKE '%'+@name+'%' AND stok > 0 ORDER BY harga desc;
END
GO
/****** Object:  StoredProcedure [dbo].[updateStatus]    Script Date: 27/04/2019 17:56:39 ******/
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
/****** Object:  Table [dbo].[charts]    Script Date: 27/04/2019 17:56:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[charts](
	[id_ktp] [char](16) NULL,
	[id_kamera] [char](5) NULL,
	[jumlah_pinjam] [int] NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[data_products]    Script Date: 27/04/2019 17:56:39 ******/
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
/****** Object:  Table [dbo].[detail_kwintasi_simpan]    Script Date: 27/04/2019 17:56:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[detail_kwintasi_simpan](
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
/****** Object:  Table [dbo].[detail_kwitansi]    Script Date: 27/04/2019 17:56:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[detail_kwitansi](
	[no_kwitansi] [char](10) NULL,
	[id_kamera] [char](5) NULL,
	[jumlah_pinjam] [int] NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[kwitansi]    Script Date: 27/04/2019 17:56:39 ******/
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
	[id_service] [char](5) NULL,
	[alamat_antar] [varchar](200) NULL,
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
/****** Object:  Table [dbo].[login_users]    Script Date: 27/04/2019 17:56:39 ******/
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
/****** Object:  Table [dbo].[type_service]    Script Date: 27/04/2019 17:56:39 ******/
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
/****** Object:  Table [dbo].[users]    Script Date: 27/04/2019 17:56:39 ******/
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
/****** Object:  View [dbo].[v_charts]    Script Date: 27/04/2019 17:56:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[v_charts]
AS
SELECT        dbo.users.id_ktp, dbo.data_products.id_kamera, dbo.data_products.nama_kamera, dbo.data_products.harga, dbo.charts.jumlah_pinjam, dbo.data_products.satuan, dbo.data_products.url_image, dbo.users.nama, 
                         dbo.data_products.harga * dbo.charts.jumlah_pinjam AS jumlah_bayar
FROM            dbo.charts INNER JOIN
                         dbo.users ON dbo.charts.id_ktp = dbo.users.id_ktp INNER JOIN
                         dbo.data_products ON dbo.charts.id_kamera = dbo.data_products.id_kamera

GO
/****** Object:  View [dbo].[v_detail_kwitansi]    Script Date: 27/04/2019 17:56:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[v_detail_kwitansi]
AS
SELECT        dbo.detail_kwitansi.no_kwitansi, dbo.detail_kwitansi.id_kamera, dbo.data_products.nama_kamera, dbo.data_products.harga, dbo.detail_kwitansi.jumlah_pinjam, dbo.type_service.ppn, 
                         dbo.data_products.harga * dbo.detail_kwitansi.jumlah_pinjam AS total, dbo.data_products.harga * dbo.type_service.ppn AS diskon, 
                         dbo.data_products.harga * dbo.detail_kwitansi.jumlah_pinjam - dbo.data_products.harga * dbo.type_service.ppn AS total_bayar
FROM            dbo.data_products INNER JOIN
                         dbo.detail_kwitansi ON dbo.data_products.id_kamera = dbo.detail_kwitansi.id_kamera INNER JOIN
                         dbo.kwitansi ON dbo.detail_kwitansi.no_kwitansi = dbo.kwitansi.no_kwitansi INNER JOIN
                         dbo.type_service ON dbo.type_service.id_service = dbo.kwitansi.id_service

GO
/****** Object:  View [dbo].[v_getLogin]    Script Date: 27/04/2019 17:56:39 ******/
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
/****** Object:  View [dbo].[v_kwitansi]    Script Date: 27/04/2019 17:56:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[v_kwitansi]
AS
SELECT        dbo.kwitansi.tanggal, dbo.kwitansi.tanggal_expire, dbo.users.id_ktp, dbo.users.nama, dbo.data_products.nama_kamera, dbo.data_products.harga, dbo.data_products.satuan, dbo.detail_kwitansi.jumlah_pinjam, 
                         dbo.type_service.id_service, dbo.type_service.nama_pelayanan, dbo.data_products.id_kamera, dbo.kwitansi.no_kwitansi, dbo.kwitansi.lama_pinjam, dbo.kwitansi.statusB
FROM            dbo.detail_kwitansi INNER JOIN
                         dbo.kwitansi ON dbo.kwitansi.no_kwitansi = dbo.detail_kwitansi.no_kwitansi INNER JOIN
                         dbo.data_products ON dbo.data_products.id_kamera = dbo.detail_kwitansi.id_kamera INNER JOIN
                         dbo.users ON dbo.users.id_ktp = dbo.kwitansi.id_ktp INNER JOIN
                         dbo.type_service ON dbo.type_service.id_service = dbo.kwitansi.id_service

GO
INSERT [dbo].[data_products] ([id_kamera], [nama_kamera], [harga], [stok], [url_image], [satuan]) VALUES (N'C0001', N'Cannon V1', 124000, 24, NULL, N'Unit')
INSERT [dbo].[data_products] ([id_kamera], [nama_kamera], [harga], [stok], [url_image], [satuan]) VALUES (N'C0002', N'Cannon V2040', 200000, -15, NULL, N'Unit')
SET IDENTITY_INSERT [dbo].[detail_kwintasi_simpan] ON 

INSERT [dbo].[detail_kwintasi_simpan] ([id], [no_kwitansi], [id_kamera], [jumlah_pinjam], [tanggal_dikembalikan]) VALUES (1023, N'K0001K0010', N'C0002', 2, CAST(0x0000AA3C011F3357 AS DateTime))
INSERT [dbo].[detail_kwintasi_simpan] ([id], [no_kwitansi], [id_kamera], [jumlah_pinjam], [tanggal_dikembalikan]) VALUES (1024, N'K0001K0010', N'C0001', 2, CAST(0x0000AA3C011F3357 AS DateTime))
INSERT [dbo].[detail_kwintasi_simpan] ([id], [no_kwitansi], [id_kamera], [jumlah_pinjam], [tanggal_dikembalikan]) VALUES (1025, N'K0001K0001', N'C0001', 2, CAST(0x0000AA3C01202787 AS DateTime))
INSERT [dbo].[detail_kwintasi_simpan] ([id], [no_kwitansi], [id_kamera], [jumlah_pinjam], [tanggal_dikembalikan]) VALUES (1026, N'K0001K0002', N'C0001', 2, CAST(0x0000AA3C01253911 AS DateTime))
INSERT [dbo].[detail_kwintasi_simpan] ([id], [no_kwitansi], [id_kamera], [jumlah_pinjam], [tanggal_dikembalikan]) VALUES (1027, N'K0001K0003', N'C0001', 2, CAST(0x0000AA3C01254CA5 AS DateTime))
SET IDENTITY_INSERT [dbo].[detail_kwintasi_simpan] OFF
INSERT [dbo].[detail_kwitansi] ([no_kwitansi], [id_kamera], [jumlah_pinjam]) VALUES (N'K0001K0002', N'C0001', 2)
INSERT [dbo].[detail_kwitansi] ([no_kwitansi], [id_kamera], [jumlah_pinjam]) VALUES (N'K0001K0003', N'C0001', 2)
INSERT [dbo].[kwitansi] ([no_kwitansi], [lama_pinjam], [tanggal], [id_ktp], [id_service], [alamat_antar], [tanggal_expire], [statusB]) VALUES (N'K0001K0001', 1, CAST(0x0000AA3C011E63DE AS DateTime), N'9999999999999999', N'S0001', N'Tokyo', CAST(0x0000AA3D00000000 AS DateTime), N'Dikembalikan')
INSERT [dbo].[kwitansi] ([no_kwitansi], [lama_pinjam], [tanggal], [id_ktp], [id_service], [alamat_antar], [tanggal_expire], [statusB]) VALUES (N'K0001K0002', 1, CAST(0x0000AA3C01253909 AS DateTime), N'9999999999999999', N'S0001', N'Tokyo', CAST(0x0000AA3D01253909 AS DateTime), N'Pinjam')
INSERT [dbo].[kwitansi] ([no_kwitansi], [lama_pinjam], [tanggal], [id_ktp], [id_service], [alamat_antar], [tanggal_expire], [statusB]) VALUES (N'K0001K0003', 1, CAST(0x0000AA3C01254C9A AS DateTime), N'9999999999999999', N'S0001', N'Tokyo', CAST(0x0000AA3D01254C9A AS DateTime), N'Pinjam')
INSERT [dbo].[kwitansi] ([no_kwitansi], [lama_pinjam], [tanggal], [id_ktp], [id_service], [alamat_antar], [tanggal_expire], [statusB]) VALUES (N'K0001K0010', 1, CAST(0x0000AA3C011E2B42 AS DateTime), N'9999999999999999', N'S0001', N'Tokyo', CAST(0x0000AA3D00000000 AS DateTime), N'Dikembalikan')
INSERT [dbo].[login_users] ([id], [id_ktp], [password_login], [timestamp_login], [keyAPI]) VALUES (N'bzsG9Mi', N'1000000000000000', N'$2b$10$aiYoxHnTQKSUGG2NFez7eeFWp5l1839YVrpTsxkyhDey6ofg.1Tla', CAST(0x0000AA2700E0C53A AS DateTime), N'W5Z21firY0uwq81YcDievlDWGaYUe3XIf0sWUnV7X3blT1us709ZbWY521Fl2BeLob1PSqlpsp3nAzOeCtjzgFiZzbrlZNhbTjtG')
INSERT [dbo].[login_users] ([id], [id_ktp], [password_login], [timestamp_login], [keyAPI]) VALUES (N'ExRW2Ka', N'0000000000000001', N'$2b$10$Q0nphtEMrug1ry84Jhi/CO0Xp9l3wIad/dof9yjaaDo3r.sgGJ/nO', CAST(0x0000AA2700D8AFD0 AS DateTime), N'pEu4BnBOwInSNMF6Pncj')
INSERT [dbo].[login_users] ([id], [id_ktp], [password_login], [timestamp_login], [keyAPI]) VALUES (N'GVREmvV', N'2000000000000000', N'$2b$10$I69hbX6DHNHUr3/y.3FqJOWS6RSvxyDmH5ywNEppMeVEE3lkCunS.', CAST(0x0000AA2800D7D95B AS DateTime), N'7qBNUbF8xldqql3c62xjaLW4wN1x79DSdyt9RQHyH3jhKdLyW1Oas6Z2tVg4ehN72LFkLNpbz7TWx8UB93IEQ7TXa3fzhFpSi3dl')
INSERT [dbo].[login_users] ([id], [id_ktp], [password_login], [timestamp_login], [keyAPI]) VALUES (N'IsryLaO', N'0000000000000000', N'$2b$10$UcmF3UxyGtPJndopMiDMQOlux8gvWDEQuKzavxTB/ceHPUqMj27Ue', CAST(0x0000AA2700084A96 AS DateTime), N'KN5gE6C6M5luFXdFMWl8')
INSERT [dbo].[login_users] ([id], [id_ktp], [password_login], [timestamp_login], [keyAPI]) VALUES (N'uupXNLG', N'9999999999999999', N'$2b$10$2fN5pcqrv2c.nxTvydQAWuH.i4MFhsALp0xYsPA24gVqiu7kRkthS', CAST(0x0000AA2900E145CC AS DateTime), N'OJJhqgv3pBifWiYSUXLPwyN5so3RPucG4ZdbK9ytWboktkoIPK94XxN5RSt2KpCf0U1OhHl0tFei676EpRekphvVtKBEhzL47gBm')
INSERT [dbo].[login_users] ([id], [id_ktp], [password_login], [timestamp_login], [keyAPI]) VALUES (N'w9i8aKF', N'0000000000000100', N'$2b$10$Kw1woXkyz5F395TsvEg9A.QrbKT/EuFgdToeblPsJWhOCYOftpC5i', CAST(0x0000AA2700E04248 AS DateTime), N'RFPf59ZjS5Bv7SPImlM0')
INSERT [dbo].[type_service] ([id_service], [nama_pelayanan], [ppn]) VALUES (N'S0001', N'Antar', 0.1)
INSERT [dbo].[type_service] ([id_service], [nama_pelayanan], [ppn]) VALUES (N'S0002', N'Ambil', 0)
INSERT [dbo].[users] ([id_ktp], [nama], [tempat_lahir], [tanggal_lahir], [alamat], [jenis_kelamin], [pekerjaan], [no_handphone]) VALUES (N'0000000000000000', N'ilham', N'Metro', CAST(0xA2220B00 AS Date), N'Jalan Khaibras', N'Male', N'Mahasiswa', N'082307304530')
INSERT [dbo].[users] ([id_ktp], [nama], [tempat_lahir], [tanggal_lahir], [alamat], [jenis_kelamin], [pekerjaan], [no_handphone]) VALUES (N'0000000000000001', N'Kuhaku', N'Metro', CAST(0xA2220B00 AS Date), N'Jalan Khaibras', N'Male', N'Mahasiswa', N'082307304530')
INSERT [dbo].[users] ([id_ktp], [nama], [tempat_lahir], [tanggal_lahir], [alamat], [jenis_kelamin], [pekerjaan], [no_handphone]) VALUES (N'0000000000000100', N'shiro', N'Kyoto', CAST(0xA2220B00 AS Date), N'Jalan Khaibras', N'Male', N'Mahasiswa', N'082307304530')
INSERT [dbo].[users] ([id_ktp], [nama], [tempat_lahir], [tanggal_lahir], [alamat], [jenis_kelamin], [pekerjaan], [no_handphone]) VALUES (N'1000000000000000', N'Megumin', N'Kyoto', CAST(0xA2220B00 AS Date), N'Jalan Khaibras', N'Male', N'Mahasiswa', N'082307304530')
INSERT [dbo].[users] ([id_ktp], [nama], [tempat_lahir], [tanggal_lahir], [alamat], [jenis_kelamin], [pekerjaan], [no_handphone]) VALUES (N'2000000000000000', N'KAZUMA', N'Kyoto', CAST(0xA2220B00 AS Date), N'Jalan Khaibras', N'Male', N'Mahasiswa', N'082307304530')
INSERT [dbo].[users] ([id_ktp], [nama], [tempat_lahir], [tanggal_lahir], [alamat], [jenis_kelamin], [pekerjaan], [no_handphone]) VALUES (N'9999999999999999', N'Yuki UDIN', N'Akihabara', CAST(0xA3220B00 AS Date), N'Jalan Khaibras', N'Male', N'Mahasiswa', N'082307304530')
SET ANSI_PADDING ON

GO
/****** Object:  Index [UQ__charts__D3CB262DC5C7DDE6]    Script Date: 27/04/2019 17:56:39 ******/
ALTER TABLE [dbo].[charts] ADD UNIQUE NONCLUSTERED 
(
	[id_kamera] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[charts]  WITH CHECK ADD  CONSTRAINT [FK__charts__id_kamer__282DF8C2] FOREIGN KEY([id_kamera])
REFERENCES [dbo].[data_products] ([id_kamera])
GO
ALTER TABLE [dbo].[charts] CHECK CONSTRAINT [FK__charts__id_kamer__282DF8C2]
GO
ALTER TABLE [dbo].[charts]  WITH CHECK ADD FOREIGN KEY([id_ktp])
REFERENCES [dbo].[users] ([id_ktp])
GO
ALTER TABLE [dbo].[detail_kwintasi_simpan]  WITH CHECK ADD  CONSTRAINT [FK_detail_kwintasi_simpan_data_products] FOREIGN KEY([id_kamera])
REFERENCES [dbo].[data_products] ([id_kamera])
GO
ALTER TABLE [dbo].[detail_kwintasi_simpan] CHECK CONSTRAINT [FK_detail_kwintasi_simpan_data_products]
GO
ALTER TABLE [dbo].[detail_kwintasi_simpan]  WITH CHECK ADD  CONSTRAINT [FK_detail_kwintasi_simpan_kwitansi] FOREIGN KEY([no_kwitansi])
REFERENCES [dbo].[kwitansi] ([no_kwitansi])
GO
ALTER TABLE [dbo].[detail_kwintasi_simpan] CHECK CONSTRAINT [FK_detail_kwintasi_simpan_kwitansi]
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
/****** Object:  Trigger [dbo].[afterDelete_detail_kwitansi]    Script Date: 27/04/2019 17:56:39 ******/
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
		
		UPDATE detail_kwintasi_simpan set detail_kwintasi_simpan.tanggal_dikembalikan =
		GETDATE()  where detail_kwintasi_simpan.no_kwitansi = @no_kwitansi; 
		
		execute updateStatus @no_kwitansi , 'Dikembalikan';
		
END;
GO
/****** Object:  Trigger [dbo].[afterInsert_detail_kwitansi]    Script Date: 27/04/2019 17:56:39 ******/
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

		insert into detail_kwintasi_simpan values (@no_kwitansi,@id_kamera,@jumlah,GETDATE());

END;
GO
/****** Object:  Trigger [dbo].[AfterInsertKwitansi]    Script Date: 27/04/2019 17:56:39 ******/
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
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'v_charts'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'v_charts'
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
         Begin Table = "data_products"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
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
            TopColumn = 0
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
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'v_detail_kwitansi'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'v_detail_kwitansi'
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
         Top = -384
         Left = 0
      End
      Begin Tables = 
         Begin Table = "detail_kwitansi"
            Begin Extent = 
               Top = 13
               Left = 306
               Bottom = 126
               Right = 476
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "kwitansi"
            Begin Extent = 
               Top = 20
               Left = 597
               Bottom = 150
               Right = 767
            End
            DisplayFlags = 280
            TopColumn = 4
         End
         Begin Table = "data_products"
            Begin Extent = 
               Top = 14
               Left = 0
               Bottom = 144
               Right = 170
            End
            DisplayFlags = 280
            TopColumn = 1
         End
         Begin Table = "users"
            Begin Extent = 
               Top = 43
               Left = 770
               Bottom = 173
               Right = 940
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "type_service"
            Begin Extent = 
               Top = 167
               Left = 387
               Bottom = 280
               Right = 565
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
         ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'v_kwitansi'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'Alias = 900
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
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'v_kwitansi'
GO
USE [master]
GO
ALTER DATABASE [db_developer] SET  READ_WRITE 
GO
