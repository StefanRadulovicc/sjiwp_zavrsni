-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 02, 2026 at 09:35 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `dbp_z`
--

-- --------------------------------------------------------

--
-- Table structure for table `izazov`
--

CREATE TABLE `izazov` (
  `ID_izazov` int(11) NOT NULL,
  `kreator_id` int(11) DEFAULT NULL,
  `Naziv` varchar(150) NOT NULL,
  `Opis` text DEFAULT NULL,
  `Pocetak` date NOT NULL,
  `Kraj` date NOT NULL CHECK (`Kraj` > `Pocetak`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `korisnik`
--

CREATE TABLE `korisnik` (
  `ID_korisnik` int(11) NOT NULL,
  `Ime` varchar(100) NOT NULL,
  `Email` varchar(150) NOT NULL,
  `LozinkaHash` varchar(255) NOT NULL,
  `DatumRegistracije` datetime NOT NULL DEFAULT current_timestamp(),
  `Cilj` varchar(50) DEFAULT NULL CHECK (`Cilj` in ('mrsavljenje','masa','kondicija','snaga','ostalo'))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `korisnik`
--

INSERT INTO `korisnik` (`ID_korisnik`, `Ime`, `Email`, `LozinkaHash`, `DatumRegistracije`, `Cilj`) VALUES
(1, 'Marko Horvat', 'marko.h@email.hr', 'hash123', '2025-01-15 10:00:00', 'masa'),
(2, 'Ana Kovač', 'ana.k@email.hr', 'hash123', '2025-02-10 14:30:00', 'mrsavljenje'),
(3, 'Ivan Babić', 'ivan.b@email.hr', 'hash123', '2025-03-05 09:15:00', 'snaga'),
(4, 'Marija Jurić', 'marija.j@email.hr', 'hash123', '2025-03-20 18:45:00', 'kondicija'),
(5, 'Josip Novak', 'josip.n@email.hr', 'hash123', '2025-04-01 07:20:00', 'masa'),
(6, 'Petra Vuković', 'petra.v@email.hr', 'hash123', '2025-05-12 16:10:00', 'ostalo'),
(7, 'Luka Knežević', 'luka.k@email.hr', 'hash123', '2025-06-18 11:55:00', 'snaga'),
(8, 'Ivana Matić', 'ivana.m@email.hr', 'hash123', '2025-07-22 20:05:00', 'mrsavljenje'),
(9, 'Tomislav Pavlić', 'tomislav.p@email.hr', 'hash123', '2025-08-30 08:40:00', 'masa'),
(10, 'Maja Blažević', 'maja.b@email.hr', 'hash123', '2025-09-14 19:25:00', 'kondicija'),
(11, 'Stjepan Šarić', 'stjepan.s@email.hr', 'hash123', '2025-10-05 06:50:00', 'snaga'),
(12, 'Katarina Perić', 'katarina.p@email.hr', 'hash123', '2025-11-11 15:35:00', 'mrsavljenje'),
(13, 'Filip Lovrić', 'filip.l@email.hr', 'hash123', '2025-12-02 12:15:00', 'masa'),
(14, 'Jelena Božić', 'jelena.b@email.hr', 'hash123', '2026-01-20 09:30:00', 'kondicija'),
(15, 'Dario Varga', 'dario.v@email.hr', 'hash123', '2026-02-15 17:00:00', 'snaga');

-- --------------------------------------------------------

--
-- Table structure for table `osobnirekord`
--

CREATE TABLE `osobnirekord` (
  `ID_rekord` int(11) NOT NULL,
  `korisnik_id` int(11) NOT NULL,
  `vjezba_id` int(11) NOT NULL,
  `MaxOpterecenje_kg` decimal(10,0) DEFAULT NULL,
  `BrojPonavljanja` int(11) DEFAULT NULL,
  `DatumPostizanja` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `osobnirekord`
--

INSERT INTO `osobnirekord` (`ID_rekord`, `korisnik_id`, `vjezba_id`, `MaxOpterecenje_kg`, `BrojPonavljanja`, `DatumPostizanja`) VALUES
(1, 1, 1, 120, 1, '2025-06-01'),
(2, 1, 2, 150, 1, '2025-06-15'),
(3, 2, 5, 0, 20, '2025-07-01'),
(4, 3, 3, 200, 1, '2025-08-10'),
(5, 4, 9, 0, 1, '2025-05-20'),
(6, 5, 1, 100, 5, '2025-09-01'),
(7, 6, 6, 20, 10, '2025-10-10'),
(8, 7, 2, 180, 1, '2025-11-15'),
(9, 8, 12, 120, 8, '2025-12-05'),
(10, 9, 4, 0, 15, '2026-01-10'),
(11, 10, 14, 0, 50, '2026-02-20'),
(12, 11, 10, 80, 3, '2026-03-01'),
(13, 12, 7, 15, 12, '2026-03-15'),
(14, 13, 8, 25, 10, '2026-04-05'),
(15, 14, 15, 0, 30, '2026-04-20');

-- --------------------------------------------------------

--
-- Table structure for table `programvjezbanja`
--

CREATE TABLE `programvjezbanja` (
  `ID_program` int(11) NOT NULL,
  `korisnik_id` int(11) DEFAULT NULL,
  `Naziv` varchar(150) NOT NULL,
  `Opis` text DEFAULT NULL,
  `JeSistemski` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tjelesnamjera`
--

CREATE TABLE `tjelesnamjera` (
  `ID_mjera` int(11) NOT NULL,
  `korisnik_id` int(11) NOT NULL,
  `Datum` date NOT NULL,
  `TjelesnaTezina` float DEFAULT NULL,
  `OpsegStruka` float DEFAULT NULL,
  `OpsegBokova` float DEFAULT NULL,
  `OpsegGrudi` float DEFAULT NULL,
  `PostotakMasnoce` float DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tjelesnamjera`
--

INSERT INTO `tjelesnamjera` (`ID_mjera`, `korisnik_id`, `Datum`, `TjelesnaTezina`, `OpsegStruka`, `OpsegBokova`, `OpsegGrudi`, `PostotakMasnoce`) VALUES
(16, 1, '2025-01-16', 85.5, 90, 100, 110, 18.5),
(17, 1, '2025-03-16', 87, 91, 101, 112, 18),
(18, 1, '2025-05-16', 88.5, 92, 102, 115, 17.5),
(19, 2, '2025-02-11', 75, 85, 105, 95, 25),
(20, 2, '2025-04-11', 72, 80, 100, 92, 22),
(21, 2, '2025-06-11', 69.5, 76, 96, 90, 20),
(22, 3, '2025-03-06', 95, 95, 110, 120, 20),
(23, 3, '2025-06-06', 94, 92, 108, 122, 18.5),
(24, 4, '2025-03-21', 65, 70, 90, 85, 19),
(25, 5, '2025-04-02', 80, 88, 98, 105, 15),
(26, 6, '2025-05-13', 78, 85, 100, 100, 21),
(27, 7, '2025-06-19', 100, 100, 115, 125, 22),
(28, 8, '2025-07-23', 82, 90, 110, 100, 28),
(29, 9, '2025-08-31', 70, 75, 90, 95, 14),
(30, 10, '2025-09-15', 60, 65, 85, 80, 18);

-- --------------------------------------------------------

--
-- Table structure for table `vjezba`
--

CREATE TABLE `vjezba` (
  `ID_vjezba` int(11) NOT NULL,
  `Naziv` varchar(150) NOT NULL,
  `MisicnaGrupa` varchar(100) DEFAULT NULL,
  `Oprema` varchar(100) DEFAULT NULL,
  `Tezina` varchar(50) DEFAULT NULL,
  `Opis` text DEFAULT NULL,
  `Video_URL` varchar(500) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `vjezba`
--

INSERT INTO `vjezba` (`ID_vjezba`, `Naziv`, `MisicnaGrupa`, `Oprema`, `Tezina`, `Opis`, `Video_URL`) VALUES
(1, 'Bench Press', 'Prsa', 'Šipka', 'Srednje', 'Osnovna vježba za prsa.', 'url/bench'),
(2, 'Čučanj', 'Noge', 'Šipka', 'Teško', 'Osnovna vježba za noge i core.', 'url/cucanj'),
(3, 'Mrtvo dizanje', 'Leđa', 'Šipka', 'Teško', 'Kompleksna vježba za cijeli stražnji lanac.', 'url/deadlift'),
(4, 'Zgibovi', 'Leđa', 'Vlastita težina', 'Srednje', 'Povlačenje tijela do šipke.', 'url/zgibovi'),
(5, 'Sklekovi', 'Prsa', 'Vlastita težina', 'Početno', 'Osnovna bodyweight vježba.', 'url/sklekovi'),
(6, 'Iskorak', 'Noge', 'Bučice', 'Srednje', 'Jednonožna vježba za kvadriceps.', 'url/iskorak'),
(7, 'Biceps pregib', 'Ruke', 'Bučice', 'Početno', 'Izolacijska vježba za biceps.', 'url/biceps'),
(8, 'Triceps ekstenzija', 'Ruke', 'Sajla', 'Početno', 'Izolacija tricepsa na sajli.', 'url/triceps'),
(9, 'Plank', 'Core', 'Vlastita težina', 'Početno', 'Izdržaj na podlakticama.', 'url/plank'),
(10, 'Vojnički potisak', 'Ramena', 'Šipka', 'Srednje', 'Potisak šipke iznad glave.', 'url/military'),
(11, 'Letenje bučicama', 'Ramena', 'Bučice', 'Srednje', 'Podizanje bučica u stranu.', 'url/letenje'),
(12, 'Leg press', 'Noge', 'Sprava', 'Početno', 'Potisak nogama na spravi.', 'url/legpress'),
(13, 'Lat mašina', 'Leđa', 'Sprava', 'Početno', 'Povlačenje na lat mašini.', 'url/lat'),
(14, 'Trbušnjaci', 'Core', 'Vlastita težina', 'Početno', 'Klasični trbušnjaci.', 'url/trbusnjaci'),
(15, 'Burpee', 'Kardio', 'Vlastita težina', 'Teško', 'Kombinacija skleka i skoka.', 'url/burpee'),
(16, 'Bench Press', 'Prsa', 'Šipka', 'Srednje', 'Osnovna vježba za prsa.', 'url/bench'),
(17, 'Čučanj', 'Noge', 'Šipka', 'Teško', 'Osnovna vježba za noge i core.', 'url/cucanj'),
(18, 'Mrtvo dizanje', 'Leđa', 'Šipka', 'Teško', 'Kompleksna vježba za cijeli stražnji lanac.', 'url/deadlift'),
(19, 'Zgibovi', 'Leđa', 'Vlastita težina', 'Srednje', 'Povlačenje tijela do šipke.', 'url/zgibovi'),
(20, 'Sklekovi', 'Prsa', 'Vlastita težina', 'Početno', 'Osnovna bodyweight vježba.', 'url/sklekovi'),
(21, 'Iskorak', 'Noge', 'Bučice', 'Srednje', 'Jednonožna vježba za kvadriceps.', 'url/iskorak'),
(22, 'Biceps pregib', 'Ruke', 'Bučice', 'Početno', 'Izolacijska vježba za biceps.', 'url/biceps'),
(23, 'Triceps ekstenzija', 'Ruke', 'Sajla', 'Početno', 'Izolacija tricepsa na sajli.', 'url/triceps'),
(24, 'Plank', 'Core', 'Vlastita težina', 'Početno', 'Izdržaj na podlakticama.', 'url/plank'),
(25, 'Vojnički potisak', 'Ramena', 'Šipka', 'Srednje', 'Potisak šipke iznad glave.', 'url/military'),
(26, 'Letenje bučicama', 'Ramena', 'Bučice', 'Srednje', 'Podizanje bučica u stranu.', 'url/letenje'),
(27, 'Leg press', 'Noge', 'Sprava', 'Početno', 'Potisak nogama na spravi.', 'url/legpress'),
(28, 'Lat mašina', 'Leđa', 'Sprava', 'Početno', 'Povlačenje na lat mašini.', 'url/lat'),
(29, 'Trbušnjaci', 'Core', 'Vlastita težina', 'Početno', 'Klasični trbušnjaci.', 'url/trbusnjaci'),
(30, 'Burpee', 'Kardio', 'Vlastita težina', 'Teško', 'Kombinacija skleka i skoka.', 'url/burpee');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `izazov`
--
ALTER TABLE `izazov`
  ADD PRIMARY KEY (`ID_izazov`),
  ADD KEY `FK_Izazov_Korisnik` (`kreator_id`);

--
-- Indexes for table `korisnik`
--
ALTER TABLE `korisnik`
  ADD PRIMARY KEY (`ID_korisnik`),
  ADD UNIQUE KEY `Email` (`Email`);

--
-- Indexes for table `osobnirekord`
--
ALTER TABLE `osobnirekord`
  ADD PRIMARY KEY (`ID_rekord`),
  ADD UNIQUE KEY `UQ_OsobniRekord` (`korisnik_id`,`vjezba_id`),
  ADD KEY `FK_OsobniRekord_Vjezba` (`vjezba_id`);

--
-- Indexes for table `programvjezbanja`
--
ALTER TABLE `programvjezbanja`
  ADD PRIMARY KEY (`ID_program`),
  ADD KEY `FK_ProgramVjezbanja_Korisnik` (`korisnik_id`);

--
-- Indexes for table `tjelesnamjera`
--
ALTER TABLE `tjelesnamjera`
  ADD PRIMARY KEY (`ID_mjera`),
  ADD KEY `FK_TjelesnaMjera_Korisnik` (`korisnik_id`);

--
-- Indexes for table `vjezba`
--
ALTER TABLE `vjezba`
  ADD PRIMARY KEY (`ID_vjezba`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `izazov`
--
ALTER TABLE `izazov`
  MODIFY `ID_izazov` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `korisnik`
--
ALTER TABLE `korisnik`
  MODIFY `ID_korisnik` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `osobnirekord`
--
ALTER TABLE `osobnirekord`
  MODIFY `ID_rekord` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `programvjezbanja`
--
ALTER TABLE `programvjezbanja`
  MODIFY `ID_program` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tjelesnamjera`
--
ALTER TABLE `tjelesnamjera`
  MODIFY `ID_mjera` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT for table `vjezba`
--
ALTER TABLE `vjezba`
  MODIFY `ID_vjezba` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `izazov`
--
ALTER TABLE `izazov`
  ADD CONSTRAINT `FK_Izazov_Korisnik` FOREIGN KEY (`kreator_id`) REFERENCES `korisnik` (`ID_korisnik`) ON DELETE SET NULL;

--
-- Constraints for table `osobnirekord`
--
ALTER TABLE `osobnirekord`
  ADD CONSTRAINT `FK_OsobniRekord_Korisnik` FOREIGN KEY (`korisnik_id`) REFERENCES `korisnik` (`ID_korisnik`) ON DELETE CASCADE,
  ADD CONSTRAINT `FK_OsobniRekord_Vjezba` FOREIGN KEY (`vjezba_id`) REFERENCES `vjezba` (`ID_vjezba`) ON DELETE CASCADE;

--
-- Constraints for table `programvjezbanja`
--
ALTER TABLE `programvjezbanja`
  ADD CONSTRAINT `FK_ProgramVjezbanja_Korisnik` FOREIGN KEY (`korisnik_id`) REFERENCES `korisnik` (`ID_korisnik`) ON DELETE SET NULL;

--
-- Constraints for table `tjelesnamjera`
--
ALTER TABLE `tjelesnamjera`
  ADD CONSTRAINT `FK_TjelesnaMjera_Korisnik` FOREIGN KEY (`korisnik_id`) REFERENCES `korisnik` (`ID_korisnik`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
