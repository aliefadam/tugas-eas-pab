-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 13 Jan 2024 pada 18.33
-- Versi server: 10.4.22-MariaDB
-- Versi PHP: 8.1.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `uniwear`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `klub`
--

CREATE TABLE `klub` (
  `id_klub` int(11) NOT NULL,
  `nama_klub` varchar(255) NOT NULL,
  `tanggal_berdiri` date NOT NULL,
  `kondisi_klub` varchar(255) NOT NULL,
  `kota_klub` varchar(255) NOT NULL,
  `peringkat` varchar(255) NOT NULL,
  `hargaKlub` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `klub`
--

INSERT INTO `klub` (`id_klub`, `nama_klub`, `tanggal_berdiri`, `kondisi_klub`, `kota_klub`, `peringkat`, `hargaKlub`) VALUES
(21, 'Persija', '2024-01-09', 'Baik', 'Jakarta', '4-6', 2000000);

-- --------------------------------------------------------

--
-- Struktur dari tabel `supporter`
--

CREATE TABLE `supporter` (
  `id_supporter` int(11) NOT NULL,
  `nama_supporter` varchar(255) NOT NULL,
  `alamat` varchar(255) NOT NULL,
  `tanggal_daftar` date NOT NULL,
  `no_telephone` varchar(255) NOT NULL,
  `foto` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `supporter`
--

INSERT INTO `supporter` (`id_supporter`, `nama_supporter`, `alamat`, `tanggal_daftar`, `no_telephone`, `foto`) VALUES
(1, 'Alief adam', 'Sby', '2024-01-12', '9090', '20240112191528.png'),
(2, 'Angga', 'Bandarejo', '2024-01-13', '0895364711840', '20240113095454.heic');

-- --------------------------------------------------------

--
-- Struktur dari tabel `user`
--

CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `nama` varchar(255) NOT NULL,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `user`
--

INSERT INTO `user` (`id`, `nama`, `username`, `password`) VALUES
(1, 'Alief', 'alief123', '$2y$10$u2DrguxesUSY0uR5qsTgKO1/YS8d6M5jH3p68n.Nv0p7xSrLNJoDG'),
(2, 'Angga', 'angga123', '$2y$10$45bp8bqNqxf5E2E6.KEPFOcb0xenckTYVeA0FyLHMxLoGv8YcxGmS');

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
