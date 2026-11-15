INSERT INTO kategori (nama_kategori)
VALUES ('Laptop'), ('Smartphone'), ('Layanan Digital');
 
INSERT INTO produk (id_kategori, nama_produk, harga, spesifikasi)
VALUES
(1, 'Laptop Pro', 8500000,
 '{"ram": "16GB", "storage": "512GB SSD", "prosesor": "Intel Core i7", "ukuran_layar": "14 inch"}'),
(2, 'Smartphone X', 4500000,
 '{"ram": "8GB", "storage": "256GB", "kamera": "50MP", "baterai": "5000mAh"}'),
(3, 'Paket Premium', 150000,
 '{"durasi": "30 hari", "jumlah_pengguna": 5, "fitur": ["Cloud Storage", "Backup", "Multi Device"]}');
 
SELECT * FROM kategori;
SELECT * FROM produk;
