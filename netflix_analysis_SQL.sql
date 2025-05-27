
SELECT * FROM netflix_content LIMIT 10;

--SORGU 1: İçerik Türü Dağılımı (Film mi Dizi mi?)


SELECT type, COUNT(*) AS total_count
FROM netflix_content
GROUP BY type;


--Açıklama:
--type sütunu, içeriğin bir "Movie" mi yoksa "TV Show" mu olduğunu gösterir.

--COUNT(*): Her türden kaç içerik olduğunu sayar.

--GROUP BY type: Aynı türleri gruplayarak sayım yapmamızı sağlar.
-------------------------------------------------------------------------------------------------

-- SORGU 2: En Fazla İçeriğe Sahip 10 Ülke

SELECT country, COUNT(*) AS total_count
FROM netflix_content
WHERE country IS NOT NULL
GROUP BY country
ORDER BY total_count DESC
LIMIT 10;

--Açıklama:
--country: İçeriğin ait olduğu ülke bilgisidir.

--COUNT(*): Her ülkeye ait toplam içerik sayısını verir.

--WHERE country IS NOT NULL: Boş (NULL) olan ülke kayıtlarını hariç tutar.

--ORDER BY total_count DESC: En çoktan aza doğru sıralar.

--LIMIT 10: Sadece en çok içeriğe sahip ilk 10 ülkeyi listeler.

---------------------------------------------------------------------------------------------

-- Yıllara Göre İçerik Yayın Trendi (En çok içerik çıkan yıllar)

SELECT release_year, COUNT(*) AS total_count
FROM netflix_content
WHERE release_year IS NOT NULL
GROUP BY release_year
ORDER BY release_year;

--Açıklama:
--release_year: İçeriğin yayınlandığı yılı belirtir.

--COUNT(*): Her yıl kaç içerik yayınlandığını sayar.

--WHERE release_year IS NOT NULL: Yılı boş olanları filtreler.

--GROUP BY release_year: Yıla göre gruplayıp sayım yapar.

--ORDER BY release_year: Kronolojik sırayla gösterir.

--Bu sorgu sayesinde Netflix’in yıllar içindeki içerik artış trendini göreceksin.

--------------------------------------------------------------------------------------------------

-- Sadece Filmler İçin Yıllara Göre Yayın Trendi


SELECT release_year, COUNT(*) AS movie_count
FROM netflix_content
WHERE type = 'Movie' AND release_year IS NOT NULL
GROUP BY release_year
ORDER BY release_year;


-- Açıklama:
--Bu sorgu yalnızca type = 'Movie' olanları (yani sadece filmleri) alır.

--release_year bilgisine göre gruplar.

--Hangi yıl kaç film yayınlandığını gösterir.

--Artış / azalış trendi incelenebilir.

-------------------------------------------------------------------------------------------------------


-- Sadece Diziler İçin Yıllara Göre Yayın Trendi
SELECT release_year, COUNT(*) AS show_count
FROM netflix_content
WHERE type = 'TV Show' AND release_year IS NOT NULL
GROUP BY release_year
ORDER BY release_year;

--Açıklama:
--Bu sorgu yalnızca type = 'TV Show' olanları (yani sadece dizileri) alır.

--release_year bilgisine göre gruplar.

--Hangi yıl kaç dizi yayınlandığını gösterir.

--Zamanla Netflix’in dizi üretimindeki eğilimleri analiz etmemizi sağlar.

--Artış / azalış trendi yıllara göre izlenebilir.

---------------------------------------------------------------------------------



-- Süreye Göre En Uzun 10 İçerik (Dakika cinsinden olanlar)
SELECT title, duration, type
FROM netflix_content
WHERE duration LIKE '%min%'
ORDER BY CAST(SPLIT_PART(duration, ' ', 1) AS INT) DESC
LIMIT 10;

-- Açıklama:

--duration sütunu süreyi içeriyor (örneğin: "90 min", "2 Seasons").

--Sadece dakikalık olanlar (%min%) filtreleniyor.

--SPLIT_PART(duration, ' ', 1) ile sayı kısmı ayrılıyor, INT'e çevrilip büyükten küçüğe sıralanıyor.

--Bu şekilde en uzun filmleri sıralayabiliriz.

-------------------------------------------------------------------------------------------

-- En Çok Sezona Sahip 10 Dizi
SELECT title, duration
FROM netflix_content
WHERE type = 'TV Show' AND duration LIKE '%Season%'
ORDER BY CAST(SPLIT_PART(duration, ' ', 1) AS INT) DESC
LIMIT 10;

--Sadece TV Show türündeki içerikler filtrelenir.

--duration sütununda sezon bilgisi (“1 Season”, “2 Seasons”…) varsa alınır.

--SPLIT_PART(..., ' ', 1) ile sadece sayı kısmı çekilir ve INT’e çevrilerek sıralanır.

--En çok sezonu olan ilk 10 dizi listelenir.

-- Bu analiz, Netflix’te uzun soluklu dizileri ortaya çıkarır.

-------------------------------------------------------------------------------------------

-- İçerik Türlerine Göre En Yaygın Kategoriler (Genre Analizi)
SELECT listed_in, COUNT(*) AS total_count
FROM netflix_content
WHERE listed_in IS NOT NULL
GROUP BY listed_in
ORDER BY total_count DESC
LIMIT 10;


--Açıklama:
--listed_in sütunu, içeriklerin ait olduğu kategori/tür bilgisini (örneğin “Comedies”, “Dramas”, “Action & Adventure”) içerir.

--Bu sorgu, her kategoriden kaç içerik olduğunu sayar.

--Boş olanlar hariç tutulur (IS NOT NULL).

--En çok içeriğe sahip ilk 10 kategori büyükten küçüğe sıralanır.

-- Bu analiz sayesinde Netflix’in en yoğun içerik türlerini görebiliriz (örneğin: "Documentaries", "Children & Family Movies" vs.)

-------------------------------------------------------------------------------------------

-- İçerik Türleri Ayrıştırılarak En Yaygın Alt Kategoriler
SELECT unnest(string_to_array(listed_in, ', ')) AS category,
       COUNT(*) AS total_count
FROM netflix_content
WHERE listed_in IS NOT NULL
GROUP BY category
ORDER BY total_count DESC
LIMIT 15;

-- Açıklama:
--listed_in sütunu birden fazla tür içeriyor: Örn. "Dramas, International Movies".

--string_to_array(..., ', '): Bu türleri virgülden bölerek dizi (array) haline getirir.

--unnest(...): Bu dizideki tüm öğeleri tek tek satırlara çevirir.

--Böylece içeriklerin her bir türü ayrı olarak sayılır.

--COUNT(*) ile her kategori kaç kez geçtiyse o kadar sayılır.

--En çok tekrar eden 15 kategori listelenir.

--Bu analiz ile bir içeriğin tüm türlerini parçalayıp, gerçek popüler kategorileri buluyoruz.

-------------------------------------------------------------------------------------------
-- Belirli Bir Ülkenin Yıllara Göre İçerik Üretimi (örnek: Türkiye)

SELECT release_year, COUNT(*) AS content_count
FROM netflix_content
WHERE country ILIKE '%Turkey%' AND release_year IS NOT NULL
GROUP BY release_year
ORDER BY release_year;

--Açıklama:

--country ILIKE '%Turkey%': İçeriğin ülkesinde "Turkey" geçenleri seçer (büyük/küçük harf duyarsız).

--GROUP BY release_year: Yıla göre gruplar.

--Türkiye menşeli içeriklerin yıllara göre nasıl dağıldığını gösterir.


-------------------------------------------------------------------------------------------

-- Belirli Bir Kategorideki İçeriklerin Yıllara Göre Trendi (örnek: Documentaries)
SELECT release_year, COUNT(*) AS content_count
FROM netflix_content
WHERE listed_in ILIKE '%Documentary%' AND release_year IS NOT NULL
GROUP BY release_year
ORDER BY release_year;

--Açıklama:

--listed_in ILIKE '%Documentary%': listed_in alanında "Documentary" geçen içerikler alınır.

--Belgesel tarzı içeriklerin yıllar içindeki artış/azalışı analiz edilir.

--Diğer kategoriler için aynı kalıp kullanılabilir.


-------------------------------------------------------------------------------------------

-- En Fazla İçerik Üreten İlk 10 Yönetmen
SELECT director, COUNT(*) AS total_count
FROM netflix_content
WHERE director IS NOT NULL
GROUP BY director
ORDER BY total_count DESC
LIMIT 10;

--Açıklama:

--director sütununa göre gruplama yapılır.

--En çok içerik üretmiş 10 yönetmen listelenir.

--NULL olmayan kayıtlar dikkate alınır.


