-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Gép: 127.0.0.1:3307
-- Létrehozás ideje: 2026. Nov 22. 13:56
-- Kiszolgáló verziója: 10.4.32-MariaDB
-- PHP verzió: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Adatbázis: `flotta`
--

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `gepjarmu`
--

CREATE TABLE `gepjarmu` (
  `Id` int(11) NOT NULL,
  `Rendszam` varchar(8) NOT NULL,
  `Marka` varchar(16) NOT NULL,
  `Tipus` varchar(16) NOT NULL,
  `Ulesek` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- A tábla adatainak kiíratása `gepjarmu`
--

INSERT INTO `gepjarmu` (`Id`, `Rendszam`, `Marka`, `Tipus`, `Ulesek`) VALUES
(1, 'ABC123', 'Suzuki', 'Vitra', 5),
(2, 'BCD234', 'Opel', 'Vivaro', 9),
(3, 'CEG987', 'Suzuki', 'Jimny', 4);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `kikuldetes`
--

CREATE TABLE `kikuldetes` (
  `Id` int(11) NOT NULL,
  `Celja` text NOT NULL,
  `Cim` varchar(128) NOT NULL,
  `Kezdes` datetime NOT NULL,
  `Befejezes` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- A tábla adatainak kiíratása `kikuldetes`
--

INSERT INTO `kikuldetes` (`Id`, `Celja`, `Cim`, `Kezdes`, `Befejezes`) VALUES
(1, 'Továbbképzés', 'Budapest VI. ker Mogácsi Károly utca 7.', '2025-11-26 20:22:12', '2025-11-27 20:22:12'),
(2, 'Megbeszélés Partner Kft.', 'Szikszó Almás utca 3', '2025-11-11 17:48:23', '2025-11-11 17:48:23'),
(3, 'Üzletkötés a NoMoney Ltd-vel', 'Wien, Neukirche str. 3', '2025-11-10 19:40:46', '2025-11-12 19:40:46');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `kikuldottjarmu`
--

CREATE TABLE `kikuldottjarmu` (
  `Id` int(11) NOT NULL,
  `GepjarmuId` int(11) NOT NULL,
  `KikuldetesId` int(11) NOT NULL,
  `Sofor` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- A tábla adatainak kiíratása `kikuldottjarmu`
--

INSERT INTO `kikuldottjarmu` (`Id`, `GepjarmuId`, `KikuldetesId`, `Sofor`) VALUES
(1, 3, 2, 3),
(2, 3, 1, 3),
(3, 1, 1, 1),
(4, 1, 3, 3);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `sofor`
--

CREATE TABLE `sofor` (
  `Id` int(11) NOT NULL,
  `Name` varchar(64) NOT NULL,
  `Address` varchar(256) NOT NULL,
  `Email` varchar(64) NOT NULL,
  `Phone` varchar(32) DEFAULT NULL,
  `Image` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- A tábla adatainak kiíratása `sofor`
--

INSERT INTO `sofor` (`Id`, `Name`, `Address`, `Email`, `Phone`, `Image`) VALUES
(1, 'Próba Ödön', 'Miskolc, Petőfi tér 2', 'probaodon@ceg.hu', '0630-1234567', 'missing.jpg'),
(3, 'Erős Pista', 'Miskolc, Umbulda tér 8', 'erosp@ceg.hu', '0630-1234579', 'missing.jpg'),
(6, 'Neveeeeeeee', 'string', 'string', 'string', 'string');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `user`
--

CREATE TABLE `user` (
  `Id` int(11) NOT NULL,
  `Name` varchar(64) NOT NULL,
  `LoginName` varchar(64) NOT NULL,
  `Status` enum('pending','active','suspended','banned') NOT NULL DEFAULT 'pending',
  `Active` tinyint(1) NOT NULL,
  `Address` varchar(256) NOT NULL,
  `Email` varchar(255) NOT NULL,
  `Hash` varchar(255) NOT NULL,
  `Phone` varchar(32) DEFAULT NULL,
  `Image` varchar(255) NOT NULL,
  `Permission` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- A tábla adatainak kiíratása `user`
--

INSERT INTO `user` (`Id`, `Name`, `LoginName`, `Status`, `Active`, `Address`, `Email`, `Hash`, `Phone`, `Image`, `Permission`) VALUES
(1, 'Próba Ödön', 'probaodon', 'active', 1, 'Miskolc, Petőfi tér 2', 'probaodon@ceg.hu', '$argon2id$v=19$m=19456,t=2,p=1$NBb0IKLtdSHpFp4SVbScew$XOsu8gpoK5n9oLZ37AOUslrnl18kzdClqK7/BemHeNE', '0630-1234567', 'missing.jpg', 2),
(3, 'Erős Pista', 'erospista', 'pending', 0, 'Miskolc, Umbulda tér 8', 'erosp@ceg.hu', '72ed7255fe0acac6810fe55d69a325b21035874220a53cd6077502a28ca063b8', '0630-1234579', 'missing.jpg', 3),
(4, 'Jajaja put', 'PUTOLVA újfent', '', 1, 'string', 'string', 'string', 'string', 'string', 0);

--
-- Indexek a kiírt táblákhoz
--

--
-- A tábla indexei `gepjarmu`
--
ALTER TABLE `gepjarmu`
  ADD PRIMARY KEY (`Id`);

--
-- A tábla indexei `kikuldetes`
--
ALTER TABLE `kikuldetes`
  ADD PRIMARY KEY (`Id`);

--
-- A tábla indexei `kikuldottjarmu`
--
ALTER TABLE `kikuldottjarmu`
  ADD PRIMARY KEY (`Id`),
  ADD KEY `GepjarmuId` (`GepjarmuId`),
  ADD KEY `KikuldetesId` (`KikuldetesId`),
  ADD KEY `Sofor` (`Sofor`);

--
-- A tábla indexei `sofor`
--
ALTER TABLE `sofor`
  ADD PRIMARY KEY (`Id`),
  ADD UNIQUE KEY `Email` (`Email`);

--
-- A tábla indexei `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`Id`),
  ADD UNIQUE KEY `Email` (`Email`),
  ADD UNIQUE KEY `LoginName` (`LoginName`),
  ADD KEY `Permission` (`Permission`);

--
-- A kiírt táblák AUTO_INCREMENT értéke
--

--
-- AUTO_INCREMENT a táblához `gepjarmu`
--
ALTER TABLE `gepjarmu`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT a táblához `kikuldetes`
--
ALTER TABLE `kikuldetes`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT a táblához `kikuldottjarmu`
--
ALTER TABLE `kikuldottjarmu`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT a táblához `sofor`
--
ALTER TABLE `sofor`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT a táblához `user`
--
ALTER TABLE `user`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Megkötések a kiírt táblákhoz
--

--
-- Megkötések a táblához `kikuldottjarmu`
--
ALTER TABLE `kikuldottjarmu`
  ADD CONSTRAINT `kikuldottjarmu_ibfk_1` FOREIGN KEY (`KikuldetesId`) REFERENCES `kikuldetes` (`Id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `kikuldottjarmu_ibfk_2` FOREIGN KEY (`Sofor`) REFERENCES `sofor` (`Id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `kikuldottjarmu_ibfk_3` FOREIGN KEY (`GepjarmuId`) REFERENCES `gepjarmu` (`Id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
