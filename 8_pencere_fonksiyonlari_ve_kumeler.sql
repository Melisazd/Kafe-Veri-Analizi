
 BÖLÜM 4: PENCERE FONKSİYONLARI VE KÜME OPERATÖRLERİ (UNION ALL)

 Bu bölümde, satır detayını kaybetmeden analitik hesaplamalar (Window Functions) ve farklı tablolardaki verileri alt alta birleştirme (UNION ALL) teknikleri uygulanmıştır.

--SENARYO 1: Ürün Fiyat Sıralama Analizi (ROW_NUMBER)

SELECT 
    UrunID, 
    UrunAdi, 
    Fiyat,
    ROW_NUMBER() OVER (ORDER BY Fiyat DESC) AS [FiyatSiraNo]
FROM dbo.Urunler;
-- SENARYO 2: Sipariş Bazlı Satış Trend Analizi (JOIN + LAG)

SELECT 
    Siparisler.Tarih,
    Siparisler.SiparisID, 
    SiparisDetay.Adet, 
    SiparisDetay.BirimFiyat,
    Siparisler.IndirimOrani,
    (SiparisDetay.Adet * SiparisDetay.BirimFiyat) * (1 - (Siparisler.IndirimOrani / 100.0)) AS [MevcutSiparisNetTutari],
    LAG((SiparisDetay.Adet * SiparisDetay.BirimFiyat) * (1 - (Siparisler.IndirimOrani / 100.0))) OVER (ORDER BY Siparisler.Tarih ASC) AS [BirOncekiSiparisNetTutari]
FROM dbo.Siparisler 
INNER JOIN dbo.SiparisDetay ON Siparisler.SiparisID = SiparisDetay.SiparisID;

-- SENARYO 3: Nakit Akış ve Kasa Çıkış Analizi (UNION ALL)

-- Mantık: Müşteri indirimleri ile hammadde harcamaları kolon sayıları 
-- ve veri tipleri eşitlenerek tek bir büyük rapor halinde alt alta birleştirilmiştir.

SELECT 
    Siparisler.Tarih AS [IslemTarihi], 
    Siparisler.IndirimOrani AS [HarcamaTutari],
    'Müşteri İndirimi' AS [IslemTipi]
FROM dbo.Siparisler

UNION ALL

SELECT 
    HammaddeAlislari.AlisTarihi AS [IslemTarihi], 
    HammaddeAlislari.AlisTutari AS [HarcamaTutari],
    'Hammadde Alımı' AS [IslemTipi]
FROM dbo.HammaddeAlislari;
