
Mihver Kafe Veri Analizi Projesi

Bu projede, bir kafenin satış ve operasyon verilerini SQL kullanarak inceledim ve işletme kararlarına nasıl katkı sağlayabileceğimi gösteren sorgular hazırladım.

Veri Kaynağı

Projede kullandığım temel veri tabanı şeması ve ham veriler, Salih Hocaoğlu'nun (EXCEL 751) hazırladığı "Mıhver Projesi" eğitim serisinden alınmıştır. Kendisine bu güzel kaynak için teşekkür ederim.

Benim Yaptığım Çalışmalar & Veri Temizliği

Eğitim serisindeki verileri direkt kullanmak yerine, projenin başında veri kalitesinden emin olmak için şu kontrolleri kendim yaptım:
• Veri Adeti Kontrolü: Sistemde ne kadar veri olduğunu ve tabloların birbirine doğru bağlanıp bağlanmadığını test ettim.
• Eksik Veri Taraması (NULL): Analizleri hatalı etkilememesi için kritik sütunlarda boş bırakılmış satır olup olmadığını SQL sorgularıyla denetledim.
• Mantık Hataları Ayıklama: Finansal raporları bozabilecek hatalı girişleri (sıfır veya eksi değerdeki adet ve fiyatlar gibi) tek tek kontrol edip temizledim.

Eğitim Serisine Ek Olarak Neler Yaptım? 

Projeyi sadece izleyerek kopyalamak yerine, işletme mantığına göre kendimden şu ileri düzey analiz senaryolarını ve SQL tekniklerini ekledim:
• Gelişmiş Ciro Hesaplama: Ham brüt cironun yanına, tablolardaki indirim oranlarını anlık olarak detay tablosuna yansıtarak ve ISNULL kontrolleriyle NULL değerleri sıfırlayarak gerçek net ciroyu hesaplayan sorguyu yazdım.
• Performans Odaklı Sorgular: Klasik UNION kullanımı yerine, arka planda gereksiz sıralama yükü getirmeyen ve büyük veride performansı artıran UNION ALL yapısını tercih ettim.
• Veri Tabanı Hatalarını Ayıklama: Şemadaki tablolar arasında doğrudan ilişkisel bağı olmayan yerleri (Urunler ve Hammaddeler arasındaki mantık hatası gibi) fark edip, sorguları hammadde tablosunun kendi dinamiklerine göre baştan düzenledim.
• İç İçe ve İlişkili Alt Sorgular (Correlated Subqueries): Statik filtrelerin yetersiz kaldığı durumlar için, menüdeki her ürünün fiyatını kendi kategorisinin ortalamasıyla kıyaslayan ve sepetteki ürün adetlerini sipariş bazlı ortalamalarla eşleştiren dinamik yapılar kurdum.
• LAG ve Window Functions ile Trend Analizi: Satır detayını kaybetmeden zamansal sıralama yaptım. Bir siparişin net tutarını bir önceki siparişin tutarıyla yan yana getirerek kafenin anlık satış momentumunu ölçecek bir yapı tasarladım.
• Konsolide Nakit Akış Raporu: Tamamen farklı tablolarda duran sipariş indirimlerini (yüzdelik oranı ciro üzerinden TL'ye çevirerek) ve hammadde harcamalarını kolon sayılarını eşitleyerek tek bir nakit akış raporu altında alt alta birleştirdim.
