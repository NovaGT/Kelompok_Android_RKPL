--Membaca atribut (select)
SELECT nama_produk, JSON_EXTRACT(spesifikasi, '$.ram') AS ram
FROM produk;
 
SELECT nama_produk, JSON_EXTRACT(spesifikasi, '$.storage') AS kapasitas_storage
FROM produk;
 
SELECT nama_produk, JSON_EXTRACT(spesifikasi, '$.baterai') AS kapasitas_baterai
FROM produk;

--Mencari produk berdasarkan atribut JSON

-- RAM 16GB
SELECT nama_produk, harga, spesifikasi
FROM produk
WHERE JSON_UNQUOTE(JSON_EXTRACT(spesifikasi, '$.ram')) = '16GB';
 
-- Kapasitas penyimpanan 256GB
SELECT nama_produk, harga
FROM produk
WHERE JSON_UNQUOTE(JSON_EXTRACT(spesifikasi, '$.storage')) = '256GB';
 
-- Produk yang memiliki fitur "Backup" (atribut berupa array)
SELECT nama_produk, harga
FROM produk
WHERE JSON_CONTAINS(spesifikasi, '"Backup"', '$.fitur');

--Mengubah atribut JSON(update)
UPDATE produk
SET spesifikasi = JSON_SET(spesifikasi, '$.ram', '32GB')
WHERE nama_produk = 'Laptop Pro';
 
SELECT nama_produk, JSON_EXTRACT(spesifikasi, '$.ram') AS ram
FROM produk
WHERE nama_produk = 'Laptop Pro';

--Menambah atribut JSON baru
UPDATE produk
SET spesifikasi = JSON_SET(spesifikasi, '$.warna', 'Silver')
WHERE nama_produk = 'Laptop Pro';
 
SELECT nama_produk, spesifikasi
FROM produk
WHERE nama_produk = 'Laptop Pro';

--Menghapus atribut JSON (Delete)
UPDATE produk
SET spesifikasi = JSON_SET(spesifikasi, '$.warna', 'Silver')
WHERE nama_produk = 'Laptop Pro';
 
SELECT nama_produk, spesifikasi
FROM produk
WHERE nama_produk = 'Laptop Pro';

--Verifikasi pencarian

-- Seharusnya kosong, karena RAM Laptop Pro sudah menjadi 32GB
SELECT nama_produk FROM produk
WHERE JSON_UNQUOTE(JSON_EXTRACT(spesifikasi, '$.ram')) = '16GB';
 
-- Seharusnya menampilkan Laptop Pro
SELECT nama_produk FROM produk
WHERE JSON_UNQUOTE(JSON_EXTRACT(spesifikasi, '$.ram')) = '32GB';

--pengjuan fungsi JSON lainya
SELECT JSON_OBJECT('nama', 'Budi', 'umur', 21, 'status', 'Mahasiswa') AS data_mahasiswa;
SELECT JSON_ARRAY('MySQL', 'MariaDB', 'PostgreSQL') AS daftar_dbms;
SELECT JSON_VALID('{"nama":"Budi","umur":21}') AS json_valid;
SELECT nama_produk, JSON_LENGTH(spesifikasi) AS jumlah_atribut FROM produk;
