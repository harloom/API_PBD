USE [db_developer]
GO
/****** Object:  StoredProcedure [dbo].[delete_chart_product]    Script Date: 04/04/2019 14:45:54 ******/
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
/****** Object:  StoredProcedure [dbo].[delete_detail_kwitansi]    Script Date: 04/04/2019 14:45:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[delete_detail_kwitansi] 
@no_kwitansi char(10),
@id_kamera char(5)
AS BEGIN
	delete from detail_kwitansi where no_kwitansi = @no_kwitansi AND id_kamera = @id_kamera;
	SELECT *FROM detail_kwitansi;
END;
GO
/****** Object:  StoredProcedure [dbo].[delete_kwitansi]    Script Date: 04/04/2019 14:45:54 ******/
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
/****** Object:  StoredProcedure [dbo].[delete_product]    Script Date: 04/04/2019 14:45:54 ******/
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
/****** Object:  StoredProcedure [dbo].[delete_user]    Script Date: 04/04/2019 14:45:54 ******/
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
/****** Object:  StoredProcedure [dbo].[deleteChartAllByUser]    Script Date: 04/04/2019 14:45:54 ******/
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
/****** Object:  StoredProcedure [dbo].[edit_product]    Script Date: 04/04/2019 14:45:54 ******/
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
/****** Object:  StoredProcedure [dbo].[edit_service]    Script Date: 04/04/2019 14:45:54 ******/
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
/****** Object:  StoredProcedure [dbo].[getChart]    Script Date: 04/04/2019 14:45:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[getChart]
@kode_ktp char(16)
AS BEGIN
	select *from charts where @kode_ktp = @kode_ktp;
END

GO
/****** Object:  StoredProcedure [dbo].[getKwitansiUser]    Script Date: 04/04/2019 14:45:54 ******/
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
/****** Object:  StoredProcedure [dbo].[getLoginTask]    Script Date: 04/04/2019 14:45:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[getLoginTask] 
@id char(10) ,
@noHandphone varchar(15)
AS BEGIN
	select *from v_dataLoginTask where no_handphone = @noHandphone OR id_ktp = @id;
END;
GO
/****** Object:  StoredProcedure [dbo].[getProduct]    Script Date: 04/04/2019 14:45:54 ******/
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
/****** Object:  StoredProcedure [dbo].[getProducts]    Script Date: 04/04/2019 14:45:54 ******/
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
/****** Object:  StoredProcedure [dbo].[getService]    Script Date: 04/04/2019 14:45:54 ******/
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
/****** Object:  StoredProcedure [dbo].[getServices]    Script Date: 04/04/2019 14:45:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[getServices]
AS BEGIN
	select *from type_service;
END;
GO
/****** Object:  StoredProcedure [dbo].[getUser]    Script Date: 04/04/2019 14:45:54 ******/
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
/****** Object:  StoredProcedure [dbo].[getUsers]    Script Date: 04/04/2019 14:45:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[getUsers] 
AS BEGIN
	select *from users ;
END;
GO
/****** Object:  StoredProcedure [dbo].[getViewDetailKwitansi]    Script Date: 04/04/2019 14:45:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[getViewDetailKwitansi] 
AS
BEGIN
	select *from v_detail_kwitansi;
END;
GO
/****** Object:  StoredProcedure [dbo].[getViewKwitansi]    Script Date: 04/04/2019 14:45:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[getViewKwitansi] 
AS
BEGIN
	select *from v_kwitansi;
END;
GO
/****** Object:  StoredProcedure [dbo].[jumlahProductChart]    Script Date: 04/04/2019 14:45:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[jumlahProductChart] 
@kode_ktp char(16),
@id_kamera char(5),
@jumlah_pinjam int

AS BEGIN
	UPDATE charts set jumlah_pinjam = @jumlah_pinjam 
	where id_kamera = @id_kamera AND @kode_ktp =@kode_ktp;

	execute getChart @kode_ktp;
END
GO
/****** Object:  StoredProcedure [dbo].[save_chart]    Script Date: 04/04/2019 14:45:54 ******/
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
/****** Object:  StoredProcedure [dbo].[save_detail_kwitansi]    Script Date: 04/04/2019 14:45:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[save_detail_kwitansi] 
@no_kwitansi char(10),
@id_kamera char(5),
@Jumlah_pinham int
AS BEGIN
	INSERT INTO detail_kwitansi VALUES (@no_kwitansi,@id_kamera,@Jumlah_pinham);
	SELECT *FROM detail_kwitansi
END;
GO
/****** Object:  StoredProcedure [dbo].[save_kwitansi]    Script Date: 04/04/2019 14:45:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[save_kwitansi] 
@no_kwitansi char(10),
@id_ktp char(16),
@lama_pinjam int,
@tanggal date,
@id_service char(5)
AS BEGIN
		insert into kwitansi VALUES (@no_kwitansi,@lama_pinjam,@tanggal,@id_ktp,@id_service);
		SELECT *from kwitansi;
END;
GO
/****** Object:  StoredProcedure [dbo].[save_product]    Script Date: 04/04/2019 14:45:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[save_product]
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
GO
/****** Object:  StoredProcedure [dbo].[save_user]    Script Date: 04/04/2019 14:45:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[save_user] 
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
GO
/****** Object:  StoredProcedure [dbo].[saveUsersLoginTask]    Script Date: 04/04/2019 14:45:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[saveUsersLoginTask]
@id_login char(10),
@id_ktp char(16),
@password_login varchar(200),
@timestamp_login datetime
AS BEGIN
	insert into login_users values (@id_login,@id_ktp,@password_login,@timestamp_login);
END;
GO
/****** Object:  StoredProcedure [dbo].[searchProductsByName]    Script Date: 04/04/2019 14:45:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[searchProductsByName] @name varchar(25)
AS BEGIN
	select *from data_products where nama_kamera LIKE '%'+@name+'%' AND stok > 0 ORDER BY harga desc;
END
GO
/****** Object:  Table [dbo].[charts]    Script Date: 04/04/2019 14:45:54 ******/
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
/****** Object:  Table [dbo].[data_products]    Script Date: 04/04/2019 14:45:55 ******/
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
	[satuan] [varchar](25) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id_kamera] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[detail_kwintasi_simpan]    Script Date: 04/04/2019 14:45:55 ******/
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
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[detail_kwitansi]    Script Date: 04/04/2019 14:45:55 ******/
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
/****** Object:  Table [dbo].[kwitansi]    Script Date: 04/04/2019 14:45:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[kwitansi](
	[no_kwitansi] [char](10) NOT NULL,
	[lama_pinjam] [int] NOT NULL,
	[tanggal] [date] NOT NULL,
	[id_ktp] [char](16) NOT NULL,
	[id_service] [char](5) NULL,
PRIMARY KEY CLUSTERED 
(
	[no_kwitansi] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[login_users]    Script Date: 04/04/2019 14:45:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[login_users](
	[id_login] [char](10) NOT NULL,
	[id_ktp] [char](16) NOT NULL,
	[password_login] [varchar](200) NOT NULL,
	[timestamp_login] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id_login] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[type_service]    Script Date: 04/04/2019 14:45:55 ******/
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
/****** Object:  Table [dbo].[users]    Script Date: 04/04/2019 14:45:55 ******/
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
/****** Object:  View [dbo].[v_dataLoginTask]    Script Date: 04/04/2019 14:45:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[v_dataLoginTask]
AS
SELECT        dbo.login_users.id_login, dbo.login_users.id_ktp, dbo.login_users.password_login, dbo.login_users.timestamp_login, dbo.users.no_handphone
FROM            dbo.users INNER JOIN
                         dbo.login_users ON dbo.users.id_ktp = dbo.login_users.id_ktp

GO
/****** Object:  View [dbo].[v_detail_kwitansi]    Script Date: 04/04/2019 14:45:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[v_detail_kwitansi] AS
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
GO
/****** Object:  View [dbo].[v_kwitansi]    Script Date: 04/04/2019 14:45:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[v_kwitansi]
AS
SELECT        dbo.detail_kwitansi.no_kwitansi, dbo.kwitansi.tanggal, dbo.users.id_ktp, dbo.users.nama, dbo.detail_kwitansi.id_kamera, dbo.data_products.nama_kamera, dbo.data_products.harga, dbo.data_products.satuan, 
                         dbo.detail_kwitansi.jumlah_pinjam, dbo.type_service.id_service, dbo.type_service.nama_pelayanan
FROM            dbo.detail_kwitansi INNER JOIN
                         dbo.kwitansi ON dbo.kwitansi.no_kwitansi = dbo.detail_kwitansi.no_kwitansi INNER JOIN
                         dbo.data_products ON dbo.data_products.id_kamera = dbo.detail_kwitansi.id_kamera INNER JOIN
                         dbo.users ON dbo.users.id_ktp = dbo.kwitansi.id_ktp INNER JOIN
                         dbo.type_service ON dbo.type_service.id_service = dbo.kwitansi.id_service

GO
INSERT [dbo].[data_products] ([id_kamera], [nama_kamera], [harga], [stok], [satuan]) VALUES (N'C0001', N'Cannon V1', 124000, 100, N'Unit')
ALTER TABLE [dbo].[charts]  WITH CHECK ADD FOREIGN KEY([id_kamera])
REFERENCES [dbo].[data_products] ([id_kamera])
GO
ALTER TABLE [dbo].[charts]  WITH CHECK ADD FOREIGN KEY([id_ktp])
REFERENCES [dbo].[users] ([id_ktp])
GO
ALTER TABLE [dbo].[detail_kwintasi_simpan]  WITH CHECK ADD FOREIGN KEY([id_kamera])
REFERENCES [dbo].[data_products] ([id_kamera])
GO
ALTER TABLE [dbo].[detail_kwintasi_simpan]  WITH CHECK ADD FOREIGN KEY([no_kwitansi])
REFERENCES [dbo].[kwitansi] ([no_kwitansi])
GO
ALTER TABLE [dbo].[detail_kwitansi]  WITH CHECK ADD FOREIGN KEY([id_kamera])
REFERENCES [dbo].[data_products] ([id_kamera])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[detail_kwitansi]  WITH CHECK ADD FOREIGN KEY([no_kwitansi])
REFERENCES [dbo].[kwitansi] ([no_kwitansi])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[kwitansi]  WITH CHECK ADD  CONSTRAINT [FK__kwitansi__id_ktp__1920BF5C] FOREIGN KEY([id_ktp])
REFERENCES [dbo].[users] ([id_ktp])
GO
ALTER TABLE [dbo].[kwitansi] CHECK CONSTRAINT [FK__kwitansi__id_ktp__1920BF5C]
GO
ALTER TABLE [dbo].[kwitansi]  WITH CHECK ADD FOREIGN KEY([id_service])
REFERENCES [dbo].[type_service] ([id_service])
GO
ALTER TABLE [dbo].[login_users]  WITH CHECK ADD FOREIGN KEY([id_ktp])
REFERENCES [dbo].[users] ([id_ktp])
GO
/****** Object:  Trigger [dbo].[afterDelete_detail_kwitansi]    Script Date: 04/04/2019 14:45:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create trigger  [dbo].[afterDelete_detail_kwitansi]
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
		
END;
GO
/****** Object:  Trigger [dbo].[afterInsert_detail_kwitansi]    Script Date: 04/04/2019 14:45:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create trigger [dbo].[afterInsert_detail_kwitansi]
ON [dbo].[detail_kwitansi]
AFTER INSERT
AS BEGIN
	DECLARE
		@jumlah int ,@id_kamera char(5),@no_kwitansi char(10)
		select @jumlah = jumlah_pinjam,@no_kwitansi = no_kwitansi ,
		@id_kamera = id_kamera from inserted
		UPDATE data_products set data_products.stok =
		data_products.stok - @jumlah where data_products.id_kamera = @id_kamera;

		insert into detail_kwintasi_simpan(no_kwitansi,id_kamera,jumlah_pinjam) 
		values(@no_kwitansi,@id_kamera,@jumlah);
END;
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[37] 4[24] 2[21] 3) )"
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
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'v_dataLoginTask'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'v_dataLoginTask'
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
         Top = -192
         Left = 0
      End
      Begin Tables = 
         Begin Table = "detail_kwitansi"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 119
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "kwitansi"
            Begin Extent = 
               Top = 6
               Left = 246
               Bottom = 136
               Right = 416
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "data_products"
            Begin Extent = 
               Top = 120
               Left = 38
               Bottom = 250
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 1
         End
         Begin Table = "users"
            Begin Extent = 
               Top = 138
               Left = 246
               Bottom = 268
               Right = 416
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "type_service"
            Begin Extent = 
               Top = 252
               Left = 38
               Bottom = 365
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
         Or = 135' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'v_kwitansi'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'0
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'v_kwitansi'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'v_kwitansi'
GO
