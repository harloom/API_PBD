Create trigger afterInsert_detail_kwitansi
ON detail_kwitansi
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

create trigger  afterDelete_detail_kwitansi
ON detail_kwitansi
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