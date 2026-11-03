-- veri adetlerine hızlıca bakış (tablolar dolmuş mu kontrol)
SELECT 'Müşteriler' AS tablo, COUNT(*) AS adet FROM Musteriler
UNION
SELECT 'Personeller', COUNT(*) FROM Personeller
UNION
SELECT 'Siparişler', COUNT(*) FROM Siparisler
UNION
SELECT 'Sipariş Detay', COUNT(*) FROM SiparisDetay;

-- sipariş tablosunda kritik boşluklar (null) var mı?
-- analiz yaparken sorun çıkmasın  diye kontrol ettim
SELECT 
    SUM(CASE WHEN MusteriID IS NULL THEN 1 ELSE 0 END) AS bos_musteri,
    SUM(CASE WHEN PersonelID IS NULL THEN 1 ELSE 0 END) AS bos_personel,
    SUM(CASE WHEN Tarih IS NULL THEN 1 ELSE 0 END) AS bos_tarih
FROM Siparisler;

-- yanlışlıkla girilen 0 veya eksi değer var mı?
-- ciro hesaplamadan önce kontrol şart
SELECT COUNT(*) AS hatali_adet_fiyat FROM SiparisDetay
WHERE Adet <= 0 OR BirimFiyat <= 0;
