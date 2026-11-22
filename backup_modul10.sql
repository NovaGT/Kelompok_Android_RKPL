-- phpMyAdmin SQL Dump
-- version 5.2.3
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Nov 08, 2026 at 12:12 PM
-- Server version: 8.0.30
-- PHP Version: 8.1.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `db_monitoring_listrik`
--

-- --------------------------------------------------------

--
-- Table structure for table `batas_pemakaian`
--

CREATE TABLE `batas_pemakaian` (
  `id_batas` int NOT NULL,
  `id_jenis` int NOT NULL,
  `nilai_batas_kwh` decimal(10,2) NOT NULL,
  `periode` enum('harian','mingguan','bulanan') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'harian'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `batas_pemakaian`
--

INSERT INTO `batas_pemakaian` (`id_batas`, `id_jenis`, `nilai_batas_kwh`, `periode`) VALUES
(1, 1, 25.00, 'harian'),
(2, 2, 60.00, 'harian'),
(3, 3, 12.00, 'harian'),
(4, 1, 400.00, 'bulanan');

-- --------------------------------------------------------

--
-- Table structure for table `jenis_ruangan`
--

CREATE TABLE `jenis_ruangan` (
  `id_jenis` int NOT NULL,
  `nama_jenis` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `jenis_ruangan`
--

INSERT INTO `jenis_ruangan` (`id_jenis`, `nama_jenis`) VALUES
(2, 'Laboratorium'),
(3, 'Ruang Dosen'),
(1, 'Ruang Kelas');

-- --------------------------------------------------------

--
-- Table structure for table `pemakaian`
--

CREATE TABLE `pemakaian` (
  `id_pemakaian` bigint NOT NULL,
  `id_perangkat` int NOT NULL,
  `waktu_catat` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `energi_kwh` decimal(10,3) NOT NULL,
  `daya_watt` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `pemakaian`
--

INSERT INTO `pemakaian` (`id_pemakaian`, `id_perangkat`, `waktu_catat`, `energi_kwh`, `daya_watt`) VALUES
(1, 1, '2026-10-01 08:00:00', 1.850, 1850.00),
(2, 1, '2026-10-01 09:00:00', 2.100, 2100.00),
(3, 2, '2026-10-01 08:00:00', 1.600, 1600.00),
(4, 3, '2026-10-01 08:00:00', 5.400, 5400.00),
(5, 4, '2026-10-01 08:00:00', 4.200, 4200.00),
(6, 5, '2026-10-01 08:00:00', 0.900, 900.00),
(103, 1, '2026-10-05 09:00:00', 3.250, 3250.00);

-- --------------------------------------------------------

--
-- Table structure for table `pengguna`
--

CREATE TABLE `pengguna` (
  `id_pengguna` int NOT NULL,
  `nama` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `username` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'disimpan sebagai hash, bukan teks asli (KNF-10)',
  `peran` enum('sarpras','teknisi','pihak_kampus') COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `pengguna`
--

INSERT INTO `pengguna` (`id_pengguna`, `nama`, `username`, `password`, `peran`) VALUES
(1, 'Petugas Sarpras', 'sarpras01', 'hash_fiktif_001', 'sarpras'),
(2, 'Teknisi Listrik', 'teknisi01', 'hash_fiktif_002', 'teknisi'),
(3, 'Pimpinan Kampus', 'kampus01', 'hash_fiktif_003', 'pihak_kampus');

-- --------------------------------------------------------

--
-- Table structure for table `perangkat_pengukur`
--

CREATE TABLE `perangkat_pengukur` (
  `id_perangkat` int NOT NULL,
  `id_ruangan` int NOT NULL,
  `kode_perangkat` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` enum('aktif','nonaktif','rusak') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'aktif'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `perangkat_pengukur`
--

INSERT INTO `perangkat_pengukur` (`id_perangkat`, `id_ruangan`, `kode_perangkat`, `status`) VALUES
(1, 1, 'PM-101-A', 'aktif'),
(2, 2, 'PM-102-A', 'aktif'),
(3, 3, 'PM-LAB-A', 'aktif'),
(4, 3, 'PM-LAB-B', 'aktif'),
(5, 4, 'PM-RD01-A', 'aktif');

-- --------------------------------------------------------

--
-- Table structure for table `peringatan`
--

CREATE TABLE `peringatan` (
  `id_peringatan` bigint NOT NULL,
  `id_ruangan` int NOT NULL,
  `id_batas` int NOT NULL,
  `waktu_peringatan` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `nilai_pemakaian` decimal(10,3) NOT NULL,
  `status_notifikasi` enum('menunggu','terkirim','dibaca','gagal') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'menunggu'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `peringatan`
--

INSERT INTO `peringatan` (`id_peringatan`, `id_ruangan`, `id_batas`, `waktu_peringatan`, `nilai_pemakaian`, `status_notifikasi`) VALUES
(1, 1, 1, '2026-10-01 14:00:00', 21.350, 'terkirim'),
(2, 3, 2, '2026-10-02 15:30:00', 62.100, 'dibaca'),
(103, 1, 1, '2026-10-05 09:00:00', 25.600, 'menunggu');

-- --------------------------------------------------------

--
-- Table structure for table `ruangan`
--

CREATE TABLE `ruangan` (
  `id_ruangan` int NOT NULL,
  `kode_ruangan` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nama_ruangan` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `id_jenis` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `ruangan`
--

INSERT INTO `ruangan` (`id_ruangan`, `kode_ruangan`, `nama_ruangan`, `id_jenis`) VALUES
(1, 'RK-101', 'Ruang Kelas 101', 1),
(2, 'RK-102', 'Ruang Kelas 102', 1),
(3, 'LAB-RPL', 'Laboratorium RPL', 2),
(4, 'RD-01', 'Ruang Dosen 01', 3);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `batas_pemakaian`
--
ALTER TABLE `batas_pemakaian`
  ADD PRIMARY KEY (`id_batas`),
  ADD UNIQUE KEY `uq_batas_jenis_periode` (`id_jenis`,`periode`);

--
-- Indexes for table `jenis_ruangan`
--
ALTER TABLE `jenis_ruangan`
  ADD PRIMARY KEY (`id_jenis`),
  ADD UNIQUE KEY `uq_jenis_nama` (`nama_jenis`);

--
-- Indexes for table `pemakaian`
--
ALTER TABLE `pemakaian`
  ADD PRIMARY KEY (`id_pemakaian`),
  ADD KEY `fk_pemakaian_perangkat` (`id_perangkat`),
  ADD KEY `idx_pemakaian_waktu` (`waktu_catat`);

--
-- Indexes for table `pengguna`
--
ALTER TABLE `pengguna`
  ADD PRIMARY KEY (`id_pengguna`),
  ADD UNIQUE KEY `uq_pengguna_username` (`username`);

--
-- Indexes for table `perangkat_pengukur`
--
ALTER TABLE `perangkat_pengukur`
  ADD PRIMARY KEY (`id_perangkat`),
  ADD UNIQUE KEY `uq_perangkat_kode` (`kode_perangkat`),
  ADD KEY `fk_perangkat_ruangan` (`id_ruangan`);

--
-- Indexes for table `peringatan`
--
ALTER TABLE `peringatan`
  ADD PRIMARY KEY (`id_peringatan`),
  ADD KEY `fk_peringatan_ruangan` (`id_ruangan`),
  ADD KEY `fk_peringatan_batas` (`id_batas`);

--
-- Indexes for table `ruangan`
--
ALTER TABLE `ruangan`
  ADD PRIMARY KEY (`id_ruangan`),
  ADD UNIQUE KEY `uq_ruangan_kode` (`kode_ruangan`),
  ADD KEY `fk_ruangan_jenis` (`id_jenis`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `batas_pemakaian`
--
ALTER TABLE `batas_pemakaian`
  MODIFY `id_batas` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `jenis_ruangan`
--
ALTER TABLE `jenis_ruangan`
  MODIFY `id_jenis` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `pemakaian`
--
ALTER TABLE `pemakaian`
  MODIFY `id_pemakaian` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=106;

--
-- AUTO_INCREMENT for table `pengguna`
--
ALTER TABLE `pengguna`
  MODIFY `id_pengguna` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `perangkat_pengukur`
--
ALTER TABLE `perangkat_pengukur`
  MODIFY `id_perangkat` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `peringatan`
--
ALTER TABLE `peringatan`
  MODIFY `id_peringatan` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=105;

--
-- AUTO_INCREMENT for table `ruangan`
--
ALTER TABLE `ruangan`
  MODIFY `id_ruangan` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `batas_pemakaian`
--
ALTER TABLE `batas_pemakaian`
  ADD CONSTRAINT `fk_batas_jenis` FOREIGN KEY (`id_jenis`) REFERENCES `jenis_ruangan` (`id_jenis`) ON DELETE RESTRICT ON UPDATE CASCADE;

--
-- Constraints for table `pemakaian`
--
ALTER TABLE `pemakaian`
  ADD CONSTRAINT `fk_pemakaian_perangkat` FOREIGN KEY (`id_perangkat`) REFERENCES `perangkat_pengukur` (`id_perangkat`) ON DELETE RESTRICT ON UPDATE CASCADE;

--
-- Constraints for table `perangkat_pengukur`
--
ALTER TABLE `perangkat_pengukur`
  ADD CONSTRAINT `fk_perangkat_ruangan` FOREIGN KEY (`id_ruangan`) REFERENCES `ruangan` (`id_ruangan`) ON DELETE RESTRICT ON UPDATE CASCADE;

--
-- Constraints for table `peringatan`
--
ALTER TABLE `peringatan`
  ADD CONSTRAINT `fk_peringatan_batas` FOREIGN KEY (`id_batas`) REFERENCES `batas_pemakaian` (`id_batas`) ON DELETE RESTRICT ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_peringatan_ruangan` FOREIGN KEY (`id_ruangan`) REFERENCES `ruangan` (`id_ruangan`) ON DELETE RESTRICT ON UPDATE CASCADE;

--
-- Constraints for table `ruangan`
--
ALTER TABLE `ruangan`
  ADD CONSTRAINT `fk_ruangan_jenis` FOREIGN KEY (`id_jenis`) REFERENCES `jenis_ruangan` (`id_jenis`) ON DELETE RESTRICT ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
