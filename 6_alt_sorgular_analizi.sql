-- BÖLÜM 2: ALT SORGULAR (SUBQUERIES) İLE VERİ ANALİZİ

-- 1. ADIM: Pasif ve Aktif Müşterilerin Analizi (WHERE IN / NOT IN)
-- Şemadaki Ad ve Soyad alanları birleştirilmiş, NOT IN koruması eklenmiştir.
SELECT MusteriID, Ad + ' ' + Soyad AS MusteriAdi 
FROM dbo.Musteriler
WHERE MusteriID NOT IN (
    SELECT DISTINCT MusteriID 
    FROM dbo.Siparisler
    WHERE MusteriID IS NOT NULL
);


-- 2. ADIM: Sepet ve Ürün Çeşitliliği Analizi (FROM İçinde Sanal Tablo)
SELECT sanalTablo.SiparisID, sanalTablo.[TOPLAM URUN ÇEŞİTİ]
FROM (
    SELECT SiparisID, COUNT(UrunID) AS [TOPLAM URUN ÇEŞİTİ]
    FROM dbo.SiparisDetay
    GROUP BY SiparisID
) AS sanalTablo				
WHERE sanalTablo.[TOPLAM URUN ÇEŞİTİ] > 5;


-- 3. ADIM: Sipariş İçi Seviye Analizi (Correlated Subquery - Örnek 1)
-- Siparişteki her bir ürünün adedini, o siparişin kendi ortalama ürün adediyle kıyaslar.
SELECT dis.SiparisDetayID, dis.SiparisID, dis.UrunID, dis.Adet, dis.BirimFiyat 
FROM SiparisDetay AS dis 
WHERE Adet > (
    SELECT AVG(ic.Adet) 
    FROM SiparisDetay AS ic 
    WHERE ic.SiparisID = dis.SiparisID
);


-- 4. ADIM: Kategori Bazlı Fiyat Analizi (Correlated Subquery - Örnek 2)
-- Her ürünün fiyatını, ait olduğu kategorinin genel fiyat ortalamasıyla kıyaslar.
SELECT dis.UrunAdi, dis.UrunID, dis.Kategori, dis.Fiyat, dis.Aciklama 
FROM Urunler AS dis
WHERE dis.Fiyat > (
    SELECT AVG(ic.Fiyat)  
    FROM Urunler AS ic
    WHERE ic.Kategori = dis.Kategori
);
