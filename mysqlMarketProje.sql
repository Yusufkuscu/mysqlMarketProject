show databases;
create database mysqlProje;
use mysqlProje;

-- YUSUF KUŞÇU

-- Ürünler Tablosu
CREATE TABLE Urunler (
	urun_id INT PRIMARY KEY AUTO_INCREMENT,
    urun_ad VARCHAR(255),
    fiyat DECIMAL(10, 2)
);

-- Mağazalar Tablosu
CREATE TABLE Marketler (
	market_id INT PRIMARY KEY,
    market_ad VARCHAR(255),
    konum VARCHAR(255)
);

-- Müşteriler Tablosu
CREATE TABLE Musteriler (
	musteri_id INT PRIMARY KEY AUTO_INCREMENT,
    musteri_ad VARCHAR(255),
    musteri_soyad VARCHAR(255),
    email VARCHAR(255),
	telefon VARCHAR(15),
    market_id INT,
    FOREIGN KEY (market_id) REFERENCES Marketler(market_id)
 );

-- Tedarikçi Tablosu
CREATE TABLE Tedarikciler (
	tedarikci_id INT PRIMARY KEY,
    tedarikci_ad VARCHAR(255),
	tedarikci_soyad VARCHAR(255),
    irtibat_kisi VARCHAR(255),
    irtibat_telefon VARCHAR(15)
);


-- Çalışanlar Tablosu
CREATE TABLE Calisanlar (
	calisan_id INT PRIMARY KEY,
    calisan_ad VARCHAR(255),
    calisan_soyad VARCHAR(255),
    pozisyon VARCHAR(255),
    market_id INT,
    FOREIGN KEY (market_id) REFERENCES Marketler(market_id)
);

-- Stok Tablosu
CREATE TABLE Stok (
    stok_id INT PRIMARY KEY,
    urun_id INT,
    market_id INT,
    miktar INT,
    FOREIGN KEY (urun_id) REFERENCES Urunler(urun_id),
    FOREIGN KEY (market_id) REFERENCES Marketler(market_id)
);

-- Satışlar Tablosu
CREATE TABLE IF NOT EXISTS Satislar (
    satis_id INT PRIMARY KEY,
    musteri_id INT,
    urun_id INT,
    market_id INT,
    miktar INT,
    tarih INT,
	FOREIGN KEY (musteri_id) REFERENCES Musteriler(musteri_id),
    FOREIGN KEY (urun_id) REFERENCES Urunler(urun_id),
    FOREIGN KEY (market_id) REFERENCES Marketler(market_id)
);

-- Kampanyalar Tablosu
CREATE TABLE Kampanyalar (
    kampanya_id INT PRIMARY KEY,
    market_id INT,
    kampanya_ad VARCHAR(255) NOT NULL,
    aciklama TEXT,
    baslangic_tarihi DATE NOT NULL,
    bitis_tarihi DATE NOT NULL,
    indirim_orani DECIMAL(5, 2) NOT NULL,
    minimum_tutar DECIMAL(10, 2) DEFAULT 0.00,
    aktif BOOLEAN DEFAULT true,
    CONSTRAINT chk_baslangic_bitis_tarihi CHECK (baslangic_tarihi <= bitis_tarihi),
    FOREIGN KEY (market_id) REFERENCES Marketler(market_id)
);



-- Satışlar Tablosuna Yapılan Satışların Tetikleyici
DELIMITER //
CREATE TRIGGER satis_yapildiginda
AFTER INSERT ON Satislar
FOR EACH ROW
BEGIN
    UPDATE Stok
    SET miktar = miktar - NEW.miktar
    WHERE urun_id = NEW.urun_id AND market_id = NEW.market_id;
END;
//
DELIMITER ;



-- Verileri Ekleme
INSERT INTO Urunler (urun_id, urun_ad, fiyat) VALUES
(1, 'Su', 2.50),
(2,'Soda', 5.00),
(3, 'Cips', 3.50),
(4, 'Süt', 1.80),
(5, 'Beyaz Peynir', 12.50),
(6, 'Domates', 2.00),
(7, 'Yumurta', 0.75),
(8, 'Ekmek', 1.50),
(9, 'Tavuk Göğsü', 8.75),
(10, 'Makarna', 1.25);

INSERT INTO Marketler (market_id, market_ad, konum) VALUES
(1, 'Şehir Şubesi', 'Ankara'),
(2, 'AVM Şubesi', 'İstanbul'),
(3, 'Cadde Şubesi', 'İzmir'),
(4, 'Antalya Şubesi', 'Antalya'),
(5, 'Bursa Şubesi', 'Bursa'),
(6, 'Gaziantep Şubesi','Gaziantep'),
(7, 'Adana Şubesi', 'Adana'),
(8, 'Trabzon Şubesi', 'Trabzon'),
(9, 'Konya Şubesi', 'Konya'),
(10, 'Samsun Şubesi', 'Samsun');


INSERT INTO Musteriler (musteri_id, musteri_ad, musteri_soyad, email, telefon, market_id) VALUES
(1, 'Ahmet','Yılmaz', 'ahmet@email.com', '555-123-4567',2),
(2, 'Ayşe','Demir', 'ayse@email.com', '555-987-6543',3),
(3, 'Mehmet','Kaya', 'mehmet@email.com', '555-234-5678',5),
(4, 'Zeynep','Akın', 'zeynep@email.com', '555-876-5432',6),
(5, 'Emre','Tekin', 'emre@email.com', '555-345-6789',1),
(6, 'Seda','Demir', 'seda@email.com', '555-654-3210',7),
(7, 'Can','Yıldırım','can@email.com', '555-432-1098',8),
(8, 'Nihan','Toprak', 'nihan@email.com', '555-321-0987',4),
(9, 'Berkay','Öztürk', 'berkay@email.com', '555-210-9876',9),
(10, 'Elif','Kara', 'elif@email.com', '555-789-0123',10);


INSERT INTO Tedarikciler (tedarikci_id, tedarikci_ad, tedarikci_soyad, irtibat_kisi, irtibat_telefon) VALUES
(1, 'ABC Toptan', 'Ali','Çim', '555-111-2222'),
(2, 'XYZ Tedarik', 'Mehmet','Ön', '555-333-4444'),
(3, '123 Dağıtım', 'Ayşe','Kor', '555-555-6666'),
(4, '456 Market', 'Zeynep','Bil', '555-777-8888'),
(5, '789 Ticaret', 'Ahmet','Tel', '555-999-0000'),
(6, 'DEF Malzeme', 'Seda','Sertaç', '555-000-1111'),
(7, 'GHI Gıda', 'Yılmaz','Yiğit', '555-222-3333'),
(8, 'JKL Toptan', 'İkkan','Kel', '555-444-5555'),
(9, 'MNO Tedarik', 'Ersoy','Pudra', '555-666-7777'),
(10, 'PQR Dağıtım', 'Elif','Alemdar', '555-888-9999');




INSERT INTO Calisanlar (calisan_id, calisan_ad, calisan_soyad, pozisyon, market_id) VALUES
(1, 'Ayşe','Kaya', 'Kasiyer', 1),
(2, 'Mustafa','Tekin', 'Depo Sorumlusu', 2),
(3, 'Fatma','Yılmaz', 'Müdür Yardımcısı', 3),
(4, 'Ahmet','Demir', 'Kasiyer', 4),
(5, 'Zeynep','Çelik', 'Mağaza Müdürü', 5),
(6, 'Mehmet','Akgün', 'Temizlik Görevlisi', 6),
(7, 'Selin','Gündüz', 'Kasiyer', 4),
(8, 'Ali','Yıldız', 'Depo Sorumlusu', 8),
(9, 'Mikdat','Kalkan', 'Mağaza Müdürü', 9),
(10, 'Berk','Özdemir', 'Kasiyer', 10);


INSERT INTO Stok (stok_id, urun_id, market_id, miktar) VALUES
(1, 1, 1, 200),
(2, 2, 1, 100),
(3, 3, 1, 150),
(4, 4, 1, 300),
(5, 5, 1, 50),
(6, 6, 1, 75),
(7, 7, 1, 400),
(8, 8, 1, 200),
(9, 9, 1, 80),
(10, 10, 1, 250);


INSERT INTO Kampanyalar (kampanya_id, market_id, kampanya_ad, aciklama, baslangic_tarihi, bitis_tarihi, indirim_orani, minimum_tutar, aktif)
VALUES
(1, 6, 'Yeni Yıl İndirimi', 'Yeni Yıla Özel Öndirim!', '2023-12-31', '2024-01-01', 0.15, 50.00, true),
(2, 8, 'Yaz Fırsatı', 'Bahar Kampanyası Başladı!', '2024-07-24', '2024-07-30', 0.10, 30.00, false),
(3, 5, 'Keyfi İndirim', 'Keyfime Özel İndirim!', '2024-03-24', '2024-03-29', 0.20, 10.00, false);


-- Satış Fonksiyonu
DELIMITER //
CREATE PROCEDURE YapilanSatis (
	IN p_satis_id INT,
    IN p_musteri_id INT,
    IN p_urun_id INT,
    IN p_market_id INT,
    IN p_miktar INT,
    IN p_tarih INT
)
BEGIN
    -- Belirtilen müşteri, ürün, mağaza ve miktar ile satışı simüle et
    INSERT INTO Satislar (satis_id, musteri_id, urun_id, market_id, miktar, tarih)
    VALUES (p_satis_id, p_musteri_id, p_urun_id, p_market_id, p_miktar, p_tarih);
END;
//
DELIMITER ;



-- Fonksiyonu Çağırma
CALL YapilanSatis(6,1, 1, 1, 5, 15);



-- Ürün Ekleme Fonksiyonu
DELIMITER //
CREATE PROCEDURE UrunEkle (
    IN p_urun_ad VARCHAR(255),
    IN p_fiyat DECIMAL(10, 2)
)
BEGIN
    -- Yeni ürünü ekleyin
    INSERT INTO Urunler (urun_ad, fiyat)
    VALUES (p_urun_ad, p_fiyat);
END;
//
DELIMITER ;

-- Fonksiyonu Çağırma
CALL UrunEkle('Patates', 29.90);


-- Müşteri Ekleme Fonksiyonu
DELIMITER //
CREATE PROCEDURE MusteriEkle (
    IN p_musteri_ad VARCHAR(255),
    IN p_musteri_soyad VARCHAR(255),
    IN p_email VARCHAR(255),
    IN p_telefon VARCHAR(15)
)
BEGIN
    -- Yeni müşteriyi ekleyin
    INSERT INTO Musteriler (musteri_ad, musteri_soyad, email, telefon)
    VALUES (p_musteri_ad, p_musteri_soyad, p_email, p_telefon);
END;
//
DELIMITER ;

-- Fonksiyonu Çağırma
CALL MusteriEkle('Furkan', 'Kurt', 'furkan@email.com', '555-893-4567');


select * from Urunler;
select * from Musteriler;
select * from Tedarikciler;
select * from Marketler;
select * from Calisanlar;
select * from Stok;
select * from Kampanyalar;






