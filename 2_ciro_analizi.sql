-- KAFENİN TOPLAM BRÜT CİROSU
-- İndirimler düşülmeden önce kasaya giren ham parayı hesapladım
SELECT 
    SUM(Adet * BirimFiyat) AS toplam_brut_ciro
FROM SiparisDetay;

-- KAFENİN TOPLAM NET CİROSU
-- Sipariş bazlı yapılan indirimleri düştüm.
-- Virgülden sonraki gereksiz sıfırları temizlemek için CAST kullanarak formatı düzenledim.
SELECT 
    CAST(SUM((SiparisDetay.Adet * SiparisDetay.BirimFiyat) * (1 - ISNULL(Siparisler.IndirimOrani, 0) / 100)) AS DECIMAL(10,2)) AS toplam_net_ciro
FROM SiparisDetay
INNER JOIN Siparisler ON SiparisDetay.SiparisID = Siparisler.SiparisID;
