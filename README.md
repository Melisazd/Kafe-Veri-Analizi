#  Mihver Kafe Veri Analizi Projesi
Bu projede, bir kafenin satış ve operasyon verilerini inceleyerek işletme kararlarına nasıl katkı sağlayabileceğimi gösteriyorum.

##  Veri Kaynağı
Projede kullandığım temel veri tabanı şeması ve ham veriler, Salih Hocaoğlu'nun (EXCEL 751) hazırladığı "Mıhver Projesi" eğitim serisinden alınmıştır. Kendisine bu güzel kaynak için teşekkür ederim.

##  Benim Yaptığım Çalışmalar & Veri Temizliği
Eğitim serisindeki verileri direkt kullanmak yerine, projenin başında şu kontrolleri kendim yaptım:
* Veri Kontrolü:Sistemde ne kadar veri olduğunu ve tabloların birbirine doğru bağlanıp bağlanmadığını inceledim.
* Eksik Veri Taraması:Analizleri hatalı etkilememesi için kritik sütunlarda boş (NULL) bırakılmış satır olup olmadığını SQL sorgularıyla denetledim.
* Mantık Hataları Ayıklama:Finansal raporları bozabilecek hatalı girişleri (sıfır veya eksi değerdeki adet ve fiyatlar gibi) tek tek kontrol ettim.
