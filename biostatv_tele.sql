-- phpMyAdmin SQL Dump
-- version 3.5.5
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Czas wygenerowania: 22 Lut 2016, 14:54
-- Wersja serwera: 5.5.29
-- Wersja PHP: 5.2.17

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Baza danych: `biostatv_tele`
--

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `contact_form`
--

CREATE TABLE IF NOT EXISTS `contact_form` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `add_date` datetime NOT NULL,
  `subject_id` tinyint(1) NOT NULL,
  `user_id` int(11) NOT NULL,
  `text` text NOT NULL,
  `name` varchar(512) NOT NULL,
  `city` varchar(128) NOT NULL,
  `province_id` int(11) NOT NULL,
  `sector` varchar(512) NOT NULL,
  `phone` varchar(48) NOT NULL,
  `email` varchar(512) NOT NULL,
  `language_skill` varchar(256) NOT NULL,
  `ip` varchar(24) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `gallery`
--

CREATE TABLE IF NOT EXISTS `gallery` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(256) NOT NULL,
  `alias` varchar(256) NOT NULL,
  `description` longtext NOT NULL,
  `add_date` datetime NOT NULL,
  `update_date` datetime NOT NULL,
  `update_user_id` int(11) NOT NULL,
  `pos` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `gallery_image`
--

CREATE TABLE IF NOT EXISTS `gallery_image` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `add_date` datetime NOT NULL,
  `add_user_id` int(11) NOT NULL,
  `gallery_id` int(11) NOT NULL,
  `filename` varchar(256) NOT NULL,
  `title` varchar(256) NOT NULL,
  `type` varchar(32) NOT NULL,
  `pos` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `i18n_group`
--

CREATE TABLE IF NOT EXISTS `i18n_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `module` varchar(32) NOT NULL,
  `view` varchar(32) NOT NULL,
  `translation_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `module` (`module`),
  KEY `view` (`view`),
  KEY `translation_id` (`translation_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=244 ;

--
-- Zrzut danych tabeli `i18n_group`
--

INSERT INTO `i18n_group` (`id`, `module`, `view`, `translation_id`) VALUES
(214, '', '', 179),
(215, '', '', 180),
(216, '', '', 181),
(217, 'pages', 'index', 182),
(218, 'pages', 'index', 183),
(219, 'pages', 'index', 184),
(220, 'pages', 'index', 185),
(221, 'pages', 'index', 186),
(222, 'sliders', 'index', 187),
(223, 'sliders', 'index', 188),
(224, 'sliders', 'index', 184),
(225, 'sliders', 'index', 185),
(226, 'sliders', 'index', 191),
(227, 'logos', 'index', 187),
(228, 'logos', 'index', 188),
(229, 'logos', 'index', 184),
(230, 'logos', 'index', 185),
(231, 'logos', 'index', 191),
(232, 'users', 'index', 188),
(233, 'users', 'index', 198),
(234, 'users', 'index', 199),
(235, 'users', 'index', 200),
(236, 'users', 'index', 201),
(237, 'users', 'index', 202),
(238, 'users', 'index', 203),
(239, 'contactforms', 'index', 204),
(240, 'contactforms', 'index', 188),
(241, 'contactforms', 'index', 206),
(242, 'contactforms', 'index', 207),
(243, 'users', 'index', 208);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `i18n_language`
--

CREATE TABLE IF NOT EXISTS `i18n_language` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `key` varchar(3) NOT NULL,
  `name` varchar(32) NOT NULL,
  `add_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `i18n_translation`
--

CREATE TABLE IF NOT EXISTS `i18n_translation` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `lang` varchar(2) NOT NULL,
  `key` varchar(128) NOT NULL,
  `text` varchar(512) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `lang` (`lang`,`key`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=209 ;

--
-- Zrzut danych tabeli `i18n_translation`
--

INSERT INTO `i18n_translation` (`id`, `lang`, `key`, `text`) VALUES
(179, 'pl', 'wrong password', 'Wrong password'),
(180, 'pl', 'loged in', 'Loged in'),
(181, 'pl', 'loged out', 'Loged out'),
(182, 'pl', 'page', 'Strona'),
(183, 'pl', 'views', 'Wyświetleń'),
(184, 'pl', 'modify date', 'Data modyfikacji'),
(185, 'pl', 'options', 'Opcje'),
(186, 'pl', 'no pages in database', 'Brak stron w bazie danych.'),
(187, 'pl', 'image', 'Zdjęcie'),
(188, 'pl', 'name', 'Nazwa'),
(191, 'pl', 'no banners in database', 'Brak banerów w bazie danych.'),
(198, 'pl', 'email', 'Email'),
(199, 'pl', 'group', 'Grupa'),
(200, 'pl', 'last visit', 'Ostatnia wizyta'),
(201, 'pl', 'status', 'Status'),
(202, 'pl', 'added', 'Dodano'),
(203, 'pl', 'never', 'nigdy'),
(204, 'pl', 'date', 'Data'),
(206, 'pl', 'ip address', 'Adres IP'),
(207, 'pl', 'no contact forms in database', 'Brak zapytan w bazie danych.'),
(208, 'pl', 'no users in database', 'Brak użytkowników w bazie danych.');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `logo`
--

CREATE TABLE IF NOT EXISTS `logo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `parent_id` int(11) NOT NULL,
  `modify_user_id` int(11) NOT NULL,
  `name` varchar(512) NOT NULL,
  `description` text NOT NULL,
  `add_date` datetime NOT NULL,
  `modify_date` datetime NOT NULL,
  `image_filename` varchar(128) NOT NULL,
  `url` varchar(512) NOT NULL,
  `publish` tinyint(1) NOT NULL,
  `pos` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `image_filename` (`image_filename`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=538 ;

--
-- Zrzut danych tabeli `logo`
--

INSERT INTO `logo` (`id`, `user_id`, `parent_id`, `modify_user_id`, `name`, `description`, `add_date`, `modify_date`, `image_filename`, `url`, `publish`, `pos`) VALUES
(10, 0, 0, 0, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 'image14.jpeg', '', 1, 0),
(11, 0, 0, 0, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 'image110.png', '', 1, 0),
(12, 0, 0, 0, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 'image48.png', '', 1, 0),
(13, 0, 0, 0, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 'image63.jpeg', '', 1, 0),
(14, 0, 0, 0, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 'image90.png', '', 1, 0),
(15, 0, 0, 0, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 'image104.jpeg', '', 1, 0),
(16, 0, 0, 0, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 'image68.png', '', 1, 0),
(17, 0, 0, 0, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 'image27.jpeg', '', 1, 0),
(18, 0, 0, 0, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 'image120.jpeg', '', 1, 0),
(19, 0, 0, 0, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 'image20.png', '', 1, 0),
(20, 0, 0, 0, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 'image108.jpeg', '', 1, 0),
(21, 0, 0, 0, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 'image53.jpeg', '', 1, 0),
(22, 0, 0, 0, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 'image44.jpeg', '', 1, 0),
(23, 0, 0, 0, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 'image141.jpeg', '', 1, 0),
(24, 0, 0, 0, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 'image16.png', '', 1, 0),
(25, 0, 0, 0, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 'image22.jpeg', '', 1, 0),
(26, 0, 0, 0, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 'image117.jpeg', '', 1, 0),
(27, 0, 0, 0, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 'image160.jpeg', '', 1, 0),
(28, 0, 0, 0, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 'image154.jpeg', '', 1, 0),
(29, 0, 0, 0, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 'image55.jpeg', '', 1, 0),
(30, 0, 0, 0, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 'image151.jpeg', '', 1, 0),
(31, 0, 0, 0, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 'image146.jpeg', '', 1, 0),
(32, 0, 0, 0, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 'image93.jpeg', '', 1, 0),
(33, 0, 0, 0, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 'image26.jpeg', '', 1, 0),
(34, 0, 0, 0, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 'image36.jpeg', '', 1, 0),
(35, 0, 0, 0, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 'image52.jpeg', '', 1, 0),
(36, 0, 0, 0, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 'image169.jpeg', '', 1, 0),
(37, 0, 0, 0, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 'image140.jpeg', '', 1, 0),
(38, 0, 0, 0, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 'image127.jpeg', '', 1, 0),
(39, 0, 0, 0, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 'image13.jpeg', '', 1, 0),
(40, 0, 0, 0, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 'image51.jpeg', '', 1, 0),
(41, 0, 0, 0, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 'image149.jpeg', '', 1, 0),
(42, 0, 0, 0, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 'image157.jpeg', '', 1, 0),
(43, 0, 0, 0, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 'image50.jpeg', '', 1, 0),
(44, 0, 0, 0, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 'image76.jpeg', '', 1, 0),
(45, 0, 0, 0, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 'image171.jpeg', '', 1, 0),
(46, 0, 0, 0, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 'image31.jpeg', '', 1, 0),
(47, 0, 0, 0, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 'image106.jpeg', '', 1, 0),
(48, 0, 0, 0, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 'image119.jpeg', '', 1, 0),
(50, 0, 0, 0, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 'image98.jpeg', '', 1, 0),
(51, 0, 0, 0, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 'image54.jpeg', '', 1, 0),
(52, 0, 0, 0, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 'image124.jpeg', '', 1, 0),
(53, 0, 0, 0, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 'image173.jpeg', '', 1, 0),
(54, 0, 0, 0, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 'image82.jpeg', '', 1, 0),
(55, 0, 0, 0, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 'image32.jpeg', '', 1, 0),
(56, 0, 0, 0, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 'image75.jpeg', '', 1, 0),
(57, 0, 0, 0, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 'image135.jpeg', '', 1, 0),
(58, 0, 0, 0, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 'image97.png', '', 1, 0),
(59, 0, 0, 0, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 'image79.jpeg', '', 1, 0),
(60, 0, 0, 0, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 'image37.png', '', 1, 0),
(61, 0, 0, 0, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 'image112.jpeg', '', 1, 0),
(62, 0, 0, 0, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 'image87.jpeg', '', 1, 0),
(63, 0, 0, 0, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 'image129.jpeg', '', 1, 0),
(64, 0, 0, 0, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 'image103.jpeg', '', 1, 0),
(65, 0, 0, 0, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 'image39.jpeg', '', 1, 0),
(66, 0, 0, 0, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 'image95.png', '', 1, 0),
(67, 0, 0, 0, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 'image61.jpeg', '', 1, 0),
(68, 0, 0, 0, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 'image46.png', '', 1, 0),
(69, 0, 0, 0, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 'image94.jpeg', '', 1, 0),
(70, 0, 0, 0, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 'image102.png', '', 1, 0),
(71, 0, 0, 0, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 'image69.jpeg', '', 1, 0),
(72, 0, 0, 0, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 'image33.jpeg', '', 1, 0),
(73, 0, 0, 0, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 'image144.jpeg', '', 1, 0),
(74, 0, 0, 0, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 'image70.png', '', 1, 0),
(75, 0, 0, 0, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 'image118.png', '', 1, 0),
(76, 0, 0, 0, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 'image111.jpeg', '', 1, 0),
(77, 0, 0, 0, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 'image38.png', '', 1, 0),
(79, 0, 0, 0, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 'image43.jpeg', '', 1, 0),
(80, 0, 0, 0, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 'image21.jpeg', '', 1, 0),
(81, 0, 0, 0, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 'image6.png', '', 1, 0),
(82, 0, 0, 0, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 'image164.jpeg', '', 1, 0),
(83, 0, 0, 0, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 'image18.png', '', 1, 0),
(84, 0, 0, 0, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 'image29.png', '', 1, 0),
(85, 0, 0, 0, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 'image131.jpeg', '', 1, 0),
(86, 0, 0, 0, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 'image136.png', '', 1, 0),
(87, 0, 0, 0, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 'image88.jpeg', '', 1, 0),
(88, 0, 0, 0, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 'image134.jpeg', '', 1, 0),
(89, 0, 0, 0, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 'image161.jpeg', '', 1, 0),
(90, 0, 0, 0, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 'image137.jpeg', '', 1, 0),
(91, 0, 0, 0, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 'image23.jpeg', '', 1, 0),
(92, 0, 0, 0, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 'image113.jpeg', '', 1, 0),
(93, 0, 0, 0, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 'image5.png', '', 1, 0),
(94, 0, 0, 0, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 'image142.jpeg', '', 1, 0),
(95, 0, 0, 0, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 'image168.jpeg', '', 1, 0),
(96, 0, 0, 0, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 'image162.png', '', 1, 0),
(97, 0, 0, 0, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 'image89.jpeg', '', 1, 0),
(98, 0, 0, 0, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 'image109.png', '', 1, 0),
(99, 0, 0, 0, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 'image1.jpeg', '', 1, 0),
(100, 0, 0, 0, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 'image41.png', '', 1, 0),
(101, 0, 0, 0, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 'image122.jpeg', '', 1, 0),
(102, 0, 0, 0, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 'image152.jpeg', '', 1, 0),
(103, 0, 0, 0, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 'image143.jpeg', '', 1, 0),
(104, 0, 0, 0, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 'image47.jpeg', '', 1, 0),
(105, 0, 0, 0, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 'image133.jpeg', '', 1, 0),
(106, 0, 0, 0, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 'image153.jpeg', '', 1, 0),
(107, 0, 0, 0, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 'image91.jpeg', '', 1, 0),
(108, 0, 0, 0, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 'image40.jpeg', '', 1, 0),
(109, 0, 0, 0, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 'image9.jpeg', '', 1, 0),
(110, 0, 0, 0, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 'image64.jpeg', '', 1, 0),
(111, 0, 0, 0, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 'image58.jpeg', '', 1, 0),
(112, 0, 0, 0, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 'image128.jpeg', '', 1, 0),
(113, 0, 0, 0, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 'image147.png', '', 1, 0),
(114, 0, 0, 0, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 'image138.png', '', 1, 0),
(115, 0, 0, 0, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 'image15.jpeg', '', 1, 0),
(116, 0, 0, 0, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 'image60.jpeg', '', 1, 0),
(117, 0, 0, 0, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 'image165.jpeg', '', 1, 0),
(118, 0, 0, 0, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 'image174.jpeg', '', 1, 0),
(120, 0, 0, 0, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 'image8.jpeg', '', 1, 0),
(121, 0, 0, 0, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 'image155.jpeg', '', 1, 0),
(122, 0, 0, 0, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 'image77.png', '', 1, 0),
(123, 0, 0, 0, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 'image130.jpeg', '', 1, 0),
(124, 0, 0, 0, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 'image115.jpeg', '', 1, 0),
(125, 0, 0, 0, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 'image156.jpeg', '', 1, 0),
(126, 0, 0, 0, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 'image96.jpeg', '', 1, 0),
(127, 0, 0, 0, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 'image25.jpeg', '', 1, 0),
(128, 0, 0, 0, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 'image3.jpeg', '', 1, 0),
(129, 0, 0, 0, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 'image59.jpeg', '', 1, 0),
(130, 0, 0, 0, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 'image80.jpeg', '', 1, 0),
(131, 0, 0, 0, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 'image172.jpeg', '', 1, 0),
(132, 0, 0, 0, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 'image56.png', '', 1, 0),
(133, 0, 0, 0, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 'image126.jpeg', '', 1, 0),
(134, 0, 0, 0, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 'image42.jpeg', '', 1, 0),
(135, 0, 0, 0, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 'image17.jpeg', '', 1, 0),
(136, 0, 0, 0, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 'image92.jpeg', '', 1, 0),
(137, 0, 0, 0, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 'image107.jpeg', '', 1, 0),
(138, 0, 0, 0, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 'image7.jpeg', '', 1, 0),
(139, 0, 0, 0, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 'image139.jpeg', '', 1, 0),
(140, 0, 0, 0, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 'image66.jpeg', '', 1, 0),
(141, 0, 0, 0, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 'image73.jpeg', '', 1, 0),
(142, 0, 0, 0, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 'image78.jpeg', '', 1, 0),
(143, 0, 0, 0, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 'image84.jpeg', '', 1, 0),
(144, 0, 0, 0, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 'image86.jpeg', '', 1, 0),
(145, 0, 0, 0, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 'image30.jpeg', '', 1, 0),
(146, 0, 0, 0, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 'image35.png', '', 1, 0),
(147, 0, 0, 0, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 'image123.jpeg', '', 1, 0),
(148, 0, 0, 0, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 'image10.jpeg', '', 1, 0),
(149, 0, 0, 0, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 'image125.jpeg', '', 1, 0),
(150, 0, 0, 0, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 'image2.png', '', 1, 0),
(151, 0, 0, 0, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 'image71.jpeg', '', 1, 0),
(152, 0, 0, 0, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 'image150.jpeg', '', 1, 0),
(153, 0, 0, 0, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 'image19.jpeg', '', 1, 0),
(154, 0, 0, 0, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 'image170.jpeg', '', 1, 0),
(155, 0, 0, 0, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 'image145.png', '', 1, 0),
(156, 0, 0, 0, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 'image34.jpeg', '', 1, 0),
(157, 0, 0, 0, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 'image83.jpeg', '', 1, 0),
(158, 0, 0, 0, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 'image158.png', '', 1, 0),
(159, 0, 0, 0, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 'image121.jpeg', '', 1, 0),
(160, 0, 0, 0, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 'image116.jpeg', '', 1, 0),
(161, 0, 0, 0, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 'image114.png', '', 1, 0),
(162, 0, 0, 0, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 'image45.jpeg', '', 1, 0),
(163, 0, 0, 0, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 'image11.jpeg', '', 1, 0),
(164, 0, 0, 0, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 'image85.png', '', 1, 0),
(165, 0, 0, 0, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 'image57.jpeg', '', 1, 0),
(166, 0, 0, 0, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 'image74.jpeg', '', 1, 0),
(167, 0, 0, 0, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 'image159.jpeg', '', 1, 0),
(168, 0, 0, 0, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 'image62.gif', '', 1, 0),
(169, 0, 0, 0, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 'image72.jpeg', '', 1, 0),
(171, 0, 0, 0, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 'image163.jpeg', '', 1, 0),
(172, 0, 0, 0, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 'image132.jpeg', '', 1, 0),
(173, 0, 0, 0, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 'image12.jpeg', '', 1, 0),
(174, 0, 0, 0, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 'image100.jpeg', '', 1, 0),
(175, 0, 0, 0, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 'image148.png', '', 1, 0),
(176, 0, 0, 0, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 'image49.jpeg', '', 1, 0),
(177, 0, 0, 0, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 'image24.jpeg', '', 1, 0),
(178, 0, 0, 0, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 'image28.png', '', 1, 0),
(179, 0, 0, 0, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 'image99.jpeg', '', 1, 0),
(180, 0, 0, 0, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 'image65.jpeg', '', 1, 0),
(181, 0, 0, 0, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 'image101.jpeg', '', 1, 0),
(182, 0, 0, 0, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 'image67.jpeg', '', 1, 0),
(183, 0, 0, 0, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 'image105.jpeg', '', 1, 0),
(184, 0, 0, 0, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 'image81.jpeg', '', 1, 0),
(185, 0, 0, 0, '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 'image4.jpeg', '', 1, 0);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `news`
--

CREATE TABLE IF NOT EXISTS `news` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `add_date` datetime NOT NULL,
  `language` varchar(2) NOT NULL DEFAULT 'pl',
  `group_id` int(11) NOT NULL,
  `title` varchar(512) NOT NULL,
  `lead` text NOT NULL,
  `text` longtext NOT NULL,
  `user_id` int(11) NOT NULL,
  `modify_date` datetime NOT NULL,
  `alias` varchar(256) NOT NULL,
  `meta_title` varchar(512) NOT NULL,
  `meta_keywords` tinytext NOT NULL,
  `meta_description` tinytext NOT NULL,
  `image_filename` varchar(128) NOT NULL,
  `views_total` int(11) NOT NULL,
  `publish` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `news_copy`
--

CREATE TABLE IF NOT EXISTS `news_copy` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `news_id` int(11) NOT NULL,
  `add_date` datetime NOT NULL,
  `language` varchar(2) NOT NULL DEFAULT 'pl',
  `title` varchar(512) NOT NULL,
  `lead` text NOT NULL,
  `text` longtext NOT NULL,
  `alias` varchar(256) NOT NULL,
  `meta_title` varchar(512) NOT NULL,
  `meta_keywords` tinytext NOT NULL,
  `meta_description` tinytext NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `page`
--

CREATE TABLE IF NOT EXISTS `page` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `add_date` datetime NOT NULL,
  `language` varchar(2) NOT NULL DEFAULT 'pl',
  `group_id` int(11) NOT NULL,
  `type` varchar(32) NOT NULL,
  `title` varchar(512) NOT NULL,
  `lead` text NOT NULL,
  `text` longtext NOT NULL,
  `user_id` int(11) NOT NULL,
  `modify_date` datetime NOT NULL,
  `parent_id` int(11) NOT NULL,
  `page_type` tinyint(1) NOT NULL,
  `target` tinyint(1) NOT NULL,
  `url` varchar(512) NOT NULL,
  `path` varchar(256) NOT NULL,
  `alias` varchar(256) NOT NULL,
  `meta_title` varchar(512) NOT NULL,
  `meta_keywords` tinytext NOT NULL,
  `meta_description` tinytext NOT NULL,
  `views_total` int(11) NOT NULL,
  `publish` tinyint(1) NOT NULL,
  `pos` int(11) NOT NULL,
  `homepage` tinyint(1) unsigned NOT NULL,
  `hide_in_menu` tinyint(1) NOT NULL,
  `menu_title` varchar(512) NOT NULL,
  `system_key` varchar(64) NOT NULL,
  `access` tinyint(1) NOT NULL,
  `image_filename` varchar(128) NOT NULL,
  `listing` tinyint(1) NOT NULL,
  `fullwidth` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `type` (`type`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=6 ;

--
-- Zrzut danych tabeli `page`
--

INSERT INTO `page` (`id`, `add_date`, `language`, `group_id`, `type`, `title`, `lead`, `text`, `user_id`, `modify_date`, `parent_id`, `page_type`, `target`, `url`, `path`, `alias`, `meta_title`, `meta_keywords`, `meta_description`, `views_total`, `publish`, `pos`, `homepage`, `hide_in_menu`, `menu_title`, `system_key`, `access`, `image_filename`, `listing`, `fullwidth`) VALUES
(1, '2015-06-28 18:29:54', 'pl', 0, '', 'STRONA GŁÓWNA', '', '', 0, '2016-01-26 08:46:58', 0, 0, 0, '', '', 'strona-glowna', 'Badania telefoniczne', 'studio CATI, badania telefoniczne, badania CATI, CATI, wywiady telefoniczne', 'Dysponujemy własnym nowoczesnym, klimatyzowanym studiem do realizacji badań CATI, mieszczącym się w siedzibie firmy, co umożliwia koordynatorowi CATI i kierownikom projektów możliwość osobistej kontroli jakości prowadzonych wywiadów.', 836, 1, 0, 1, 0, '', 'home', 0, '', 0, 0),
(2, '2016-01-25 13:46:53', 'pl', 0, '', 'Wywiady telefoniczne', '', '<p style="font-size: 23px; margin-top: 20px; text-align: justify;">Realizujemy 40&nbsp;000 efektywnych wywiad&oacute;w rocznie, w tym na numerach telefon&oacute;w stacjonarnych i&nbsp;kom&oacute;rkowych.</p>\n\n<p style="text-align: justify;">&nbsp;</p>\n\n<p style="font-weight: 100; text-align: justify;margin-bottom: 40px;">Tylko w 2015 roku nasze studio CATI realizowało badania z dziedzin: edukacji, wizerunku marki, rynku produkt&oacute;w i usług, satysfakcji klient&oacute;w, model&oacute;w zarządzania, rynku pracy i problem&oacute;w społecznych. Nieustannie pytamy o zdanie przedsiębiorc&oacute;w, internaut&oacute;w, menedżer&oacute;w, senior&oacute;w, mieszkańc&oacute;w aglomeracji i wsi, student&oacute;w, gospodynie domowe, społecznik&oacute;w, wyborc&oacute;w, farmaceut&oacute;w, geodet&oacute;w, dyrektor&oacute;w szk&oacute;ł i przedstawicieli wielu innych grup. R&oacute;żnorodność prowadzonych badań wymusza specjalizację, dlatego zatrudniamy ankieter&oacute;w wyspecjalizowanych w konkretnych dziedzinach i w rozmowach z wybranymi grupami respondent&oacute;w.</p>\n', 0, '2016-01-25 14:11:43', 0, 0, 0, '', '', 'wywiady-telefoniczne', 'Wywiady telefoniczne', 'wywiady telefoniczne, badania telefoniczne, cati, cawi, capi, system badawczy, CATI System, CATI-System, catisystem,', 'Realizujemy 40 000 efektywnych wywiadów rocznie, w tym na numerach telefonów stacjonarnych i komórkowych. ', 20, 1, 0, 0, 0, '', '', 0, '', 0, 0),
(3, '2016-01-25 14:00:35', 'pl', 0, '', 'Dostęp do wyników', '', '<p style="font-size: 23px; margin-top: 20px; text-align: justify;"><img align="right" src="/assets/img/statystyki2.png" style="margin: -40px -8px 0px 30px;" /> Aplikacja nadzorująca przebieg badania na bieżąco śledzi postępy.</p>\n\n<p>&nbsp;</p>\n\n<p style="font-weight:100;text-align:justify">Stały dostęp do gromadzonych danych posiadają menedżerowie projekt&oacute;w i&nbsp;koordynatorzy badań telefonicznych, kt&oacute;rzy mogą reagować na bieżąco. W&nbsp;każdej chwili możliwe jest przekazanie Zamawiającemu kompletnych informacji dotyczących przede wszystkim:</p>\n\n<ul class="ul" style="font-weight:100">\n	<li>liczby zrealizowanych wywiad&oacute;w,</li>\n	<li>liczby pracujących&nbsp; w danej chwili ankieter&oacute;w,</li>\n	<li>liczby godzin pracy,</li>\n	<li>średniej liczby ankiet realizowanych w ciągu godziny, w ciągu dnia i poszczeg&oacute;lnych dni,</li>\n	<li>aktualnego rozkładu odpowiedzi na dowolne pytanie z kwestionariusza,</li>\n	<li>aktualnego wyniku krzyżowania wybranych zmiennych.</li>\n</ul>\n<style type="text/css">.ul li{padding-left:30px}\n</style>\n', 0, '2016-01-25 14:12:47', 0, 0, 0, '', '', 'dostep-do-wynikow', 'Dostęp do wyników', 'badania telefoniczne, wywiady telefoniczne, CATI, CAWI, CAPI, aplikacje dedykowane, oprogramowanie dedykowane', 'Aplikacja nadzorująca przebieg badania telefonicznego na bieżąco śledzi postępy.', 32, 1, 0, 0, 0, '', '', 0, '', 0, 0),
(4, '2016-01-25 14:09:19', 'pl', 0, '', 'Innowacyjne oprogramowanie', '', '<div class="col-md-6 col-xs-12">\n<div class="oprogramowanie-img"><img src="/assets/img/i-cati.png" /></div>\n\n<div class="oprogramowanie-content">Badania powinny być łatwe. Nasi ankieterzy pracują na oprogramowaniu opracowanym przez naszych ekspert&oacute;w, z myślą o kompleksowej realizacji badań statystycznych. CATI-System wyposażyliśmy w kreator pytań, walidator wprowadzanych danych, moduł podpowiedzi, mechanizm testowania logiki ankiety, walidator analizy pr&oacute;by, moduł bieżących statystyk, generator wykres&oacute;w. <a class="btn-custom2" href="http://www.cati-system.pl" target="_blank">DOWIEDZ SIĘ WIĘCEJ</a></div>\n</div>\n\n<div class="col-md-6 col-xs-12">\n<div class="oprogramowanie-img"><img src="/assets/img/i-ecrf.png" /></div>\n\n<div class="oprogramowanie-content">Platforma to w pełni funkcjonalny system (Clinical Data Management System) do prowadzenia badań klinicznych, obserwacyjnych, PMS i rejestr&oacute;w w trybie ankiety online. eCRF.biz&trade; jest obecnie najbardziej zaawansowanym w tym obszarze rozwiązaniem na rynku polskim. <a class="btn-custom2" href="http://www.ecrf.biz.pl" target="_blank">DOWIEDZ SIĘ WIĘCEJ</a></div>\n</div>\n', 0, '2016-01-25 14:14:27', 0, 0, 0, '', '', 'innowacyjne-oprogramowanie', 'Innnowacyjne oprogramowanie', 'oprogramowanie badawcze, wywiady telefoniczne, badania telefoniczne, CATI, CAWI, CAPI, CATI-System, eCRF.biz, ecrf, Omnibus CATI, badania omnibus', 'Badania powinny być łatwe. Nasi ankieterzy pracują na oprogramowaniu opracowanym przez naszych ekspertów, z myślą o kompleksowej realizacji badań statystycznych.', 18, 1, 0, 0, 0, '', '', 0, '', 0, 0),
(5, '2016-01-26 11:52:43', 'pl', 0, '', 'Kontakt', '', '<div style="margin-top:40px">&nbsp;</div>\n\n<div class="col-md-4 col-contact">BioStat<br />\nTel: (+48) 22 12 28 025<br />\nTel. kom.: (+48) 668 300 664<br />\nE-mail: biuro@biostat.com.pl</div>\n\n<div class="col-md-4 col-contact">Biuro w Rybniku:<br />\nBioStat<br />\nul. Kowalczyka 17<br />\n44-206 Rybnik</div>\n\n<div class="col-md-4 col-contact"><br />\nTel: (+48) 32 42 21 707<br />\nFax: (+48) 32 44 08 564<br />\n&nbsp;</div>\n\n<div class="ask" id="ask" style="padding-top:40px;clear:both">\n<div class="wrapper">\n<h1>ZAPYTAJ NAS O...</h1>\n<!-- <div class="bar"></div> -->\n\n<div aria-multiselectable="true" class="panel-group" id="accordion" role="tablist">\n<div class="panel panel-default">\n<div class="panel-heading ask-panel-heading1" id="headingOne" role="tab">\n<h4 class="panel-title"><a aria-controls="collapseOne" aria-expanded="true" data-parent="#accordion" data-toggle="collapse" href="#collapseOne" role="button">SONDAŻ </a></h4>\n</div>\n\n<div aria-labelledby="headingOne" class="panel-collapse collapse" id="collapseOne" role="tabpanel">\n<div class="panel-body">\n<div class="col-md-6 photo"><img alt="Bartosz Olcha" src="/assets/img/bolcha.png" /></div>\n\n<div class="col-md-6 descr">\n<div class="names">BARTOSZ OLCHA</div>\n\n<div class="title">Project Manager</div>\n\n<div class="details"><strong>tel:</strong> 666-069-831<br />\n<strong>mail:</strong> <a href="mailto:bolcha@biostat.com.pl">bolcha@biostat.com.pl</a></div>\n</div>\n</div>\n</div>\n</div>\n\n<div class="panel panel-default">\n<div class="panel-heading ask-panel-heading2" id="headingTwo" role="tab">\n<h4 class="panel-title"><a aria-controls="collapseTwo" aria-expanded="false" class="collapsed" data-parent="#accordion" data-toggle="collapse" href="#collapseTwo" role="button">BADANIE OMNIBUSOWE </a></h4>\n</div>\n\n<div aria-labelledby="headingTwo" class="panel-collapse collapse" id="collapseTwo" role="tabpanel">\n<div class="panel-body">\n<div class="col-md-6 photo"><img alt="dr Monika Kurpanik" src="/assets/img/mkurpanik.png" /></div>\n\n<div class="col-md-6 descr">\n<div class="names">DR MONIKA KURPANIK</div>\n\n<div class="title">Project Manager</div>\n\n<div class="details"><strong>tel:</strong> 666-068-671<br />\n<strong>mail:</strong> <a href="mailto:badania@biostat.com.pl">badania@biostat.com.pl</a></div>\n</div>\n</div>\n</div>\n</div>\n\n<div class="panel panel-default">\n<div class="panel-heading ask-panel-heading3" id="headingThree" role="tab">\n<h4 class="panel-title"><a aria-controls="collapseThree" aria-expanded="false" class="collapsed" data-parent="#accordion" data-toggle="collapse" href="#collapseThree" role="button">BADANIE MARKETINGOWE </a></h4>\n</div>\n\n<div aria-labelledby="headingThree" class="panel-collapse collapse" id="collapseThree" role="tabpanel">\n<div class="panel-body">\n<div class="col-md-6 photo"><img alt="Jakub Galeja" src="/assets/img/jgaleja.png" /></div>\n\n<div class="col-md-6 descr">\n<div class="names">JAKUB GALEJA</div>\n\n<div class="title">Project Manager działu Market Research</div>\n\n<div class="details"><strong>tel:</strong> 668-660-390<br />\n<strong>mail:</strong> <a href="mailto:bsp@biostat.com.pl">bsp@biostat.com.pl</a></div>\n</div>\n</div>\n</div>\n</div>\n\n<div class="panel panel-default">\n<div class="panel-heading ask-panel-heading4 " id="headingThree" role="tab">\n<h4 class="panel-title"><a aria-controls="collapseThree" aria-expanded="false" class="collapsed" data-parent="#accordion" data-toggle="collapse" href="#collapseFour" role="button">MYSTERY CALLING </a></h4>\n</div>\n\n<div aria-labelledby="headingThree" class="panel-collapse collapse" id="collapseFour" role="tabpanel">\n<div class="panel-body">\n<div class="col-md-6 photo"><img alt="dr Monika Kurpanik" src="/assets/img/mkurpanik.png" /></div>\n\n<div class="col-md-6 descr">\n<div class="names">DR MONIKA KURPANIK</div>\n\n<div class="title">Project Manager</div>\n\n<div class="details"><strong>tel:</strong> 666-068-671<br />\n<strong>mail:</strong> <a href="mailto:badania@biostat.com.pl">badania@biostat.com.pl</a></div>\n</div>\n</div>\n</div>\n</div>\n\n<div class="panel panel-default">\n<div class="panel-heading ask-panel-heading5" id="headingThree" role="tab">\n<h4 class="panel-title"><a aria-controls="collapseThree" aria-expanded="false" class="collapsed" data-parent="#accordion" data-toggle="collapse" href="#collapseFive" role="button">EWALUACJĘ </a></h4>\n</div>\n\n<div aria-labelledby="headingThree" class="panel-collapse collapse" id="collapseFive" role="tabpanel">\n<div class="panel-body">\n<div class="col-md-6 photo"><img alt="dr Monika Kurpanik" src="/assets/img/mkurpanik.png" /></div>\n\n<div class="col-md-6 descr">\n<div class="names">DR MONIKA KURPANIK</div>\n\n<div class="title">Project Manager</div>\n\n<div class="details"><strong>tel:</strong> 666-068-671<br />\n<strong>mail:</strong> <a href="mailto:badania@biostat.com.pl">badania@biostat.com.pl</a></div>\n</div>\n</div>\n</div>\n</div>\n\n<div class="panel panel-default">\n<div class="panel-heading ask-panel-heading6" id="headingThree" role="tab">\n<h4 class="panel-title"><a aria-controls="collapseThree" aria-expanded="false" class="collapsed" data-parent="#accordion" data-toggle="collapse" href="#collapseSix" role="button">BADANIA SPOŁECZNE </a></h4>\n</div>\n\n<div aria-labelledby="headingSix" class="panel-collapse collapse" id="collapseSix" role="tabpanel">\n<div class="panel-body">\n<div class="col-md-6 photo"><img alt="Bartosz Olcha" src="/assets/img/bolcha.png" /></div>\n\n<div class="col-md-6 descr">\n<div class="names">BARTOSZ OLCHA</div>\n\n<div class="title">Project Manager</div>\n\n<div class="details"><strong>tel:</strong> 666-069-831<br />\n<strong>mail:</strong> <a href="mailto:bolcha@biostat.com.pl">bolcha@biostat.com.pl</a></div>\n</div>\n</div>\n</div>\n</div>\n</div>\n</div>\n</div>\n', 0, '2016-01-26 12:02:08', 0, 0, 0, '', '', 'kontakt', 'Kontakt', 'badania telefoniczne, wywiady telefoniczne, studio CATI, CATI, CATI System, ', 'Dysponujemy własnym nowoczesnym, klimatyzowanym studiem do realizacji badań CATI, mieszczącym się w siedzibie firmy, co umożliwia koordynatorowi CATI i kierownikom projektów możliwość osobistej kontroli jakości prowadzonych wywiadów.', 16, 1, 0, 0, 0, '', '', 0, '', 0, 0);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `page_data`
--

CREATE TABLE IF NOT EXISTS `page_data` (
  `key` varchar(128) NOT NULL,
  `lang` varchar(2) NOT NULL,
  `value` longtext NOT NULL,
  `type` enum('text','html','json','image') NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Zrzut danych tabeli `page_data`
--

INSERT INTO `page_data` (`key`, `lang`, `value`, `type`) VALUES
('home_slide_1', 'pl', '', 'text'),
('home_slide_3', 'pl', '', 'text'),
('home_slide_2', 'pl', '', 'text'),
('home_about_before', 'pl', '<p>Jesteśmy dynamicznie rozwijająca się firma doradczą i badawczą. Tworzenie indywidualnych rozwiązań jest naszą pasją , kt&oacute;rą staramy się zarażad osoby wsp&oacute;łpracujące z nami. Każdemu Klientowi zapewniamy zaangażowanie w powierzone zadania, poufnośd oraz gwarancję sprostania wymaganiom. Nasz Zesp&oacute;ł ustawicznie pogłębia swoją wiedzę i zdobywa nowe doświadczenia. Największym sukcesem jest zadowolony Klient. Każdy projekt jest ciekawym wyzwaniem, kt&oacute;re mobilizuje nas do szukania indywidualnych rozwiązao, zapewniających sprostanie potrzebom i możliwościom naszych Klient&oacute;w. Zapraszamy do wsp&oacute;łpracy.</p>\n', 'text'),
('home_about_after', 'pl', '<p>Szczeg&oacute;lną uwagę przywiązujemy do jakości naszych usług. Wypracowane procedury wewnętrzne gwarantują uzyskanie rzetelnego materiału. Dbamy o zachowanie tajemnicy handlowej i wzorce etyki biznesu. Nasze bogate doświadczenie zaowocowało zrealizowanymi projektami zar&oacute;wno dla firm komercyjnych jak i sektora publicznego. Posiadamy własna siatkę moderator&oacute;w, audytor&oacute;w i ankieter&oacute;w oraz wsp&oacute;łpracujemy z koordynatorami terenowymi na obszarze całego kraju, przez co większośd realizowanych projekt&oacute;w ma zasięg og&oacute;lnopolski.</p>\n', 'text'),
('home_doradztwo_before', 'pl', '<p>Oferujemy wsparcie i pomoc doświadczonych os&oacute;b, dla kt&oacute;rych każde nowe zlecenie jest ciekawym wyzwaniem, pozwalającym realizować się zawodowo i tworzyć nowatorskie rozwiązania. Połączenie kreatywności, wiedzy biznesowej i marketingowej ułatwia nam opracowanie projekt&oacute;w łączących r&oacute;żne dziedziny biznesu.</p>\n', 'text'),
('home_doradztwo_after', 'pl', '<p>1. Doradztwo bussinesowe<br />\n- pomoc w poszukiwaniu partner&oacute;w strategicznych<br />\n- optymalizacja koszt&oacute;w<br />\n- opracowanie wniosk&oacute;w kredytowych i leasingowych<br />\n- opracowanie dokumentacji do dotacji unijnych<br />\n<br />\n2. Doradztwo w organizacji firmy<br />\n- określenie schemat&oacute;w organizacyjnych<br />\n- tworzenie procedur<br />\n- optymalizacja proces&oacute;w<br />\n- pomoc przy inwentaryzacjach<br />\n<br />\n3. Controlling- zarządzanie poprzez informację<br />\n- budżetowanie i analiza realizacji założeń<br />\n- projektowanie i doradztwo w doborze rozwiązań informatycznych<br />\n<br />\n4. Marketing i Copywriting<br />\n- tworzenie tekst&oacute;w reklamowych: do stron internetowych, ulotek, materiał&oacute;w promocyjnych oraz do prezentacji firm, tworzenie skutecznych haseł reklamowych<br />\n- kompleksowa obsługa kampanii reklamowych</p>\n', 'text'),
('home_badaniaspoleczne_before', 'pl', '<h1>BADANIA SPOŁECZNE</h1>\n\n<p>Pomagają lepiej poznać i zrozumieć społeczeństwo, jego poglądy, wartości, przekonania czy oczekiwania. Wiedza taka pozwala na skuteczną diagnozę preferencji i nastroj&oacute;w społecznych a także pomoże w określeniu przyszłych trend&oacute;w.</p>\n', 'text'),
('home_badaniaspoleczne_after', 'pl', '<h1>BADANIA SPOŁECZNE</h1>\n\n<p>W celu uzyskania właściwego, rzetelnego i obiektywnego materiału badawczego wykorzystujemy następujące metody i techniki badawcze:</p>\n\n<p>1. Metody ilościowe:<br />\n- wywiady kwestionariuszowe (PAPI)&nbsp;<br />\n- wywiady bezpośrednie z wykorzystaniem komputera (CAPI)<br />\n- wywiady telefoniczne wspomagane komputerowo (CATI)<br />\n- sondaże wspomagane komputerowo (CAWI)</p>\n\n<p>2. Metody jakościowe :<br />\n- pogłębione wywiady indywidualne (IDI)&nbsp;<br />\n- pogłębione wywiady telefoniczne (TDI)&nbsp;<br />\n- obserwacje&nbsp;<br />\n- wywiady swobodne&nbsp;<br />\n- wywiady grupowe (FGI)&nbsp;</p>\n\n<p>Pomożemy opracować metodologię badania, właściwie zaprojektować proces badawczy, przeprowadzimy badanie terenowe oraz opracujemy wyniki wraz z graficzną prezentacją danych.</p>\n', 'text'),
('home_badaniamarketingowe_before', 'pl', '<h1>BADANIA MARKETINGOWE</h1>\n\n<p>Pomagają w doskonaleniu i usprawnieniu proces&oacute;w planowania sprzedaży i promocji, pozwalająca na rozpoznanie problem&oacute;w i błęd&oacute;w, kt&oacute;re należy zniwelować dla zadowolenia klienta. Dane uzyskane w trakcie badania związane zar&oacute;wno z popytem, jak i trendami rynkowymi są wsparciem do podejmowania kluczowych decyzji strategii sprzedaży, rozpoznawalności własnej marki oraz satysfakcji kontrahent&oacute;w.</p>\n', 'text'),
('home_badaniamarketingowe_after', 'pl', '<h1>BADANIA MARKETINGOWE</h1>\n\n<p>Zależnie od potrzeb, celu badania marketingowego oraz od przeznaczonych środk&oacute;w zaprojektujemy i wykonamy kompleksowo określone badanie.</p>\n\n<p>- Audyty Tajemniczego Klienta<br />\n- Badania satysfakcji klient&oacute;w<br />\n- Badania rynku i konkurencji<br />\n- Badania rozpoznawalności marki</p>\n\n<p>Posiadamy og&oacute;lnopolską siatkę doświadczonych audytor&oacute;w chętnych do przeprowadzenia proces&oacute;w badawczych zar&oacute;wno sondażowych, jak i wywiad&oacute;w indywidualnych oraz grupowych. Nasi teleankieterzy skutecznie uzyskują informacje w trakcie rozm&oacute;w telefonicznych, dbając o jakość wraz z zachowaniem wysokiej kultury osobistej.</p>\n', 'text'),
('home_badaniahr_before', 'pl', '<h1>BADANIA HR</h1>\n\n<p>Pomagają poznać relacje międzyludzkie, postrzeganie wizji i misji przedsiębiorstwa, poziomu spełnienia zawodowego oraz monitorują efektywność pracy. Kapitał ludzki to największa wartość każdego przedsiębiorstwa i od zadowolenia pracownik&oacute;w w ogromnej mierze zależy sukces firmy, dlatego bardzo istotna jest diagnoza potrzeb i nastroj&oacute;w w środowisku pracy.</p>\n', 'text'),
('home_badaniahr_after', 'pl', '<h1>BADANIA HR</h1>\n\n<p>Najskuteczniejszym sposobem na właściwą diagnozę jest przeprowadzenie profesjonalnego badania, odpowiednio zaprojektowanego pod kątem potrzeb:</p>\n\n<p>- Badania opinii pracownik&oacute;w<br />\n- Badania kompetencji pracownik&oacute;w<br />\n- Okresowa ocena pracownik&oacute;w<br />\n- Badanie potrzeb szkoleniowych</p>\n\n<p>Jesteśmy przekonani, że unikalne podejście do każdego klienta i procesu badawczego daje nieszablonowe, wymierne efekty . Zadbamy o opracowanie trafnej metodologii badania oraz pełną anonimowość pracownik&oacute;w uczestniczących w procesie badawczym. Finalnie nasz Zesp&oacute;ł opracuje wnikliwą analizę uzyskanych wynik&oacute;w w formie raportu oraz prezentacji multimedialnej.</p>\n', 'text'),
('home_wspolpraca', 'pl', '<h1>WSP&Oacute;ŁPRACA</h1>\n\n<p>Daje gotowe rozwiązanie na koordynację i rzetelne przeprowadzenie procesu badań terenowych na obszarze całego kraju. Dzięki doświadczonym audytorom, moderatorom i ankieterom zapewniamy realizacje badań społecznych, marketingowych oraz HR. Szczeg&oacute;lny nacisk kładziemy na szkolenie i kontrolę pracy ankieter&oacute;w, co gwarantuje uzyskanie właściwego materiału badawczego.</p>\n', 'text'),
('home_contact', 'pl', '<p>e-mail: darek@dsdron.pl<br />\ntel: 506352545</p>\n', 'text'),
('home_about', 'pl', '<h3>INFORMACJE O FIRMIE</h3>\n\n<p>Firma powstała w 2015 roku w odpowiedzi na rosnące zapotrzebowanie na usługi w obszarze filmowania z powietrza. Gwarancją satysfakcji moich klient&oacute;w jest profesjonalny sprzęt, rejestrujący z rozdzielczością FullHD oraz 4K oraz świadectwo kwalifikacji personelu lotniczego UAVO, potwierdzające umiejętności do wykonywania zadań z zachowaniem wszelkich zasad bezpieczeństwa.</p>\n', 'text'),
('home_offer', 'pl', '<p>Działalność firmy DS DRON cechuje się wysokim poziomem elastyczności, w przypadku niestandardowych zleceń proszę o kontakt.</p>\n\n<ul>\n	<li>Rejestracja foto/video obiekt&oacute;w oraz wydarzeń z powietrza w jakości FullHD lub 4K,</li>\n	<li>możliwość zrealizowania zar&oacute;wno surowego materiału, jak i montażu oraz obr&oacute;bki,</li>\n	<li>możliwość transmisji na żywo w jakości FullHD przez serwis Youtube,</li>\n	<li>nagrania pamiątkowe, np. wesela, rocznice, imprezy,</li>\n	<li>materiały promocyjne obiekt&oacute;w, miast, osiedli,</li>\n	<li>wsp&oacute;łpraca z firmami zajmującymi się tradycyjnym filmowaniem,</li>\n	<li>wsp&oacute;łpraca z agencjami reklamowymi oraz promocyjnymi,</li>\n	<li>indywidualna wycena.</li>\n</ul>\n', 'text'),
('circle1', 'pl', '<p>Ostatnio zbadaliśmy m.in.</p>\n\n<p>Uwarunkowania wdrażania &nbsp;w przedsiębiorstwach narzędzi pomiaru kapitału ludzkiego &ndash; dla Polskiej Agencji Rozwoju Przedsiębiorczości</p>\n\n<p>Ofertę i możliwość odbywania praktyk i staży u dolnośląskich pracodawc&oacute;w &ndash; dla Dolnośląskiego Wojew&oacute;dzkiego Urzędu Pracy w Wałbrzychu</p>\n', 'text'),
('circle2', 'pl', '<p>Ostatnio zbadaliśmy m.in.</p>\n\n<p>Marketingowe koncepcje reklamowe &ndash; dla Biofarm Sp. z o.o.</p>\n\n<p>Ruch turystyczny na Dolnym Śląsku &ndash; dla Wojew&oacute;dztwa Dolnośląskiego</p>\n', 'text'),
('circle3', 'pl', '<p>Ostatnio zbadaliśmy m.in.</p>\n\n<p>Uwarunkowania sytuacji zawodowej absolwent&oacute;w i uczni&oacute;w zasadniczych szk&oacute;ł zawodowych w Wielkopolsce &ndash; dla Wojew&oacute;dzkiego Urzędu Pracy w Poznaniu</p>\n\n<p>Systemowy Program &bdquo;Edukacja dla Doliny Baryczy&rdquo; &ndash; dla Stowarzyszenia Partnerstwo dla Doliny Baryczy</p>\n', 'text'),
('circle4', 'pl', '<p>Ostatnio zbadaliśmy m.in.</p>\n\n<p>Wizerunek wojew&oacute;dztwa kujawsko-pomorskiego &ndash; dla Wojew&oacute;dztwa Kujawsko-Pomorskiego</p>\n\n<p>Strategie społecznej odpowiedzialności w wojew&oacute;dztwie opolskim &ndash; dla Wojew&oacute;dztwa Opolskiego</p>\n', 'text'),
('circle5', 'pl', '<p>Realizujemy telefoniczne sondaże opinii oraz sondaże polityczne (sondaże przedwyborcze) zar&oacute;wno og&oacute;lnopolskie, jak i lokalne. Pr&oacute;ba pozyskana z populacji jest najczęściej: losowa, kwotowo-losowa lub kwotowa. W zależności od metody losowania jednostek do pr&oacute;by oraz jej liczebności możliwe jest określenie błędu statystycznego.</p>\n', 'text'),
('circle6', 'pl', '<p>Ostatnio zbadaliśmy m.in.</p>\n\n<p>Efekty wsparcia działania 4.5.2. Zapobieganie zagrożeniom realizowanego w ramach IV osi priorytetowej infrastruktura ochrony środowiska Regionalnego Programu Operacyjnego Wojew&oacute;dztwa Zachodniopomorskiego na lata 2007-2013 &ndash; dla Wojew&oacute;dztwa Zachodniopomorskiego</p>\n\n<p>Coaching i tutoring jako elementy nowoczesnej pracy dydaktycznej &ndash; dla Wojew&oacute;dztwa Kujawsko-Pomorskiego</p>\n', 'text'),
('circle7', 'pl', '<p>Ostatnio zbadaliśmy m.in.</p>\n\n<p>Rozpoznawalność marek w kategorii produkt&oacute;w do pieczenia, przechowywania i sprzątania &ndash; dla POLITAN Sp. z o.o.</p>\n\n<p>Innowacyjny projekt testujący możliwość zatrudnienia bezrobotnych kobiet &ndash; dla Miejskiego Urzędu Pracy w Kielcach</p>\n', 'text'),
('circle8', 'pl', '<p>Ostatnio zbadaliśmy m.in.</p>\n\n<p>Potrzeby senior&oacute;w zamieszkały na obszarze Rzeszowskiego Obszaru Funkcjonalnego &ndash; dla Miasta Rzeszowa</p>\n\n<p>Uczestnictwo os&oacute;b w wieku 50+ w życiu społeczno-gospodarczym wojew&oacute;dztwa opolskiego &ndash; dla Wojew&oacute;dzkiego Urzędu Pracy w Opolu</p>\n', 'text'),
('acircle1', 'pl', '<p>Preferencje konsument&oacute;w to obszar często analizowany w badaniach telefonicznych. Najczęściej ustalamy preferencje w zakresie: opakowań do żywności, obsługi, ceny, oferty gastronomicznej, wystroju, program&oacute;w lojalnościowych, sposob&oacute;w pozyskiwania informacji, czy promocji. Z naszych usług korzystali m.in. przedstawiciele branży finansowej, liderzy sektora motoryzacji, media, czy właściciele park&oacute;w rekreacyjno-rozrywkowych. &nbsp;&nbsp;</p>\n', 'text'),
('acircle2', 'pl', '<p>Telefoniczne badania wizerunkowe to nasza specjalność. Na takie badanie prowadzone przez firmę Biostat zdecydowali się między innymi: Ł&oacute;dź, Radom, Poznań i Płock, wojew&oacute;dztwo kujawsko-pomorskie, Centrum Handlowe Plejada, czy marki zrzeszone w Konsorcjum Marki Poznań.</p>\n', 'text'),
('acircle3', 'pl', '<p>Od lat analizujemy sytuację na rynku pracy na zlecenie Wojew&oacute;dzkich i Powiatowych Urzęd&oacute;w Pracy, uczelni wyższych i firm komercyjnych. Zaufało nam już blisko 200 instytucji rynku pracy. Wśr&oacute;d naszych klient&oacute;w znajdują się m.in. Wojew&oacute;dzkie Urzędu Pracy w Poznaniu, Łodzi, Wałbrzychu, Opolu, Gdańsku i Szczecinie, Gł&oacute;wny Urząd Geodezji i Kartografii oraz PZU S.A.</p>\n', 'text'),
('acircle4', 'pl', '<p>Zwyczaje zakupowe badamy w odniesieniu do decyzji podejmowanych w tradycyjnych sklepach, ale r&oacute;wnie często pytamy internaut&oacute;w. W ramach badań telefonicznych docieramy do &bdquo;łowc&oacute;w okazji&rdquo;, odbiorc&oacute;w d&oacute;br konsumpcyjnych, a nawet tak trudnych respondent&oacute;w jak biorcy kredyt&oacute;w i pożyczek. &nbsp;&nbsp;</p>\n', 'text'),
('acircle5', 'pl', '<p>Na podstawie baz danych teleadresowych przekazanych przez Zleceniodawcę jesteśmy w stanie dotrzeć do kontrahent&oacute;w i klient&oacute;w, kt&oacute;rzy w ściśle określonym czasie dokonali zakupu lub skorzystali z oferowanej usługi. W ramach badań telefonicznych docieraliśmy m.in. do inwestor&oacute;w zagranicznych, uczestnik&oacute;w szkoleń, os&oacute;b korzystających z odnowy biologicznej, a nawet klient&oacute;w sieci wodociągowych.</p>\n', 'text'),
('acircle6', 'pl', '<p>Telefoniczne badania wykorzystywanych sposob&oacute;w zarządzania w przedsiębiorstwach należą do najtrudniejszych projekt&oacute;w ze względu na specjalistyczną terminologię i konieczność dotarcia do menedżer&oacute;w wysokiego szczebla. Wśr&oacute;d naszych klient&oacute;w w tym zakresie znajdują się wiodące instytucje wsparcia biznesu (m.in. Polska Agencja Rozwoju Przedsiębiorczości) oraz największe polskie uczelnie publiczne.</p>\n', 'text'),
('acircle7', 'pl', '<p>Zrealizowaliśmy kilkanaście, gł&oacute;wnie lokalnych sondaży, na zlecenie formacji politycznych i medi&oacute;w. Niekt&oacute;re łączyliśmy z jakościowymi testami projekt&oacute;w kampanii wyborczych. Nasi badacze analizowali zależność preferencji politycznych od szeregu zmiennych społeczno-demograficznych charakteryzujących potencjalnych wyborc&oacute;w.</p>\n', 'text'),
('home', 'pl', '<p>Dysponujemy własnym nowoczesnym, klimatyzowanym studiem do realizacji badań CATI, mieszczącym się w siedzibie firmy, co umożliwia koordynatorowi CATI i kierownikom projekt&oacute;w możliwość osobistej kontroli jakości prowadzonych badań telefonicznych. Każde stanowisko wyposażone jest w laptop obsługujący 3 typy innowacyjnego oprogramowania. Każde jest odpowiednio wyciszone w celu polepszenia jakości prowadzonych wywiad&oacute;w.</p>\n', 'text'),
('acircle8', 'pl', '', 'text');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `page_faq`
--

CREATE TABLE IF NOT EXISTS `page_faq` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `page_id` int(11) NOT NULL,
  `add_date` datetime NOT NULL,
  `question` text NOT NULL,
  `answer` text NOT NULL,
  `pos` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `page_group`
--

CREATE TABLE IF NOT EXISTS `page_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(256) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=4 ;

--
-- Zrzut danych tabeli `page_group`
--

INSERT INTO `page_group` (`id`, `name`) VALUES
(1, 'Menu lewe'),
(3, 'Menu prawe');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `product`
--

CREATE TABLE IF NOT EXISTS `product` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `customer_id` int(11) NOT NULL,
  `active` tinyint(1) NOT NULL,
  `name` varchar(256) NOT NULL,
  `alias` varchar(256) NOT NULL,
  `serial` varchar(64) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `tax_rate` decimal(10,2) NOT NULL,
  `short` text NOT NULL,
  `description` longtext NOT NULL,
  `functions` longtext NOT NULL,
  `manual` longtext NOT NULL,
  `category_id` int(11) NOT NULL,
  `teamviewer_id` varchar(32) NOT NULL,
  `add_date` datetime NOT NULL,
  `update_date` datetime NOT NULL,
  `update_user_id` int(11) NOT NULL,
  `pos` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `product_attribute`
--

CREATE TABLE IF NOT EXISTS `product_attribute` (
  `product_id` int(11) NOT NULL,
  `attribute_id` int(11) NOT NULL,
  `value` text NOT NULL,
  PRIMARY KEY (`product_id`,`attribute_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `product_image`
--

CREATE TABLE IF NOT EXISTS `product_image` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `add_date` datetime NOT NULL,
  `add_user_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `filename` varchar(256) NOT NULL,
  `title` varchar(256) NOT NULL,
  `type` varchar(32) NOT NULL,
  `pos` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `product_movie`
--

CREATE TABLE IF NOT EXISTS `product_movie` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `product_id` int(11) NOT NULL,
  `title` varchar(256) NOT NULL,
  `url` varchar(512) NOT NULL,
  `pos` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `product_relation`
--

CREATE TABLE IF NOT EXISTS `product_relation` (
  `product_id` int(11) NOT NULL,
  `related_id` int(11) NOT NULL,
  PRIMARY KEY (`product_id`,`related_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin2;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `product_stroller`
--

CREATE TABLE IF NOT EXISTS `product_stroller` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `product_id` int(11) NOT NULL,
  `brand` varchar(256) NOT NULL,
  `name` varchar(256) NOT NULL,
  `pos` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `session`
--

CREATE TABLE IF NOT EXISTS `session` (
  `id` varchar(64) CHARACTER SET utf8 NOT NULL,
  `name` varchar(32) CHARACTER SET utf8 NOT NULL,
  `add_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modify_date` timestamp NULL DEFAULT NULL,
  `expires` int(11) NOT NULL,
  `remember` int(11) NOT NULL,
  `data` longtext CHARACTER SET utf8 NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Zrzut danych tabeli `session`
--

INSERT INTO `session` (`id`, `name`, `add_date`, `modify_date`, `expires`, `remember`, `data`) VALUES
('7fb14c14190adf85e57346125f42611a', 'CMS', '2016-02-12 14:07:27', NULL, 1456495647, 0, 'SESSION_CLIENT_BROWSER|s:75:"Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 5.1; SV1; .NET CLR 2.0.50727)";language|s:2:"pl";msg|O:8:"Messages":1:{s:19:"\0Messages\0_messages";a:0:{}}'),
('208259d6ea36d8ed63b90a38485891c6', 'CMS', '2016-02-10 20:24:13', NULL, 1456345453, 0, 'SESSION_CLIENT_BROWSER|s:65:"''Mozilla/5.0 (compatible; MSIE 9.0; Windows NT 6.1; Trident/5.0)''";language|s:2:"pl";'),
('5aa2a9242dd5a21fb54fb0f746b8e62b', 'CMS', '2016-02-10 22:23:26', NULL, 1456352606, 0, 'SESSION_CLIENT_BROWSER|s:71:"Mozilla/5.0 (compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm)";language|s:2:"pl";'),
('4b8ab939ffb1704a4368182b9f9c3628', 'CMS', '2016-02-10 19:53:08', NULL, 1456343588, 0, 'SESSION_CLIENT_BROWSER|s:72:"Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)";language|s:2:"pl";'),
('072b8946073a1288b68b4044fc6dc693', 'CMS', '2016-02-10 18:41:44', NULL, 1456339304, 0, 'SESSION_CLIENT_BROWSER|s:72:"Mozilla/5.0 (Windows NT 6.1; WOW64; rv:44.0) Gecko/20100101 Firefox/44.0";language|s:2:"pl";msg|O:8:"Messages":1:{s:19:"\0Messages\0_messages";a:0:{}}'),
('dd2a95114420ebbaa2bf53d63e52dfc6', 'CMS', '2016-02-10 16:44:25', NULL, 1456332265, 0, 'SESSION_CLIENT_BROWSER|s:11:"Katalok.pl;";language|s:2:"pl";'),
('1a4b70ee59a29df68a262d5c30f9f5fd', 'CMS', '2016-02-10 16:44:25', NULL, 1456332265, 0, 'SESSION_CLIENT_BROWSER|s:11:"Katalok.pl;";language|s:2:"pl";msg|O:8:"Messages":1:{s:19:"\0Messages\0_messages";a:0:{}}'),
('e0e68f1e6db3bc82ad0112fa423ce293', 'CMS', '2016-02-10 16:44:23', NULL, 1456332263, 0, 'SESSION_CLIENT_BROWSER|s:112:"Firefox (WindowsXP) - Mozilla/5.0 (Windows; U; Windows NT 5.1; en-GB; rv:1.8.1.6) Gecko/20070725 Firefox/2.0.0.6";language|s:2:"pl";'),
('db82bf4e404f2e5dfc92614e6bca7c0d', 'CMS', '2016-02-10 16:44:23', NULL, 1456332263, 0, 'SESSION_CLIENT_BROWSER|s:11:"Katalok.pl;";language|s:2:"pl";'),
('b0bac34b35733d2ed05769fe667fdcb3', 'CMS', '2016-02-10 15:20:37', NULL, 1456327237, 0, 'SESSION_CLIENT_BROWSER|s:71:"Mozilla/5.0 (compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm)";language|s:2:"pl";'),
('7b38157e17392dee5a5a9ec5181a8a3a', 'CMS', '2016-02-10 16:42:24', NULL, 1456332144, 0, 'SESSION_CLIENT_BROWSER|s:24:"Mozilla/5.0 (compatible)";language|s:2:"pl";'),
('6c9bf0288a3d9d1d60bfd86abdfbec51', 'CMS', '2016-02-10 15:20:34', NULL, 1456327234, 0, 'SESSION_CLIENT_BROWSER|s:71:"Mozilla/5.0 (compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm)";language|s:2:"pl";msg|O:8:"Messages":1:{s:19:"\0Messages\0_messages";a:0:{}}'),
('34708f879e7c8ff524e3748f5cc29ba7', 'CMS', '2016-02-10 13:10:06', NULL, 1456319406, 0, 'SESSION_CLIENT_BROWSER|s:79:"Mozilla/5.0 (compatible; MJ12bot/v1.4.5; http://www.majestic12.co.uk/bot.php?+)";language|s:2:"pl";'),
('6a0fcad508ca5bc88874b5939c4a3354', 'CMS', '2016-02-10 12:42:13', NULL, 1456317733, 0, 'SESSION_CLIENT_BROWSER|s:64:"Mozilla/5.0 (compatible; YandexBot/3.0; +http://yandex.com/bots)";language|s:2:"pl";'),
('23d3e8ef54c55475c306ae29d478d0fa', 'CMS', '2016-02-12 22:53:36', NULL, 1456527216, 0, 'SESSION_CLIENT_BROWSER|s:79:"Mozilla/5.0 (compatible; MJ12bot/v1.4.5; http://www.majestic12.co.uk/bot.php?+)";language|s:2:"pl";'),
('09764cb46e7654dc934e6443913ef064', 'CMS', '2016-02-12 21:51:08', NULL, 1456523468, 0, 'SESSION_CLIENT_BROWSER|s:71:"Mozilla/5.0 (compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm)";language|s:2:"pl";'),
('2dc4ceb32810b9b4f921aef0b6d8090c', 'CMS', '2016-02-12 20:26:37', NULL, 1456518397, 0, 'SESSION_CLIENT_BROWSER|s:72:"Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101 Firefox/38.0";language|s:2:"pl";'),
('147e6e2002683f9b5426c741100d58d4', 'CMS', '2016-02-12 17:52:04', NULL, 1456509124, 0, 'SESSION_CLIENT_BROWSER|s:65:"Mozilla/5.0 (Windows NT 6.1; rv:40.0) Gecko/20100101 Firefox/40.0";language|s:2:"pl";'),
('87697ae59e7bcb34d23a0a478b4b5e6b', 'CMS', '2016-02-12 17:30:37', NULL, 1456507837, 0, 'SESSION_CLIENT_BROWSER|s:72:"Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)";language|s:2:"pl";'),
('68d343b7e868261d5013f3f6dea09c1e', 'CMS', '2016-02-12 15:35:06', NULL, 1456500906, 0, 'SESSION_CLIENT_BROWSER|s:63:"Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 5.1; Trident/4.0)";language|s:2:"pl";'),
('5f3a39596aec874c78f1251810b2805c', 'CMS', '2016-02-09 19:43:07', NULL, 1456256587, 0, 'SESSION_CLIENT_BROWSER|s:71:"Mozilla/5.0 (compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm)";language|s:2:"pl";msg|O:8:"Messages":1:{s:19:"\0Messages\0_messages";a:0:{}}'),
('ee16941ec7dc20d5694ac9ffdaa0acd2', 'CMS', '2016-02-12 17:20:41', NULL, 1456507241, 0, 'SESSION_CLIENT_BROWSER|s:71:"Mozilla/5.0 (compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm)";language|s:2:"pl";'),
('bae8e95530b279a9152458a131dbf1d2', 'CMS', '2016-02-12 14:07:41', NULL, 1456495661, 0, 'SESSION_CLIENT_BROWSER|s:75:"Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 5.1; SV1; .NET CLR 2.0.50727)";language|s:2:"pl";'),
('13442980613e637facab922da474a85d', 'CMS', '2016-02-12 14:07:40', NULL, 1456495660, 0, 'SESSION_CLIENT_BROWSER|s:75:"Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 5.1; SV1; .NET CLR 2.0.50727)";language|s:2:"pl";'),
('be4e999fa903c34c74ca13c1532d9c89', 'CMS', '2016-02-12 14:07:40', NULL, 1456495660, 0, 'SESSION_CLIENT_BROWSER|s:75:"Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 5.1; SV1; .NET CLR 2.0.50727)";language|s:2:"pl";'),
('75497107df9dedb9b1057d73643d734b', 'CMS', '2016-02-12 14:07:39', NULL, 1456495659, 0, 'SESSION_CLIENT_BROWSER|s:75:"Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 5.1; SV1; .NET CLR 2.0.50727)";language|s:2:"pl";'),
('4d8cc32c03cda15d0fadae49b062aeda', 'CMS', '2016-02-12 14:07:39', NULL, 1456495659, 0, 'SESSION_CLIENT_BROWSER|s:75:"Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 5.1; SV1; .NET CLR 2.0.50727)";language|s:2:"pl";'),
('8dc79a92cc3ba0afda807a9407a904e6', 'CMS', '2016-02-12 14:07:38', NULL, 1456495658, 0, 'SESSION_CLIENT_BROWSER|s:75:"Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 5.1; SV1; .NET CLR 2.0.50727)";language|s:2:"pl";'),
('9fd1bc8fbe9814401f939983c2e10226', 'CMS', '2016-02-12 14:07:37', NULL, 1456495657, 0, 'SESSION_CLIENT_BROWSER|s:75:"Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 5.1; SV1; .NET CLR 2.0.50727)";language|s:2:"pl";'),
('dea812b81b82cca4c53facb1d6f45f67', 'CMS', '2016-02-12 14:07:37', NULL, 1456495657, 0, 'SESSION_CLIENT_BROWSER|s:75:"Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 5.1; SV1; .NET CLR 2.0.50727)";language|s:2:"pl";'),
('a13a54bac38acd705fe11bd4b18f11c8', 'CMS', '2016-02-12 14:07:35', NULL, 1456495655, 0, 'SESSION_CLIENT_BROWSER|s:75:"Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 5.1; SV1; .NET CLR 2.0.50727)";language|s:2:"pl";'),
('b5b1d5212da2b8b82c631558536542e5', 'CMS', '2016-02-12 14:07:34', NULL, 1456495654, 0, 'SESSION_CLIENT_BROWSER|s:75:"Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 5.1; SV1; .NET CLR 2.0.50727)";language|s:2:"pl";'),
('9c37b32279f7d597eb78f39a1b98bebf', 'CMS', '2016-02-12 14:07:34', NULL, 1456495653, 0, 'SESSION_CLIENT_BROWSER|s:75:"Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 5.1; SV1; .NET CLR 2.0.50727)";language|s:2:"pl";'),
('4999a2ee78f73f3ecc9eae2409a5cd8b', 'CMS', '2016-02-12 14:07:33', NULL, 1456495653, 0, 'SESSION_CLIENT_BROWSER|s:75:"Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 5.1; SV1; .NET CLR 2.0.50727)";language|s:2:"pl";'),
('01f70aa5611bba31fbaacc8a75577431', 'CMS', '2016-02-12 14:07:32', NULL, 1456495652, 0, 'SESSION_CLIENT_BROWSER|s:75:"Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 5.1; SV1; .NET CLR 2.0.50727)";language|s:2:"pl";'),
('57e3c25152dac5351d13cc440ad5b228', 'CMS', '2016-02-12 14:07:32', NULL, 1456495652, 0, 'SESSION_CLIENT_BROWSER|s:75:"Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 5.1; SV1; .NET CLR 2.0.50727)";language|s:2:"pl";'),
('dc0efd7d66519749d30c11a1e0fea22d', 'CMS', '2016-02-15 16:57:32', NULL, 1456765052, 0, 'SESSION_CLIENT_BROWSER|s:109:"Mozilla/5.0 (Windows NT 6.3; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/48.0.2564.109 Safari/537.36";language|s:2:"pl";'),
('b17ed3b23ba78cb85fe4eb9ea6e8334b', 'CMS', '2016-02-15 20:15:14', NULL, 1456776914, 0, 'SESSION_CLIENT_BROWSER|s:71:"Mozilla/5.0 (compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm)";language|s:2:"pl";'),
('047f81ed03ecc824121824a3b1f758ac', 'CMS', '2016-02-15 10:21:16', NULL, 1456741276, 0, 'SESSION_CLIENT_BROWSER|s:71:"Mozilla/5.0 (compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm)";language|s:2:"pl";'),
('6a4a94329090a1664a2e751bc25681f7', 'CMS', '2016-02-15 22:15:18', NULL, 1456784118, 0, 'SESSION_CLIENT_BROWSER|s:79:"Mozilla/5.0 (compatible; MJ12bot/v1.4.5; http://www.majestic12.co.uk/bot.php?+)";language|s:2:"pl";'),
('18f063892439092e453958d057b3f658', 'CMS', '2016-02-15 10:21:15', NULL, 1456741275, 0, 'SESSION_CLIENT_BROWSER|s:71:"Mozilla/5.0 (compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm)";language|s:2:"pl";msg|O:8:"Messages":1:{s:19:"\0Messages\0_messages";a:0:{}}'),
('162246c5e73ac9c39f72cdf1aeab423a', 'CMS', '2016-02-15 10:04:57', NULL, 1456740297, 0, 'SESSION_CLIENT_BROWSER|s:71:"Mozilla/5.0 (compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm)";language|s:2:"pl";'),
('716055e7de501a37490ff151e9ce7937', 'CMS', '2016-02-15 10:04:52', NULL, 1456740292, 0, 'SESSION_CLIENT_BROWSER|s:71:"Mozilla/5.0 (compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm)";language|s:2:"pl";msg|O:8:"Messages":1:{s:19:"\0Messages\0_messages";a:0:{}}'),
('cd179e71ef4b56be9a3c2cae7e6e37f3', 'CMS', '2016-02-15 09:59:29', NULL, 1456739969, 0, 'SESSION_CLIENT_BROWSER|s:71:"Mozilla/5.0 (compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm)";language|s:2:"pl";'),
('afa24da6bf2eacd83340c8ee36cfd2a2', 'CMS', '2016-02-15 09:34:43', NULL, 1456738483, 0, 'SESSION_CLIENT_BROWSER|s:109:"Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/48.0.2564.109 Safari/537.36";language|s:2:"pl";'),
('535e92d305370eaa8c6e42ef12b2d989', 'CMS', '2016-02-18 14:46:33', NULL, 1457016393, 0, 'SESSION_CLIENT_BROWSER|s:71:"Mozilla/5.0 (compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm)";language|s:2:"pl";'),
('742fa29631c4537ac38ce3f6fd8a490a', 'CMS', '2016-02-18 08:30:25', NULL, 1456993825, 0, 'SESSION_CLIENT_BROWSER|s:79:"Mozilla/5.0 (compatible; MJ12bot/v1.4.5; http://www.majestic12.co.uk/bot.php?+)";language|s:2:"pl";msg|O:8:"Messages":1:{s:19:"\0Messages\0_messages";a:0:{}}'),
('03d8af93a092d4b7b54c6aff9c41d9c6', 'CMS', '2016-02-17 10:48:50', NULL, 1456915730, 0, 'SESSION_CLIENT_BROWSER|s:75:"Mozilla/5.0 (compatible; SemrushBot/1~bl; +http://www.semrush.com/bot.html)";language|s:2:"pl";msg|O:8:"Messages":1:{s:19:"\0Messages\0_messages";a:0:{}}'),
('df433c9cb9a39470c58a862d7c47b8f6', 'CMS', '2016-02-17 10:46:29', NULL, 1456915589, 0, 'SESSION_CLIENT_BROWSER|s:75:"Mozilla/5.0 (compatible; SemrushBot/1~bl; +http://www.semrush.com/bot.html)";language|s:2:"pl";msg|O:8:"Messages":1:{s:19:"\0Messages\0_messages";a:0:{}}'),
('3fa53815094baa615e7335b021082f53', 'CMS', '2016-02-17 10:42:59', NULL, 1456915379, 0, 'SESSION_CLIENT_BROWSER|s:75:"Mozilla/5.0 (compatible; SemrushBot/1~bl; +http://www.semrush.com/bot.html)";language|s:2:"pl";msg|O:8:"Messages":1:{s:19:"\0Messages\0_messages";a:0:{}}'),
('9bcd1c8de50aa42585fe2780c97dadfa', 'CMS', '2016-02-17 10:41:20', NULL, 1456915280, 0, 'SESSION_CLIENT_BROWSER|s:75:"Mozilla/5.0 (compatible; SemrushBot/1~bl; +http://www.semrush.com/bot.html)";language|s:2:"pl";msg|O:8:"Messages":1:{s:19:"\0Messages\0_messages";a:0:{}}'),
('19a6bbb908321f83b3f11f32aca6386a', 'CMS', '2016-02-17 10:38:33', NULL, 1456915113, 0, 'SESSION_CLIENT_BROWSER|s:75:"Mozilla/5.0 (compatible; SemrushBot/1~bl; +http://www.semrush.com/bot.html)";language|s:2:"pl";'),
('8fd16d878eaf3f3b1088735c480543a6', 'CMS', '2016-02-17 10:36:22', NULL, 1456914982, 0, 'SESSION_CLIENT_BROWSER|s:75:"Mozilla/5.0 (compatible; SemrushBot/1~bl; +http://www.semrush.com/bot.html)";language|s:2:"pl";msg|O:8:"Messages":1:{s:19:"\0Messages\0_messages";a:0:{}}'),
('589bbebd602ec75788f38a95c5b43d12', 'CMS', '2016-02-17 10:34:14', NULL, 1456914854, 0, 'SESSION_CLIENT_BROWSER|s:75:"Mozilla/5.0 (compatible; SemrushBot/1~bl; +http://www.semrush.com/bot.html)";language|s:2:"pl";msg|O:8:"Messages":1:{s:19:"\0Messages\0_messages";a:0:{}}'),
('19a479e57cae169dc34694dfcc21e9af', 'CMS', '2016-02-17 10:32:54', NULL, 1456914774, 0, 'SESSION_CLIENT_BROWSER|s:75:"Mozilla/5.0 (compatible; SemrushBot/1~bl; +http://www.semrush.com/bot.html)";language|s:2:"pl";msg|O:8:"Messages":1:{s:19:"\0Messages\0_messages";a:0:{}}'),
('4c8d8f1b3258c6cd188f1c607e56bcf4', 'CMS', '2016-02-17 10:26:26', NULL, 1456914386, 0, 'SESSION_CLIENT_BROWSER|s:75:"Mozilla/5.0 (compatible; SemrushBot/1~bl; +http://www.semrush.com/bot.html)";language|s:2:"pl";msg|O:8:"Messages":1:{s:19:"\0Messages\0_messages";a:0:{}}'),
('433546e4101dd206ddee5c0afc63eb91', 'CMS', '2016-02-17 10:24:18', NULL, 1456914258, 0, 'SESSION_CLIENT_BROWSER|s:75:"Mozilla/5.0 (compatible; SemrushBot/1~bl; +http://www.semrush.com/bot.html)";language|s:2:"pl";msg|O:8:"Messages":1:{s:19:"\0Messages\0_messages";a:0:{}}'),
('cc667d3f9fbf7842aadb21d6887d9d8b', 'CMS', '2016-02-17 10:20:25', NULL, 1456914025, 0, 'SESSION_CLIENT_BROWSER|s:75:"Mozilla/5.0 (compatible; SemrushBot/1~bl; +http://www.semrush.com/bot.html)";language|s:2:"pl";msg|O:8:"Messages":1:{s:19:"\0Messages\0_messages";a:0:{}}'),
('fbb15b6c5e63430181ec0230a12571f0', 'CMS', '2016-02-17 10:18:46', NULL, 1456913926, 0, 'SESSION_CLIENT_BROWSER|s:75:"Mozilla/5.0 (compatible; SemrushBot/1~bl; +http://www.semrush.com/bot.html)";language|s:2:"pl";msg|O:8:"Messages":1:{s:19:"\0Messages\0_messages";a:0:{}}'),
('640168a83781ff53d1684f01cbf59cea', 'CMS', '2016-02-17 10:15:44', NULL, 1456913744, 0, 'SESSION_CLIENT_BROWSER|s:75:"Mozilla/5.0 (compatible; SemrushBot/1~bl; +http://www.semrush.com/bot.html)";language|s:2:"pl";msg|O:8:"Messages":1:{s:19:"\0Messages\0_messages";a:0:{}}'),
('14a7d592fb3dfc56ee7adf4683f7fda5', 'CMS', '2016-02-17 10:13:26', NULL, 1456913606, 0, 'SESSION_CLIENT_BROWSER|s:75:"Mozilla/5.0 (compatible; SemrushBot/1~bl; +http://www.semrush.com/bot.html)";language|s:2:"pl";msg|O:8:"Messages":1:{s:19:"\0Messages\0_messages";a:0:{}}'),
('1c4db7d062cbe13feda3c7dc1babccac', 'CMS', '2016-02-17 10:11:12', NULL, 1456913472, 0, 'SESSION_CLIENT_BROWSER|s:75:"Mozilla/5.0 (compatible; SemrushBot/1~bl; +http://www.semrush.com/bot.html)";language|s:2:"pl";msg|O:8:"Messages":1:{s:19:"\0Messages\0_messages";a:0:{}}'),
('e51a4cb7c6be853b0e4fa750311bf631', 'CMS', '2016-02-17 10:06:24', NULL, 1456913184, 0, 'SESSION_CLIENT_BROWSER|s:75:"Mozilla/5.0 (compatible; SemrushBot/1~bl; +http://www.semrush.com/bot.html)";language|s:2:"pl";msg|O:8:"Messages":1:{s:19:"\0Messages\0_messages";a:0:{}}'),
('ea335e2dda4d5664f7556a00ceedf3ab', 'CMS', '2016-02-17 10:01:13', NULL, 1456912873, 0, 'SESSION_CLIENT_BROWSER|s:75:"Mozilla/5.0 (compatible; SemrushBot/1~bl; +http://www.semrush.com/bot.html)";language|s:2:"pl";msg|O:8:"Messages":1:{s:19:"\0Messages\0_messages";a:0:{}}'),
('c8e6bf6c5fcdb833e5fd4e9a49075999', 'CMS', '2016-02-17 09:58:21', NULL, 1456912701, 0, 'SESSION_CLIENT_BROWSER|s:75:"Mozilla/5.0 (compatible; SemrushBot/1~bl; +http://www.semrush.com/bot.html)";language|s:2:"pl";msg|O:8:"Messages":1:{s:19:"\0Messages\0_messages";a:0:{}}'),
('6593ab1d211b4dcbe9a03acbf76cdcba', 'CMS', '2016-02-17 09:55:44', NULL, 1456912544, 0, 'SESSION_CLIENT_BROWSER|s:75:"Mozilla/5.0 (compatible; SemrushBot/1~bl; +http://www.semrush.com/bot.html)";language|s:2:"pl";msg|O:8:"Messages":1:{s:19:"\0Messages\0_messages";a:0:{}}'),
('5d26628e24fa91c378e48f631456e2d5', 'CMS', '2016-02-17 09:48:44', NULL, 1456912124, 0, 'SESSION_CLIENT_BROWSER|s:75:"Mozilla/5.0 (compatible; SemrushBot/1~bl; +http://www.semrush.com/bot.html)";language|s:2:"pl";msg|O:8:"Messages":1:{s:19:"\0Messages\0_messages";a:0:{}}'),
('f3cd8709b9a8a8093499c3f65bbd0cd6', 'CMS', '2016-02-17 17:31:11', NULL, 1456939871, 0, 'SESSION_CLIENT_BROWSER|s:69:"Mozilla/5.0 (compatible; Exabot/3.0; +http://www.exabot.com/go/robot)";language|s:2:"pl";'),
('cfb761ff2315e21f9b61250ea782887a', 'CMS', '2016-02-17 19:04:15', NULL, 1456945455, 0, 'SESSION_CLIENT_BROWSER|s:79:"Mozilla/5.0 (compatible; MJ12bot/v1.4.5; http://www.majestic12.co.uk/bot.php?+)";language|s:2:"pl";'),
('b72daa1e9ef110f413ba8cb60b53d023', 'CMS', '2016-02-17 15:35:50', NULL, 1456932950, 0, 'SESSION_CLIENT_BROWSER|s:118:"Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US) AppleWebKit/534.17 (KHTML, like Gecko) Chrome/10.0.649.0 Safari/534.17";language|s:2:"pl";'),
('3e357140aecc7113f3209cee006dfedd', 'CMS', '2016-02-17 15:35:47', NULL, 1456932947, 0, 'SESSION_CLIENT_BROWSER|s:118:"Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US) AppleWebKit/534.17 (KHTML, like Gecko) Chrome/10.0.649.0 Safari/534.17";language|s:2:"pl";'),
('0a95bc1be553932be38de2edc7d61153', 'CMS', '2016-02-17 15:35:38', NULL, 1456932938, 0, 'SESSION_CLIENT_BROWSER|s:118:"Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US) AppleWebKit/534.17 (KHTML, like Gecko) Chrome/10.0.649.0 Safari/534.17";language|s:2:"pl";'),
('77f006cec16bd16a2d841f5b72c2234f', 'CMS', '2016-02-17 15:35:36', NULL, 1456932936, 0, 'SESSION_CLIENT_BROWSER|s:118:"Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US) AppleWebKit/534.17 (KHTML, like Gecko) Chrome/10.0.649.0 Safari/534.17";language|s:2:"pl";'),
('91a8e9e3a2c361f99382b56f639005de', 'CMS', '2016-02-22 12:55:08', NULL, 1457355308, 0, 'SESSION_CLIENT_BROWSER|s:72:"Mozilla/5.0 (Windows NT 6.1; WOW64; rv:44.0) Gecko/20100101 Firefox/44.0";language|s:2:"pl";mod_pages|a:1:{s:8:"language";s:2:"pl";}last_call|s:43:"http://www.badania-telefoniczne.pl/manager/";'),
('f1e74f6e1257e6301c4f56dffa1162c9', 'CMS', '2016-02-17 13:23:07', NULL, 1456924987, 0, 'SESSION_CLIENT_BROWSER|s:72:"Mozilla/5.0 (Windows NT 6.1; WOW64; rv:44.0) Gecko/20100101 Firefox/44.0";language|s:2:"pl";'),
('50c145d0b4912c9f820c0a4fdafee23d', 'CMS', '2016-02-17 13:23:07', NULL, 1456924987, 0, 'SESSION_CLIENT_BROWSER|s:72:"Mozilla/5.0 (Windows NT 6.1; WOW64; rv:44.0) Gecko/20100101 Firefox/44.0";language|s:2:"pl";msg|O:8:"Messages":1:{s:19:"\0Messages\0_messages";a:0:{}}'),
('0408dc310e06e314de9f1e3444b06cae', 'CMS', '2016-02-17 13:23:06', NULL, 1456924986, 0, 'SESSION_CLIENT_BROWSER|s:72:"Mozilla/5.0 (Windows NT 6.1; WOW64; rv:44.0) Gecko/20100101 Firefox/44.0";language|s:2:"pl";'),
('4d2aa17a838e77d9ed5a2da7462a64aa', 'CMS', '2016-02-17 13:23:01', NULL, 1456924981, 0, 'SESSION_CLIENT_BROWSER|s:72:"Mozilla/5.0 (Windows NT 6.1; WOW64; rv:44.0) Gecko/20100101 Firefox/44.0";language|s:2:"pl";'),
('c9cff3911b7b7b6ef367d7155e369864', 'CMS', '2016-02-17 15:35:45', NULL, 1456932945, 0, 'SESSION_CLIENT_BROWSER|s:118:"Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US) AppleWebKit/534.17 (KHTML, like Gecko) Chrome/10.0.649.0 Safari/534.17";language|s:2:"pl";'),
('45657e48e922fc689c8ccc6aab0bfb2b', 'CMS', '2016-02-17 15:35:42', NULL, 1456932942, 0, 'SESSION_CLIENT_BROWSER|s:118:"Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US) AppleWebKit/534.17 (KHTML, like Gecko) Chrome/10.0.649.0 Safari/534.17";language|s:2:"pl";'),
('15413be095eb6aabad99d4ceac11b347', 'CMS', '2016-02-18 20:31:05', NULL, 1457037065, 0, 'SESSION_CLIENT_BROWSER|s:71:"Mozilla/5.0 (compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm)";language|s:2:"pl";'),
('ce96cd01139ad00e878a83c99a0ad426', 'CMS', '2016-02-18 23:34:29', NULL, 1457048069, 0, 'SESSION_CLIENT_BROWSER|s:66:"Mozilla/5.0 (compatible; AhrefsBot/5.0; +http://ahrefs.com/robot/)";language|s:2:"pl";msg|O:8:"Messages":1:{s:19:"\0Messages\0_messages";a:0:{}}'),
('f644e89d61705207720a51211c529434', 'CMS', '2016-02-18 18:58:01', NULL, 1457031481, 0, 'SESSION_CLIENT_BROWSER|s:66:"Mozilla/5.0 (compatible; AhrefsBot/5.0; +http://ahrefs.com/robot/)";language|s:2:"pl";msg|O:8:"Messages":1:{s:19:"\0Messages\0_messages";a:0:{}}'),
('6007dc671e2ecc319798c0b28ffee2f1', 'CMS', '2016-02-18 16:07:05', NULL, 1457021225, 0, 'SESSION_CLIENT_BROWSER|s:71:"Mozilla/5.0 (compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm)";language|s:2:"pl";'),
('330282df922270b355e2fd32b7d248b6', 'CMS', '2016-02-18 18:07:42', NULL, 1457028462, 0, 'SESSION_CLIENT_BROWSER|s:66:"Mozilla/5.0 (compatible; AhrefsBot/5.0; +http://ahrefs.com/robot/)";language|s:2:"pl";msg|O:8:"Messages":1:{s:19:"\0Messages\0_messages";a:0:{}}'),
('bf16b6c30cd4d7504148b705a2fe72fc', 'CMS', '2016-02-18 16:07:03', NULL, 1457021223, 0, 'SESSION_CLIENT_BROWSER|s:71:"Mozilla/5.0 (compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm)";language|s:2:"pl";'),
('eba4452ab07d3cc6919ae88ff5eb15b5', 'CMS', '2016-02-18 16:07:04', NULL, 1457021224, 0, 'SESSION_CLIENT_BROWSER|s:71:"Mozilla/5.0 (compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm)";language|s:2:"pl";'),
('fafc901c4ce8298648e77614f659b45b', 'CMS', '2016-02-18 15:22:46', NULL, 1457018566, 0, 'SESSION_CLIENT_BROWSER|s:72:"Mozilla/5.0 (Windows NT 6.1; WOW64; rv:44.0) Gecko/20100101 Firefox/44.0";language|s:2:"pl";'),
('33f68afb7e43d8262af037e9d367e807', 'CMS', '2016-02-18 15:22:45', NULL, 1457018565, 0, 'SESSION_CLIENT_BROWSER|s:72:"Mozilla/5.0 (Windows NT 6.1; WOW64; rv:44.0) Gecko/20100101 Firefox/44.0";language|s:2:"pl";msg|O:8:"Messages":1:{s:19:"\0Messages\0_messages";a:0:{}}'),
('1f28a6ca5917747fc8517eb667315bbe', 'CMS', '2016-02-18 15:22:44', NULL, 1457018564, 0, 'SESSION_CLIENT_BROWSER|s:72:"Mozilla/5.0 (Windows NT 6.1; WOW64; rv:44.0) Gecko/20100101 Firefox/44.0";language|s:2:"pl";'),
('b76835c4b4555bbeefef020d340551c9', 'CMS', '2016-02-18 15:22:44', NULL, 1457018564, 0, 'SESSION_CLIENT_BROWSER|s:72:"Mozilla/5.0 (Windows NT 6.1; WOW64; rv:44.0) Gecko/20100101 Firefox/44.0";language|s:2:"pl";msg|O:8:"Messages":1:{s:19:"\0Messages\0_messages";a:0:{}}'),
('8742d1b41b49f3c9361fc650f481d96c', 'CMS', '2016-02-18 15:22:42', NULL, 1457018562, 0, 'SESSION_CLIENT_BROWSER|s:72:"Mozilla/5.0 (Windows NT 6.1; WOW64; rv:44.0) Gecko/20100101 Firefox/44.0";language|s:2:"pl";'),
('0f1316682fe7bc3fe3e3d29e2cc6018e', 'CMS', '2016-02-09 14:47:58', NULL, 1456238878, 0, 'SESSION_CLIENT_BROWSER|s:72:"Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)";language|s:2:"pl";'),
('a237c6d949849ec55ccc2dc3916b6683', 'CMS', '2016-02-18 12:54:41', NULL, 1457009681, 0, 'SESSION_CLIENT_BROWSER|s:23:"Wget/1.16.3 (linux-gnu)";language|s:2:"pl";'),
('85d5219b978952a8a65a1e343842eefe', 'CMS', '2016-02-18 12:41:19', NULL, 1457008879, 0, 'SESSION_CLIENT_BROWSER|s:109:"Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/48.0.2564.109 Safari/537.36";language|s:2:"pl";'),
('a2b4e516c1ab850a36f1c615956ee456', 'CMS', '2016-02-10 11:01:29', NULL, 1456311689, 0, 'SESSION_CLIENT_BROWSER|s:71:"Mozilla/5.0 (compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm)";language|s:2:"pl";msg|O:8:"Messages":1:{s:19:"\0Messages\0_messages";a:0:{}}'),
('8657e57349e58ab4ef68c3c6a19daaa1', 'CMS', '2016-02-10 12:42:11', NULL, 1456317731, 0, 'SESSION_CLIENT_BROWSER|s:64:"Mozilla/5.0 (compatible; YandexBot/3.0; +http://yandex.com/bots)";language|s:2:"pl";'),
('18414083ad4d8d534a7d58190a61e54a', 'CMS', '2016-02-19 21:30:21', NULL, 1457127021, 0, 'SESSION_CLIENT_BROWSER|s:105:"Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/37.0.2062.120 Safari/537.36";language|s:2:"pl";'),
('11a158b7a64f99e59dcf6288435b2b3e', 'CMS', '2016-02-19 21:02:11', NULL, 1457125331, 0, 'SESSION_CLIENT_BROWSER|s:71:"Mozilla/5.0 (compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm)";language|s:2:"pl";'),
('56566a487b3afd4fcca678fc361158e6', 'CMS', '2016-02-19 19:15:08', NULL, 1457118908, 0, 'SESSION_CLIENT_BROWSER|s:66:"Mozilla/5.0 (compatible; AhrefsBot/5.0; +http://ahrefs.com/robot/)";language|s:2:"pl";msg|O:8:"Messages":1:{s:19:"\0Messages\0_messages";a:0:{}}'),
('7a9aceda6e7af4458f66a6d5482a256b', 'CMS', '2016-02-19 18:04:17', NULL, 1457114657, 0, 'SESSION_CLIENT_BROWSER|s:71:"Mozilla/5.0 (compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm)";language|s:2:"pl";msg|O:8:"Messages":1:{s:19:"\0Messages\0_messages";a:0:{}}'),
('4fe7d4df93f699b555f135650757eeac', 'CMS', '2016-02-20 23:01:46', NULL, 1457218906, 0, 'SESSION_CLIENT_BROWSER|s:66:"Mozilla/5.0 (compatible; AhrefsBot/5.0; +http://ahrefs.com/robot/)";language|s:2:"pl";'),
('12f592b73a9ec132c46192052ea1e1f3', 'CMS', '2016-02-20 21:18:15', NULL, 1457212695, 0, 'SESSION_CLIENT_BROWSER|s:71:"Mozilla/5.0 (compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm)";language|s:2:"pl";msg|O:8:"Messages":1:{s:19:"\0Messages\0_messages";a:0:{}}'),
('a56f1b8f144a0c00a9a79f053b0581aa', 'CMS', '2016-02-20 20:46:55', NULL, 1457210815, 0, 'SESSION_CLIENT_BROWSER|s:71:"Mozilla/5.0 (compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm)";language|s:2:"pl";'),
('374c1530d41a97f322706cbef641d90a', 'CMS', '2016-02-20 21:15:58', NULL, 1457212558, 0, 'SESSION_CLIENT_BROWSER|s:66:"Mozilla/5.0 (compatible; AhrefsBot/5.0; +http://ahrefs.com/robot/)";language|s:2:"pl";msg|O:8:"Messages":1:{s:19:"\0Messages\0_messages";a:0:{}}'),
('3b106756af75cebf2b12787f6478eda3', 'CMS', '2016-02-20 16:52:08', NULL, 1457196728, 0, 'SESSION_CLIENT_BROWSER|s:71:"Mozilla/5.0 (compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm)";language|s:2:"pl";'),
('c349af342a360e2e1cf89d31e94a8220', 'CMS', '2016-02-20 16:52:07', NULL, 1457196727, 0, 'SESSION_CLIENT_BROWSER|s:71:"Mozilla/5.0 (compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm)";language|s:2:"pl";msg|O:8:"Messages":1:{s:19:"\0Messages\0_messages";a:0:{}}'),
('ca384b242a61f4d112d199f4ec0ca47f', 'CMS', '2016-02-20 15:01:41', NULL, 1457190101, 0, 'SESSION_CLIENT_BROWSER|s:67:"Mozilla/5.0 (Windows NT 5.1; rv:6.0.2) Gecko/20100101 Firefox/6.0.2";language|s:2:"pl";'),
('74d5a24da6996312ab3db0f967c61c7e', 'CMS', '2016-02-20 14:50:33', NULL, 1457189433, 0, 'SESSION_CLIENT_BROWSER|s:105:"Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/37.0.2062.120 Safari/537.36";language|s:2:"pl";'),
('c5ebf81b9fd0777aada19c291e903fdb', 'CMS', '2016-02-21 22:53:47', NULL, 1457304827, 0, 'SESSION_CLIENT_BROWSER|s:79:"Mozilla/5.0 (compatible; MJ12bot/v1.4.5; http://www.majestic12.co.uk/bot.php?+)";language|s:2:"pl";'),
('6427f0cfae16f46f251343b525c7a116', 'CMS', '2016-02-21 20:38:52', NULL, 1457296732, 0, 'SESSION_CLIENT_BROWSER|s:41:"Wotbox/2.01 (+http://www.wotbox.com/bot/)";language|s:2:"pl";'),
('2ad053e6e95108738cacf46c9778577c', 'CMS', '2016-02-08 02:32:55', NULL, 1456108375, 0, 'SESSION_CLIENT_BROWSER|s:66:"Mozilla/5.0 (compatible; AhrefsBot/5.0; +http://ahrefs.com/robot/)";language|s:2:"pl";'),
('6d79cb63e4bf4f78438d92aeb93b7d2d', 'CMS', '2016-02-08 02:58:01', NULL, 1456109881, 0, 'SESSION_CLIENT_BROWSER|b:0;language|s:2:"pl";'),
('09aff9f5d161ae4d8681be7f50465eec', 'CMS', '2016-02-08 03:43:07', NULL, 1456112587, 0, 'SESSION_CLIENT_BROWSER|s:109:"Mozilla/5.0 (Windows NT 6.3; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/48.0.2564.103 Safari/537.36";language|s:2:"pl";msg|O:8:"Messages":1:{s:19:"\0Messages\0_messages";a:0:{}}'),
('cf6f0c5f55237a848ba06c4653edee8a', 'CMS', '2016-02-08 06:14:44', NULL, 1456121684, 0, 'SESSION_CLIENT_BROWSER|s:76:"Mozilla/4.0 (compatible; MSIE 6.0; MSIE 5.5; Windows NT 5.1) Opera 7.01 [en]";language|s:2:"pl";'),
('28ea2fb8bbbad993c09b3e29de56e56d', 'CMS', '2016-02-08 06:14:44', NULL, 1456121684, 0, 'SESSION_CLIENT_BROWSER|s:76:"Mozilla/4.0 (compatible; MSIE 6.0; MSIE 5.5; Windows NT 5.1) Opera 7.01 [en]";language|s:2:"pl";msg|O:8:"Messages":1:{s:19:"\0Messages\0_messages";a:0:{}}'),
('fe537649174c94282ce449fd0de18d57', 'CMS', '2016-02-08 06:14:45', NULL, 1456121685, 0, 'SESSION_CLIENT_BROWSER|s:76:"Mozilla/4.0 (compatible; MSIE 6.0; MSIE 5.5; Windows NT 5.1) Opera 7.01 [en]";language|s:2:"pl";'),
('476a874c31aaae587ba0add79f47a878', 'CMS', '2016-02-08 06:14:45', NULL, 1456121685, 0, 'SESSION_CLIENT_BROWSER|s:76:"Mozilla/4.0 (compatible; MSIE 6.0; MSIE 5.5; Windows NT 5.1) Opera 7.01 [en]";language|s:2:"pl";msg|O:8:"Messages":1:{s:19:"\0Messages\0_messages";a:0:{}}'),
('2a7f8397ffbccac8426aa07cd9eb3b22', 'CMS', '2016-02-08 06:14:45', NULL, 1456121685, 0, 'SESSION_CLIENT_BROWSER|s:76:"Mozilla/4.0 (compatible; MSIE 6.0; MSIE 5.5; Windows NT 5.1) Opera 7.01 [en]";language|s:2:"pl";'),
('33a48556d4e9e2114aeba385e2520fd1', 'CMS', '2016-02-08 06:14:45', NULL, 1456121685, 0, 'SESSION_CLIENT_BROWSER|s:76:"Mozilla/4.0 (compatible; MSIE 6.0; MSIE 5.5; Windows NT 5.1) Opera 7.01 [en]";language|s:2:"pl";msg|O:8:"Messages":1:{s:19:"\0Messages\0_messages";a:0:{}}'),
('d9aa0a0b4e345832312ea682e0436f4c', 'CMS', '2016-02-08 06:14:45', NULL, 1456121685, 0, 'SESSION_CLIENT_BROWSER|s:76:"Mozilla/4.0 (compatible; MSIE 6.0; MSIE 5.5; Windows NT 5.1) Opera 7.01 [en]";language|s:2:"pl";'),
('1b3ce671bb640cc8edc4db25871e93f5', 'CMS', '2016-02-08 08:56:54', NULL, 1456131414, 0, 'SESSION_CLIENT_BROWSER|s:72:"Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)";language|s:2:"pl";'),
('92c71a033684f4665e86935e9ded3073', 'CMS', '2016-02-08 09:28:37', NULL, 1456133317, 0, 'SESSION_CLIENT_BROWSER|s:135:"Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Ubuntu Chromium/33.0.1750.152 Chrome/33.0.1750.152 Safari/537.36";language|s:2:"pl";'),
('caaaeaed345156e500204eedade02462', 'CMS', '2016-02-08 14:52:34', NULL, 1456152754, 0, 'SESSION_CLIENT_BROWSER|s:79:"Mozilla/5.0 (compatible; MJ12bot/v1.4.5; http://www.majestic12.co.uk/bot.php?+)";language|s:2:"pl";'),
('cca1906d01d3573e156975c016d82a88', 'CMS', '2016-02-08 12:02:19', NULL, 1456142539, 0, 'SESSION_CLIENT_BROWSER|s:109:"Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/48.0.2564.103 Safari/537.36";language|s:2:"pl";'),
('d1f68c182e1d2bd7718a8c03b6b74d28', 'CMS', '2016-02-08 15:11:42', NULL, 1456153902, 0, 'SESSION_CLIENT_BROWSER|s:105:"Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/37.0.2062.120 Safari/537.36";language|s:2:"pl";'),
('4d849b2de7ae1681f11d24e62ba4e9ce', 'CMS', '2016-02-10 18:41:45', NULL, 1456339305, 0, 'SESSION_CLIENT_BROWSER|s:72:"Mozilla/5.0 (Windows NT 6.1; WOW64; rv:44.0) Gecko/20100101 Firefox/44.0";language|s:2:"pl";'),
('a9f6aeae3af7910d6978455904e8b399', 'CMS', '2016-02-09 01:44:25', NULL, 1456191865, 0, 'SESSION_CLIENT_BROWSER|s:79:"Mozilla/5.0 (compatible; MJ12bot/v1.4.5; http://www.majestic12.co.uk/bot.php?+)";language|s:2:"pl";'),
('354b40516e56133936c21be1903eaccf', 'CMS', '2016-02-09 03:04:12', NULL, 1456196652, 0, 'SESSION_CLIENT_BROWSER|b:0;language|s:2:"pl";'),
('76bd58373716095d31837303f046fabf', 'CMS', '2016-02-09 03:29:16', NULL, 1456198156, 0, 'SESSION_CLIENT_BROWSER|s:73:"Mozilla/5.0 (Windows NT 10.0; WOW64; rv:41.0) Gecko/20100101 Firefox/41.0";language|s:2:"pl";'),
('4e7fbba7edb72bd74b3778b263a869e7', 'CMS', '2016-02-09 03:43:37', NULL, 1456199017, 0, 'SESSION_CLIENT_BROWSER|s:72:"Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)";language|s:2:"pl";'),
('8cc091828a581bef87a5b6eecedb1b11', 'CMS', '2016-02-09 03:50:20', NULL, 1456199420, 0, 'SESSION_CLIENT_BROWSER|s:79:"Mozilla/5.0 (compatible; MJ12bot/v1.4.5; http://www.majestic12.co.uk/bot.php?+)";language|s:2:"pl";msg|O:8:"Messages":1:{s:19:"\0Messages\0_messages";a:0:{}}'),
('8c2cb7339394e229891741fdf476796f', 'CMS', '2016-02-09 03:50:25', NULL, 1456199425, 0, 'SESSION_CLIENT_BROWSER|s:79:"Mozilla/5.0 (compatible; MJ12bot/v1.4.5; http://www.majestic12.co.uk/bot.php?+)";language|s:2:"pl";'),
('e7b79a9a98044ab88ebdc4e9dfca2884', 'CMS', '2016-02-09 03:50:27', NULL, 1456199427, 0, 'SESSION_CLIENT_BROWSER|s:79:"Mozilla/5.0 (compatible; MJ12bot/v1.4.5; http://www.majestic12.co.uk/bot.php?+)";language|s:2:"pl";'),
('9508e738fecb9745337b011ce9730687', 'CMS', '2016-02-09 09:12:56', NULL, 1456218776, 0, 'SESSION_CLIENT_BROWSER|s:72:"Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)";language|s:2:"pl";'),
('91f710ee376be6b1b511847a0fe02ca2', 'CMS', '2016-02-09 09:14:13', NULL, 1456218853, 0, 'SESSION_CLIENT_BROWSER|s:79:"Mozilla/5.0 (compatible; MJ12bot/v1.4.5; http://www.majestic12.co.uk/bot.php?+)";language|s:2:"pl";'),
('751ad58a49372a597a0f91a97b64251f', 'CMS', '2016-02-09 09:17:09', NULL, 1456219029, 0, 'SESSION_CLIENT_BROWSER|s:68:"Mozilla/5.0 (Windows NT 6.1; WOW64; Trident/7.0; rv:11.0) like Gecko";language|s:2:"pl";'),
('181e6cc7f21200ff8f0a63597592ce5c', 'CMS', '2016-02-09 13:40:49', NULL, 1456234849, 0, 'SESSION_CLIENT_BROWSER|s:65:"Mozilla/5.0 (Windows NT 6.0; rv:43.0) Gecko/20100101 Firefox/43.0";language|s:2:"pl";'),
('9a9c963e082750a82ab303a3805c5ec6', 'CMS', '2016-02-09 14:43:54', NULL, 1456238634, 0, 'SESSION_CLIENT_BROWSER|s:109:"Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/48.0.2564.103 Safari/537.36";language|s:2:"pl";'),
('aed12b77569b55911997c1f5009de0ae', 'CMS', '2016-02-09 14:50:14', NULL, 1456239014, 0, 'SESSION_CLIENT_BROWSER|s:79:"Mozilla/5.0 (compatible; MJ12bot/v1.4.5; http://www.majestic12.co.uk/bot.php?+)";language|s:2:"pl";'),
('c6e920bede1338e8535ac5bb9eeb9435', 'CMS', '2016-02-09 14:50:17', NULL, 1456239017, 0, 'SESSION_CLIENT_BROWSER|s:79:"Mozilla/5.0 (compatible; MJ12bot/v1.4.5; http://www.majestic12.co.uk/bot.php?+)";language|s:2:"pl";'),
('9fee50a330d6923d421bfbadca48bc13', 'CMS', '2016-02-09 14:50:20', NULL, 1456239020, 0, 'SESSION_CLIENT_BROWSER|s:79:"Mozilla/5.0 (compatible; MJ12bot/v1.4.5; http://www.majestic12.co.uk/bot.php?+)";language|s:2:"pl";'),
('6939908a1aa5dd91cdcb30d6a7307b30', 'CMS', '2016-02-09 14:50:23', NULL, 1456239023, 0, 'SESSION_CLIENT_BROWSER|s:79:"Mozilla/5.0 (compatible; MJ12bot/v1.4.5; http://www.majestic12.co.uk/bot.php?+)";language|s:2:"pl";'),
('720ade5ba42ccbe449293ba2df8b1ad9', 'CMS', '2016-02-09 14:51:17', NULL, 1456239077, 0, 'SESSION_CLIENT_BROWSER|s:64:"Mozilla/5.0 (compatible; YandexBot/3.0; +http://yandex.com/bots)";language|s:2:"pl";'),
('6ff4f7c9e70088dd185033439516c1bb', 'CMS', '2016-02-09 14:51:28', NULL, 1456239088, 0, 'SESSION_CLIENT_BROWSER|s:64:"Mozilla/5.0 (compatible; YandexBot/3.0; +http://yandex.com/bots)";language|s:2:"pl";'),
('c6826756f4511fd4388fe483be7d0cd7', 'CMS', '2016-02-09 18:53:29', NULL, 1456253609, 0, 'SESSION_CLIENT_BROWSER|s:71:"Mozilla/5.0 (compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm)";language|s:2:"pl";msg|O:8:"Messages":1:{s:19:"\0Messages\0_messages";a:0:{}}'),
('e4e338b21deab8c5e628925be754b67a', 'CMS', '2016-02-09 18:53:29', NULL, 1456253609, 0, 'SESSION_CLIENT_BROWSER|s:71:"Mozilla/5.0 (compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm)";language|s:2:"pl";'),
('fa7c3729ed5eafc13f397a8baf72bd32', 'CMS', '2016-02-09 19:00:32', NULL, 1456254032, 0, 'SESSION_CLIENT_BROWSER|s:65:"Mozilla/5.0 (Windows NT 5.1; rv:43.0) Gecko/20100101 Firefox/43.0";language|s:2:"pl";'),
('2276483bf7227eaa7275c8a94243fda4', 'CMS', '2016-02-09 19:43:07', NULL, 1456256587, 0, 'SESSION_CLIENT_BROWSER|s:71:"Mozilla/5.0 (compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm)";language|s:2:"pl";'),
('c83bf012408b8f70a48a6e61d6a4ac36', 'CMS', '2016-02-09 22:04:29', NULL, 1456265069, 0, 'SESSION_CLIENT_BROWSER|s:72:"Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)";language|s:2:"pl";'),
('3538415f74f69e62195c6aa38ed64774', 'CMS', '2016-02-09 21:32:41', NULL, 1456263161, 0, 'SESSION_CLIENT_BROWSER|s:133:"Mozilla/5.0 (iPhone; CPU iPhone OS 8_3 like Mac OS X) AppleWebKit/600.1.4 (KHTML, like Gecko) Version/8.0 Mobile/12F70 Safari/600.1.4";language|s:2:"pl";'),
('7dc4be70c9463dc121c5267d4d204820', 'CMS', '2016-02-09 22:21:07', NULL, 1456266067, 0, 'SESSION_CLIENT_BROWSER|s:71:"Mozilla/5.0 (compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm)";language|s:2:"pl";'),
('bd965cbaf3f314eb012fae12e465ffee', 'CMS', '2016-02-09 22:54:44', NULL, 1456268084, 0, 'SESSION_CLIENT_BROWSER|s:79:"Mozilla/5.0 (compatible; MJ12bot/v1.4.5; http://www.majestic12.co.uk/bot.php?+)";language|s:2:"pl";'),
('fa18daaea5bd31887cbc2aa421ffa89d', 'CMS', '2016-02-09 22:54:46', NULL, 1456268086, 0, 'SESSION_CLIENT_BROWSER|s:79:"Mozilla/5.0 (compatible; MJ12bot/v1.4.5; http://www.majestic12.co.uk/bot.php?+)";language|s:2:"pl";'),
('90f3fdba9cf438119edb74bde90df754', 'CMS', '2016-02-09 22:54:48', NULL, 1456268088, 0, 'SESSION_CLIENT_BROWSER|s:79:"Mozilla/5.0 (compatible; MJ12bot/v1.4.5; http://www.majestic12.co.uk/bot.php?+)";language|s:2:"pl";'),
('1697ebbbe758bec8efbcd55d564c7ac7', 'CMS', '2016-02-10 03:12:17', NULL, 1456283537, 0, 'SESSION_CLIENT_BROWSER|b:0;language|s:2:"pl";'),
('80bc9171f4e67635ac8398629fd270c5', 'CMS', '2016-02-10 07:33:22', NULL, 1456299202, 0, 'SESSION_CLIENT_BROWSER|s:72:"Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)";language|s:2:"pl";'),
('b18396e85f2c8a9f2a754c287897a378', 'CMS', '2016-02-10 10:05:11', NULL, 1456308311, 0, 'SESSION_CLIENT_BROWSER|s:71:"Mozilla/5.0 (compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm)";language|s:2:"pl";'),
('ff87c665c64e91b4f3686bb7ff12af8e', 'CMS', '2016-02-11 10:07:13', NULL, 1456394833, 0, 'SESSION_CLIENT_BROWSER|s:71:"Mozilla/5.0 (compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm)";language|s:2:"pl";'),
('5e5dbaeeebec9ab5d653ae3e6793aedd', 'CMS', '2016-02-11 00:16:23', NULL, 1456359383, 0, 'SESSION_CLIENT_BROWSER|s:72:"Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)";language|s:2:"pl";'),
('99d97a4db555d42e4c9b1e31bdcf70d4', 'CMS', '2016-02-11 01:24:39', NULL, 1456363479, 0, 'SESSION_CLIENT_BROWSER|s:72:"Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)";language|s:2:"pl";'),
('de35ed4e137f36ad74dc885782414a61', 'CMS', '2016-02-11 01:42:16', NULL, 1456364536, 0, 'SESSION_CLIENT_BROWSER|s:83:"Mozilla/5.0 (compatible; Yahoo! Slurp; http://help.yahoo.com/help/us/ysearch/slurp)";language|s:2:"pl";'),
('b146c5c87307b8ffe2c3fd14f9413527', 'CMS', '2016-02-11 01:42:16', NULL, 1456364536, 0, 'SESSION_CLIENT_BROWSER|s:83:"Mozilla/5.0 (compatible; Yahoo! Slurp; http://help.yahoo.com/help/us/ysearch/slurp)";language|s:2:"pl";'),
('95286c81abe6f321a646713847544f30', 'CMS', '2016-02-11 01:42:16', NULL, 1456364536, 0, 'SESSION_CLIENT_BROWSER|s:83:"Mozilla/5.0 (compatible; Yahoo! Slurp; http://help.yahoo.com/help/us/ysearch/slurp)";language|s:2:"pl";'),
('4d8b90669f9f83d985f98417d2dc84ab', 'CMS', '2016-02-11 03:18:01', NULL, 1456370281, 0, 'SESSION_CLIENT_BROWSER|b:0;language|s:2:"pl";'),
('914e2b72f5d060595b671e2823d45d6b', 'CMS', '2016-02-11 05:56:46', NULL, 1456379806, 0, 'SESSION_CLIENT_BROWSER|s:79:"Mozilla/5.0 (compatible; MJ12bot/v1.4.5; http://www.majestic12.co.uk/bot.php?+)";language|s:2:"pl";'),
('2b261e78b3d43d814ae04f47d64db340', 'CMS', '2016-02-17 13:23:05', NULL, 1456924985, 0, 'SESSION_CLIENT_BROWSER|s:72:"Mozilla/5.0 (Windows NT 6.1; WOW64; rv:44.0) Gecko/20100101 Firefox/44.0";language|s:2:"pl";msg|O:8:"Messages":1:{s:19:"\0Messages\0_messages";a:0:{}}'),
('0a94191bda21330341ecefd00dddc8b8', 'CMS', '2016-02-11 11:33:33', NULL, 1456400013, 0, 'SESSION_CLIENT_BROWSER|s:72:"Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)";language|s:2:"pl";'),
('9977c913f10b78155564f1ed0ea4c381', 'CMS', '2016-02-11 12:05:08', NULL, 1456401908, 0, 'SESSION_CLIENT_BROWSER|s:71:"Mozilla/5.0 (compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm)";language|s:2:"pl";msg|O:8:"Messages":1:{s:19:"\0Messages\0_messages";a:0:{}}'),
('bcf438798030959282d1ae878630a112', 'CMS', '2016-02-11 12:58:40', NULL, 1456405120, 0, 'SESSION_CLIENT_BROWSER|s:69:"Mozilla/5.0 (compatible; Exabot/3.0; +http://www.exabot.com/go/robot)";language|s:2:"pl";msg|O:8:"Messages":1:{s:19:"\0Messages\0_messages";a:0:{}}'),
('a9b1cac64e4c7529f8b3347d7c1e6467', 'CMS', '2016-02-11 12:58:50', NULL, 1456405130, 0, 'SESSION_CLIENT_BROWSER|s:69:"Mozilla/5.0 (compatible; Exabot/3.0; +http://www.exabot.com/go/robot)";language|s:2:"pl";'),
('17d1e9d5e0a9bd7ce30baddd46449ca3', 'CMS', '2016-02-11 12:59:30', NULL, 1456405170, 0, 'SESSION_CLIENT_BROWSER|s:69:"Mozilla/5.0 (compatible; Exabot/3.0; +http://www.exabot.com/go/robot)";language|s:2:"pl";'),
('d9086b4bf44c52e023563933ed341d68', 'CMS', '2016-02-11 12:59:37', NULL, 1456405177, 0, 'SESSION_CLIENT_BROWSER|s:69:"Mozilla/5.0 (compatible; Exabot/3.0; +http://www.exabot.com/go/robot)";language|s:2:"pl";'),
('40b76f50b495ea01ebf5e72ae76b2d70', 'CMS', '2016-02-11 14:06:11', NULL, 1456409171, 0, 'SESSION_CLIENT_BROWSER|s:108:"Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/45.0.2454.93 Safari/537.36";language|s:2:"pl";'),
('bb838cddd40290863197fa18cfc0cb07', 'CMS', '2016-02-11 14:28:47', NULL, 1456410527, 0, 'SESSION_CLIENT_BROWSER|s:71:"Mozilla/5.0 (compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm)";language|s:2:"pl";'),
('6f9a9625c3936146a659a2799ed6fc34', 'CMS', '2016-02-11 16:30:17', NULL, 1456417817, 0, 'SESSION_CLIENT_BROWSER|s:72:"Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)";language|s:2:"pl";'),
('4cf76a4679e1a346a4eecf9b0e8f8283', 'CMS', '2016-02-11 17:31:40', NULL, 1456421500, 0, 'SESSION_CLIENT_BROWSER|s:78:"Mozilla/5.0 (Windows NT 6.1; rv:6.0) Gecko/20110814 Firefox/6.0 Google Favicon";language|s:2:"pl";'),
('fc83e6983fb37171bc516459cfa0a1e6', 'CMS', '2016-02-11 17:31:40', NULL, 1456421500, 0, 'SESSION_CLIENT_BROWSER|s:78:"Mozilla/5.0 (Windows NT 6.1; rv:6.0) Gecko/20110814 Firefox/6.0 Google Favicon";language|s:2:"pl";msg|O:8:"Messages":1:{s:19:"\0Messages\0_messages";a:0:{}}'),
('67eccf2097512146597d5b24254a0d13', 'CMS', '2016-02-11 17:31:41', NULL, 1456421501, 0, 'SESSION_CLIENT_BROWSER|s:78:"Mozilla/5.0 (Windows NT 6.1; rv:6.0) Gecko/20110814 Firefox/6.0 Google Favicon";language|s:2:"pl";'),
('8b4e5ebf0ea521f8d418f72c80c46598', 'CMS', '2016-02-11 20:27:35', NULL, 1456432055, 0, 'SESSION_CLIENT_BROWSER|s:64:"Mozilla/5.0 (compatible; YandexBot/3.0; +http://yandex.com/bots)";language|s:2:"pl";'),
('4f5661ba871899dd90f34c6867b1d4f3', 'CMS', '2016-02-11 17:44:04', NULL, 1456422244, 0, 'SESSION_CLIENT_BROWSER|s:102:"Mozilla/5.0 (Windows NT 6.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/48.0.2564.109 Safari/537.36";language|s:2:"pl";'),
('e8e0d50c17ba8b2c475e3cedec1d43f9', 'CMS', '2016-02-11 20:27:41', NULL, 1456432061, 0, 'SESSION_CLIENT_BROWSER|s:64:"Mozilla/5.0 (compatible; YandexBot/3.0; +http://yandex.com/bots)";language|s:2:"pl";'),
('60c32598489656a7c84f7bf755b498e1', 'CMS', '2016-02-11 20:28:10', NULL, 1456432090, 0, 'SESSION_CLIENT_BROWSER|s:71:"Mozilla/5.0 (compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm)";language|s:2:"pl";msg|O:8:"Messages":1:{s:19:"\0Messages\0_messages";a:0:{}}'),
('da3b3fed7db1fc662adade5cb181b912', 'CMS', '2016-02-11 20:28:11', NULL, 1456432091, 0, 'SESSION_CLIENT_BROWSER|s:71:"Mozilla/5.0 (compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm)";language|s:2:"pl";'),
('b513606839bc9a710597383ed618e455', 'CMS', '2016-02-11 20:35:08', NULL, 1456432508, 0, 'SESSION_CLIENT_BROWSER|s:71:"Mozilla/5.0 (compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm)";language|s:2:"pl";msg|O:8:"Messages":1:{s:19:"\0Messages\0_messages";a:0:{}}'),
('426c156e4125f60e75b86a82a70cae66', 'CMS', '2016-02-11 20:35:12', NULL, 1456432512, 0, 'SESSION_CLIENT_BROWSER|s:71:"Mozilla/5.0 (compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm)";language|s:2:"pl";'),
('2f5c4bcaf310c954e56b3161210f7537', 'CMS', '2016-02-11 22:03:17', NULL, 1456437797, 0, 'SESSION_CLIENT_BROWSER|s:79:"Mozilla/5.0 (compatible; MJ12bot/v1.4.5; http://www.majestic12.co.uk/bot.php?+)";language|s:2:"pl";'),
('faeb5bc6ae71f30842898c5a098b4ee2', 'CMS', '2016-02-11 22:09:38', NULL, 1456438178, 0, 'SESSION_CLIENT_BROWSER|s:71:"Mozilla/5.0 (compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm)";language|s:2:"pl";'),
('60149cf33960855ed0325390d55a6f48', 'CMS', '2016-02-12 00:07:24', NULL, 1456445244, 0, 'SESSION_CLIENT_BROWSER|s:69:"Mozilla/5.0 (compatible; Exabot/3.0; +http://www.exabot.com/go/robot)";language|s:2:"pl";'),
('ce8167121500f0dfbd0cf4806b17f903', 'CMS', '2016-02-12 00:13:14', NULL, 1456445594, 0, 'SESSION_CLIENT_BROWSER|s:79:"Mozilla/5.0 (compatible; MJ12bot/v1.4.5; http://www.majestic12.co.uk/bot.php?+)";language|s:2:"pl";'),
('f6347298d1f6e8ee388f4fa796c551bb', 'CMS', '2016-02-12 00:35:23', NULL, 1456446923, 0, 'SESSION_CLIENT_BROWSER|s:72:"Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)";language|s:2:"pl";'),
('a009d345a51ba8f9bfaf995222e54174', 'CMS', '2016-02-12 03:23:17', NULL, 1456456997, 0, 'SESSION_CLIENT_BROWSER|b:0;language|s:2:"pl";'),
('d7980c89f4047a084bd39ea7597a920f', 'CMS', '2016-02-12 06:10:18', NULL, 1456467018, 0, 'SESSION_CLIENT_BROWSER|s:72:"Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)";language|s:2:"pl";'),
('f79cdd0e8325d6b51ba07c5db6d10ee6', 'CMS', '2016-02-12 08:23:00', NULL, 1456474980, 0, 'SESSION_CLIENT_BROWSER|s:79:"Mozilla/5.0 (compatible; MJ12bot/v1.4.5; http://www.majestic12.co.uk/bot.php?+)";language|s:2:"pl";'),
('c46afc0b4168b0b906c0ea62d4c01abf', 'CMS', '2016-02-12 08:23:06', NULL, 1456474986, 0, 'SESSION_CLIENT_BROWSER|s:79:"Mozilla/5.0 (compatible; MJ12bot/v1.4.5; http://www.majestic12.co.uk/bot.php?+)";language|s:2:"pl";'),
('ddce0e0e199b3ab5ce515e0b2f041fd5', 'CMS', '2016-02-12 08:23:08', NULL, 1456474988, 0, 'SESSION_CLIENT_BROWSER|s:79:"Mozilla/5.0 (compatible; MJ12bot/v1.4.5; http://www.majestic12.co.uk/bot.php?+)";language|s:2:"pl";'),
('876ae931f8e34fd1b4daad6ed91ccd2d', 'CMS', '2016-02-12 08:32:06', NULL, 1456475526, 0, 'SESSION_CLIENT_BROWSER|s:71:"Mozilla/5.0 (compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm)";language|s:2:"pl";msg|O:8:"Messages":1:{s:19:"\0Messages\0_messages";a:0:{}}'),
('e26c49beca9fc584614d2d360e8dc868', 'CMS', '2016-02-12 08:32:09', NULL, 1456475529, 0, 'SESSION_CLIENT_BROWSER|s:71:"Mozilla/5.0 (compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm)";language|s:2:"pl";'),
('7f168d1c42e9ce73bf2f46ef35000014', 'CMS', '2016-02-12 09:03:06', NULL, 1456477386, 0, 'SESSION_CLIENT_BROWSER|s:79:"Mozilla/5.0 (compatible; MJ12bot/v1.4.5; http://www.majestic12.co.uk/bot.php?+)";language|s:2:"pl";'),
('6d7a43955110485da102148a1b3da4a1', 'CMS', '2016-02-12 09:49:38', NULL, 1456480178, 0, 'SESSION_CLIENT_BROWSER|s:71:"Mozilla/5.0 (compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm)";language|s:2:"pl";'),
('2a5ee7dd1a34c7be8ea310192da1eb88', 'CMS', '2016-02-12 09:13:23', NULL, 1456478003, 0, 'SESSION_CLIENT_BROWSER|s:109:"Mozilla/5.0 (Windows NT 6.3; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/48.0.2564.109 Safari/537.36";language|s:2:"pl";'),
('6d1b1f8a5fde503ab0a6b7e64b0363b8', 'CMS', '2016-02-12 09:45:32', NULL, 1456479932, 0, 'SESSION_CLIENT_BROWSER|s:19:"Googlebot-Image/1.0";language|s:2:"pl";'),
('e0be133483f72c7891b9c4f571363b59', 'CMS', '2016-02-12 11:46:17', NULL, 1456487177, 0, 'SESSION_CLIENT_BROWSER|s:90:"Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.1) Gecko/20061204 Firefox/2.0.0.1";language|s:2:"pl";'),
('cbb0baf4d54babecdc4a6b943a20c078', 'CMS', '2016-02-12 14:07:27', NULL, 1456495647, 0, 'SESSION_CLIENT_BROWSER|s:75:"Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 5.1; SV1; .NET CLR 2.0.50727)";language|s:2:"pl";'),
('bddf74aeda41adc674e482a89d80cb47', 'CMS', '2016-02-12 14:07:28', NULL, 1456495648, 0, 'SESSION_CLIENT_BROWSER|s:75:"Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 5.1; SV1; .NET CLR 2.0.50727)";language|s:2:"pl";'),
('e4c16b474f1146fda077b5c1732926da', 'CMS', '2016-02-12 14:07:29', NULL, 1456495649, 0, 'SESSION_CLIENT_BROWSER|s:75:"Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 5.1; SV1; .NET CLR 2.0.50727)";language|s:2:"pl";'),
('467c7e45f8660118685b986552080caf', 'CMS', '2016-02-12 14:07:30', NULL, 1456495650, 0, 'SESSION_CLIENT_BROWSER|s:75:"Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 5.1; SV1; .NET CLR 2.0.50727)";language|s:2:"pl";'),
('1a65a9b183f2a9f5dee24aada523a125', 'CMS', '2016-02-12 14:07:30', NULL, 1456495650, 0, 'SESSION_CLIENT_BROWSER|s:75:"Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 5.1; SV1; .NET CLR 2.0.50727)";language|s:2:"pl";'),
('5163fd48af3c45b050b59487b947fc87', 'CMS', '2016-02-12 14:07:31', NULL, 1456495651, 0, 'SESSION_CLIENT_BROWSER|s:75:"Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 5.1; SV1; .NET CLR 2.0.50727)";language|s:2:"pl";'),
('f3cf6e7c3e29f28c4c1e84efaf2f7489', 'CMS', '2016-02-13 00:15:27', NULL, 1456532127, 0, 'SESSION_CLIENT_BROWSER|s:119:"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_7_2) AppleWebKit/535.19 (KHTML, like Gecko) Chrome/18.0.1025.45 Safari/535.19";language|s:2:"pl";'),
('daedd104dbe4938dd0b5e513fe16caa9', 'CMS', '2016-02-13 01:32:50', NULL, 1456536770, 0, 'SESSION_CLIENT_BROWSER|s:64:"Mozilla/5.0 (compatible; YandexBot/3.0; +http://yandex.com/bots)";language|s:2:"pl";'),
('8011793dd6978adb01ed062eef7856d3', 'CMS', '2016-02-13 01:32:53', NULL, 1456536773, 0, 'SESSION_CLIENT_BROWSER|s:64:"Mozilla/5.0 (compatible; YandexBot/3.0; +http://yandex.com/bots)";language|s:2:"pl";'),
('82de99c2231aa1bdb902affd89c0d3b5', 'CMS', '2016-02-13 02:28:06', NULL, 1456540086, 0, 'SESSION_CLIENT_BROWSER|s:71:"Mozilla/5.0 (compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm)";language|s:2:"pl";msg|O:8:"Messages":1:{s:19:"\0Messages\0_messages";a:0:{}}'),
('ec8718c701d62a6f722f2f83945007d7', 'CMS', '2016-02-13 02:28:08', NULL, 1456540088, 0, 'SESSION_CLIENT_BROWSER|s:71:"Mozilla/5.0 (compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm)";language|s:2:"pl";'),
('1d83c66b7e40e87be9a75880a21eee5c', 'CMS', '2016-02-13 03:11:50', NULL, 1456542710, 0, 'SESSION_CLIENT_BROWSER|b:0;language|s:2:"pl";'),
('206c0164397c802e7fe49b3952401469', 'CMS', '2016-02-13 04:52:21', NULL, 1456548741, 0, 'SESSION_CLIENT_BROWSER|s:195:"Mozilla/5.0 (iPhone; CPU iPhone OS 7_0 like Mac OS X) AppleWebKit/537.51.1 (KHTML, like Gecko) Version/7.0 Mobile/11A465 Safari/9537.53 (compatible; bingbot/2.0;  http://www.bing.com/bingbot.htm)";language|s:2:"pl";msg|O:8:"Messages":1:{s:19:"\0Messages\0_messages";a:0:{}}'),
('0a10a0ebc46be1596ec2483a6c72a5e7', 'CMS', '2016-02-13 04:52:24', NULL, 1456548744, 0, 'SESSION_CLIENT_BROWSER|s:195:"Mozilla/5.0 (iPhone; CPU iPhone OS 7_0 like Mac OS X) AppleWebKit/537.51.1 (KHTML, like Gecko) Version/7.0 Mobile/11A465 Safari/9537.53 (compatible; bingbot/2.0;  http://www.bing.com/bingbot.htm)";language|s:2:"pl";');
INSERT INTO `session` (`id`, `name`, `add_date`, `modify_date`, `expires`, `remember`, `data`) VALUES
('9bcd6fa3dda3988e92b2ba38334279a2', 'CMS', '2016-02-13 05:53:41', NULL, 1456552421, 0, 'SESSION_CLIENT_BROWSER|s:152:"Mozilla/5.0 (iPhone; CPU iPhone OS 7_0 like Mac OS X) AppleWebKit/537.51.1 (KHTML, like Gecko) Version/7.0 Mobile/11A465 Safari/9537.53 BingPreview/1.0b";language|s:2:"pl";'),
('03c6ef4cd01903f0a0ff24f30e9c5bce', 'CMS', '2016-02-13 08:50:38', NULL, 1456563038, 0, 'SESSION_CLIENT_BROWSER|s:195:"Mozilla/5.0 (iPhone; CPU iPhone OS 7_0 like Mac OS X) AppleWebKit/537.51.1 (KHTML, like Gecko) Version/7.0 Mobile/11A465 Safari/9537.53 (compatible; bingbot/2.0;  http://www.bing.com/bingbot.htm)";language|s:2:"pl";'),
('e4be64354fc40a9a6592d7d08efaee85', 'CMS', '2016-02-13 09:48:15', NULL, 1456566495, 0, 'SESSION_CLIENT_BROWSER|s:71:"Mozilla/5.0 (compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm)";language|s:2:"pl";'),
('950f8ccfc826df3cb6ca549d58e07de4', 'CMS', '2016-02-13 10:40:14', NULL, 1456569614, 0, 'SESSION_CLIENT_BROWSER|s:7:"Mozilla";language|s:2:"pl";'),
('b5c818ed74512a0c216bc2c47217ed75', 'CMS', '2016-02-13 11:41:43', NULL, 1456573303, 0, 'SESSION_CLIENT_BROWSER|s:79:"Mozilla/5.0 (compatible; MJ12bot/v1.4.5; http://www.majestic12.co.uk/bot.php?+)";language|s:2:"pl";'),
('6805b6ac5e5d3c95769503326c3de4f7', 'CMS', '2016-02-13 16:41:39', NULL, 1456591299, 0, 'SESSION_CLIENT_BROWSER|s:72:"Mozilla/5.0 (Windows NT 6.1; WOW64; rv:40.0) Gecko/20100101 Firefox/40.0";language|s:2:"pl";'),
('a342e53f296ec712823cd5fb31188401', 'CMS', '2016-02-13 21:18:09', NULL, 1456607889, 0, 'SESSION_CLIENT_BROWSER|s:72:"Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)";language|s:2:"pl";'),
('56360570a1881927aa1d85125f69e7bf', 'CMS', '2016-02-14 00:23:01', NULL, 1456618981, 0, 'SESSION_CLIENT_BROWSER|s:71:"Mozilla/5.0 (compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm)";language|s:2:"pl";'),
('e6ee01fbda291416b099658181595fe6', 'CMS', '2016-02-14 00:23:06', NULL, 1456618986, 0, 'SESSION_CLIENT_BROWSER|s:71:"Mozilla/5.0 (compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm)";language|s:2:"pl";'),
('1bbdbda9203a05657bc11746918c9852', 'CMS', '2016-02-14 00:52:35', NULL, 1456620755, 0, 'SESSION_CLIENT_BROWSER|s:79:"Mozilla/5.0 (compatible; MJ12bot/v1.4.5; http://www.majestic12.co.uk/bot.php?+)";language|s:2:"pl";'),
('28b183c03dfe5dac9df8256e507854fc', 'CMS', '2016-02-14 02:53:22', NULL, 1456628002, 0, 'SESSION_CLIENT_BROWSER|b:0;language|s:2:"pl";'),
('6f823cdb318df0a5e562b7552df35656', 'CMS', '2016-02-14 02:53:23', NULL, 1456628003, 0, 'SESSION_CLIENT_BROWSER|b:0;language|s:2:"pl";msg|O:8:"Messages":1:{s:19:"\0Messages\0_messages";a:0:{}}'),
('38806aa010de92b7a5bf762bc2963dc4', 'CMS', '2016-02-14 02:53:23', NULL, 1456628003, 0, 'SESSION_CLIENT_BROWSER|b:0;language|s:2:"pl";'),
('d48e439e0902a595c6d2c8e1d5593d7d', 'CMS', '2016-02-14 03:09:17', NULL, 1456628957, 0, 'SESSION_CLIENT_BROWSER|b:0;language|s:2:"pl";'),
('3c5567c53b881993cf21166f7d32906e', 'CMS', '2016-02-14 03:59:56', NULL, 1456631996, 0, 'SESSION_CLIENT_BROWSER|s:71:"Mozilla/5.0 (compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm)";language|s:2:"pl";msg|O:8:"Messages":1:{s:19:"\0Messages\0_messages";a:0:{}}'),
('d4d136ea3efeb2a65a773422053ac510', 'CMS', '2016-02-14 03:59:58', NULL, 1456631998, 0, 'SESSION_CLIENT_BROWSER|s:71:"Mozilla/5.0 (compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm)";language|s:2:"pl";'),
('d00db50e0750f8835cbf4e35dbc5a2cd', 'CMS', '2016-02-14 07:56:54', NULL, 1456646214, 0, 'SESSION_CLIENT_BROWSER|s:72:"Mozilla/5.0 (Windows NT 6.1; WOW64; rv:23.0) Gecko/20100101 Firefox/23.0";language|s:2:"pl";'),
('dc5b71d16813be3333bcb0aab8602360', 'CMS', '2016-02-14 08:30:42', NULL, 1456648242, 0, 'SESSION_CLIENT_BROWSER|s:71:"Mozilla/5.0 (compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm)";language|s:2:"pl";'),
('1f8861dd735b8a7fec4f17e039dff860', 'CMS', '2016-02-14 10:41:41', NULL, 1456656101, 0, 'SESSION_CLIENT_BROWSER|s:87:"BlackBerry9000/4.6.0.167 Profile/MIDP-2.0 Configuration/CLDC-1.1 VendorID/102 ips-agent";language|s:2:"pl";'),
('ebd8844b87fea74b679ebb7e544b7605', 'CMS', '2016-02-14 10:41:45', NULL, 1456656105, 0, 'SESSION_CLIENT_BROWSER|s:87:"BlackBerry9000/4.6.0.167 Profile/MIDP-2.0 Configuration/CLDC-1.1 VendorID/102 ips-agent";language|s:2:"pl";'),
('7039568f45a4ad668f70aedc488e82a3', 'CMS', '2016-02-14 10:41:48', NULL, 1456656108, 0, 'SESSION_CLIENT_BROWSER|s:87:"Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:14.0; ips-agent) Gecko/20100101 Firefox/14.0.1";language|s:2:"pl";'),
('8756b8f88aeb192e5be5714d6b7238ab', 'CMS', '2016-02-14 10:41:51', NULL, 1456656111, 0, 'SESSION_CLIENT_BROWSER|s:87:"Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:14.0; ips-agent) Gecko/20100101 Firefox/14.0.1";language|s:2:"pl";'),
('de9f28a798ca56e90ba54035f24bb6f4', 'CMS', '2016-02-14 10:41:53', NULL, 1456656113, 0, 'SESSION_CLIENT_BROWSER|s:87:"Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:14.0; ips-agent) Gecko/20100101 Firefox/14.0.1";language|s:2:"pl";'),
('8085796b1c563560db7d342d34e2a83b', 'CMS', '2016-02-14 10:41:55', NULL, 1456656115, 0, 'SESSION_CLIENT_BROWSER|s:87:"Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:14.0; ips-agent) Gecko/20100101 Firefox/14.0.1";language|s:2:"pl";'),
('52208c343cb33b199030109b23a89b63', 'CMS', '2016-02-14 11:16:44', NULL, 1456658204, 0, 'SESSION_CLIENT_BROWSER|s:79:"Mozilla/5.0 (compatible; MJ12bot/v1.4.5; http://www.majestic12.co.uk/bot.php?+)";language|s:2:"pl";'),
('98a4fe0dda8b70487b743a855aab65c9', 'CMS', '2016-02-14 11:16:45', NULL, 1456658205, 0, 'SESSION_CLIENT_BROWSER|s:79:"Mozilla/5.0 (compatible; MJ12bot/v1.4.5; http://www.majestic12.co.uk/bot.php?+)";language|s:2:"pl";'),
('1f91748fe0fc3df61d11dd2f5311af22', 'CMS', '2016-02-14 11:16:47', NULL, 1456658207, 0, 'SESSION_CLIENT_BROWSER|s:79:"Mozilla/5.0 (compatible; MJ12bot/v1.4.5; http://www.majestic12.co.uk/bot.php?+)";language|s:2:"pl";'),
('d76e93b8c8dd8693ac108bb303577bb6', 'CMS', '2016-02-14 13:58:21', NULL, 1456667901, 0, 'SESSION_CLIENT_BROWSER|s:79:"Mozilla/5.0 (compatible; MJ12bot/v1.4.5; http://www.majestic12.co.uk/bot.php?+)";language|s:2:"pl";'),
('42356789f3a882c13d06233eeb2497ca', 'CMS', '2016-02-14 16:05:09', NULL, 1456675509, 0, 'SESSION_CLIENT_BROWSER|s:72:"Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)";language|s:2:"pl";'),
('5e65e7fb384ef434509f57a5587b5d1e', 'CMS', '2016-02-14 18:41:26', NULL, 1456684886, 0, 'SESSION_CLIENT_BROWSER|s:50:"Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 5.2)";language|s:2:"pl";'),
('af8c9a51cb1b9404f319e6c1262b45b0', 'CMS', '2016-02-14 20:26:35', NULL, 1456691195, 0, 'SESSION_CLIENT_BROWSER|s:71:"Mozilla/5.0 (compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm)";language|s:2:"pl";'),
('2085911daf00503954b891faf23eb37f', 'CMS', '2016-02-14 21:03:08', NULL, 1456693388, 0, 'SESSION_CLIENT_BROWSER|s:64:"Mozilla/5.0 (compatible; YandexBot/3.0; +http://yandex.com/bots)";language|s:2:"pl";'),
('0d89e07935abf6b05bbdd09f907010b6', 'CMS', '2016-02-14 21:03:12', NULL, 1456693392, 0, 'SESSION_CLIENT_BROWSER|s:64:"Mozilla/5.0 (compatible; YandexBot/3.0; +http://yandex.com/bots)";language|s:2:"pl";'),
('a0069c0215afc654bbdf3aa9843bfbc1', 'CMS', '2016-02-14 21:17:42', NULL, 1456694262, 0, 'SESSION_CLIENT_BROWSER|s:79:"Mozilla/5.0 (compatible; MJ12bot/v1.4.5; http://www.majestic12.co.uk/bot.php?+)";language|s:2:"pl";'),
('71a7f92d17ffc4faa0a32578a668130d', 'CMS', '2016-02-15 09:59:26', NULL, 1456739966, 0, 'SESSION_CLIENT_BROWSER|s:71:"Mozilla/5.0 (compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm)";language|s:2:"pl";msg|O:8:"Messages":1:{s:19:"\0Messages\0_messages";a:0:{}}'),
('9b3d41c0a97de3a4c55fea3c1dbc47d3', 'CMS', '2016-02-15 00:57:35', NULL, 1456707455, 0, 'SESSION_CLIENT_BROWSER|s:83:"Mozilla/5.0 (compatible; Yahoo! Slurp; http://help.yahoo.com/help/us/ysearch/slurp)";language|s:2:"pl";'),
('a567cd6afbf8a552657ee8ebad1fcd7a', 'CMS', '2016-02-15 03:23:20', NULL, 1456716200, 0, 'SESSION_CLIENT_BROWSER|b:0;language|s:2:"pl";'),
('884834e7ed4999e31135a8853e62bb58', 'CMS', '2016-02-15 05:59:04', NULL, 1456725544, 0, 'SESSION_CLIENT_BROWSER|s:69:"Mozilla/5.0 (compatible; Exabot/3.0; +http://www.exabot.com/go/robot)";language|s:2:"pl";msg|O:8:"Messages":1:{s:19:"\0Messages\0_messages";a:0:{}}'),
('baa145389aebcfa0329861475bb09ae1', 'CMS', '2016-02-15 05:59:07', NULL, 1456725547, 0, 'SESSION_CLIENT_BROWSER|s:69:"Mozilla/5.0 (compatible; Exabot/3.0; +http://www.exabot.com/go/robot)";language|s:2:"pl";'),
('3e2bdd22dcbf7f4d7cab87de52ef199a', 'CMS', '2016-02-15 05:59:48', NULL, 1456725588, 0, 'SESSION_CLIENT_BROWSER|s:69:"Mozilla/5.0 (compatible; Exabot/3.0; +http://www.exabot.com/go/robot)";language|s:2:"pl";'),
('5e048b82eab9fa7e6129a9b513df6d11', 'CMS', '2016-02-15 07:18:50', NULL, 1456730330, 0, 'SESSION_CLIENT_BROWSER|s:72:"Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)";language|s:2:"pl";'),
('528a4a4196891750987b968c9ba8ad96', 'CMS', '2016-02-16 15:26:21', NULL, 1456845981, 0, 'SESSION_CLIENT_BROWSER|s:71:"Mozilla/5.0 (compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm)";language|s:2:"pl";'),
('7bd50d70261442e1e3937347edee5a8f', 'CMS', '2016-02-16 08:15:22', NULL, 1456820122, 0, 'SESSION_CLIENT_BROWSER|s:79:"Mozilla/5.0 (compatible; MJ12bot/v1.4.5; http://www.majestic12.co.uk/bot.php?+)";language|s:2:"pl";'),
('57081dc2bbc7bbfb71e2de1ad023d43a', 'CMS', '2016-02-16 02:42:26', NULL, 1456800146, 0, 'SESSION_CLIENT_BROWSER|s:71:"Mozilla/5.0 (compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm)";language|s:2:"pl";msg|O:8:"Messages":1:{s:19:"\0Messages\0_messages";a:0:{}}'),
('52e0b6de7300bd65b4a445f20d2fc0b0', 'CMS', '2016-02-16 02:42:28', NULL, 1456800148, 0, 'SESSION_CLIENT_BROWSER|s:71:"Mozilla/5.0 (compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm)";language|s:2:"pl";'),
('49459b2f9f5140fb2233f5666f1d5ce0', 'CMS', '2016-02-16 03:22:55', NULL, 1456802575, 0, 'SESSION_CLIENT_BROWSER|b:0;language|s:2:"pl";'),
('b73a95e93dbdf179a0f3a216c69c2640', 'CMS', '2016-02-16 03:35:32', NULL, 1456803332, 0, 'SESSION_CLIENT_BROWSER|s:71:"Mozilla/5.0 (compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm)";language|s:2:"pl";'),
('20960aa5c97d9905b2053c4ec35f63ad', 'CMS', '2016-02-16 07:19:25', NULL, 1456816765, 0, 'SESSION_CLIENT_BROWSER|s:109:"Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/48.0.2564.109 Safari/537.36";language|s:2:"pl";'),
('2812b4a86f00fb83f78b3354f97cac66', 'CMS', '2016-02-16 09:12:18', NULL, 1456823538, 0, 'SESSION_CLIENT_BROWSER|s:137:"Mozilla/5.0 (Windows; U; Windows NT 5.1; en; rv:1.9.0.13) Gecko/2009073022 Firefox/3.5.2 (.NET CLR 3.5.30729) SurveyBot/2.3 (DomainTools)";language|s:2:"pl";'),
('95794ab00ee4732d9e6b120513164211', 'CMS', '2016-02-16 11:33:27', NULL, 1456832007, 0, 'SESSION_CLIENT_BROWSER|s:109:"Mozilla/5.0 (Windows NT 6.2; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/48.0.2564.103 Safari/537.36";language|s:2:"pl";'),
('476dc7153d38f18339fa6e3e80fa8eaf', 'CMS', '2016-02-16 14:33:21', NULL, 1456842801, 0, 'SESSION_CLIENT_BROWSER|s:114:"Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/48.0.2564.109 Safari/537.36";language|s:2:"pl";'),
('d3e0e8bbad33930335b0c5e0048e4fc2', 'CMS', '2016-02-16 11:56:51', NULL, 1456833411, 0, 'SESSION_CLIENT_BROWSER|s:149:"Mozilla/5.0 (Linux; Android 4.4.2; LG-D722 Build/KOT49I.A1423200729) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/36.0.1985.135 Mobile Safari/537.36";language|s:2:"pl";'),
('c41450233457f6562a590868eff15a58', 'CMS', '2016-02-16 12:23:46', NULL, 1456835026, 0, 'SESSION_CLIENT_BROWSER|s:120:"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/39.0.2171.65 Safari/537.36";language|s:2:"pl";'),
('a3f961d300f24856573bfcf396a05b68', 'CMS', '2016-02-16 12:22:46', NULL, 1456834966, 0, 'SESSION_CLIENT_BROWSER|s:113:"Mozilla/5.0 (X11; Fedora; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/48.0.2564.109 Safari/537.36";language|s:2:"pl";'),
('12c3768a5134614d40582a0b65da2d42', 'CMS', '2016-02-16 14:19:36', NULL, 1456841976, 0, 'SESSION_CLIENT_BROWSER|s:71:"Mozilla/5.0 (compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm)";language|s:2:"pl";msg|O:8:"Messages":1:{s:19:"\0Messages\0_messages";a:0:{}}'),
('6c4692b9c9a1e4ae3ba617ad5391a1e9', 'CMS', '2016-02-16 15:44:53', NULL, 1456847093, 0, 'SESSION_CLIENT_BROWSER|s:66:"Mozilla/5.0 (compatible; AhrefsBot/5.0; +http://ahrefs.com/robot/)";language|s:2:"pl";msg|O:8:"Messages":1:{s:19:"\0Messages\0_messages";a:0:{}}'),
('d8c2c48108eaca5fd97e7d4a6a259c5e', 'CMS', '2016-02-16 18:35:32', NULL, 1456857332, 0, 'SESSION_CLIENT_BROWSER|s:79:"Mozilla/5.0 (compatible; MJ12bot/v1.4.5; http://www.majestic12.co.uk/bot.php?+)";language|s:2:"pl";'),
('66db76853629966024463b1a8faf2c73', 'CMS', '2016-02-16 19:23:45', NULL, 1456860225, 0, 'SESSION_CLIENT_BROWSER|s:71:"Mozilla/5.0 (compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm)";language|s:2:"pl";msg|O:8:"Messages":1:{s:19:"\0Messages\0_messages";a:0:{}}'),
('5abb7644ffaacb55b41d2cf8a33a9604', 'CMS', '2016-02-16 22:36:45', NULL, 1456871805, 0, 'SESSION_CLIENT_BROWSER|s:165:"Mozilla/5.0 (Windows Phone 10.0; Android 4.2.1; Microsoft; Lumia 950 XL) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/46.0.2486.0 Mobile Safari/537.36 Edge/13.10586";language|s:2:"pl";'),
('6777c9c546a8563b8fc3aebb5698296f', 'CMS', '2016-02-17 02:44:44', NULL, 1456886684, 0, 'SESSION_CLIENT_BROWSER|s:72:"Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)";language|s:2:"pl";'),
('8483f5c05cd178cd1bb258b517cb7472', 'CMS', '2016-02-17 02:53:01', NULL, 1456887181, 0, 'SESSION_CLIENT_BROWSER|s:71:"Mozilla/5.0 (compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm)";language|s:2:"pl";msg|O:8:"Messages":1:{s:19:"\0Messages\0_messages";a:0:{}}'),
('c5e47a0fbcc2066b70486e31323948cf', 'CMS', '2016-02-17 02:53:26', NULL, 1456887206, 0, 'SESSION_CLIENT_BROWSER|s:71:"Mozilla/5.0 (compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm)";language|s:2:"pl";'),
('e639956139728e2d617a62ab8312b940', 'CMS', '2016-02-17 03:02:58', NULL, 1456887778, 0, 'SESSION_CLIENT_BROWSER|s:71:"Mozilla/5.0 (compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm)";language|s:2:"pl";msg|O:8:"Messages":1:{s:19:"\0Messages\0_messages";a:0:{}}'),
('81f02309ec843cb871f729b457271903', 'CMS', '2016-02-17 03:03:00', NULL, 1456887780, 0, 'SESSION_CLIENT_BROWSER|s:71:"Mozilla/5.0 (compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm)";language|s:2:"pl";'),
('fa66891f1417594904aa2ff5947c85ef', 'CMS', '2016-02-17 03:21:55', NULL, 1456888915, 0, 'SESSION_CLIENT_BROWSER|s:71:"Mozilla/5.0 (compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm)";language|s:2:"pl";'),
('9e9bd322bc42613971739b94cc87f136', 'CMS', '2016-02-17 03:23:52', NULL, 1456889032, 0, 'SESSION_CLIENT_BROWSER|s:89:"Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.9) Gecko/20100915 Gentoo Firefox/3.6.9";language|s:2:"pl";'),
('39100271614aba24c6db786c3e09b776', 'CMS', '2016-02-17 03:24:11', NULL, 1456889051, 0, 'SESSION_CLIENT_BROWSER|b:0;language|s:2:"pl";'),
('d634e9e86aba48b1fe555caf9ebbf8cc', 'CMS', '2016-02-17 05:16:14', NULL, 1456895774, 0, 'SESSION_CLIENT_BROWSER|s:46:"SafeDNSBot (https://www.safedns.com/searchbot)";language|s:2:"pl";'),
('732bf7c885b99ae039243a00adb821b3', 'CMS', '2016-02-17 06:09:33', NULL, 1456898973, 0, 'SESSION_CLIENT_BROWSER|s:71:"Mozilla/5.0 (compatible; oBot/2.3.1; +http://filterdb.iss.net/crawler/)";language|s:2:"pl";'),
('964334375d5fc45200a482a363811ad9', 'CMS', '2016-02-17 06:09:42', NULL, 1456898982, 0, 'SESSION_CLIENT_BROWSER|s:71:"Mozilla/5.0 (compatible; oBot/2.3.1; +http://filterdb.iss.net/crawler/)";language|s:2:"pl";msg|O:8:"Messages":1:{s:19:"\0Messages\0_messages";a:0:{}}'),
('a967fc44bed545dea9b6e4d9199235ac', 'CMS', '2016-02-17 06:09:43', NULL, 1456898983, 0, 'SESSION_CLIENT_BROWSER|s:71:"Mozilla/5.0 (compatible; oBot/2.3.1; +http://filterdb.iss.net/crawler/)";language|s:2:"pl";'),
('01f910769c88eda99f3941b37992e275', 'CMS', '2016-02-17 06:09:45', NULL, 1456898985, 0, 'SESSION_CLIENT_BROWSER|s:71:"Mozilla/5.0 (compatible; oBot/2.3.1; +http://filterdb.iss.net/crawler/)";language|s:2:"pl";msg|O:8:"Messages":1:{s:19:"\0Messages\0_messages";a:0:{}}'),
('a480fbc0801735d53d0ed0bde1380c17', 'CMS', '2016-02-17 06:09:45', NULL, 1456898985, 0, 'SESSION_CLIENT_BROWSER|s:71:"Mozilla/5.0 (compatible; oBot/2.3.1; +http://filterdb.iss.net/crawler/)";language|s:2:"pl";'),
('7722a27a1097c74e3efb0cc4f12d2bdc', 'CMS', '2016-02-17 06:09:46', NULL, 1456898986, 0, 'SESSION_CLIENT_BROWSER|s:71:"Mozilla/5.0 (compatible; oBot/2.3.1; +http://filterdb.iss.net/crawler/)";language|s:2:"pl";msg|O:8:"Messages":1:{s:19:"\0Messages\0_messages";a:0:{}}'),
('12c44c6babcc7d387cf057f69834047e', 'CMS', '2016-02-17 06:09:46', NULL, 1456898986, 0, 'SESSION_CLIENT_BROWSER|s:71:"Mozilla/5.0 (compatible; oBot/2.3.1; +http://filterdb.iss.net/crawler/)";language|s:2:"pl";'),
('6478590463b31117041063713a1930a1', 'CMS', '2016-02-17 06:09:47', NULL, 1456898987, 0, 'SESSION_CLIENT_BROWSER|s:71:"Mozilla/5.0 (compatible; oBot/2.3.1; +http://filterdb.iss.net/crawler/)";language|s:2:"pl";msg|O:8:"Messages":1:{s:19:"\0Messages\0_messages";a:0:{}}'),
('702805e0edbc3bfc21b201d97f862532', 'CMS', '2016-02-17 06:09:48', NULL, 1456898988, 0, 'SESSION_CLIENT_BROWSER|s:71:"Mozilla/5.0 (compatible; oBot/2.3.1; +http://filterdb.iss.net/crawler/)";language|s:2:"pl";'),
('2af8ca037086c33fc65adf113f91f60d', 'CMS', '2016-02-17 06:09:49', NULL, 1456898989, 0, 'SESSION_CLIENT_BROWSER|s:71:"Mozilla/5.0 (compatible; oBot/2.3.1; +http://filterdb.iss.net/crawler/)";language|s:2:"pl";msg|O:8:"Messages":1:{s:19:"\0Messages\0_messages";a:0:{}}'),
('9ba0135735c8cf18d01e0185e65eb7b4', 'CMS', '2016-02-17 06:09:49', NULL, 1456898989, 0, 'SESSION_CLIENT_BROWSER|s:71:"Mozilla/5.0 (compatible; oBot/2.3.1; +http://filterdb.iss.net/crawler/)";language|s:2:"pl";'),
('2b8e8f26ab2136132089fce882972511', 'CMS', '2016-02-17 06:09:51', NULL, 1456898991, 0, 'SESSION_CLIENT_BROWSER|s:71:"Mozilla/5.0 (compatible; oBot/2.3.1; +http://filterdb.iss.net/crawler/)";language|s:2:"pl";msg|O:8:"Messages":1:{s:19:"\0Messages\0_messages";a:0:{}}'),
('16776cf6a16c9fd8a6074b8c7fc92065', 'CMS', '2016-02-17 06:09:51', NULL, 1456898991, 0, 'SESSION_CLIENT_BROWSER|s:71:"Mozilla/5.0 (compatible; oBot/2.3.1; +http://filterdb.iss.net/crawler/)";language|s:2:"pl";'),
('23ce8083311d5f1a6c1a194ef30db628', 'CMS', '2016-02-17 06:09:52', NULL, 1456898992, 0, 'SESSION_CLIENT_BROWSER|s:71:"Mozilla/5.0 (compatible; oBot/2.3.1; +http://filterdb.iss.net/crawler/)";language|s:2:"pl";msg|O:8:"Messages":1:{s:19:"\0Messages\0_messages";a:0:{}}'),
('037cea8c7b59f5f2c2f57f4f00a36777', 'CMS', '2016-02-17 06:09:52', NULL, 1456898992, 0, 'SESSION_CLIENT_BROWSER|s:71:"Mozilla/5.0 (compatible; oBot/2.3.1; +http://filterdb.iss.net/crawler/)";language|s:2:"pl";'),
('f47d5457b05ac56f3bdfe72ba62dbfab', 'CMS', '2016-02-17 06:09:53', NULL, 1456898993, 0, 'SESSION_CLIENT_BROWSER|s:71:"Mozilla/5.0 (compatible; oBot/2.3.1; +http://filterdb.iss.net/crawler/)";language|s:2:"pl";msg|O:8:"Messages":1:{s:19:"\0Messages\0_messages";a:0:{}}'),
('1dffa2842cf475d0f7f5b0956d2279e9', 'CMS', '2016-02-17 06:09:53', NULL, 1456898993, 0, 'SESSION_CLIENT_BROWSER|s:71:"Mozilla/5.0 (compatible; oBot/2.3.1; +http://filterdb.iss.net/crawler/)";language|s:2:"pl";'),
('6e55af3227d981b630b1806aa71a555a', 'CMS', '2016-02-18 02:30:19', NULL, 1456972219, 0, 'SESSION_CLIENT_BROWSER|s:71:"Mozilla/5.0 (compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm)";language|s:2:"pl";msg|O:8:"Messages":1:{s:19:"\0Messages\0_messages";a:0:{}}'),
('307ebd602bf3ab6b08ddbb7028ae42f0', 'CMS', '2016-02-18 02:30:21', NULL, 1456972221, 0, 'SESSION_CLIENT_BROWSER|s:71:"Mozilla/5.0 (compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm)";language|s:2:"pl";'),
('919743e19bdb28c09802d07575261d71', 'CMS', '2016-02-18 02:33:06', NULL, 1456972386, 0, 'SESSION_CLIENT_BROWSER|s:71:"Mozilla/5.0 (compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm)";language|s:2:"pl";msg|O:8:"Messages":1:{s:19:"\0Messages\0_messages";a:0:{}}'),
('f27abd8ea3718f17bf7c521a03bc5752', 'CMS', '2016-02-18 02:33:07', NULL, 1456972387, 0, 'SESSION_CLIENT_BROWSER|s:71:"Mozilla/5.0 (compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm)";language|s:2:"pl";'),
('43a682fbf03fd24a956083bb14a80bcb', 'CMS', '2016-02-18 02:33:36', NULL, 1456972416, 0, 'SESSION_CLIENT_BROWSER|s:71:"Mozilla/5.0 (compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm)";language|s:2:"pl";msg|O:8:"Messages":1:{s:19:"\0Messages\0_messages";a:0:{}}'),
('d546a4b01d9c7b50e4288a4076513466', 'CMS', '2016-02-18 02:33:37', NULL, 1456972417, 0, 'SESSION_CLIENT_BROWSER|s:71:"Mozilla/5.0 (compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm)";language|s:2:"pl";'),
('c5fbb701f552ecab2030d6503d74d479', 'CMS', '2016-02-18 02:36:43', NULL, 1456972603, 0, 'SESSION_CLIENT_BROWSER|s:71:"Mozilla/5.0 (compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm)";language|s:2:"pl";msg|O:8:"Messages":1:{s:19:"\0Messages\0_messages";a:0:{}}'),
('1f06297b758cb64b966a1e97a7906918', 'CMS', '2016-02-18 02:36:43', NULL, 1456972603, 0, 'SESSION_CLIENT_BROWSER|s:71:"Mozilla/5.0 (compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm)";language|s:2:"pl";'),
('17afd4f332033476e02126a167ced112', 'CMS', '2016-02-18 02:42:33', NULL, 1456972953, 0, 'SESSION_CLIENT_BROWSER|s:71:"Mozilla/5.0 (compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm)";language|s:2:"pl";msg|O:8:"Messages":1:{s:19:"\0Messages\0_messages";a:0:{}}'),
('fb667e84aaa2daa6b7cccc419fc82e52', 'CMS', '2016-02-18 02:42:34', NULL, 1456972954, 0, 'SESSION_CLIENT_BROWSER|s:71:"Mozilla/5.0 (compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm)";language|s:2:"pl";'),
('5382ddaf879a836e3cc2e91addbabde3', 'CMS', '2016-02-18 02:55:30', NULL, 1456973730, 0, 'SESSION_CLIENT_BROWSER|s:71:"Mozilla/5.0 (compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm)";language|s:2:"pl";'),
('ce3f62b459b1790a3fa4fb06ac28d6b5', 'CMS', '2016-02-18 03:23:50', NULL, 1456975430, 0, 'SESSION_CLIENT_BROWSER|b:0;language|s:2:"pl";'),
('158dde03e22663b9a4b54ca2be3a7433', 'CMS', '2016-02-18 05:29:51', NULL, 1456982991, 0, 'SESSION_CLIENT_BROWSER|s:69:"Mozilla/5.0 (compatible; Exabot/3.0; +http://www.exabot.com/go/robot)";language|s:2:"pl";msg|O:8:"Messages":1:{s:19:"\0Messages\0_messages";a:0:{}}'),
('3f3af8c5b2b1efc9a56df0f6a675b8f8', 'CMS', '2016-02-18 08:30:27', NULL, 1456993827, 0, 'SESSION_CLIENT_BROWSER|s:79:"Mozilla/5.0 (compatible; MJ12bot/v1.4.5; http://www.majestic12.co.uk/bot.php?+)";language|s:2:"pl";'),
('339de407c76238941423ed7fc66233ce', 'CMS', '2016-02-18 08:30:29', NULL, 1456993829, 0, 'SESSION_CLIENT_BROWSER|s:79:"Mozilla/5.0 (compatible; MJ12bot/v1.4.5; http://www.majestic12.co.uk/bot.php?+)";language|s:2:"pl";'),
('ed9a0e6c6745c11a1f542b43a589b67d', 'CMS', '2016-02-18 08:30:31', NULL, 1456993831, 0, 'SESSION_CLIENT_BROWSER|s:79:"Mozilla/5.0 (compatible; MJ12bot/v1.4.5; http://www.majestic12.co.uk/bot.php?+)";language|s:2:"pl";msg|O:8:"Messages":1:{s:19:"\0Messages\0_messages";a:0:{}}'),
('e961e913884097f4191be40c9823386e', 'CMS', '2016-02-18 08:30:34', NULL, 1456993834, 0, 'SESSION_CLIENT_BROWSER|s:79:"Mozilla/5.0 (compatible; MJ12bot/v1.4.5; http://www.majestic12.co.uk/bot.php?+)";language|s:2:"pl";'),
('e8cfb81831c50f7d0be7a3d982a7986e', 'CMS', '2016-02-18 08:30:35', NULL, 1456993835, 0, 'SESSION_CLIENT_BROWSER|s:79:"Mozilla/5.0 (compatible; MJ12bot/v1.4.5; http://www.majestic12.co.uk/bot.php?+)";language|s:2:"pl";'),
('4427f81cff9e1df7e396ce10d206710f', 'CMS', '2016-02-18 09:24:44', NULL, 1456997084, 0, 'SESSION_CLIENT_BROWSER|s:79:"Mozilla/5.0 (compatible; MJ12bot/v1.4.5; http://www.majestic12.co.uk/bot.php?+)";language|s:2:"pl";'),
('5b448ee973ea5c79bb9835fe20b1bb02', 'CMS', '2016-02-18 09:50:19', NULL, 1456998619, 0, 'SESSION_CLIENT_BROWSER|s:72:"Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)";language|s:2:"pl";'),
('2f0e75bc11728a19a0fccbb18f7a4a54', 'CMS', '2016-02-18 10:34:39', NULL, 1457001279, 0, 'SESSION_CLIENT_BROWSER|s:66:"Mozilla/5.0 (compatible; AhrefsBot/5.0; +http://ahrefs.com/robot/)";language|s:2:"pl";msg|O:8:"Messages":1:{s:19:"\0Messages\0_messages";a:0:{}}'),
('a8bdb8be74bbe86497150e83238ba4dd', 'CMS', '2016-02-18 09:54:18', NULL, 1456998858, 0, 'SESSION_CLIENT_BROWSER|s:72:"Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)";language|s:2:"pl";'),
('a7fe5b327da9b87c69b208e7a0804da1', 'CMS', '2016-02-18 10:55:03', NULL, 1457002503, 0, 'SESSION_CLIENT_BROWSER|s:71:"Mozilla/5.0 (compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm)";language|s:2:"pl";msg|O:8:"Messages":1:{s:19:"\0Messages\0_messages";a:0:{}}'),
('d56dfa4c1b446cc44b94fbea3eb37e12', 'CMS', '2016-02-19 01:38:23', NULL, 1457055503, 0, 'SESSION_CLIENT_BROWSER|s:46:"SafeDNSBot (https://www.safedns.com/searchbot)";language|s:2:"pl";'),
('435bd65c5e74c253d2cec4e0a58c2702', 'CMS', '2016-02-19 01:45:50', NULL, 1457055950, 0, 'SESSION_CLIENT_BROWSER|s:46:"SafeDNSBot (https://www.safedns.com/searchbot)";language|s:2:"pl";'),
('53b67c748bb75b8cd1d98e6e54ea47d7', 'CMS', '2016-02-19 02:23:34', NULL, 1457058214, 0, 'SESSION_CLIENT_BROWSER|s:71:"Mozilla/5.0 (compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm)";language|s:2:"pl";msg|O:8:"Messages":1:{s:19:"\0Messages\0_messages";a:0:{}}'),
('2285b950f2d838bcb1b5f4fc9ef873e8', 'CMS', '2016-02-19 02:23:37', NULL, 1457058217, 0, 'SESSION_CLIENT_BROWSER|s:71:"Mozilla/5.0 (compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm)";language|s:2:"pl";'),
('422b79240784b41737517bde50ad14ac', 'CMS', '2016-02-19 02:36:43', NULL, 1457059003, 0, 'SESSION_CLIENT_BROWSER|s:66:"Mozilla/5.0 (compatible; AhrefsBot/5.0; +http://ahrefs.com/robot/)";language|s:2:"pl";msg|O:8:"Messages":1:{s:19:"\0Messages\0_messages";a:0:{}}'),
('babc084e1fb8803ae50d1961821c10ae', 'CMS', '2016-02-19 02:42:17', NULL, 1457059337, 0, 'SESSION_CLIENT_BROWSER|s:66:"Mozilla/5.0 (compatible; AhrefsBot/5.0; +http://ahrefs.com/robot/)";language|s:2:"pl";'),
('cef8574031e80217cd2f7fb937b2e44d', 'CMS', '2016-02-19 03:30:48', NULL, 1457062248, 0, 'SESSION_CLIENT_BROWSER|b:0;language|s:2:"pl";'),
('51483b90a1582bbae12c0d8978acd443', 'CMS', '2016-02-19 08:41:02', NULL, 1457080862, 0, 'SESSION_CLIENT_BROWSER|s:71:"Mozilla/5.0 (compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm)";language|s:2:"pl";'),
('46fc9c38b18e4f61c52dac890ff91a1e', 'CMS', '2016-02-19 07:53:39', NULL, 1457078019, 0, 'SESSION_CLIENT_BROWSER|s:72:"Mozilla/5.0 (Windows NT 6.1; WOW64; rv:44.0) Gecko/20100101 Firefox/44.0";language|s:2:"pl";mod_pages|a:1:{s:8:"language";s:2:"pl";}last_call|s:39:"http://badania-telefoniczne.pl/manager/";user_login_record_id|i:17;'),
('12458bb827d3e5df2927030267a082f7', 'CMS', '2016-02-19 08:52:30', NULL, 1457081550, 0, 'SESSION_CLIENT_BROWSER|s:79:"Mozilla/5.0 (compatible; MJ12bot/v1.4.5; http://www.majestic12.co.uk/bot.php?+)";language|s:2:"pl";'),
('98e48e6a548807b8ac28dab37842ffb6', 'CMS', '2016-02-19 10:28:09', NULL, 1457087289, 0, 'SESSION_CLIENT_BROWSER|s:105:"Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/37.0.2062.120 Safari/537.36";language|s:2:"pl";'),
('62a7781cf85428ed50eff0ef2c5d9612', 'CMS', '2016-02-19 16:30:10', NULL, 1457109010, 0, 'SESSION_CLIENT_BROWSER|s:71:"Mozilla/5.0 (compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm)";language|s:2:"pl";msg|O:8:"Messages":1:{s:19:"\0Messages\0_messages";a:0:{}}'),
('e9e05f8cf27d7dbbf19b6c4482806399', 'CMS', '2016-02-20 00:26:33', NULL, 1457137593, 0, 'SESSION_CLIENT_BROWSER|s:66:"Mozilla/5.0 (compatible; AhrefsBot/5.0; +http://ahrefs.com/robot/)";language|s:2:"pl";msg|O:8:"Messages":1:{s:19:"\0Messages\0_messages";a:0:{}}'),
('8afd3257d84f5b211488a84136272a50', 'CMS', '2016-02-20 00:43:28', NULL, 1457138608, 0, 'SESSION_CLIENT_BROWSER|s:79:"Mozilla/5.0 (compatible; MJ12bot/v1.4.5; http://www.majestic12.co.uk/bot.php?+)";language|s:2:"pl";'),
('88ce056c4498899935b6e1ed573b6c58', 'CMS', '2016-02-20 02:15:03', NULL, 1457144103, 0, 'SESSION_CLIENT_BROWSER|s:79:"Mozilla/5.0 (compatible; MJ12bot/v1.4.5; http://www.majestic12.co.uk/bot.php?+)";language|s:2:"pl";'),
('b37da9609b8adbd4bf661de39a6f89da', 'CMS', '2016-02-20 02:29:09', NULL, 1457144949, 0, 'SESSION_CLIENT_BROWSER|s:71:"Mozilla/5.0 (compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm)";language|s:2:"pl";msg|O:8:"Messages":1:{s:19:"\0Messages\0_messages";a:0:{}}'),
('6fcce29b3cc208c7e2c5e5a3fc16e851', 'CMS', '2016-02-20 02:40:16', NULL, 1457145616, 0, 'SESSION_CLIENT_BROWSER|s:71:"Mozilla/5.0 (compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm)";language|s:2:"pl";msg|O:8:"Messages":1:{s:19:"\0Messages\0_messages";a:0:{}}'),
('ef5f3f019885a598c7ba1c9c39b0e8d0', 'CMS', '2016-02-20 02:40:46', NULL, 1457145646, 0, 'SESSION_CLIENT_BROWSER|s:71:"Mozilla/5.0 (compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm)";language|s:2:"pl";'),
('a93cafd2f2865ea0b7d682c1dd8aa2fc', 'CMS', '2016-02-20 02:42:45', NULL, 1457145765, 0, 'SESSION_CLIENT_BROWSER|s:71:"Mozilla/5.0 (compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm)";language|s:2:"pl";msg|O:8:"Messages":1:{s:19:"\0Messages\0_messages";a:0:{}}'),
('cae8f2aea1ed22136154ea59761c25d0', 'CMS', '2016-02-20 02:42:46', NULL, 1457145766, 0, 'SESSION_CLIENT_BROWSER|s:71:"Mozilla/5.0 (compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm)";language|s:2:"pl";'),
('e767eb82f0c503871ee7196ccbdb4418', 'CMS', '2016-02-20 02:44:47', NULL, 1457145887, 0, 'SESSION_CLIENT_BROWSER|s:72:"Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)";language|s:2:"pl";'),
('56b36dea92eaaec3174105eae87547ea', 'CMS', '2016-02-20 02:48:58', NULL, 1457146138, 0, 'SESSION_CLIENT_BROWSER|s:71:"Mozilla/5.0 (compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm)";language|s:2:"pl";msg|O:8:"Messages":1:{s:19:"\0Messages\0_messages";a:0:{}}'),
('4ca284348058e70198d6530ceb9b918d', 'CMS', '2016-02-20 02:49:07', NULL, 1457146147, 0, 'SESSION_CLIENT_BROWSER|s:71:"Mozilla/5.0 (compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm)";language|s:2:"pl";'),
('4ef31af776635f151d724315c0f26041', 'CMS', '2016-02-20 02:49:42', NULL, 1457146182, 0, 'SESSION_CLIENT_BROWSER|s:71:"Mozilla/5.0 (compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm)";language|s:2:"pl";msg|O:8:"Messages":1:{s:19:"\0Messages\0_messages";a:0:{}}'),
('dadd3533f11c3936816482b8fdff5ddf', 'CMS', '2016-02-20 02:49:44', NULL, 1457146184, 0, 'SESSION_CLIENT_BROWSER|s:71:"Mozilla/5.0 (compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm)";language|s:2:"pl";'),
('92551f195b9d727fc73161d28bc5dc60', 'CMS', '2016-02-20 02:55:13', NULL, 1457146513, 0, 'SESSION_CLIENT_BROWSER|s:71:"Mozilla/5.0 (compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm)";language|s:2:"pl";msg|O:8:"Messages":1:{s:19:"\0Messages\0_messages";a:0:{}}'),
('1bdc5e2cdfd5ee1b8283a9d5c37a5beb', 'CMS', '2016-02-20 02:55:14', NULL, 1457146514, 0, 'SESSION_CLIENT_BROWSER|s:71:"Mozilla/5.0 (compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm)";language|s:2:"pl";'),
('f7ea40d6c7dd5f555756bd28b707642b', 'CMS', '2016-02-20 02:55:22', NULL, 1457146522, 0, 'SESSION_CLIENT_BROWSER|s:71:"Mozilla/5.0 (compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm)";language|s:2:"pl";msg|O:8:"Messages":1:{s:19:"\0Messages\0_messages";a:0:{}}'),
('cf3bcc1897302199d10987b54886bf97', 'CMS', '2016-02-20 02:55:23', NULL, 1457146523, 0, 'SESSION_CLIENT_BROWSER|s:71:"Mozilla/5.0 (compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm)";language|s:2:"pl";'),
('367835f6bae38a2c35ad8c26af7303a1', 'CMS', '2016-02-20 02:58:46', NULL, 1457146726, 0, 'SESSION_CLIENT_BROWSER|s:71:"Mozilla/5.0 (compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm)";language|s:2:"pl";msg|O:8:"Messages":1:{s:19:"\0Messages\0_messages";a:0:{}}'),
('b5397428a8cb83949aec3f498dd190a6', 'CMS', '2016-02-20 02:58:47', NULL, 1457146727, 0, 'SESSION_CLIENT_BROWSER|s:71:"Mozilla/5.0 (compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm)";language|s:2:"pl";'),
('ed60776c6d4e1de048446e5d58a30c07', 'CMS', '2016-02-20 03:33:36', NULL, 1457148816, 0, 'SESSION_CLIENT_BROWSER|b:0;language|s:2:"pl";'),
('ac66ed9fd9fd8c8cae7d3ada185f3c42', 'CMS', '2016-02-20 07:22:49', NULL, 1457162569, 0, 'SESSION_CLIENT_BROWSER|s:65:"''Mozilla/5.0 (compatible; MSIE 9.0; Windows NT 6.1; Trident/5.0)''";language|s:2:"pl";'),
('b85d610b729f7ea0f2a90f2136373613', 'CMS', '2016-02-20 09:00:21', NULL, 1457168421, 0, 'SESSION_CLIENT_BROWSER|s:71:"Mozilla/5.0 (compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm)";language|s:2:"pl";'),
('b1031a5549f479506a54cc1f8f208d42', 'CMS', '2016-02-20 13:44:37', NULL, 1457185477, 0, 'SESSION_CLIENT_BROWSER|s:66:"Mozilla/5.0 (compatible; AhrefsBot/5.0; +http://ahrefs.com/robot/)";language|s:2:"pl";'),
('bbd138fec23b0a736210a1f089093c51', 'CMS', '2016-02-20 23:57:49', NULL, 1457222269, 0, 'SESSION_CLIENT_BROWSER|s:67:"Mozilla/5.0 (Windows NT 5.1; rv:6.0.2) Gecko/20100101 Firefox/6.0.2";language|s:2:"pl";'),
('504f6398681db58094ae288b7b26f6ee', 'CMS', '2016-02-21 01:10:36', NULL, 1457226636, 0, 'SESSION_CLIENT_BROWSER|s:71:"Mozilla/5.0 (compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm)";language|s:2:"pl";'),
('18b9067c3a606e4ad585189435dc86c6', 'CMS', '2016-02-21 01:10:48', NULL, 1457226648, 0, 'SESSION_CLIENT_BROWSER|s:195:"Mozilla/5.0 (iPhone; CPU iPhone OS 7_0 like Mac OS X) AppleWebKit/537.51.1 (KHTML, like Gecko) Version/7.0 Mobile/11A465 Safari/9537.53 (compatible; bingbot/2.0;  http://www.bing.com/bingbot.htm)";language|s:2:"pl";msg|O:8:"Messages":1:{s:19:"\0Messages\0_messages";a:0:{}}'),
('7e352084b308e26933ddc983cf42042d', 'CMS', '2016-02-21 01:11:15', NULL, 1457226675, 0, 'SESSION_CLIENT_BROWSER|s:195:"Mozilla/5.0 (iPhone; CPU iPhone OS 7_0 like Mac OS X) AppleWebKit/537.51.1 (KHTML, like Gecko) Version/7.0 Mobile/11A465 Safari/9537.53 (compatible; bingbot/2.0;  http://www.bing.com/bingbot.htm)";language|s:2:"pl";'),
('195629637f07f27044aefa8290a5c304', 'CMS', '2016-02-21 01:41:18', NULL, 1457228478, 0, 'SESSION_CLIENT_BROWSER|s:66:"Mozilla/5.0 (compatible; AhrefsBot/5.0; +http://ahrefs.com/robot/)";language|s:2:"pl";msg|O:8:"Messages":1:{s:19:"\0Messages\0_messages";a:0:{}}'),
('c1712dd6e26fb9ebacb8eba8d8849bf2', 'CMS', '2016-02-21 02:12:31', NULL, 1457230351, 0, 'SESSION_CLIENT_BROWSER|s:152:"Mozilla/5.0 (iPhone; CPU iPhone OS 7_0 like Mac OS X) AppleWebKit/537.51.1 (KHTML, like Gecko) Version/7.0 Mobile/11A465 Safari/9537.53 BingPreview/1.0b";language|s:2:"pl";'),
('7a3983a7d966ec7f5054b3c395ab2369', 'CMS', '2016-02-21 02:48:04', NULL, 1457232484, 0, 'SESSION_CLIENT_BROWSER|s:66:"Mozilla/5.0 (compatible; AhrefsBot/5.0; +http://ahrefs.com/robot/)";language|s:2:"pl";'),
('8bd165707b250e85c9b1ad58f1413457', 'CMS', '2016-02-21 03:06:42', NULL, 1457233602, 0, 'SESSION_CLIENT_BROWSER|s:71:"Mozilla/5.0 (compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm)";language|s:2:"pl";msg|O:8:"Messages":1:{s:19:"\0Messages\0_messages";a:0:{}}'),
('f27ff84713f6b3abf0c52309591d0b5e', 'CMS', '2016-02-21 03:06:46', NULL, 1457233606, 0, 'SESSION_CLIENT_BROWSER|s:71:"Mozilla/5.0 (compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm)";language|s:2:"pl";'),
('9cdb17452e82fa677919e1aeccc1fe26', 'CMS', '2016-02-21 03:07:35', NULL, 1457233655, 0, 'SESSION_CLIENT_BROWSER|s:71:"Mozilla/5.0 (compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm)";language|s:2:"pl";msg|O:8:"Messages":1:{s:19:"\0Messages\0_messages";a:0:{}}'),
('a58e9a582a3972be065cc2dc2166a393', 'CMS', '2016-02-21 03:07:36', NULL, 1457233656, 0, 'SESSION_CLIENT_BROWSER|s:71:"Mozilla/5.0 (compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm)";language|s:2:"pl";'),
('97d9318e79ac53021d9c602831116e77', 'CMS', '2016-02-21 03:14:58', NULL, 1457234098, 0, 'SESSION_CLIENT_BROWSER|s:71:"Mozilla/5.0 (compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm)";language|s:2:"pl";msg|O:8:"Messages":1:{s:19:"\0Messages\0_messages";a:0:{}}'),
('ecd3842dcc9a63b4bb5b94e475b0d1cf', 'CMS', '2016-02-21 03:16:11', NULL, 1457234171, 0, 'SESSION_CLIENT_BROWSER|s:71:"Mozilla/5.0 (compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm)";language|s:2:"pl";'),
('2f1b80a923e04d828ef5e704c001604b', 'CMS', '2016-02-21 03:25:41', NULL, 1457234740, 0, 'SESSION_CLIENT_BROWSER|b:0;language|s:2:"pl";'),
('33a9194302c55cde58e25c1be1cb548a', 'CMS', '2016-02-21 03:29:20', NULL, 1457234960, 0, 'SESSION_CLIENT_BROWSER|s:71:"Mozilla/5.0 (compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm)";language|s:2:"pl";msg|O:8:"Messages":1:{s:19:"\0Messages\0_messages";a:0:{}}'),
('f9939b9a69d594941b81a18624b52fc1', 'CMS', '2016-02-21 03:29:22', NULL, 1457234962, 0, 'SESSION_CLIENT_BROWSER|s:71:"Mozilla/5.0 (compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm)";language|s:2:"pl";'),
('0ee3ad65cbe212c60719b62823cff68b', 'CMS', '2016-02-21 06:28:28', NULL, 1457245708, 0, 'SESSION_CLIENT_BROWSER|s:195:"Mozilla/5.0 (iPhone; CPU iPhone OS 7_0 like Mac OS X) AppleWebKit/537.51.1 (KHTML, like Gecko) Version/7.0 Mobile/11A465 Safari/9537.53 (compatible; bingbot/2.0;  http://www.bing.com/bingbot.htm)";language|s:2:"pl";msg|O:8:"Messages":1:{s:19:"\0Messages\0_messages";a:0:{}}'),
('c5a47dad73a5829219f2a3949f0b70de', 'CMS', '2016-02-21 06:28:31', NULL, 1457245711, 0, 'SESSION_CLIENT_BROWSER|s:195:"Mozilla/5.0 (iPhone; CPU iPhone OS 7_0 like Mac OS X) AppleWebKit/537.51.1 (KHTML, like Gecko) Version/7.0 Mobile/11A465 Safari/9537.53 (compatible; bingbot/2.0;  http://www.bing.com/bingbot.htm)";language|s:2:"pl";'),
('a1929132cb1694a5b9b921bb1f83c6a1', 'CMS', '2016-02-21 09:03:59', NULL, 1457255039, 0, 'SESSION_CLIENT_BROWSER|s:50:"Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 5.2)";language|s:2:"pl";'),
('1e8b2be9e2f7b353287eb39464283f9c', 'CMS', '2016-02-21 11:12:29', NULL, 1457262749, 0, 'SESSION_CLIENT_BROWSER|s:79:"Mozilla/5.0 (compatible; MJ12bot/v1.4.5; http://www.majestic12.co.uk/bot.php?+)";language|s:2:"pl";'),
('3220f1a94a45dec6e2db02567b97fb9e', 'CMS', '2016-02-21 11:12:31', NULL, 1457262751, 0, 'SESSION_CLIENT_BROWSER|s:79:"Mozilla/5.0 (compatible; MJ12bot/v1.4.5; http://www.majestic12.co.uk/bot.php?+)";language|s:2:"pl";'),
('9e8bda36f3790f7cd4b52bb4eab6ef4b', 'CMS', '2016-02-21 11:12:32', NULL, 1457262752, 0, 'SESSION_CLIENT_BROWSER|s:79:"Mozilla/5.0 (compatible; MJ12bot/v1.4.5; http://www.majestic12.co.uk/bot.php?+)";language|s:2:"pl";'),
('5a3dfcbbca64158b13cab1cbf7108f1d', 'CMS', '2016-02-21 12:57:38', NULL, 1457269058, 0, 'SESSION_CLIENT_BROWSER|s:71:"Mozilla/5.0 (compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm)";language|s:2:"pl";'),
('b635bddcef71a8e772d2a1d6c742f192', 'CMS', '2016-02-21 13:25:52', NULL, 1457270752, 0, 'SESSION_CLIENT_BROWSER|s:66:"Mozilla/5.0 (compatible; AhrefsBot/5.0; +http://ahrefs.com/robot/)";language|s:2:"pl";'),
('11bd491558abe2237a5c3288df7104d2', 'CMS', '2016-02-21 15:42:32', NULL, 1457278952, 0, 'SESSION_CLIENT_BROWSER|s:79:"Mozilla/5.0 (compatible; MJ12bot/v1.4.5; http://www.majestic12.co.uk/bot.php?+)";language|s:2:"pl";'),
('b756278d79e00a40ba5a259ec4e8e45f', 'CMS', '2016-02-21 17:38:28', NULL, 1457285908, 0, 'SESSION_CLIENT_BROWSER|s:66:"Mozilla/5.0 (compatible; AhrefsBot/5.0; +http://ahrefs.com/robot/)";language|s:2:"pl";msg|O:8:"Messages":1:{s:19:"\0Messages\0_messages";a:0:{}}'),
('54c0c5cf9f57ca83ca3bc5af9ee2770a', 'CMS', '2016-02-21 20:38:00', NULL, 1457296680, 0, 'SESSION_CLIENT_BROWSER|s:41:"Wotbox/2.01 (+http://www.wotbox.com/bot/)";language|s:2:"pl";'),
('fceb158b89cbbd2b171bcc37043a8d1b', 'CMS', '2016-02-21 20:38:09', NULL, 1457296689, 0, 'SESSION_CLIENT_BROWSER|s:41:"Wotbox/2.01 (+http://www.wotbox.com/bot/)";language|s:2:"pl";'),
('98f356d9401c53774d6c550b6d4f8395', 'CMS', '2016-02-21 20:38:17', NULL, 1457296697, 0, 'SESSION_CLIENT_BROWSER|s:41:"Wotbox/2.01 (+http://www.wotbox.com/bot/)";language|s:2:"pl";'),
('7e26f63ab7b8333f7f1c98015aeb01a3', 'CMS', '2016-02-21 20:38:31', NULL, 1457296711, 0, 'SESSION_CLIENT_BROWSER|s:41:"Wotbox/2.01 (+http://www.wotbox.com/bot/)";language|s:2:"pl";'),
('a0f64694b9b419663b8bf59116cd6709', 'CMS', '2016-02-21 20:38:41', NULL, 1457296721, 0, 'SESSION_CLIENT_BROWSER|s:41:"Wotbox/2.01 (+http://www.wotbox.com/bot/)";language|s:2:"pl";'),
('5eb67cc928abaf5524ac6dc994a6ddcc', 'CMS', '2016-02-21 23:49:38', NULL, 1457308178, 0, 'SESSION_CLIENT_BROWSER|s:71:"Mozilla/5.0 (compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm)";language|s:2:"pl";msg|O:8:"Messages":1:{s:19:"\0Messages\0_messages";a:0:{}}'),
('db7bf1b562fe7774b1aa663a901aa6ee', 'CMS', '2016-02-22 03:23:13', NULL, 1457320993, 0, 'SESSION_CLIENT_BROWSER|b:0;language|s:2:"pl";'),
('f6a2be00a9bce00ac94711bb22cef8bf', 'CMS', '2016-02-22 11:57:34', NULL, 1457351854, 0, 'SESSION_CLIENT_BROWSER|s:195:"Mozilla/5.0 (iPhone; CPU iPhone OS 7_0 like Mac OS X) AppleWebKit/537.51.1 (KHTML, like Gecko) Version/7.0 Mobile/11A465 Safari/9537.53 (compatible; bingbot/2.0;  http://www.bing.com/bingbot.htm)";language|s:2:"pl";'),
('d4eca1e963e5cac6f69b7ee2b67e9116', 'CMS', '2016-02-22 11:57:55', NULL, 1457351875, 0, 'SESSION_CLIENT_BROWSER|s:195:"Mozilla/5.0 (iPhone; CPU iPhone OS 7_0 like Mac OS X) AppleWebKit/537.51.1 (KHTML, like Gecko) Version/7.0 Mobile/11A465 Safari/9537.53 (compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm)";language|s:2:"pl";msg|O:8:"Messages":1:{s:19:"\0Messages\0_messages";a:0:{}}'),
('ec2eb098255c44b9318b50316ccaa5a5', 'CMS', '2016-02-22 11:57:56', NULL, 1457351876, 0, 'SESSION_CLIENT_BROWSER|s:195:"Mozilla/5.0 (iPhone; CPU iPhone OS 7_0 like Mac OS X) AppleWebKit/537.51.1 (KHTML, like Gecko) Version/7.0 Mobile/11A465 Safari/9537.53 (compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm)";language|s:2:"pl";'),
('454e5a43f516c8cbd57e50d0824be7d2', 'CMS', '2016-02-22 11:58:20', NULL, 1457351899, 0, 'SESSION_CLIENT_BROWSER|s:195:"Mozilla/5.0 (iPhone; CPU iPhone OS 7_0 like Mac OS X) AppleWebKit/537.51.1 (KHTML, like Gecko) Version/7.0 Mobile/11A465 Safari/9537.53 (compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm)";language|s:2:"pl";msg|O:8:"Messages":1:{s:19:"\0Messages\0_messages";a:0:{}}'),
('3fc355b61251b551613bd9acdff46e92', 'CMS', '2016-02-22 11:58:20', NULL, 1457351900, 0, 'SESSION_CLIENT_BROWSER|s:195:"Mozilla/5.0 (iPhone; CPU iPhone OS 7_0 like Mac OS X) AppleWebKit/537.51.1 (KHTML, like Gecko) Version/7.0 Mobile/11A465 Safari/9537.53 (compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm)";language|s:2:"pl";'),
('64e6533c2ca8d3439437aa0598e0af6e', 'CMS', '2016-02-22 12:21:22', NULL, 1457353282, 0, 'SESSION_CLIENT_BROWSER|s:71:"Mozilla/5.0 (compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm)";language|s:2:"pl";'),
('13bc568eab1e04b1ec729cdaa803894f', 'CMS', '2016-02-22 12:58:59', NULL, 1457355539, 0, 'SESSION_CLIENT_BROWSER|s:152:"Mozilla/5.0 (iPhone; CPU iPhone OS 7_0 like Mac OS X) AppleWebKit/537.51.1 (KHTML, like Gecko) Version/7.0 Mobile/11A465 Safari/9537.53 BingPreview/1.0b";language|s:2:"pl";'),
('f54dae5df7f074033e047a8a63486d11', 'CMS', '2016-02-22 13:43:04', NULL, 1457358184, 0, 'SESSION_CLIENT_BROWSER|s:72:"Mozilla/5.0 (Windows NT 6.1; WOW64; rv:44.0) Gecko/20100101 Firefox/44.0";language|s:2:"pl";');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `slider`
--

CREATE TABLE IF NOT EXISTS `slider` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `parent_id` int(11) NOT NULL,
  `modify_user_id` int(11) NOT NULL,
  `name` varchar(512) NOT NULL,
  `description` text NOT NULL,
  `add_date` datetime NOT NULL,
  `modify_date` datetime NOT NULL,
  `image_filename` varchar(128) NOT NULL,
  `url` varchar(512) NOT NULL,
  `publish` tinyint(1) NOT NULL,
  `pos` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=39 ;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `system_action`
--

CREATE TABLE IF NOT EXISTS `system_action` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(128) NOT NULL,
  `constant` varchar(64) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `constant` (`constant`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC AUTO_INCREMENT=2 ;

--
-- Zrzut danych tabeli `system_action`
--

INSERT INTO `system_action` (`id`, `name`, `constant`) VALUES
(1, 'Zapytanie kontaktowe', 'contact_form');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `system_action_var`
--

CREATE TABLE IF NOT EXISTS `system_action_var` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_id` int(11) NOT NULL,
  `name` varchar(64) NOT NULL,
  `desc` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC AUTO_INCREMENT=7 ;

--
-- Zrzut danych tabeli `system_action_var`
--

INSERT INTO `system_action_var` (`id`, `action_id`, `name`, `desc`) VALUES
(1, 1, 'text', ''),
(2, 1, 'date', ''),
(3, 1, 'name', ''),
(4, 1, 'phone', ''),
(5, 1, 'ip', ''),
(6, 1, 'email', '');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `system_lock`
--

CREATE TABLE IF NOT EXISTS `system_lock` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `user_id` int(10) unsigned NOT NULL,
  `type` varchar(32) NOT NULL,
  `object_id` int(10) unsigned NOT NULL,
  `add_date` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2369 ;

--
-- Zrzut danych tabeli `system_lock`
--

INSERT INTO `system_lock` (`id`, `timestamp`, `user_id`, `type`, `object_id`, `add_date`) VALUES
(2368, '2016-02-04 08:23:39', 2, 'page', 1, '0000-00-00 00:00:00');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `system_message`
--

CREATE TABLE IF NOT EXISTS `system_message` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `store` tinyint(1) NOT NULL,
  `action_id` int(11) NOT NULL,
  `title` varchar(256) NOT NULL,
  `content` text NOT NULL,
  `active` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `store` (`store`,`action_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC AUTO_INCREMENT=2 ;

--
-- Zrzut danych tabeli `system_message`
--

INSERT INTO `system_message` (`id`, `store`, `action_id`, `title`, `content`, `active`) VALUES
(1, 0, 1, '', '', 0);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `system_message_description`
--

CREATE TABLE IF NOT EXISTS `system_message_description` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `lang` varchar(2) NOT NULL,
  `message_id` int(11) NOT NULL,
  `title` varchar(512) NOT NULL,
  `content` text NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `lang` (`lang`,`message_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=6 ;

--
-- Zrzut danych tabeli `system_message_description`
--

INSERT INTO `system_message_description` (`id`, `lang`, `message_id`, `title`, `content`) VALUES
(5, 'pl', 1, 'Zapytanie kontaktowe', '<p>{name}<br />\r\n{date}<br />\r\n{email}<br />\r\n{phone}<br />\r\n---<br />\r\n<span style="line-height: 1.6;">{text}</span></p>\r\n\r\n<p><span style="line-height: 1.6;">--<br />\r\n{ip}</span><br />\r\n&nbsp;</p>\r\n');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `system_module`
--

CREATE TABLE IF NOT EXISTS `system_module` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(256) NOT NULL,
  `object` varchar(128) NOT NULL,
  `title` varchar(512) NOT NULL,
  `access` varchar(128) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `object` (`object`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=25 ;

--
-- Zrzut danych tabeli `system_module`
--

INSERT INTO `system_module` (`id`, `name`, `object`, `title`, `access`) VALUES
(1, 'Module_Box', 'box', '', ''),
(2, 'Module_Calls', 'calls', '', ''),
(3, 'Module_Configuration', 'configuration', '', ''),
(4, 'Module_Contactforms', 'contactforms', '', ''),
(5, 'Module_Dashboard', 'dashboard', '', ''),
(6, 'Module_Error', 'error', '', ''),
(7, 'Module_Events', 'events', '', ''),
(8, 'Module_Galleries', 'galleries', '', ''),
(9, 'Module_Install', 'install', '', ''),
(10, 'Module_Login', 'login', '', ''),
(11, 'Module_Logos', 'logos', '', ''),
(12, 'Module_News', 'news', '', ''),
(13, 'Module_Orders_Payments', 'orders_payments', '', ''),
(14, 'Module_Orders_Postages', 'orders_postages', '', ''),
(15, 'Module_Pages_Index', 'pages_index', '', ''),
(16, 'Module_Pages', 'pages', 'Strony', 'pages'),
(17, 'Module_Products', 'products', '', ''),
(18, 'Module_Search', 'search', '', ''),
(19, 'Module_Sliders', 'sliders', '', ''),
(20, 'Module_System_Languages', 'system_languages', '', ''),
(21, 'Module_System_Messages', 'system_messages', '', ''),
(22, 'Module_System_Modules', 'system_modules', '', ''),
(23, 'Module_User', 'user', '', ''),
(24, 'Module_Users', 'users', 'Użytkownicy systemu', 'users');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `system_module_action`
--

CREATE TABLE IF NOT EXISTS `system_module_action` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `access` varchar(128) NOT NULL,
  `name` varchar(256) NOT NULL,
  `action` varchar(256) NOT NULL,
  `title` varchar(512) NOT NULL,
  `type` varchar(128) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=145 ;

--
-- Zrzut danych tabeli `system_module_action`
--

INSERT INTO `system_module_action` (`id`, `access`, `name`, `action`, `title`, `type`) VALUES
(1, '', 'Basket_Actions', '_update_item', '', ''),
(2, '', 'Basket_Actions', '_remove_item', '', ''),
(3, '', 'Basket_Actions', '_add', '', ''),
(4, '', 'Box_Actions', '_add', '', ''),
(5, '', 'Box_Actions', '_update', '', ''),
(6, '', 'Box_Actions', '_delete', '', ''),
(7, '', 'Box_Actions', '_switch_publish', '', ''),
(8, '', 'Box_Actions', '_upload_image', '', ''),
(9, '', 'Calls_Templates_Actions', '_add', '', ''),
(10, '', 'Calls_Templates_Actions', '_save', '', ''),
(11, '', 'Calls_Templates_Actions', '_delete', '', ''),
(12, '', 'Calls_Templates_Actions', '_load_to_editor', '', ''),
(13, '', 'Calls_Actions', '_add', '', ''),
(14, '', 'Calls_Actions', '_save', '', ''),
(15, '', 'Calls_Actions', '_remove', '', ''),
(16, '', 'Calls_Actions', '_activate', '', ''),
(17, '', 'Calls_Actions', '_add_call', '', ''),
(18, '', 'Calls_Actions', '_remove_call', '', ''),
(19, '', 'Configurations_Actions', '_save', '', ''),
(20, '', 'Contact_Form_Actions', '_send', '', ''),
(21, '', 'Contact_Form_Actions', '_remove_selected', '', ''),
(22, '', 'Customers_Actions', '_add', '', ''),
(23, '', 'Customers_Actions', '_save', '', ''),
(24, '', 'Customers_Actions', '_remove', '', ''),
(25, '', 'Customers_Actions', '_activate', '', ''),
(26, '', 'Customers_Actions', '_add_agent', '', ''),
(27, '', 'Customers_Actions', '_save_agent', '', ''),
(28, '', 'Customers_Actions', '_remove_agent', '', ''),
(29, '', 'Events_Actions', '_add', '', ''),
(30, '', 'Events_Actions', '_update', '', ''),
(31, '', 'Events_Actions', '_delete', '', ''),
(32, '', 'Events_Actions', '_switch_publish', '', ''),
(33, '', 'Galleries_Actions', '_add', '', ''),
(34, '', 'Galleries_Actions', '_ajax_save_positions', '', ''),
(35, '', 'Galleries_Actions', '_save', '', ''),
(36, '', 'Galleries_Actions', '_save_images', '', ''),
(37, '', 'Galleries_Actions', '_remove', '', ''),
(38, '', 'Galleries_Actions', '_toggle_active', '', ''),
(39, '', 'Galleries_Actions', '_upload_image', '', ''),
(40, '', 'Galleries_Actions', '_remove_image', '', ''),
(41, '', 'Galleries_Actions', '_upload_category_image', '', ''),
(42, '', 'Generic_Actions', '__construct', '', ''),
(43, '', 'Keys_Actions', '_add', '', ''),
(44, '', 'Keys_Actions', '_save', '', ''),
(45, '', 'Keys_Actions', '_remove', '', ''),
(46, '', 'Logos_Actions', '_add', '', ''),
(47, '', 'Logos_Actions', '_update', '', ''),
(48, '', 'Logos_Actions', '_delete', '', ''),
(49, '', 'Logos_Actions', '_switch_publish', '', ''),
(50, '', 'Logos_Actions', '_ajax_save_positions', '', ''),
(51, '', 'Logos_Actions', '_upload_image', '', ''),
(52, '', 'News_Actions', '_add', '', ''),
(53, '', 'News_Actions', '_update', '', ''),
(54, '', 'News_Actions', '_delete', '', ''),
(55, '', 'News_Actions', '_switch_publish', '', ''),
(56, '', 'News_Actions', '_revive_copy', '', ''),
(57, '', 'News_Actions', '_upload_image', '', ''),
(58, '', 'Orders_Payments_Actions', '_add', '', ''),
(59, '', 'Orders_Payments_Actions', '_save', '', ''),
(60, '', 'Orders_Payments_Actions', '_remove', '', ''),
(61, '', 'Orders_Postages_Actions', '_add', '', ''),
(62, '', 'Orders_Postages_Actions', '_save', '', ''),
(63, '', 'Orders_Postages_Actions', '_remove', '', ''),
(64, '', 'Pages_Data_Actions', '_save', '', ''),
(65, '', 'Pages_Actions', '_add', '', ''),
(66, '', 'Pages_Actions', '_update', '', ''),
(67, '', 'Pages_Actions', '_ajax_save_positions', '', ''),
(68, '', 'Pages_Actions', '_delete', '', ''),
(69, '', 'Pages_Actions', '_switch_publish', '', ''),
(70, '', 'Pages_Actions', '_revive_copy', '', ''),
(71, '', 'Pages_Actions', '_upload_image', '', ''),
(72, '', 'Pages_Actions', '_add_attributes', '', ''),
(73, '', 'Pages_Actions', '_save_attributes', '', ''),
(74, '', 'Products_Actions', '_add', '', ''),
(75, '', 'Products_Actions', '_ajax_save_positions', '', ''),
(76, '', 'Products_Actions', '_save', '', ''),
(77, '', 'Products_Actions', '_save_category', '', ''),
(78, '', 'Products_Actions', '_save_accessories', '', ''),
(79, '', 'Products_Actions', '_save_images', '', ''),
(80, '', 'Products_Actions', '_copy', '', ''),
(81, '', 'Products_Actions', '_add_attributes', '', ''),
(82, '', 'Products_Actions', '_save_attributes', '', ''),
(83, '', 'Products_Actions', '_add_strollers', '', ''),
(84, '', 'Products_Actions', '_save_strollers', '', ''),
(85, '', 'Products_Actions', '_add_movies', '', ''),
(86, '', 'Products_Actions', '_save_movies', '', ''),
(87, '', 'Products_Actions', '_remove', '', ''),
(88, '', 'Products_Actions', '_add_category', '', ''),
(89, '', 'Products_Actions', '_remove_category', '', ''),
(90, '', 'Products_Actions', '_update_categories', '', ''),
(91, '', 'Products_Actions', '_toggle_active', '', ''),
(92, '', 'Products_Actions', '_check_serial', '', ''),
(93, '', 'Products_Actions', '_upload_image', '', ''),
(94, '', 'Products_Actions', '_remove_image', '', ''),
(95, '', 'Products_Actions', '_upload_category_image', '', ''),
(96, '', 'Reports_Actions', '_approve_person', '', ''),
(97, '', 'Reports_Actions', '_register', '', ''),
(98, '', 'Reports_Actions', '_add', '', ''),
(99, '', 'Reports_Actions', '_save', '', ''),
(100, '', 'Reports_Actions', '_remove', '', ''),
(101, '', 'Reports_Actions', '_close', '', ''),
(102, '', 'Reports_Actions', '_complain', '', ''),
(103, '', 'Reports_Actions', '_add_task', '', ''),
(104, '', 'Reports_Actions', '_save_task', '', ''),
(105, '', 'Reports_Actions', '_remove_task', '', ''),
(106, '', 'Reports_Actions', '_upload_from_clipboard', '', ''),
(107, '', 'Reports_Actions', '_upload_tmp_from_clipboard', '', ''),
(108, '', 'Reports_Actions', '_upload_file', '', ''),
(109, '', 'Reports_Actions', '_upload_tmp_file', '', ''),
(110, '', 'Rootkit_Actions', '_clear_cache', '', ''),
(111, '', 'Sliders_Actions', '_add', '', ''),
(112, '', 'Sliders_Actions', '_update', '', ''),
(113, '', 'Sliders_Actions', '_delete', '', ''),
(114, '', 'Sliders_Actions', '_switch_publish', '', ''),
(115, '', 'Sliders_Actions', '_ajax_save_positions', '', ''),
(116, '', 'Sliders_Actions', '_upload_image', '', ''),
(117, '', 'Stores_Actions', '_add', '', ''),
(118, '', 'Stores_Actions', '_save', '', ''),
(119, '', 'Stores_Actions', '_remove', '', ''),
(120, '', 'System_Languages_Actions', '_save_translations', '', ''),
(121, '', 'System_Locks_Actions', '_lock', '', ''),
(122, '', 'System_Locks_Actions', '_check_locks', '', ''),
(123, '', 'System_Messages_Actions', '_add', '', ''),
(124, '', 'System_Messages_Actions', '_save', '', ''),
(125, '', 'System_Messages_Actions', '_delete', '', ''),
(126, '', 'System_Modules_Actions', '_rebuild_all', '', ''),
(127, '', 'System_Modules_Actions', '_scan_modules_directory', '', ''),
(128, '', 'System_Modules_Actions', '_scan_module_class', '', ''),
(129, '', 'System_Modules_Actions', '_scan_actions_directory', '', ''),
(130, '', 'System_Modules_Actions', '_scan_action_class', '', ''),
(131, '', 'Users_Groups_Actions', '_save', '', ''),
(132, '', 'Users_Groups_Actions', '_delete', '', ''),
(133, '', 'Users_Groups_Actions', '_save_rights2', '', ''),
(134, '', 'Users_Groups_Actions', '_save_single_right', '', ''),
(135, '', 'Users_Groups_Actions', '_rewrite_config_file', '', ''),
(136, 'users', 'Users_Actions', '_save', 'Zapisz użytkownika\r', 'write\r'),
(137, 'users', 'Users_Actions', '_save_account', 'Zapisz dane zalogowanego użytkownika\r', 'write\r'),
(138, 'users', 'Users_Actions', '_delete', 'Usun użytkownika\r', 'remove\r'),
(139, 'users', 'Users_Actions', '_answer_invitation', 'Odpowiedz na zaproszenie\r', 'write\r'),
(140, 'users', 'Users_Actions', '_register', 'Zarejestruj konto\r', 'write\r'),
(141, 'users', 'Users_Actions', '_toggle_active', 'Aktywuj/Deaktywuj konto\r', 'write\r'),
(142, '', 'Warranty_Actions', '_add', '', ''),
(143, '', 'Warranty_Actions', '_save', '', ''),
(144, '', 'Warranty_Actions', '_remove', '', '');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `system_module_view`
--

CREATE TABLE IF NOT EXISTS `system_module_view` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(256) NOT NULL,
  `view` varchar(128) NOT NULL,
  `module_id` int(11) NOT NULL,
  `module` varchar(64) NOT NULL,
  `title` varchar(512) NOT NULL,
  `access` varchar(128) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=81 ;

--
-- Zrzut danych tabeli `system_module_view`
--

INSERT INTO `system_module_view` (`id`, `name`, `view`, `module_id`, `module`, `title`, `access`) VALUES
(1, 'index', 'index', 1, 'box', '', ''),
(2, 'add', 'add', 1, 'box', '', ''),
(3, 'edit', 'edit', 1, 'box', '', ''),
(4, 'index', 'index', 2, 'calls', '', ''),
(5, 'add', 'add', 2, 'calls', '', ''),
(6, 'edit', 'edit', 2, 'calls', '', ''),
(7, 'preview', 'preview', 2, 'calls', '', ''),
(8, 'index', 'index', 3, 'configuration', '', ''),
(9, 'test_smtp_connection', 'test_smtp_connection', 3, 'configuration', '', ''),
(10, 'index', 'index', 4, 'contactforms', '', ''),
(11, 'index', 'index', 5, 'dashboard', '', ''),
(12, 'index', 'index', 6, 'error', '', ''),
(13, 'noaccess', 'noaccess', 6, 'error', '', ''),
(14, 'index', 'index', 7, 'events', '', ''),
(15, 'add', 'add', 7, 'events', '', ''),
(16, 'edit', 'edit', 7, 'events', '', ''),
(17, 'index', 'index', 8, 'galleries', '', ''),
(18, 'add', 'add', 8, 'galleries', '', ''),
(19, 'edit', 'edit', 8, 'galleries', '', ''),
(20, 'index', 'index', 9, 'install', '', ''),
(21, 'index', 'index', 10, 'login', '', ''),
(22, 'ajax_check', 'ajax_check', 10, 'login', '', ''),
(23, 'index', 'index', 11, 'logos', '', ''),
(24, 'add', 'add', 11, 'logos', '', ''),
(25, 'edit', 'edit', 11, 'logos', '', ''),
(26, 'build_breadcrumb', 'build_breadcrumb', 11, 'logos', '', ''),
(27, 'index', 'index', 12, 'news', '', ''),
(28, 'add', 'add', 12, 'news', '', ''),
(29, 'preview', 'preview', 12, 'news', '', ''),
(30, 'edit', 'edit', 12, 'news', '', ''),
(31, 'revisions', 'revisions', 12, 'news', '', ''),
(32, 'index', 'index', 13, 'orders_payments', '', ''),
(33, 'add', 'add', 13, 'orders_payments', '', ''),
(34, 'edit', 'edit', 13, 'orders_payments', '', ''),
(35, 'index', 'index', 14, 'orders_postages', '', ''),
(36, 'add', 'add', 14, 'orders_postages', '', ''),
(37, 'edit', 'edit', 14, 'orders_postages', '', ''),
(38, 'index', 'index', 15, 'pages_index', '', ''),
(39, 'gallery', 'gallery', 15, 'pages_index', '', ''),
(40, 'search', 'search', 15, 'pages_index', '', ''),
(41, 'index', 'index', 16, 'pages', 'Lista stron', 'pages'),
(42, 'add', 'add', 16, 'pages', 'Dodawanie stron', 'pages'),
(43, 'edit', 'edit', 16, 'pages', 'Edycja strony', 'pages'),
(44, 'revisions', 'revisions', 16, 'pages', 'Rewizje', 'pages'),
(45, 'build_breadcrumb', 'build_breadcrumb', 16, 'pages', 'Breadcrumb', 'pages'),
(46, 'edit_data_html', 'edit_data_html', 16, 'pages', 'Edycja treści HTML z poziomu strony', 'pages'),
(47, 'index', 'index', 17, 'products', '', ''),
(48, 'add', 'add', 17, 'products', '', ''),
(49, 'edit', 'edit', 17, 'products', '', ''),
(50, 'add_category', 'add_category', 17, 'products', '', ''),
(51, 'edit_category', 'edit_category', 17, 'products', '', ''),
(52, 'attributes_list', 'attributes_list', 17, 'products', '', ''),
(53, 'settings', 'settings', 17, 'products', '', ''),
(54, 'all', 'all', 18, 'search', '', ''),
(55, 'attributes', 'attributes', 18, 'search', '', ''),
(56, 'pages', 'pages', 18, 'search', '', ''),
(57, 'index', 'index', 19, 'sliders', '', ''),
(58, 'add', 'add', 19, 'sliders', '', ''),
(59, 'edit', 'edit', 19, 'sliders', '', ''),
(60, 'build_breadcrumb', 'build_breadcrumb', 19, 'sliders', '', ''),
(61, 'index', 'index', 20, 'system_languages', '', ''),
(62, 'index', 'index', 21, 'system_messages', '', ''),
(63, 'edit', 'edit', 21, 'system_messages', '', ''),
(64, 'add', 'add', 21, 'system_messages', '', ''),
(65, 'index', 'index', 22, 'system_modules', '', ''),
(66, 'add', 'add', 22, 'system_modules', '', ''),
(67, 'edit', 'edit', 22, 'system_modules', '', ''),
(68, 'add_view', 'add_view', 22, 'system_modules', '', ''),
(69, 'edit_view', 'edit_view', 22, 'system_modules', '', ''),
(70, 'register', 'register', 23, 'user', '', ''),
(71, 'invites', 'invites', 23, 'user', '', ''),
(72, 'index', 'index', 23, 'user', '', ''),
(73, 'preview', 'preview', 23, 'user', '', ''),
(74, 'index', 'index', 24, 'users', 'Lista użytkowników', 'users'),
(75, 'edit', 'edit', 24, 'users', 'Formularz edycji użytkownika', 'users'),
(76, 'add', 'add', 24, 'users', 'Formularz nowego użytkownika', 'users'),
(77, 'edit_account', 'edit_account', 24, 'users', 'Edycja konta zalogowanego użytkownika', 'users'),
(78, 'login_history', 'login_history', 24, 'users', 'Historia logowania użytkownika', 'users'),
(79, 'register', 'register', 24, 'users', 'Rejestracja użytkownika', 'users'),
(80, 'groups_rights', 'groups_rights', 24, 'users', 'Prawa dostępu', 'users');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `user`
--

CREATE TABLE IF NOT EXISTS `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `login` varchar(64) DEFAULT NULL,
  `password` varchar(128) DEFAULT NULL,
  `password_change_request` varchar(512) DEFAULT NULL,
  `session_id` varchar(48) DEFAULT NULL,
  `name` varchar(45) NOT NULL,
  `lastname` varchar(45) NOT NULL,
  `add_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `group_id` tinyint(2) NOT NULL,
  `active` tinyint(1) DEFAULT NULL,
  `language` varchar(3) DEFAULT 'pl',
  `email` varchar(256) NOT NULL,
  `email_change_request` varchar(512) DEFAULT NULL,
  `email_signature` text,
  `avatar` varchar(32) DEFAULT NULL,
  `super_admin` tinyint(1) DEFAULT NULL,
  `access_list` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT AUTO_INCREMENT=3 ;

--
-- Zrzut danych tabeli `user`
--

INSERT INTO `user` (`id`, `login`, `password`, `password_change_request`, `session_id`, `name`, `lastname`, `add_date`, `group_id`, `active`, `language`, `email`, `email_change_request`, `email_signature`, `avatar`, `super_admin`, `access_list`) VALUES
(1, NULL, '$2y$11$7JfWqqmOZ1tX/C1w9ojSl.b4HHuRQZDCWvefTQOeZIR2ipE8IGlfW', NULL, NULL, 'Super', 'Admin', '2015-03-06 14:56:24', 1, 1, 'pl', 'vsemak@gmail.com', NULL, NULL, NULL, 1, ''),
(2, NULL, '0158a4d4d5fcbecede74c1b69d6880baa39c5dd8', NULL, NULL, 'Admin', '1', '2015-03-06 14:56:25', 1, 1, 'pl', 'admin@admin.pl', NULL, NULL, NULL, 1, '');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `user_group`
--

CREATE TABLE IF NOT EXISTS `user_group` (
  `id` tinyint(4) NOT NULL AUTO_INCREMENT,
  `code` varchar(32) NOT NULL,
  `name` varchar(256) NOT NULL,
  `hidden` tinyint(1) DEFAULT NULL,
  `color` varchar(32) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT AUTO_INCREMENT=4 ;

--
-- Zrzut danych tabeli `user_group`
--

INSERT INTO `user_group` (`id`, `code`, `name`, `hidden`, `color`) VALUES
(1, 'programers', 'Developer', 1, '#aaa'),
(2, 'admin', 'Admin', NULL, 'red'),
(3, '__anonymous', 'Gość', 1, 'blue');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `user_group_right`
--

CREATE TABLE IF NOT EXISTS `user_group_right` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `module` varchar(128) NOT NULL,
  `view` varchar(128) NOT NULL,
  `access` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `group_id` (`group_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=994 ;

--
-- Zrzut danych tabeli `user_group_right`
--

INSERT INTO `user_group_right` (`id`, `group_id`, `module`, `view`, `access`) VALUES
(879, 2, 'box', '', 1),
(880, 2, 'box', 'add', 1),
(881, 2, 'box', 'edit', 1),
(882, 2, 'box', 'index', 1),
(883, 2, 'calls', '', 1),
(884, 2, 'calls', 'add', 1),
(885, 2, 'calls', 'edit', 1),
(886, 2, 'calls', 'index', 1),
(887, 2, 'calls', 'preview', 1),
(888, 2, 'configuration', '', 1),
(889, 2, 'configuration', 'index', 1),
(890, 2, 'configuration', 'test_smtp_connection', 1),
(891, 2, 'dashboard', '', 1),
(892, 2, 'dashboard', 'index', 1),
(893, 2, 'error', '', 1),
(894, 2, 'error', 'index', 1),
(895, 2, 'error', 'noaccess', 1),
(896, 2, 'events', '', 1),
(897, 2, 'events', 'add', 1),
(898, 2, 'events', 'edit', 1),
(899, 2, 'events', 'index', 1),
(900, 2, 'galleries', '', 1),
(901, 2, 'galleries', 'edit', 1),
(902, 2, 'galleries', 'add', 1),
(903, 2, 'galleries', 'index', 1),
(904, 2, 'install', '', 1),
(905, 2, 'install', 'index', 1),
(906, 2, 'login', '', 1),
(907, 2, 'login', 'ajax_check', 1),
(908, 2, 'login', 'index', 1),
(909, 2, 'logos', '', 1),
(910, 2, 'logos', 'add', 1),
(911, 2, 'logos', 'build_breadcrumb', 1),
(912, 2, 'logos', 'edit', 1),
(913, 2, 'logos', 'index', 1),
(914, 2, 'news', '', 1),
(915, 2, 'news', 'add', 1),
(916, 2, 'news', 'edit', 1),
(917, 2, 'news', 'index', 1),
(918, 2, 'news', 'preview', 1),
(919, 2, 'news', 'revisions', 1),
(920, 2, 'orders_payments', '', 1),
(921, 2, 'orders_payments', 'add', 1),
(922, 2, 'orders_payments', 'edit', 1),
(923, 2, 'orders_payments', 'index', 1),
(924, 2, 'orders_postages', '', 1),
(925, 2, 'orders_postages', 'add', 1),
(926, 2, 'orders_postages', 'edit', 1),
(927, 2, 'orders_postages', 'index', 1),
(928, 2, 'pages', '', 1),
(929, 2, 'pages', 'add', 1),
(930, 2, 'pages', 'build_breadcrumb', 1),
(931, 2, 'pages', 'edit', 1),
(932, 2, 'pages', 'edit_data_html', 1),
(933, 2, 'pages', 'index', 1),
(934, 2, 'pages', 'revisions', 1),
(935, 2, 'pages_index', '', 1),
(936, 2, 'pages_index', 'basket', 1),
(937, 2, 'pages_index', 'category', 1),
(938, 2, 'pages_index', 'gallery', 1),
(939, 2, 'pages_index', 'index', 1),
(940, 2, 'pages_index', 'product', 1),
(941, 2, 'pages_index', 'search', 1),
(942, 2, 'products', '', 1),
(943, 2, 'products', 'add', 1),
(944, 2, 'products', 'add_category', 1),
(945, 2, 'products', 'attributes_list', 1),
(946, 2, 'products', 'edit', 1),
(947, 2, 'products', 'edit_category', 1),
(948, 2, 'products', 'index', 1),
(949, 2, 'products', 'settings', 1),
(950, 2, 'search', '', 1),
(951, 2, 'search', 'all', 1),
(952, 2, 'search', 'attributes', 1),
(953, 2, 'search', 'pages', 1),
(954, 2, 'sliders', '', 1),
(955, 2, 'sliders', 'add', 1),
(956, 2, 'sliders', 'build_breadcrumb', 1),
(957, 2, 'sliders', 'edit', 1),
(958, 2, 'sliders', 'index', 1),
(959, 2, 'stores', '', 1),
(960, 2, 'stores', 'add', 1),
(961, 2, 'stores', 'edit', 1),
(962, 2, 'stores', 'index', 1),
(963, 2, 'system_languages', '', 1),
(964, 2, 'system_languages', 'index', 1),
(965, 2, 'system_messages', '', 1),
(966, 2, 'system_messages', 'add', 1),
(967, 2, 'system_messages', 'edit', 1),
(968, 2, 'system_messages', 'index', 1),
(969, 2, 'system_modules', '', 1),
(970, 2, 'system_modules', 'add', 1),
(971, 2, 'system_modules', 'add_view', 1),
(972, 2, 'system_modules', 'edit', 1),
(973, 2, 'system_modules', 'edit_view', 1),
(974, 2, 'system_modules', 'index', 1),
(975, 2, 'user', '', 1),
(976, 2, 'user', 'index', 1),
(977, 2, 'user', 'invites', 1),
(978, 2, 'user', 'preview', 1),
(979, 2, 'user', 'register', 1),
(980, 2, 'users', '', 1),
(981, 2, 'users', 'add', 1),
(982, 2, 'users', 'edit', 1),
(983, 2, 'users', 'groups_rights', 1),
(984, 2, 'users', 'edit_account', 1),
(985, 2, 'users', 'index', 1),
(986, 2, 'users', 'login_history', 1),
(987, 2, 'users', 'register', 1),
(988, 3, 'pages_index', '', 1),
(989, 3, 'pages_index', 'gallery', 1),
(990, 3, 'pages_index', 'index', 1),
(991, 3, 'pages_index', 'search', 1),
(992, 2, 'contactforms', '', 1),
(993, 2, 'contactforms', 'index', 1);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `user_login_history`
--

CREATE TABLE IF NOT EXISTS `user_login_history` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `session_id` varchar(48) NOT NULL,
  `date` datetime NOT NULL,
  `ip_address` varchar(45) NOT NULL,
  `browser` varchar(512) NOT NULL,
  `error` tinyint(4) NOT NULL,
  `last_action_time` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index1` (`user_id`,`date`),
  KEY `session_id` (`session_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC AUTO_INCREMENT=18 ;

--
-- Zrzut danych tabeli `user_login_history`
--

INSERT INTO `user_login_history` (`id`, `user_id`, `session_id`, `date`, `ip_address`, `browser`, `error`, `last_action_time`) VALUES
(1, 1, '', '2015-06-28 18:29:09', '::1', 'Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101 Firefox/38.0', 1, '2015-06-28 18:29:09'),
(2, 1, '', '2015-06-28 18:29:14', '::1', 'Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101 Firefox/38.0', 1, '2015-06-28 18:29:14'),
(3, 1, '612kjthgtrd0ib1ri9f14f4vr2', '2015-06-28 18:29:26', '::1', 'Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101 Firefox/38.0', 0, '2015-06-28 19:22:43'),
(4, 1, '', '2015-06-28 18:36:50', '::1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/43.0.2357.130 Safari/537.36', 1, '2015-06-28 18:36:50'),
(5, 1, '55ecivbr939j176vus2eoi0cu7', '2015-06-28 18:36:54', '::1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/43.0.2357.130 Safari/537.36', 0, '2015-06-28 19:22:57'),
(6, 1, 'ntocpcq4t0ghraotqvtam5i4l6', '2015-06-28 20:04:31', '::1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/43.0.2357.130 Safari/537.36', 0, '2015-06-28 20:07:10'),
(7, 2, '', '2016-01-25 11:09:30', '91.200.24.19', 'Mozilla/5.0 (Windows NT 6.1; WOW64; rv:43.0) Gecko/20100101 Firefox/43.0', 1, '2016-01-25 11:09:30'),
(8, 2, '', '2016-01-25 11:09:54', '91.200.24.19', 'Mozilla/5.0 (Windows NT 6.1; WOW64; rv:43.0) Gecko/20100101 Firefox/43.0', 1, '2016-01-25 11:09:54'),
(9, 2, '73e20728fb9d77f1c39d95f84a5a2eae', '2016-01-25 11:11:02', '91.200.24.19', 'Mozilla/5.0 (Windows NT 6.1; WOW64; rv:43.0) Gecko/20100101 Firefox/43.0', 0, '2016-01-25 11:11:27'),
(10, 2, '73e20728fb9d77f1c39d95f84a5a2eae', '2016-01-25 11:11:32', '91.200.24.19', 'Mozilla/5.0 (Windows NT 6.1; WOW64; rv:43.0) Gecko/20100101 Firefox/43.0', 0, '2016-01-25 11:11:52'),
(11, 2, '73e20728fb9d77f1c39d95f84a5a2eae', '2016-01-25 11:11:55', '91.200.24.19', 'Mozilla/5.0 (Windows NT 6.1; WOW64; rv:43.0) Gecko/20100101 Firefox/43.0', 0, '2016-01-25 11:54:02'),
(12, 2, '91a8e9e3a2c361f99382b56f639005de', '2016-01-25 11:52:38', '91.200.24.19', 'Mozilla/5.0 (Windows NT 6.1; WOW64; rv:43.0) Gecko/20100101 Firefox/43.0', 0, '2016-01-28 09:04:16'),
(13, 2, 'c00bff24a74336e5f78556025fe9ecd4', '2016-01-25 13:46:46', '91.200.24.19', 'Mozilla/5.0 (Windows NT 6.1; WOW64; rv:43.0) Gecko/20100101 Firefox/43.0', 0, '2016-01-28 09:02:59'),
(14, 2, '991cb585f9894877e963fd3cbfc2904a', '2016-02-01 09:44:22', '91.200.24.19', 'Mozilla/5.0 (Windows NT 6.1; WOW64; rv:44.0) Gecko/20100101 Firefox/44.0', 0, '2016-02-01 09:44:46'),
(15, 2, '991cb585f9894877e963fd3cbfc2904a', '2016-02-01 13:52:28', '91.200.24.19', 'Mozilla/5.0 (Windows NT 6.1; WOW64; rv:44.0) Gecko/20100101 Firefox/44.0', 0, '2016-02-02 10:44:06'),
(16, 2, '91a8e9e3a2c361f99382b56f639005de', '2016-02-02 10:46:13', '91.200.24.19', 'Mozilla/5.0 (Windows NT 6.1; WOW64; rv:44.0) Gecko/20100101 Firefox/44.0', 0, '2016-02-04 10:22:09'),
(17, 2, '', '2016-02-19 08:53:38', '91.200.24.19', 'Mozilla/5.0 (Windows NT 6.1; WOW64; rv:44.0) Gecko/20100101 Firefox/44.0', 1, '2016-02-19 08:53:38');

--
-- Ograniczenia dla zrzutów tabel
--

--
-- Ograniczenia dla tabeli `i18n_group`
--
ALTER TABLE `i18n_group`
  ADD CONSTRAINT `i18n_group_ibfk_1` FOREIGN KEY (`translation_id`) REFERENCES `i18n_translation` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
