CREATE DATABASE IF NOT EXISTS `toko_online` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `toko_online`;

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";

CREATE TABLE `tb_barang` (
	`id_brg` int(11) NOT NULL,
	`nama_brg` varchar(120) NOT NULL,
	`keterangan` varchar(225) NOT NULL,
	`kategori` varchar(60) NOT NULL,
	`harga` int(11) NOT NULL,
	`stok` int(4) NOT NULL,
	`gambar` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `tb_barang` (`id_brg`, `nama_brg`, `keterangan`, `kategori`, `harga`, `stok`, `gambar`) VALUES
	(1, 'Sepatu', 'Sepatu Merk All Stars', 'Pakaian Pria', 300000, 10, 'sepatu.jpg'),
	(2, 'Kamera', 'Kamera Canon EOS 200D', 'Elektronik', 5900000, 10, 'kamera.jpg'),
	(3, 'Handphone', 'Samsung Galaxy A20', 'Elektronik', 3400000, 10, 'hp.jpg'),
	(4, 'Laptop', 'Laptop ASUS RAM 2GB', 'Elektronik', 4500000, 10, 'laptop.jpg');

CREATE TABLE `tb_invoice` (
	`id` int(11) NOT NULL,
	`nama` varchar(56) NOT NULL,
	`alamat` varchar(225) NOT NULL,
	`tgl_pesan` datetime NOT NULL,
	`batas_bayar` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `tb_pesanan` (
	`id` int(11) NOT NULL,
	`id_invoice` int(11) NOT NULL,
	`id_brg` int(11) NOT NULL,
	`nama_brg` varchar(50) NOT NULL,
	`jumlah` int(3) NOT NULL,
	`harga` int(10) NOT NULL,
	`pilihan` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

DELIMITER $$
CREATE TRIGGER `pesanan_penjualan` AFTER INSERT ON `tb_pesanan` FOR EACH ROW BEGIN
UPDATE tb_barang SET stok = stok-NEW.jumlah
WHERE id_brg = NEW.id_brg;
END
$$
DELIMITER ;

CREATE TABLE `tb_user` (
	`id` int(11) NOT NULL,
	`nama` varchar(50) NOT NULL,
	`username` varchar(50) NOT NULL,
	`password` varchar(50) NOT NULL,
	`role_id` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `tb_user` (`id`, `nama`, `username`, `password`, `role_id`) VALUES
	(1, 'admin', 'admin', '123', 1),
	(2, 'user', 'user', '123', 2);

ALTER TABLE `tb_barang`
ADD PRIMARY KEY (`id_brg`);

ALTER TABLE `tb_invoice`
ADD PRIMARY KEY (`id`);

ALTER TABLE `tb_pesanan`
ADD PRIMARY KEY (`id`);

ALTER TABLE `tb_user`
ADD PRIMARY KEY (`id`);

ALTER TABLE `tb_barang`
MODIFY `id_brg` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

ALTER TABLE `tb_invoice`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1;

ALTER TABLE `tb_pesanan`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1;

ALTER TABLE `tb_user`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

COMMIT;
