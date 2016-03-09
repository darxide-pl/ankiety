-- phpMyAdmin SQL Dump
-- version 4.2.7.1
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Czas generowania: 28 Cze 2015, 20:23
-- Wersja serwera: 5.6.20
-- Wersja PHP: 5.5.15

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Baza danych: `foto`
--

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `contact_form`
--

CREATE TABLE IF NOT EXISTS `contact_form` (
`id` int(11) NOT NULL,
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
  `ip` varchar(24) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `gallery`
--

CREATE TABLE IF NOT EXISTS `gallery` (
`id` int(11) NOT NULL,
  `name` varchar(256) NOT NULL,
  `alias` varchar(256) NOT NULL,
  `description` longtext NOT NULL,
  `add_date` datetime NOT NULL,
  `update_date` datetime NOT NULL,
  `update_user_id` int(11) NOT NULL,
  `pos` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `gallery_image`
--

CREATE TABLE IF NOT EXISTS `gallery_image` (
`id` int(11) NOT NULL,
  `add_date` datetime NOT NULL,
  `add_user_id` int(11) NOT NULL,
  `gallery_id` int(11) NOT NULL,
  `filename` varchar(256) NOT NULL,
  `title` varchar(256) NOT NULL,
  `type` varchar(32) NOT NULL,
  `pos` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `i18n_group`
--

CREATE TABLE IF NOT EXISTS `i18n_group` (
`id` int(11) NOT NULL,
  `module` varchar(32) NOT NULL,
  `view` varchar(32) NOT NULL,
  `translation_id` int(11) NOT NULL
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=243 ;

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
(242, 'contactforms', 'index', 207);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `i18n_language`
--

CREATE TABLE IF NOT EXISTS `i18n_language` (
`id` int(11) NOT NULL,
  `key` varchar(3) NOT NULL,
  `name` varchar(32) NOT NULL,
  `add_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `i18n_translation`
--

CREATE TABLE IF NOT EXISTS `i18n_translation` (
`id` int(11) NOT NULL,
  `lang` varchar(2) NOT NULL,
  `key` varchar(128) NOT NULL,
  `text` varchar(512) NOT NULL
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=208 ;

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
(207, 'pl', 'no contact forms in database', 'Brak zapytan w bazie danych.');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `logo`
--

CREATE TABLE IF NOT EXISTS `logo` (
`id` int(11) NOT NULL,
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
  `pos` int(11) NOT NULL
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=9 ;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `news`
--

CREATE TABLE IF NOT EXISTS `news` (
`id` int(11) NOT NULL,
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
  `publish` tinyint(1) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `news_copy`
--

CREATE TABLE IF NOT EXISTS `news_copy` (
`id` int(11) NOT NULL,
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
  `user_id` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `page`
--

CREATE TABLE IF NOT EXISTS `page` (
`id` int(11) NOT NULL,
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
  `fullwidth` tinyint(1) NOT NULL
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Zrzut danych tabeli `page`
--

INSERT INTO `page` (`id`, `add_date`, `language`, `group_id`, `type`, `title`, `lead`, `text`, `user_id`, `modify_date`, `parent_id`, `page_type`, `target`, `url`, `path`, `alias`, `meta_title`, `meta_keywords`, `meta_description`, `views_total`, `publish`, `pos`, `homepage`, `hide_in_menu`, `menu_title`, `system_key`, `access`, `image_filename`, `listing`, `fullwidth`) VALUES
(1, '2015-06-28 18:29:54', 'pl', 0, '', 'STRONA GŁÓWNA', '', '', 0, '2015-06-28 18:30:09', 0, 0, 0, '', '', 'strona-glowna', 'JSTC', '', '', 338, 1, 0, 1, 0, '', 'home', 0, '', 0, 0);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `page_data`
--

CREATE TABLE IF NOT EXISTS `page_data` (
  `key` varchar(128) NOT NULL,
  `lang` varchar(2) NOT NULL,
  `value` longtext NOT NULL,
  `type` enum('text','html','json','image') NOT NULL
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
('home_offer', 'pl', '<p>Działalność firmy DS DRON cechuje się wysokim poziomem elastyczności, w przypadku niestandardowych zleceń proszę o kontakt.</p>\n\n<ul>\n	<li>Rejestracja foto/video obiekt&oacute;w oraz wydarzeń z powietrza w jakości FullHD lub 4K,</li>\n	<li>możliwość zrealizowania zar&oacute;wno surowego materiału, jak i montażu oraz obr&oacute;bki,</li>\n	<li>możliwość transmisji na żywo w jakości FullHD przez serwis Youtube,</li>\n	<li>nagrania pamiątkowe, np. wesela, rocznice, imprezy,</li>\n	<li>materiały promocyjne obiekt&oacute;w, miast, osiedli,</li>\n	<li>wsp&oacute;łpraca z firmami zajmującymi się tradycyjnym filmowaniem,</li>\n	<li>wsp&oacute;łpraca z agencjami reklamowymi oraz promocyjnymi,</li>\n	<li>indywidualna wycena.</li>\n</ul>\n', 'text');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `page_faq`
--

CREATE TABLE IF NOT EXISTS `page_faq` (
`id` int(11) NOT NULL,
  `page_id` int(11) NOT NULL,
  `add_date` datetime NOT NULL,
  `question` text NOT NULL,
  `answer` text NOT NULL,
  `pos` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `page_group`
--

CREATE TABLE IF NOT EXISTS `page_group` (
`id` int(11) NOT NULL,
  `name` varchar(256) NOT NULL
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
`id` int(11) NOT NULL,
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
  `pos` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `product_attribute`
--

CREATE TABLE IF NOT EXISTS `product_attribute` (
  `product_id` int(11) NOT NULL,
  `attribute_id` int(11) NOT NULL,
  `value` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `product_image`
--

CREATE TABLE IF NOT EXISTS `product_image` (
`id` int(11) NOT NULL,
  `add_date` datetime NOT NULL,
  `add_user_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `filename` varchar(256) NOT NULL,
  `title` varchar(256) NOT NULL,
  `type` varchar(32) NOT NULL,
  `pos` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `product_movie`
--

CREATE TABLE IF NOT EXISTS `product_movie` (
`id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `title` varchar(256) NOT NULL,
  `url` varchar(512) NOT NULL,
  `pos` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `product_relation`
--

CREATE TABLE IF NOT EXISTS `product_relation` (
  `product_id` int(11) NOT NULL,
  `related_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin2;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `product_stroller`
--

CREATE TABLE IF NOT EXISTS `product_stroller` (
`id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `brand` varchar(256) NOT NULL,
  `name` varchar(256) NOT NULL,
  `pos` int(11) NOT NULL
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
  `data` longtext CHARACTER SET utf8 NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Zrzut danych tabeli `session`
--

INSERT INTO `session` (`id`, `name`, `add_date`, `modify_date`, `expires`, `remember`, `data`) VALUES
('612kjthgtrd0ib1ri9f14f4vr2', 'CMS', '2015-06-28 17:22:43', NULL, 1436721763, 0, 'SESSION_CLIENT_BROWSER|s:72:"Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101 Firefox/38.0";language|s:2:"pl";mod_pages|a:2:{s:8:"language";s:2:"pl";s:8:"group_id";s:1:"0";}user_login_record_id|i:3;user_loged|b:1;user_id|s:1:"1";user_group|s:10:"programers";user_password|s:40:"633e86f0428660b85f4dd2ea4304ced3c4d3637a";user_login|s:16:"vsemak@gmail.com";user_login_time|s:19:"2015-06-28 18:29:26";loged_right_now|i:0;list_pages_index|a:3:{s:7:"filters";a:0:{}s:8:"order_by";N;s:9:"order_dir";N;}list_users_groups_rights|a:3:{s:7:"filters";a:0:{}s:8:"order_by";N;s:9:"order_dir";N;}mod_news|a:1:{s:8:"language";s:2:"pl";}'),
('tkamesmb4msau2ep75i0g2i4c5', 'CMS', '2015-06-28 17:37:22', NULL, 1436722642, 0, 'SESSION_CLIENT_BROWSER|s:109:"Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/43.0.2357.130 Safari/537.36";language|s:2:"pl";'),
('1jclnket70r103t9eb5ifh7871', 'CMS', '2015-06-28 17:59:33', NULL, 1436723973, 0, 'SESSION_CLIENT_BROWSER|s:109:"Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/43.0.2357.130 Safari/537.36";language|s:2:"pl";'),
('ho0r9g7l8183t2pgj1iriln3c3', 'CMS', '2015-06-28 18:03:52', NULL, 1436724232, 0, 'SESSION_CLIENT_BROWSER|s:109:"Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/43.0.2357.130 Safari/537.36";language|s:2:"pl";'),
('3h7pbufe8ovsrvnkv89gv5mm36', 'CMS', '2015-06-28 18:03:53', NULL, 1436724233, 0, 'SESSION_CLIENT_BROWSER|s:109:"Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/43.0.2357.130 Safari/537.36";language|s:2:"pl";'),
('u8stuiu7sqg6jck55c91nlp2u7', 'CMS', '2015-06-28 18:15:41', NULL, 1436724941, 0, 'SESSION_CLIENT_BROWSER|s:142:"Mozilla/5.0 (iPhone; CPU iPhone OS 7_0 like Mac OS X; en-us) AppleWebKit/537.51.1 (KHTML, like Gecko) Version/7.0 Mobile/11A465 Safari/9537.53";language|s:2:"pl";');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `slider`
--

CREATE TABLE IF NOT EXISTS `slider` (
`id` int(11) NOT NULL,
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
  `pos` int(11) NOT NULL
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=37 ;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `system_action`
--

CREATE TABLE IF NOT EXISTS `system_action` (
`id` int(11) NOT NULL,
  `name` varchar(128) NOT NULL,
  `constant` varchar(64) NOT NULL
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
`id` int(11) NOT NULL,
  `action_id` int(11) NOT NULL,
  `name` varchar(64) NOT NULL,
  `desc` text NOT NULL
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
`id` int(11) NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `user_id` int(10) unsigned NOT NULL,
  `type` varchar(32) NOT NULL,
  `object_id` int(10) unsigned NOT NULL,
  `add_date` datetime NOT NULL
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2356 ;

--
-- Zrzut danych tabeli `system_lock`
--

INSERT INTO `system_lock` (`id`, `timestamp`, `user_id`, `type`, `object_id`, `add_date`) VALUES
(2355, '2015-06-01 09:50:06', 2, 'page', 290, '0000-00-00 00:00:00');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `system_message`
--

CREATE TABLE IF NOT EXISTS `system_message` (
`id` int(11) NOT NULL,
  `store` tinyint(1) NOT NULL,
  `action_id` int(11) NOT NULL,
  `title` varchar(256) NOT NULL,
  `content` text NOT NULL,
  `active` tinyint(1) NOT NULL
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
`id` int(11) NOT NULL,
  `lang` varchar(2) NOT NULL,
  `message_id` int(11) NOT NULL,
  `title` varchar(512) NOT NULL,
  `content` text NOT NULL
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
`id` int(11) NOT NULL,
  `name` varchar(256) NOT NULL,
  `object` varchar(128) NOT NULL,
  `title` varchar(512) NOT NULL,
  `access` varchar(128) NOT NULL
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
`id` int(11) NOT NULL,
  `access` varchar(128) NOT NULL,
  `name` varchar(256) NOT NULL,
  `action` varchar(256) NOT NULL,
  `title` varchar(512) NOT NULL,
  `type` varchar(128) NOT NULL
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
`id` int(11) NOT NULL,
  `name` varchar(256) NOT NULL,
  `view` varchar(128) NOT NULL,
  `module_id` int(11) NOT NULL,
  `module` varchar(64) NOT NULL,
  `title` varchar(512) NOT NULL,
  `access` varchar(128) NOT NULL
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
`id` int(11) NOT NULL,
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
  `access_list` text NOT NULL
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT AUTO_INCREMENT=3 ;

--
-- Zrzut danych tabeli `user`
--

INSERT INTO `user` (`id`, `login`, `password`, `password_change_request`, `session_id`, `name`, `lastname`, `add_date`, `group_id`, `active`, `language`, `email`, `email_change_request`, `email_signature`, `avatar`, `super_admin`, `access_list`) VALUES
(1, NULL, '$2y$11$7JfWqqmOZ1tX/C1w9ojSl.b4HHuRQZDCWvefTQOeZIR2ipE8IGlfW', NULL, NULL, 'Super', 'Admin', '2015-03-06 14:56:24', 1, 1, 'pl', 'vsemak@gmail.com', NULL, NULL, NULL, 1, ''),
(2, NULL, '$2y$11$iXlgF7horeWzZ1sEixCaoeWSgXJ2eeRpkDgQGcVppH0J/W5wDszAq', NULL, NULL, 'Admin', '1', '2015-03-06 14:56:25', 2, 1, 'pl', 'admin@admin.pl', NULL, NULL, NULL, 0, 'a:1:{s:5:"users";a:3:{s:4:"read";s:1:"1";s:5:"write";s:1:"1";s:6:"remove";s:1:"1";}}');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `user_group`
--

CREATE TABLE IF NOT EXISTS `user_group` (
`id` tinyint(4) NOT NULL,
  `code` varchar(32) NOT NULL,
  `name` varchar(256) NOT NULL,
  `hidden` tinyint(1) DEFAULT NULL,
  `color` varchar(32) NOT NULL
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
`id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  `module` varchar(128) NOT NULL,
  `view` varchar(128) NOT NULL,
  `access` tinyint(1) NOT NULL
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
`id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `session_id` varchar(48) NOT NULL,
  `date` datetime NOT NULL,
  `ip_address` varchar(45) NOT NULL,
  `browser` varchar(512) NOT NULL,
  `error` tinyint(4) NOT NULL,
  `last_action_time` datetime NOT NULL
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC AUTO_INCREMENT=7 ;

--
-- Zrzut danych tabeli `user_login_history`
--

INSERT INTO `user_login_history` (`id`, `user_id`, `session_id`, `date`, `ip_address`, `browser`, `error`, `last_action_time`) VALUES
(1, 1, '', '2015-06-28 18:29:09', '::1', 'Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101 Firefox/38.0', 1, '2015-06-28 18:29:09'),
(2, 1, '', '2015-06-28 18:29:14', '::1', 'Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101 Firefox/38.0', 1, '2015-06-28 18:29:14'),
(3, 1, '612kjthgtrd0ib1ri9f14f4vr2', '2015-06-28 18:29:26', '::1', 'Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101 Firefox/38.0', 0, '2015-06-28 19:22:43'),
(4, 1, '', '2015-06-28 18:36:50', '::1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/43.0.2357.130 Safari/537.36', 1, '2015-06-28 18:36:50'),
(5, 1, '55ecivbr939j176vus2eoi0cu7', '2015-06-28 18:36:54', '::1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/43.0.2357.130 Safari/537.36', 0, '2015-06-28 19:22:57'),
(6, 1, 'ntocpcq4t0ghraotqvtam5i4l6', '2015-06-28 20:04:31', '::1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/43.0.2357.130 Safari/537.36', 0, '2015-06-28 20:07:10');

--
-- Indeksy dla zrzutów tabel
--

--
-- Indexes for table `contact_form`
--
ALTER TABLE `contact_form`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `gallery`
--
ALTER TABLE `gallery`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `gallery_image`
--
ALTER TABLE `gallery_image`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `i18n_group`
--
ALTER TABLE `i18n_group`
 ADD PRIMARY KEY (`id`), ADD KEY `module` (`module`), ADD KEY `view` (`view`), ADD KEY `translation_id` (`translation_id`);

--
-- Indexes for table `i18n_language`
--
ALTER TABLE `i18n_language`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `i18n_translation`
--
ALTER TABLE `i18n_translation`
 ADD PRIMARY KEY (`id`), ADD UNIQUE KEY `lang` (`lang`,`key`);

--
-- Indexes for table `logo`
--
ALTER TABLE `logo`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `news`
--
ALTER TABLE `news`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `news_copy`
--
ALTER TABLE `news_copy`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `page`
--
ALTER TABLE `page`
 ADD PRIMARY KEY (`id`), ADD KEY `type` (`type`);

--
-- Indexes for table `page_data`
--
ALTER TABLE `page_data`
 ADD PRIMARY KEY (`key`);

--
-- Indexes for table `page_faq`
--
ALTER TABLE `page_faq`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `page_group`
--
ALTER TABLE `page_group`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `product`
--
ALTER TABLE `product`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `product_attribute`
--
ALTER TABLE `product_attribute`
 ADD PRIMARY KEY (`product_id`,`attribute_id`);

--
-- Indexes for table `product_image`
--
ALTER TABLE `product_image`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `product_movie`
--
ALTER TABLE `product_movie`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `product_relation`
--
ALTER TABLE `product_relation`
 ADD PRIMARY KEY (`product_id`,`related_id`);

--
-- Indexes for table `product_stroller`
--
ALTER TABLE `product_stroller`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `session`
--
ALTER TABLE `session`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `slider`
--
ALTER TABLE `slider`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `system_action`
--
ALTER TABLE `system_action`
 ADD PRIMARY KEY (`id`), ADD UNIQUE KEY `constant` (`constant`);

--
-- Indexes for table `system_action_var`
--
ALTER TABLE `system_action_var`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `system_lock`
--
ALTER TABLE `system_lock`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `system_message`
--
ALTER TABLE `system_message`
 ADD PRIMARY KEY (`id`), ADD UNIQUE KEY `store` (`store`,`action_id`);

--
-- Indexes for table `system_message_description`
--
ALTER TABLE `system_message_description`
 ADD PRIMARY KEY (`id`), ADD UNIQUE KEY `lang` (`lang`,`message_id`);

--
-- Indexes for table `system_module`
--
ALTER TABLE `system_module`
 ADD PRIMARY KEY (`id`), ADD KEY `object` (`object`);

--
-- Indexes for table `system_module_action`
--
ALTER TABLE `system_module_action`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `system_module_view`
--
ALTER TABLE `system_module_view`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user_group`
--
ALTER TABLE `user_group`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user_group_right`
--
ALTER TABLE `user_group_right`
 ADD PRIMARY KEY (`id`), ADD KEY `group_id` (`group_id`);

--
-- Indexes for table `user_login_history`
--
ALTER TABLE `user_login_history`
 ADD PRIMARY KEY (`id`), ADD UNIQUE KEY `index1` (`user_id`,`date`), ADD KEY `session_id` (`session_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT dla tabeli `contact_form`
--
ALTER TABLE `contact_form`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT dla tabeli `gallery`
--
ALTER TABLE `gallery`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT dla tabeli `gallery_image`
--
ALTER TABLE `gallery_image`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT dla tabeli `i18n_group`
--
ALTER TABLE `i18n_group`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=243;
--
-- AUTO_INCREMENT dla tabeli `i18n_language`
--
ALTER TABLE `i18n_language`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT dla tabeli `i18n_translation`
--
ALTER TABLE `i18n_translation`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=208;
--
-- AUTO_INCREMENT dla tabeli `logo`
--
ALTER TABLE `logo`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=9;
--
-- AUTO_INCREMENT dla tabeli `news`
--
ALTER TABLE `news`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT dla tabeli `news_copy`
--
ALTER TABLE `news_copy`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT dla tabeli `page`
--
ALTER TABLE `page`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT dla tabeli `page_faq`
--
ALTER TABLE `page_faq`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT dla tabeli `page_group`
--
ALTER TABLE `page_group`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT dla tabeli `product`
--
ALTER TABLE `product`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT dla tabeli `product_image`
--
ALTER TABLE `product_image`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT dla tabeli `product_movie`
--
ALTER TABLE `product_movie`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT dla tabeli `product_stroller`
--
ALTER TABLE `product_stroller`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT dla tabeli `slider`
--
ALTER TABLE `slider`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=37;
--
-- AUTO_INCREMENT dla tabeli `system_action`
--
ALTER TABLE `system_action`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT dla tabeli `system_action_var`
--
ALTER TABLE `system_action_var`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=7;
--
-- AUTO_INCREMENT dla tabeli `system_lock`
--
ALTER TABLE `system_lock`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2356;
--
-- AUTO_INCREMENT dla tabeli `system_message`
--
ALTER TABLE `system_message`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT dla tabeli `system_message_description`
--
ALTER TABLE `system_message_description`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT dla tabeli `system_module`
--
ALTER TABLE `system_module`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=25;
--
-- AUTO_INCREMENT dla tabeli `system_module_action`
--
ALTER TABLE `system_module_action`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=145;
--
-- AUTO_INCREMENT dla tabeli `system_module_view`
--
ALTER TABLE `system_module_view`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=81;
--
-- AUTO_INCREMENT dla tabeli `user`
--
ALTER TABLE `user`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT dla tabeli `user_group`
--
ALTER TABLE `user_group`
MODIFY `id` tinyint(4) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT dla tabeli `user_group_right`
--
ALTER TABLE `user_group_right`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=994;
--
-- AUTO_INCREMENT dla tabeli `user_login_history`
--
ALTER TABLE `user_login_history`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=7;
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
