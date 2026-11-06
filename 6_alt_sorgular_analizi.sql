
BÖLÜM 2: ALT SORGULAR (SUBQUERIES) İLE VERİ ANALİZİ


1. ADIM: Pasif ve Aktif Müşterilerin Analizi (WHERE IN / NOT IN)

SELECT MusteriID, MusteriAdi 
FROM dbo.Musteriler
WHERE MusteriID NOT IN (
    SELECT DISTINCT MusteriID 
    FROM dbo.Siparisler
);


 2. ADIM: Sepet ve Ürün Çeşitliliği Analizi (FROM İçinde Sanal Tablo)

SELECT sanalTablo.SiparisID, sanalTablo.[TOPLAM URUN ÇEŞİTİ]
FROM (
    SELECT SiparisID, COUNT(UrunID) AS [TOPLAM URUN ÇEŞİTİ]
    FROM dbo.SiparisDetay
    GROUP BY SiparisID
) AS sanalTablo					
WHERE sanalTablo.[TOPLAM URUN ÇEŞİTİ] > 5;


 3. ADIM: Sipariş İçi Seviye Analizi (Correlated Subquery - Örnek 1)

SELECT dis.SiparisDetayID, dis.SiparisID, dis.UrunID, dis.Adet, dis.BirimFiyat 
FROM SiparisDetay AS dis 
WHERE Adet > (
    SELECT AVG(ic.Adet) 
    FROM SiparisDetay AS ic 
    WHERE ic.SiparisID = dis.SiparisID
);


-- 4. ADIM: Kategori Bazlı Fiyat Analizi (Correlated Subquery - Örnek 2)

SELECT dis.UrunAdi, dis.UrunID, dis.Kategori, dis.Fiyat, dis.Aciklama 
FROM Urunler AS dis
WHERE dis.Fiyat > (
    SELECT AVG(ic.Fiyat)  
    FROM Urunler AS ic
    WHERE ic.Kategori = dis.Kategori
);
