
 BÖLÜM 2: ALT SORGULAR (SUBQUERIES) İLE VERİ ANALİZİ

SENARYO 1: Pasif ve Aktif Müşterilerin Analizi (WHERE IN / NOT IN)

-- Soru: Sistemde kayıtlı olan ancak bugüne kadar hiç sipariş vermemiş 
-- potansiyel pasif müşterileri nasıl tespit ederiz?

SELECT MusteriID, MusteriAdi 
FROM dbo.Musteriler
WHERE MusteriID NOT IN (
    SELECT DISTINCT MusteriID 
    FROM dbo.Siparisler
);


-- DISTINCT anahtar kelimesi, alt sorgunun ürettiği listeyi benzersiz hale getirerek performansı artırmak için kullanılmıştır.


 SENARYO 2: Sepet ve Ürün Çeşitliliği Analizi (FROM İçinde Sanal Tablo)

-- Soru: Tek seferde 5 çeşitten fazla ürün içeren (büyük sepetli) siparişleri nasıl buluruz?
-- Mantık: SQL'de COUNT gibi toplama fonksiyonları doğrudan WHERE içinde filitrelenemediği için,
-- önce içteki sorguyla bir "Sanal Özet Tablo" üretilmiş, ardından dış sorguyla filtrelenmiştir.

SELECT sanalTablo.SiparisID, sanalTablo.[TOPLAM URUN ÇEŞİTİ]
FROM (
    SELECT SiparisID, COUNT(UrunID) AS [TOPLAM URUN ÇEŞİTİ]
    FROM dbo.SiparisDetay
    GROUP BY SiparisID
) AS sanalTablo					
WHERE sanalTablo.[TOPLAM URUN ÇEŞİTİ] > 5;


SENARYO 3: Büyük Tedarikçilerin Tespiti (FROM İçinde Sanal Tablo)

-- Soru: Toplam hammadde alım tutarımız 250.000 TL'den fazla olan büyük tedarikçiler hangileridir?

SELECT HarcamaTablosu.TedarikciID, HarcamaTablosu.[ToplamHarcama]
FROM (
    SELECT TedarikciID, SUM(AlisTutari) AS [ToplamHarcama]
    FROM dbo.HammaddeAlislari
    GROUP BY TedarikciID
) AS HarcamaTablosu
WHERE HarcamaTablosu.[ToplamHarcama] > 250000;



