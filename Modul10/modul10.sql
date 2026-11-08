CREATE DATABASE db_monitoring_listrik
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

USE db_monitoring_listrik;

CREATE TABLE pengguna (
    id_pengguna INT          NOT NULL AUTO_INCREMENT,
    nama        VARCHAR(100) NOT NULL,
    username    VARCHAR(50)  NOT NULL,
    password    VARCHAR(255) NOT NULL COMMENT 'disimpan sebagai hash, bukan teks asli (KNF-10)',
    peran       ENUM('sarpras','teknisi','pihak_kampus') NOT NULL,
    PRIMARY KEY (id_pengguna),
    UNIQUE KEY uq_pengguna_username (username)
) ENGINE=InnoDB;

CREATE TABLE jenis_ruangan (
    id_jenis   INT         NOT NULL AUTO_INCREMENT,
    nama_jenis VARCHAR(50) NOT NULL,
    PRIMARY KEY (id_jenis),
    UNIQUE KEY uq_jenis_nama (nama_jenis)
) ENGINE=InnoDB;

CREATE TABLE ruangan (
    id_ruangan   INT          NOT NULL AUTO_INCREMENT,
    kode_ruangan VARCHAR(20)  NOT NULL,
    nama_ruangan VARCHAR(100) NOT NULL,
    id_jenis     INT          NOT NULL,
    PRIMARY KEY (id_ruangan),
    UNIQUE KEY uq_ruangan_kode (kode_ruangan),
    CONSTRAINT fk_ruangan_jenis FOREIGN KEY (id_jenis)
        REFERENCES jenis_ruangan (id_jenis)
        ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB;

CREATE TABLE batas_pemakaian (
    id_batas        INT           NOT NULL AUTO_INCREMENT,
    id_jenis        INT           NOT NULL,
    nilai_batas_kwh DECIMAL(10,2) NOT NULL,
    periode         ENUM('harian','mingguan','bulanan') NOT NULL DEFAULT 'harian',
    PRIMARY KEY (id_batas),
    UNIQUE KEY uq_batas_jenis_periode (id_jenis, periode),
    CONSTRAINT fk_batas_jenis FOREIGN KEY (id_jenis)
        REFERENCES jenis_ruangan (id_jenis)
        ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB;

CREATE TABLE perangkat_pengukur (
    id_perangkat   INT         NOT NULL AUTO_INCREMENT,
    id_ruangan     INT         NOT NULL,
    kode_perangkat VARCHAR(30) NOT NULL,
    status         ENUM('aktif','nonaktif','rusak') NOT NULL DEFAULT 'aktif',
    PRIMARY KEY (id_perangkat),
    UNIQUE KEY uq_perangkat_kode (kode_perangkat),
    CONSTRAINT fk_perangkat_ruangan FOREIGN KEY (id_ruangan)
        REFERENCES ruangan (id_ruangan)
        ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB;

CREATE TABLE pemakaian (
    id_pemakaian BIGINT        NOT NULL AUTO_INCREMENT,
    id_perangkat INT           NOT NULL,
    waktu_catat  DATETIME      NOT NULL DEFAULT CURRENT_TIMESTAMP,
    energi_kwh   DECIMAL(10,3) NOT NULL,
    daya_watt    DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (id_pemakaian),
    CONSTRAINT fk_pemakaian_perangkat FOREIGN KEY (id_perangkat)
        REFERENCES perangkat_pengukur (id_perangkat)
        ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB;

CREATE TABLE peringatan (
    id_peringatan     BIGINT        NOT NULL AUTO_INCREMENT,
    id_ruangan        INT           NOT NULL,
    id_batas          INT           NOT NULL,
    waktu_peringatan  DATETIME      NOT NULL DEFAULT CURRENT_TIMESTAMP,
    nilai_pemakaian   DECIMAL(10,3) NOT NULL,
    status_notifikasi ENUM('menunggu','terkirim','dibaca','gagal') NOT NULL DEFAULT 'menunggu',
    PRIMARY KEY (id_peringatan),
    CONSTRAINT fk_peringatan_ruangan FOREIGN KEY (id_ruangan)
        REFERENCES ruangan (id_ruangan)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT fk_peringatan_batas FOREIGN KEY (id_batas)
        REFERENCES batas_pemakaian (id_batas)
        ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB;

