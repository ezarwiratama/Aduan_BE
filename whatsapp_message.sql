-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 06 Agu 2024 pada 09.58
-- Versi server: 10.4.32-MariaDB
-- Versi PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `whatsapp_message`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `contacts`
--

CREATE TABLE `contacts` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `no_handphone` varchar(255) NOT NULL,
  `bidang` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `contacts`
--

INSERT INTO `contacts` (`id`, `name`, `no_handphone`, `bidang`) VALUES
(5, 'Deni Setiaji', '6281383318712', 'Informatika (2)'),
(8, 'Ezar Hardin Wiratama', '6285174100604', 'Informatika (2)');

-- --------------------------------------------------------

--
-- Struktur dari tabel `messages`
--

CREATE TABLE `messages` (
  `id` int(11) NOT NULL,
  `status` varchar(12) NOT NULL,
  `phoneNumber` varchar(255) NOT NULL,
  `userName` varchar(255) NOT NULL,
  `message` text NOT NULL,
  `date` date NOT NULL,
  `hour` time NOT NULL DEFAULT current_timestamp(),
  `createdAt` date NOT NULL DEFAULT current_timestamp(),
  `updatedAt` date NOT NULL DEFAULT current_timestamp(),
  `pic` varchar(255) NOT NULL,
  `no_pic` varchar(255) NOT NULL,
  `reply_message` text NOT NULL,
  `reply_time` datetime NOT NULL,
  `reply_pic` text NOT NULL,
  `media` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `messages`
--

INSERT INTO `messages` (`id`, `status`, `phoneNumber`, `userName`, `message`, `date`, `hour`, `createdAt`, `updatedAt`, `pic`, `no_pic`, `reply_message`, `reply_time`, `reply_pic`, `media`) VALUES
(95, 'done', '6285174100604', 'Ezar Hardin', 'ppppppp', '2024-07-22', '08:17:18', '2024-07-22', '2024-07-22', 'Ezar Hardin Wiratama', '6285174100604', 'selesai', '2024-07-24 00:00:00', '', ''),
(96, 'done', '6285174100604', 'Ezar Hardin', 'ppp', '2024-07-22', '08:28:48', '2024-07-22', '2024-07-22', 'Ezar Hardin Wiratama', '6285174100604', 'selesai', '2024-07-24 00:00:00', '', ''),
(97, 'done', '6285174100604', 'Ezar Hardin', 'pppp', '2024-07-22', '09:20:37', '2024-07-22', '2024-07-22', 'Ezar Hardin Wiratama', '6285174100604', 'selesai', '2024-07-24 00:00:00', '', ''),
(98, 'done', '6285174100604', 'Ezar Hardin', 'ppppp', '2024-07-22', '09:23:12', '2024-07-22', '2024-07-24', 'Ezar Hardin Wiratama', '6285174100604', 'done', '2024-07-24 00:00:00', 'aduan telah selesai', ''),
(99, 'done', '6285174100604', 'Ezar Hardin', 'pppp', '2024-07-22', '09:23:15', '2024-07-22', '2024-07-24', 'Ezar Hardin Wiratama', '6285174100604', 'done', '2024-07-24 00:00:00', 'aduan telah ditangani', ''),
(100, 'done', '6285174100604', 'Ezar Hardin', 'aduan masuk', '2024-07-22', '14:30:08', '2024-07-22', '2024-07-22', 'Ezar Hardin Wiratama', '6285174100604', 'selesai', '2024-07-24 00:00:00', '', ''),
(101, 'done', '6281383318712', 'Deni Setiaji', 'Aduan internet', '2024-07-22', '14:32:24', '2024-07-22', '2024-07-22', 'Ezar Hardin Wiratama', '6285174100604', 'Aduan sudah ditangani', '2024-07-24 00:00:00', '', ''),
(102, 'done', '62895380801797', 'diva', 'test', '2024-07-22', '21:35:17', '2024-07-22', '2024-07-22', 'Ezar Hardin Wiratama', '6285174100604', 'aduan udah selese yaa', '2024-07-24 00:00:00', '', ''),
(103, 'done', '6289636967752', 'Lucky Luke', 'aduan dari bidang informatika', '2024-07-23', '07:46:59', '2024-07-23', '2024-07-23', 'Ezar Hardin Wiratama', '6285174100604', 'aman', '2024-07-24 00:00:00', '', ''),
(104, 'done', '6285174100604', 'Ezar Hardin', 'aduan masuk', '2024-07-24', '07:44:07', '2024-07-24', '2024-07-24', 'Ezar Hardin Wiratama', '6285174100604', 'done', '2024-07-24 00:00:00', 'aduan telah selesai', ''),
(105, 'done', '6285174100604', 'Ezar Hardin', 'aduan masukk', '2024-07-24', '10:56:03', '2024-07-24', '2024-07-24', 'Ezar Hardin Wiratama', '6285174100604', 'done', '0000-00-00 00:00:00', 'aduan telah selesai', ''),
(106, 'done', '6285174100604', 'Ezar Hardin', 'aduan masuk', '2024-07-24', '11:31:35', '2024-07-24', '2024-07-24', 'Ezar Hardin Wiratama', '6285174100604', 'done', '0000-00-00 00:00:00', 'done', ''),
(107, 'done', '6285174100604', 'Ezar Hardin', 'aduan masuk', '2024-07-24', '11:31:45', '2024-07-24', '2024-07-24', 'Ezar Hardin Wiratama', '6285174100604', 'done', '0000-00-00 00:00:00', 'done', ''),
(108, 'done', '6285174100604', 'Ezar Hardin', 'masukk', '2024-07-24', '11:39:11', '2024-07-24', '2024-07-24', 'Ezar Hardin Wiratama', '6285174100604', 'done', '0000-00-00 00:00:00', 'done', ''),
(109, 'done', '6285174100604', 'Ezar Hardin', 'masukk', '2024-07-24', '11:39:25', '2024-07-24', '2024-07-24', 'Ezar Hardin Wiratama', '6285174100604', 'done', '0000-00-00 00:00:00', 'done', ''),
(110, 'done', '6285174100604', 'Ezar Hardin', 'masukk', '2024-07-24', '11:39:30', '2024-07-24', '2024-07-24', 'Ezar Hardin Wiratama', '6285174100604', 'done', '0000-00-00 00:00:00', 'done', ''),
(111, 'done', '6285174100604', 'Ezar Hardin', 'masukk', '2024-07-24', '11:55:31', '2024-07-24', '2024-07-24', 'Ezar Hardin Wiratama', '6285174100604', 'P', '2024-07-24 04:56:24', 'p', ''),
(112, 'done', '6285174100604', 'Ezar Hardin', 'masukk', '2024-07-24', '11:55:36', '2024-07-24', '2024-07-29', 'Ezar Hardin Wiratama', '6285174100604', '', '0000-00-00 00:00:00', '', ''),
(113, 'done', '628156982413', 'Abdur Rahman', 'Lapor Pak, jaringan di tempat saya bermasalah', '2024-07-24', '13:33:18', '2024-07-24', '2024-07-24', 'Deni', '6281383318712', '', '0000-00-00 00:00:00', '', ''),
(114, 'done', '628156982413', 'Abdur Rahman', 'Lapor Pak, jaringan di tempat saya bermasalah', '2024-07-24', '13:35:34', '2024-07-24', '2024-07-24', 'Ezar Hardin Wiratama', '6285174100604', 'aduan selesai', '2024-07-24 06:38:14', 'aduan udah diselesaikan', ''),
(115, 'done', '6285174100604', 'Ezar Hardin', '', '2024-07-25', '09:17:25', '2024-07-25', '2024-07-29', 'Ezar Hardin Wiratama', '6285174100604', '', '0000-00-00 00:00:00', '', '2024-07-25-09:17:25-aduan.jpg'),
(116, 'done', '6285174100604', 'Ezar Hardin', '', '2024-07-25', '09:19:52', '2024-07-25', '2024-07-29', 'Ezar Hardin Wiratama', '6285174100604', '', '0000-00-00 00:00:00', '', '2024-07-25-09:19:52-Embedded System 11 - Pengantar Message Queuing Telemetry Transport.pdf.pdf'),
(117, 'done', '6285174100604', 'Ezar Hardin', '', '2024-07-25', '09:42:19', '2024-07-25', '2024-07-29', 'Ezar Hardin Wiratama', '6285174100604', '', '0000-00-00 00:00:00', '', '2024-07-25-09:42:19-aduan.jpg'),
(118, 'done', '6285174100604', 'Ezar Hardin', '', '2024-07-25', '09:48:04', '2024-07-25', '2024-07-29', 'Ezar Hardin Wiratama', '6285174100604', '', '0000-00-00 00:00:00', '', '2024-07-25-09:48:04-aduan.jpg'),
(119, 'done', '6285174100604', 'Ezar Hardin', '', '2024-07-25', '09:49:04', '2024-07-25', '2024-07-25', '', '', '', '0000-00-00 00:00:00', '', '2024-07-25-09:49:04-aduan.jpg'),
(120, 'done', '6285174100604', 'Ezar Hardin', '', '2024-07-25', '09:51:53', '2024-07-25', '2024-07-25', '', '', '', '0000-00-00 00:00:00', '', '2024-07-25-09:51:53-aduan.jpg'),
(121, 'done', '6285174100604', 'Ezar Hardin', '', '2024-07-25', '09:53:01', '2024-07-25', '2024-07-25', '', '', '', '0000-00-00 00:00:00', '', '2024-07-25-09:53:01-aduan.jpg'),
(122, 'done', '6285174100604', 'Ezar Hardin', '', '2024-07-25', '09:53:46', '2024-07-25', '2024-07-25', '', '', '', '0000-00-00 00:00:00', '', '2024-07-25-09:53:46-aduan.jpg'),
(123, 'done', '6285174100604', 'Ezar Hardin', '', '2024-07-25', '10:02:27', '2024-07-25', '2024-07-25', '', '', '', '0000-00-00 00:00:00', '', '2024-07-25-10:02:27-aduan.jpg'),
(124, 'done', '6285174100604', 'Ezar Hardin', 'p', '2024-07-25', '10:26:21', '2024-07-25', '2024-07-25', '', '', '', '0000-00-00 00:00:00', '', ''),
(125, 'done', '6285174100604', 'Ezar Hardin', 'aduan masuk', '2024-07-25', '11:12:09', '2024-07-25', '2024-07-25', '', '', '', '0000-00-00 00:00:00', '', ''),
(126, 'done', '6285174100604', 'Ezar Hardin', 'aduan masuk', '2024-07-25', '11:13:20', '2024-07-25', '2024-07-25', '', '', '', '0000-00-00 00:00:00', '', ''),
(127, 'done', '6285174100604', 'Ezar Hardin', 'aduan gambar masuk', '2024-07-25', '11:32:09', '2024-07-25', '2024-07-25', '', '', '', '0000-00-00 00:00:00', '', '\'ADUAN-\' + 2024-07-25 + Ezar Hardin .jpeg'),
(128, 'done', '6285174100604', 'Ezar Hardin', 'aduan gambar masuk', '2024-07-25', '11:32:09', '2024-07-25', '2024-07-25', '', '', '', '0000-00-00 00:00:00', '', ''),
(129, 'done', '6285174100604', 'Ezar Hardin', 'aduan gambar 2 masuk', '2024-07-25', '11:35:33', '2024-07-25', '2024-07-25', '', '', '', '0000-00-00 00:00:00', '', 'ADUAN-2024-07-25-Ezar Hardin.jpeg'),
(130, 'done', '6285174100604', 'Ezar Hardin', 'aduan gambar 2 masuk', '2024-07-25', '11:35:33', '2024-07-25', '2024-07-25', '', '', '', '0000-00-00 00:00:00', '', ''),
(131, 'done', '6285174100604', 'Ezar Hardin', 'aduan masuk', '2024-07-25', '11:43:37', '2024-07-25', '2024-07-25', '', '', '', '0000-00-00 00:00:00', '', ''),
(132, 'done', '6285174100604', 'Ezar Hardin', 'aduan masuk gambar', '2024-07-25', '11:43:54', '2024-07-25', '2024-07-25', '', '', '', '0000-00-00 00:00:00', '', 'ADUAN-2024-07-25-Ezar Hardin.jpeg'),
(133, 'done', '6285174100604', 'Ezar Hardin', 'aduan masuk gambar', '2024-07-25', '13:59:53', '2024-07-25', '2024-07-25', '', '', '', '0000-00-00 00:00:00', '', 'ADUAN-2024-07-25-6285174100604.jpeg'),
(134, 'done', '6285174100604', 'Ezar Hardin', 'aduan masuk gambar', '2024-07-25', '14:00:19', '2024-07-25', '2024-07-25', '', '', '', '0000-00-00 00:00:00', '', 'ADUAN-2024-07-25-6285174100604.jpeg'),
(135, 'done', '6285174100604', 'Ezar Hardin', 'test gambar', '2024-07-26', '13:23:18', '2024-07-26', '2024-07-26', '', '', '', '0000-00-00 00:00:00', '', 'ADUAN-2024-07-26-628517410060408A6928CF2510713A001893A9AE563A2.jpeg'),
(136, 'done', '6285174100604', 'Ezar Hardin', 'test', '2024-07-26', '13:24:11', '2024-07-26', '2024-07-26', 'Ezar Hardin Wiratama', '6285174100604', '', '0000-00-00 00:00:00', 'aduan sudah dikerjakann', ''),
(137, 'done', '6285174100604', 'Ezar Hardin', 'test docx', '2024-07-26', '13:30:30', '2024-07-26', '2024-07-26', '', '', '', '0000-00-00 00:00:00', '', '13kp-Permohonan KP_Prodi.docx.docx'),
(138, 'done', '6285174100604', 'Ezar Hardin', 'test pdf', '2024-07-26', '13:32:14', '2024-07-26', '2024-07-26', '', '', '', '0000-00-00 00:00:00', '', '13.polimer-sintetik.pdf.pdf'),
(139, 'done', '6285174100604', 'Ezar Hardin', 'test pdf', '2024-07-26', '13:35:57', '2024-07-26', '2024-07-26', '', '', '', '0000-00-00 00:00:00', '', '13.polimer-sintetik.pdf.ts'),
(140, 'done', '6285174100604', 'Ezar Hardin', 'test pdf', '2024-07-26', '13:37:09', '2024-07-26', '2024-07-26', '', '', '', '0000-00-00 00:00:00', '', '13.polimer-sintetik.pdfapplication/pdf'),
(141, 'done', '6285174100604', 'Ezar Hardin', 'p pdf', '2024-07-26', '13:44:09', '2024-07-26', '2024-07-29', 'Ezar Hardin Wiratama', '6285174100604', '', '0000-00-00 00:00:00', '', '13.polimer-sintetik.pdf.pdf'),
(142, 'done', '6285174100604', 'Ezar Hardin', 'foto', '2024-07-26', '13:44:37', '2024-07-26', '2024-07-26', '', '', '', '0000-00-00 00:00:00', '', 'ADUAN-2024-07-26-62851741006049B3627570925D35F0348969482C0FA99.jpeg'),
(143, 'done', '6285174100604', 'Ezar Hardin', 'pdf', '2024-07-26', '13:47:04', '2024-07-26', '2024-07-26', '', '', '', '0000-00-00 00:00:00', '', '13.polimer-sintetik.pdf'),
(144, 'done', '6285174100604', 'Ezar Hardin', 'pdf', '2024-07-26', '13:49:55', '2024-07-26', '2024-07-29', 'Ezar Hardin Wiratama', '6285174100604', 'selesai', '2024-07-29 01:07:50', 'aduan sudah dikerjakannnnnn', '13.polimer-sintetik.pdf'),
(145, 'done', '6285174100604', 'Ezar Hardin', 'test ngirim gambar', '2024-07-29', '08:58:40', '2024-07-29', '2024-07-29', 'Ezar Hardin Wiratama', '6285174100604', '', '0000-00-00 00:00:00', '', 'ADUAN-2024-07-29-6285174100604D0A5A526C46F4B872C8132E4FDB0F554.jpeg'),
(146, 'done', '6285174100604', 'Ezar Hardin', 'aduan gambar', '2024-07-29', '09:10:32', '2024-07-29', '2024-07-29', 'Ezar Hardin Wiratama', '6285174100604', '', '0000-00-00 00:00:00', '', 'ADUAN-2024-07-29-628517410060469AC3BFC3178B3B4E2C36CDBA82DD94A.jpeg'),
(147, 'done', '6285174100604', 'Ezar Hardin', 'aduan masuk', '2024-07-29', '09:16:24', '2024-07-29', '2024-07-29', 'Ezar Hardin Wiratama', '6285174100604', '', '0000-00-00 00:00:00', '', 'ADUAN-2024-07-29-6285174100604AC8492C26A35C9DF76262279BD7B2375.jpeg'),
(148, 'done', '6285174100604', 'Ezar Hardin', 'aduan masuk pdf', '2024-07-29', '09:44:14', '2024-07-29', '2024-07-29', 'Ezar Hardin Wiratama', '6285174100604', '', '0000-00-00 00:00:00', '', 'Cara Menggunakan WIFI UNDIPConnect Pada Windows 10.pdf'),
(149, 'done', '6285174100604', 'Ezar Hardin', 'aduan jaringan', '2024-07-29', '11:10:10', '2024-07-29', '2024-07-30', 'Ezar Hardin Wiratama', '6285174100604', 'done', '2024-07-30 02:32:56', 'sudah', ''),
(150, 'process', '6285174100604', 'Ezar Hardin', 'aduan jaringan', '2024-07-30', '09:30:42', '2024-07-30', '2024-07-30', 'Ezar Hardin Wiratama', '6285174100604', '', '0000-00-00 00:00:00', '', ''),
(151, 'done', '6285174100604', 'Ezar Hardin', 'aduan jaringan', '2024-07-30', '09:31:18', '2024-07-30', '2024-07-30', 'Ezar Hardin Wiratama', '6285174100604', 'done', '2024-07-30 03:18:51', 'aduan selesai', 'ADUAN-2024-07-30-6285174100604D54A1476AA40E5637A2D0C21419FE959.jpeg'),
(152, 'process', '6285174100604', 'Ezar Hardin', 'aduan', '2024-07-30', '10:23:37', '2024-07-30', '2024-07-30', 'Ezar Hardin Wiratama', '6285174100604', '', '0000-00-00 00:00:00', '', ''),
(153, 'process', '6285174100604', 'Ezar Hardin', 'aduan', '2024-07-30', '10:23:44', '2024-07-30', '2024-07-30', 'Ezar Hardin Wiratama', '6285174100604', '', '0000-00-00 00:00:00', '', ''),
(154, 'done', '6285174100604', 'Ezar Hardin', 'aduan gambar', '2024-07-30', '14:59:12', '2024-07-30', '2024-07-30', 'Ezar Hardin Wiratama', '6285174100604', 'done', '2024-07-30 08:00:44', 'aduan selesai', 'ADUAN-2024-07-30-6285174100604E73A429A99AEAADA562B473148BD11F2.jpeg'),
(155, 'pending', '6285174100604', 'Ezar Hardin', 'aduan', '2024-07-31', '15:22:33', '2024-07-31', '2024-07-31', '', '', '', '0000-00-00 00:00:00', '', '');

-- --------------------------------------------------------

--
-- Struktur dari tabel `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(255) NOT NULL,
  `role` varchar(12) NOT NULL,
  `password` varchar(255) NOT NULL,
  `createdAt` timestamp NOT NULL DEFAULT current_timestamp(),
  `updatedAt` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `users`
--

INSERT INTO `users` (`id`, `username`, `role`, `password`, `createdAt`, `updatedAt`) VALUES
(1, 'admin', 'admin', '$2a$10$6ln/AeNKsh4es5Q88SbmOesV54N/wP4lF/xE2tq2bOtm7nBhqR.yu', '2024-07-30 06:53:30', '0000-00-00 00:00:00'),
(2, 'ezar', 'user', '$2a$10$Q3wGVpBHzSJTSP91W2gVhO.Hw7JJjBj1Di0G5w5cGoeE/lKAwhZK2', '2024-07-30 07:12:30', '0000-00-00 00:00:00');

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `contacts`
--
ALTER TABLE `contacts`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `messages`
--
ALTER TABLE `messages`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `contacts`
--
ALTER TABLE `contacts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT untuk tabel `messages`
--
ALTER TABLE `messages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=156;

--
-- AUTO_INCREMENT untuk tabel `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
