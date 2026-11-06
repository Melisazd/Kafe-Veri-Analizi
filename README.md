
Mihver Kafe Veri Analizi Projesi

Bu projede, bir kafenin satış ve operasyon verilerini SQL kullanarak inceledim ve işletme kararlarına nasıl katkı sağlayabileceğimi gösteren sorgular hazırladım.

Veri Kaynağı

Projede kullandığım temel veri tabanı şeması ve ham veriler, Salih Hocaoğlu'nun (EXCEL 751) hazırladığı "Mıhver Projesi" eğitim serisinden alınmıştır. Kendisine bu güzel kaynak için teşekkür ederim.

Benim Yaptığım Çalışmalar & Veri Temizliği

Eğitim serisindeki verileri direkt kullanmak yerine, projenin başında veri kalitesinden emin olmak için şu kontrolleri kendim yaptım:
• Veri Adeti Kontrolü: Sistemde ne kadar veri olduğunu ve tabloların birbirine doğru bağlanıp bağlanmadığını test ettim.
• Eksik Veri Taraması (NULL): Analizleri hatalı etkilememesi için kritik sütunlarda boş bırakılmış satır olup olmadığını SQL sorgularıyla denetledim.
• Mantık Hataları Ayıklama: Finansal raporları bozabilecek hatalı girişleri (sıfır veya eksi değerdeki adet ve fiyatlar gibi) tek tek kontrol edip temizledim.
