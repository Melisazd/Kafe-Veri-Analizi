-- BÖLÜM 4: PENCERE FONKSİYONLARI VE KÜME OPERATÖRLERİ (UNION ALL)

-- SENARYO 1: Ürün Fiyat Sıralama Analizi (ROW_NUMBER)
SELECT 
    UrunID, 
    UrunAdi, 
    Fiyat,
    ROW_NUMBER() OVER (ORDER BY Fiyat DESC) AS [FiyatSiraNo]
FROM dbo.Urunler;


-- SENARYO 2: Sipariş Bazlı Satış Trend Analizi (JOIN + LAG)
-- Satır bazlı detay korunarak bir önceki sipariş tutarı pencere fonksiyonuyla yanına yazdırılmıştır.
SELECT 
    s.Tarih,
    s.SiparisID, 
    sd.Adet, 
    sd.BirimFiyat,
    s.IndirimOrani,
    (sd.Adet * sd.BirimFiyat) * (1 - (ISNULL(s.IndirimOrani, 0) / 100.0)) AS [MevcutSiparisNetTutari],
    LAG((sd.Adet * sd.BirimFiyat) * (1 - (ISNULL(s.IndirimOrani, 0) / 100.0))) OVER (ORDER BY s.Tarih ASC, s.SiparisID ASC) AS [BirOncekiSiparisNetTutari]
FROM dbo.Siparisler AS s
INNER JOIN dbo.SiparisDetay AS sd ON s.SiparisID = sd.SiparisID;


-- SENARYO 3: Nakit Akış ve Kasa Çıkış Analizi (UNION ALL)
-- Sütun türlerinin (TL cinsinden) ve isimlerinin şemaya göre eşitlenerek birleştirilmesi.
SELECT 
    s.Tarih AS [IslemTarihi], 
    (sd.Adet * sd.BirimFiyat) * (ISNULL(s.IndirimOrani, 0) / 100.0) AS [HarcamaTutari], -- Oran tutara (TL) çevrildi
    N'Müşteri İndirimi (Feragat Edilen Gelir)' AS [IslemTipi]
FROM dbo.Siparisler AS s
INNER JOIN dbo.SiparisDetay AS sd ON s.SiparisID = sd.SiparisID

UNION ALL

SELECT 
    Tarih AS [IslemTarihi], 
    ToplamAlisFiyati AS [HarcamaTutari], -- Şemadaki doğru sütun adı yazıldı
    N'Hammadde Alımı' AS [IslemTipi]
FROM dbo.HammaddeAlislari;
