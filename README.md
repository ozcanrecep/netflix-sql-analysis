# 🎬 Netflix SQL Veri Analizi Projesi

Bu projede, Netflix'in 8800+ içerikten oluşan veri seti kullanılarak PostgreSQL üzerinde SQL sorguları ile detaylı analizler yapılmıştır.

## 📌 Kullanılan Teknolojiler
- PostgreSQL
- SQL
- pgAdmin 4

## 🔍 Analiz Başlıkları

1. Film ve Dizi Sayısı
2. En Fazla İçerik Üreten Ülkeler
3. Yıllara Göre İçerik Yayın Trendi
4. Filmler ve Diziler İçin Yıllık Dağılım
5. En Uzun Filmler ve En Çok Sezonlu Diziler
6. İçerik Kategori Analizi
7. Ülke ve Kategori Bazlı Trendler
8. En Çok İçerik Üreten Yönetmenler

## 📂 Dosyalar
- `netflix_titles.csv`: Orijinal veri seti
- `netflix_analysis_SQL.sql`: Tüm SQL sorguları açıklamalı şekilde
- `README.md`: Proje tanıtım dosyası (bu dosya)

## ✨ Sorgu Örneği

```sql
-- Sadece Filmler İçin Yıllara Göre Yayın Trendi
SELECT release_year, COUNT(*) AS movie_count
FROM netflix_content
WHERE type = 'Movie' AND release_year IS NOT NULL
GROUP BY release_year
ORDER BY release_year;

## 📈 Öne Çıkan Sonuçlar

- Filmler, dizilerden yaklaşık 2 kat daha fazla.
- En çok içerik üreten ülkeler: ABD, Hindistan, İngiltere.
- İçerik üretimi 2018-2020 yıllarında zirve yapmış.
- Belgesel, Dramatik ve Uluslararası içerikler öne çıkıyor.

## 👤 Hazırlayan

**Recep Özcan**  
📍 İzmir, Türkiye  
📧 ozcanrec@gmail.com  
🔗 [LinkedIn](https://www.linkedin.com/in/recep-%C3%B6zcan-6496a5224)  

