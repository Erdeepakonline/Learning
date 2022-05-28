-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: May 28, 2022 at 09:01 AM
-- Server version: 5.7.36
-- PHP Version: 7.4.26

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `deepak`
--

-- --------------------------------------------------------

--
-- Table structure for table `adv_address_log`
--

DROP TABLE IF EXISTS `adv_address_log`;
CREATE TABLE IF NOT EXISTS `adv_address_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_type` int(11) NOT NULL DEFAULT '0',
  `user_id` int(11) NOT NULL,
  `addr_id` int(11) NOT NULL DEFAULT '0',
  `name` varchar(200) NOT NULL,
  `address` varchar(255) NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Triggers `adv_address_log`
--
DROP TRIGGER IF EXISTS `addr_act_sts`;
DELIMITER $$
CREATE TRIGGER `addr_act_sts` AFTER INSERT ON `adv_address_log` FOR EACH ROW UPDATE adv_shop_address SET status=0 WHERE id != NEW.addr_id AND user_id=NEW.user_id AND user_type=NEW.user_type
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `adv_ad_details`
--

DROP TABLE IF EXISTS `adv_ad_details`;
CREATE TABLE IF NOT EXISTS `adv_ad_details` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(1000) NOT NULL,
  `state_id` varchar(100) NOT NULL DEFAULT '0',
  `city_id` varchar(100) NOT NULL DEFAULT '0',
  `pages` varchar(100) NOT NULL DEFAULT '0',
  `url` varchar(2000) NOT NULL,
  `start_dt` date DEFAULT NULL,
  `end_dt` date DEFAULT NULL,
  `payment_amt` int(11) NOT NULL,
  `pay_mode` varchar(200) DEFAULT NULL,
  `image` varchar(255) NOT NULL,
  `status` int(11) NOT NULL DEFAULT '0',
  `craeted` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `adv_ad_view`
--

DROP TABLE IF EXISTS `adv_ad_view`;
CREATE TABLE IF NOT EXISTS `adv_ad_view` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ad_id` int(11) NOT NULL DEFAULT '0',
  `ip_addr` varchar(100) NOT NULL,
  `city` varchar(100) NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `adv_artist`
--

DROP TABLE IF EXISTS `adv_artist`;
CREATE TABLE IF NOT EXISTS `adv_artist` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(50) NOT NULL,
  `slug` varchar(250) NOT NULL,
  `profile_pic` varchar(250) NOT NULL,
  `fname` varchar(100) NOT NULL,
  `lname` varchar(100) NOT NULL,
  `dob` date NOT NULL,
  `gender` int(11) NOT NULL,
  `email` varchar(150) NOT NULL,
  `mobile` varchar(20) NOT NULL,
  `alt_mobile` varchar(20) NOT NULL,
  `password` varchar(250) NOT NULL,
  `address` varchar(256) NOT NULL,
  `city` varchar(60) NOT NULL,
  `state` int(11) NOT NULL,
  `country` varchar(100) NOT NULL,
  `pincode` varchar(10) NOT NULL,
  `artist_bio` text NOT NULL,
  `work_since` varchar(100) NOT NULL,
  `mentor` text NOT NULL,
  `sponsor` text NOT NULL,
  `celeb` int(11) NOT NULL DEFAULT '0',
  `celeb_name` varchar(200) NOT NULL,
  `emp_type` varchar(120) NOT NULL,
  `cats` varchar(150) NOT NULL,
  `pmode` int(11) NOT NULL,
  `price` int(11) NOT NULL DEFAULT '0',
  `pshow` int(11) NOT NULL DEFAULT '0',
  `website` varchar(200) NOT NULL,
  `facebook` varchar(250) NOT NULL,
  `instagram` varchar(250) NOT NULL,
  `pinterest` varchar(250) NOT NULL,
  `youtube` text NOT NULL,
  `blog_url` text NOT NULL,
  `profile_step` int(11) NOT NULL DEFAULT '1',
  `ref_code` varchar(100) NOT NULL,
  `wallet` int(11) NOT NULL DEFAULT '0',
  `pedia_wallet` int(11) NOT NULL DEFAULT '0',
  `artist_offer` varchar(200) NOT NULL,
  `status` int(11) DEFAULT '1',
  `feature` int(11) NOT NULL DEFAULT '0',
  `direct_booking` int(11) NOT NULL DEFAULT '0',
  `piercing` int(11) NOT NULL DEFAULT '0',
  `minimum_booking_amount` varchar(50) NOT NULL,
  `verified` int(11) NOT NULL DEFAULT '0',
  `meta_title` varchar(200) NOT NULL,
  `meta_keyword` varchar(200) NOT NULL,
  `meta_desc` varchar(250) NOT NULL,
  `list_order` int(11) NOT NULL DEFAULT '0',
  `fs_date` date DEFAULT NULL,
  `fe_date` date DEFAULT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `last_login` date DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=465 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `adv_artist`
--

INSERT INTO `adv_artist` (`id`, `code`, `slug`, `profile_pic`, `fname`, `lname`, `dob`, `gender`, `email`, `mobile`, `alt_mobile`, `password`, `address`, `city`, `state`, `country`, `pincode`, `artist_bio`, `work_since`, `mentor`, `sponsor`, `celeb`, `celeb_name`, `emp_type`, `cats`, `pmode`, `price`, `pshow`, `website`, `facebook`, `instagram`, `pinterest`, `youtube`, `blog_url`, `profile_step`, `ref_code`, `wallet`, `pedia_wallet`, `artist_offer`, `status`, `feature`, `direct_booking`, `piercing`, `minimum_booking_amount`, `verified`, `meta_title`, `meta_keyword`, `meta_desc`, `list_order`, `fs_date`, `fe_date`, `created`, `last_login`) VALUES
(1, 'VS97Z7URY0', 'ashraf-ali', 'profile-pic-1617797102.jpg', 'Ashraf Ali', 'Akhtar', '1994-09-07', 1, 'ashrafeyeweb@gmail.com', '9140740297', '012040756435', 'f19b8dc2029cf707939e886e4b164681', '123 ABC Road Sctor Z1', '158', 13, '1', '226016', 'hi', '1980', 'Tattoo Guruz,Simple Tattooz,Grey TATTOO,Saundaryam,bhilaigarh', 'Keshav,Shrishti,Shivtosh,Veer,anas', 2, 'Ritesh Bhandari,Divya Ghosla,Priya Nagpal,Jatin manchanda,Kirori Lal', '', '1,3,6,22,23', 2, 1800, 0, 'https://www.thetattoopedia.com', 'http://facebook.com', 'https://instagram.com', 'https://pinterest.com', 'https://youtu.be', 'https://google.com', 3, 'SHOUTT21', 1091, 0, '25% OFF on All type tattoo', 0, 0, 1, 1, '1500', 1, 'Ashraf Ali Tatto Artist in India | The TattooPedia', 'Ashraf Ali', 'Ashraf Ali is the top tattoo artist at The Tattoo Pedia in India. Our artist gives you top quality tattoo designs and ideas for a cheap rate.', 0, NULL, NULL, '2020-11-12 18:02:23', NULL),
(4, 'KVY2G28C1A', 'lokesh-verma', '', 'Lokesh', 'Verma', '0000-00-00', 1, 'devilztattooz@gmail.com', '9876543285', '', 'd20b9098a4466cb1b519f2d6fca50cb2', '', '', 0, '', '', '', '', '', '', 0, '', '', '', 0, 0, 0, '', '', '', '', '', '', 1, '', 0, 0, '', 1, 0, 0, 0, '', 0, 'Lokesh Verma Tatto Artist in India | The TattooPedia', 'Lokesh Verma', 'Lokesh Verma is one of the best tattoo artists at The Tattoo Pedia in India. He provides you top quality tattoo designs and ideas for a cheap rate.', 0, NULL, NULL, '2020-11-15 18:23:56', NULL),
(5, '34Q4RHZ7BV', 'tuhi-dutta', 'profile-pic-1606315311.jpg', 'Tuhi', 'Dutta', '1989-10-23', 2, 'tuhis.tattoo@gmail.com', '9038042981', '', '1702bd251c5312a62d6569708b8313cf', '63/29/8 Dum Dum Road, Surer Math, near Indian Art College', '589', 35, '1', '700074', 'Tuhi\'s Tattoo studio, run by Kolkata\'s first female tattoo artist, Tuhi. We believe in making good tattoos maintaining the utmost hygiene. ', '2012', 'self', '', 3, '', '', '3,5,10,12,26', 2, 2000, 1, '', 'https://p.facebook.com/tuhistattoostudio/', 'https://www.instagram.com/tuhistattoostudio/', '', 'https://m.youtube.com/channel/UCTZFoZn9q-36rDazbBFZ5ug', '', 3, '', 0, 0, '', 1, 1, 1, 0, '500', 1, 'Tuhi Dutta Tatto Artist in India | The TattooPedia', 'Tuhi Dutta', 'Tuhi Dutta is the top tattoo artist at The Tattoo Pedia in India. Our artist gives you top quality tattoo designs and ideas for a cheap rate.', 12, NULL, NULL, '2020-11-17 12:15:52', NULL),
(6, '2XU3CG1K5Z', 'shrishti-aggarwal-1', '', 'Shrishti', 'Aggarwal', '1970-01-01', 2, 'shrishtiaggarwal93@gmail.com', '9540061789', '', '38249b3a6a5b36e4f2e0e268a701739d', 'Gurgaon', '155', 13, '1', '', 'fkdsFsdafsdhflh aifjkadf jAJFH FJH ;ajof ;weohf F jaf ijF Jand jhef jasf fa dNAJDn fa IJAFN KAJSFND oqjf;d fkdsFsdafsdhflh aifjkadf jAJFH FJH ;ajof ;weohf F jaf ijF Jand jhef jasf fa dNAJDn fa IJAFN KAJSFND oqjf;d fkdsFsdafsdhflh aifjkadf jAJFH FJH ;ajof ;weohf F jaf ijF Jand jhef jasf fa dNAJDn fa IJAFN KAJSFND oqjf;d', '2017', 'KEHSAV', 'KESHAV', 1, 'KESHAV', '', '1,4,7,11,14', 1, 10000, 1, '', '', '', '', '', '', 3, '', 0, 100, '', 0, 0, 1, 2, '3000', 1, 'The TattooPedia: Tatto Artist Shrishti Aggarwal', 'Shrishti Aggarwal', 'Shrishti Aggarwal is one of the best tattoo artists at The Tattoo Pedia in India. She provides you top quality tattoo designs and ideas for a cheap rate.', 0, NULL, NULL, '2020-11-17 15:07:11', NULL),
(9, '3WSYM3QU93', 'anmoll-baid', '', 'Annmoll ', 'Baid', '1982-05-12', 1, 'anmolbaid@rediffmail.com', '9373360007', '', 'd20b9098a4466cb1b519f2d6fca50cb2', 'M3 Magneto Mega Mart & Star Tattoo,Opposite Swami Tailors, Near Prabhakar Photo Studio, Samadhan Hotel Road, Indira Market,Wardha ', '331', 21, '1', '442001', 'Welcome to \"M3 STAR TATTOO & PIERCING STUDIO\", a safe,clean,friendly, fun & modern studio.\r\n\r\nWhether its your 1st tattoo or an add to your collection, we at \"M3 STAR TATTOO\" have the skill & experience to give you that specific piece of artwork.\r\n\r\nIf you are looking to have a meaningful work of art etched into your skin or add a style statement, a custom designed or a coloured tattoo then \"M3 STAR TATTOO & PIERCING STUDIO\" is the best place for you.\r\n\r\nCustomer satisfaction is what makes us buzz & it is our goal to achieve work you will be extremely proud of. And thats one reason people are coming to us from all over India.\r\n\r\nHave a look on some Tattoos Tattooed @ \"M3 STAR TATTOO & PIERCING STUDIO\"\r\n\r\nAnnmoll Baid ( Jain )\r\nTattoo Artist/Owner M3.', '2013', '', '', 1, 'Jasleen Matharu, Vishal Kothari, VIP Vijay Pawar', '', '1,7,10,16,26', 1, 800, 0, '', 'https://www.facebook.com/groups/300654050006931/?ref=share', '', '', '', '', 3, '', 0, 0, '', 1, 0, 1, 0, '2000', 1, 'Annmoll Baid Tatto Artist in India | The TattooPedia', 'Annmoll Baid', 'Annmoll Baid is one of the best tattoo artists at The Tattoo Pedia in India. He provides you top quality tattoo designs and ideas for a cheap rate.', 5, NULL, NULL, '2020-11-19 10:17:54', NULL),
(15, 'GF311AQD5C', 'pritesh-yagnik', '', 'Pritesh', 'Yagnik', '1979-04-12', 1, 'priteshyagnik3@gmail.com', '8460123458', '8980123457', 'd20b9098a4466cb1b519f2d6fca50cb2', '2 Shivnandan complex, opp union bank, jaihind cross road, Maninagar', '134', 12, '1', '', 'My self Pritesh Yagnik.I m tattoo artist in Ahmadabad .I m as a tattoo artist since 2002.i have 2 tattoo studio in Ahmadabad .We are Professional tattoo maker.customer satisfaction is our 1st priority.we believe in 100% higine and safe tattoo work.', '2002', 'Swaminarayan school', '', 2, '', '', '4,7,10,22,26', 1, 400, 1, '', 'The Tattoo Galaxy', 'thetattoogalaxy', 'thetattoogalaxy', '', '', 3, '', 0, 0, '', 1, 0, 1, 0, '500', 1, 'The TattooPedia: Tatto Artist Pritesh Yagnik', 'Pritesh Yagnik', 'Pritesh Yagnik is the top tattoo artist at The Tattoo Pedia in India. Our artist gives you top quality tattoo designs and ideas for a cheap rate.', 6, NULL, NULL, '2020-11-20 12:10:27', NULL),
(17, '6W4QR9GNH9', 'tahir-hussain', '', 'Tahir ', 'Hussain', '0000-00-00', 1, 'tahirhussain0701@gmail.com', '9582156480', '', 'd20b9098a4466cb1b519f2d6fca50cb2', '', '', 0, '', '', '', '', '', '', 0, '', '', '', 0, 0, 0, '', '', '', '', '', '', 1, '', 0, 0, '', 1, 0, 0, 0, '', 1, 'The TattooPedia: Tatto Artist Tahir Hussain', 'Tahir Hussain', 'Tahir Hussain is the top tattoo artist at The Tattoo Pedia in India. Our artist gives you top quality tattoo designs and ideas for a cheap rate.', 0, NULL, NULL, '2020-11-20 13:32:48', NULL),
(18, 'Y6XM6B2AE2', 'meghna-saikia', '', 'Meghna ', 'Saikia', '0000-00-00', 2, 'meghnasaikia70@icloud.com', '7002314654', '', 'd20b9098a4466cb1b519f2d6fca50cb2', '', '', 0, '', '', '', '', '', '', 0, '', '', '', 0, 0, 0, '', '', '', '', '', '', 1, '', 0, 0, '', 1, 0, 0, 0, '', 1, 'Meghna Saikia Tatto Artist in India | The TattooPedia', 'Meghna Saikia', 'Meghna Saikia is one of the best tattoo artists at The Tattoo Pedia in India. She provides you top quality tattoo designs and ideas for a cheap rate.', 0, NULL, NULL, '2020-11-20 14:05:54', NULL),
(19, 'K4MGBH66D8', 'kalee-k', 'profile-pic-1606977819.jpg', 'kalee', 'k', '1970-01-01', 2, 'kalee.tribeinkk@gmail.com', '9113621102', '', 'd20b9098a4466cb1b519f2d6fca50cb2', 'Saldhana orchid Goa ', '649', 11, '1', '', 'Atma NAMASTE! Welcome to tribeink kalee here - I curate handpoke ritual tattoos & tribal traditional tattoos in Goa India. My inspiration is to revive lost ancient practices of tattoo traditions in India. The tattoos are created with all natural holistic materials that is hand crafted by myself. The origin of my tattoo style is most typically tribal - with complimentary styles of ornamental and geometry outlook ', '2013', 'Skin deep ', '', 3, '', '', '5,7,8,21,22', 2, 0, 0, '', '', 'https://instagram.com/tribeink?igshid=1cwgb0b5qkhhl', '', '', '', 3, '', 0, 0, '', 1, 0, 1, 0, '2000', 1, 'kalee k Tatto Artist in India | The TattooPedia', 'kalee k', 'kalee k is the top tattoo artist at The Tattoo Pedia in India. Our artist gives you top quality tattoo designs and ideas for a cheap rate.', 7, NULL, NULL, '2020-11-21 09:12:58', NULL),
(20, 'F4A6HT8K4E', 'goutham-ramesh', 'profile-pic-1606133344.jpg', 'Goutham ', 'Ramesh', '1997-01-23', 1, 'gouthamramesh4@gmail.com', '9620345156', '', 'd20b9098a4466cb1b519f2d6fca50cb2', '10 , 2and cross,2and main,gowthamapuram,ulsoor ', '660', 17, '1', '', 'Hi am a Bangalore artist,  specialized in realism,black work,colour work, cover ups and neo traditional, and good at digital art and graffiti, with the experience of 6 years of tattooing, and 4 years of experience in body piercing, do check the profil and contact number below. And book your appointments. ', '2012', 'Self thought ', '', 3, 'Soundriya', '', '4,13,16,18,26', 1, 650, 0, '', 'https://m.facebook.com/profile.php?id=100005078291909', 'https://www.instagram.com/gouthamgogoink/?hl=en', '', '', '', 3, '', 0, 0, '', 1, 0, 1, 0, '1500', 1, 'Goutham-Ramesh', 'Goutham-Ramesh', 'Goutham-Ramesh', 10, NULL, NULL, '2020-11-23 11:56:35', NULL),
(21, '90P9BXKHN4', 'prashant-yaduvanshi', 'profile-pic-1609249663.jpg', 'Prashant', 'Yaduvanshi', '1970-01-01', 1, 'yaduvanshi.1732@gmail.com', '8160377424', '', '698a00c0968d2ed12ce7642a59f04463', 'D40/4, indra enclave, saket', '120', 10, '1', '', 'I travel and work as a guest artist, exploring realism and coverups in depth, but flexible with all styles. Based in New Delhi, I am also exploring and learning digital art to improvise my skill to serve better to my clients! I have worked in Mumbai, Goa, Bangalore, Allahabad and Delhi in India and The Hague and Amsterdam in The Netherlands as a guest artist.', '2014', 'Self Taught', '', 1, 'Hard Kaur, Mohini Dey', '', '10,12,16,18,26', 2, 6000, 1, '', '', 'www.instagram.com/shaman_inks', '', 'https://youtu.be/tfZpDuZFkz4', '', 3, '', 0, 0, '', 1, 1, 1, 0, '3000', 1, 'Prashant-Yaduvanshi', 'Prashant-Yaduvanshi', 'Prashant-Yaduvanshi', 8, NULL, NULL, '2020-11-25 08:34:31', NULL),
(22, 'DX66T7SK6E', 'vaishnavi-jamdar-a', '', 'Vaishnavi', 'Jamdar', '0000-00-00', 2, 'jamdarvaishnavi21@gmail.com', '7620204840', '', 'd20b9098a4466cb1b519f2d6fca50cb2', '', '', 0, '', '', '', '', '', '', 0, '', '', '', 0, 0, 0, '', '', '', '', '', '', 1, '', 0, 0, '', 1, 0, 0, 0, '', 1, 'Vaishnavi-Jamdar', 'Vaishnavi-Jamdar', 'Vaishnavi-Jamdar', 0, NULL, NULL, '2020-11-25 13:26:27', NULL),
(23, 'VE44D2YSQ5', 'angel-zimik', 'profile-pic-1629059780.jpeg', 'Angel ', 'Zimik', '1970-01-01', 2, 'angelkunzimik@gmail.com', '9876543285', '', '8bddc0b98492f1db7a6b88f8d4050d57', 'Gk 1, M block ', '120', 10, '1', '', 'Angel zimik from Manipur, Ukhrul who started her tattooing career in 2018 April is now one of the most booked artist in Devilz tattooz, New Delhi, India. She specialised  in the single needle technique and fine lines, and mastered in the type of style she do, Some would describe her works as minimalist, or geometric , but it is more then just that, her design blend around pattern with florae and fauna, spirituality, mysticism and a character of secret geometric touch with dynamic composition. Whilst most of her tattoos often contain all those elements, she would say her designs are something we cannot categorize in one or two standard tattoo styles. \r\nShe will often says that “”becoming a tattoo artist is a commitment, as the learning never stops. And I have never been committed to anything like this before in my life.\r\nThere are many years ahead of me, I still have lots to learn, lots of stories to hear, lots of tiring days ahead, lots of designing and 5:AM sleep. I cannot wait to do all of this over and over again. Because this is who iam and I’m much happier as a tattoo artist then anything else.””', '2018', 'Devilz tattooz', '', 3, '', '', '2,4,7,12,25', 2, 10000, 0, 'https://www.tattoosnewdelhi.com/', 'https://www.facebook.com/angel.kimiz', 'https://instagram.com/angel_inkylicious?igshid=m3cntcgsdqv3', 'https://pin.it/4GK3PFM', '', '', 3, '', 0, 0, '', 1, 0, 0, 2, '', 1, 'Angel-Zimik', 'Angel-Zimik', 'Angel-Zimik', 9, NULL, NULL, '2020-11-27 20:12:52', NULL),
(25, 'U4L40BMND1', 'ketan-saindane', 'profile-pic-1606666868.png', 'Ketan', 'Saindane', '1985-03-30', 1, 'ketology@gmail.com', '9819010674', '', 'd20b9098a4466cb1b519f2d6fca50cb2', 'Shop no 2 plot no 11A Basera and Basera Soc. Sector 10 vashi, navi mumbai', '676', 21, '1', '400703', 'Our bodies were made as blank pages to be filled with the ink of our stories.\r\n\r\nThey keep track of time. Sometimes things happen and you feel that you need to mark them down.\r\n\r\nInkholics is one of the leading Tattoo studio in Navi Mumbai Also known for all styles of tattoos and piercings.', '2003', 'L.S Raheja', '', 3, '', '', '2,10,16,18,26', 1, 700, 1, '', '', 'https://instagram.com/inkholics?igshid=gs1kk5i8zb8j', '', '', '', 3, '', 0, 0, '', 1, 0, 1, 0, '2000', 1, 'Ketan-Saindane', 'Ketan-Saindane', 'Ketan-Saindane', 9, NULL, NULL, '2020-11-29 15:18:13', NULL),
(26, '39VNUCD9Z4', 'shrishti-aggarwal', '', 'Shrishti', 'Aggarwal', '1993-12-22', 2, 'shrishtiaggarwal0@gmail.com', '9540061789', '9540061789', 'd20b9098a4466cb1b519f2d6fca50cb2', '16, Kailash Enclave, 2nd floor\r\nPitampura', '120', 10, '1', '110034', 'NA', '1980', '', '', 2, '', '', '2,5,8,11,14', 1, 5000, 0, '', '', '', '', '', '', 3, '', 0, 0, '', 0, 0, 0, 0, '', 1, 'Shrishti-Aggarwal', 'Shrishti-Aggarwal', 'Shrishti-Aggarwal\r\n', 0, NULL, NULL, '2020-12-02 08:42:06', NULL),
(27, 'DEFRL55A84', 'ritopriyo-saha', 'profile-pic-1612249367.jpg', 'Ritopriyo', 'Saha', '1985-04-07', 1, 'krishnakalis@gmail.com', '9748298107', '9916557528', '78c796e25019a85f664ffb135fe2015d', '475, 1st A Cross Rd, KHB Colony, 5th Block, Koramangala, Bengaluru, Karnataka 560095', '660', 17, '1', '', 'Ritopriyo Saha is a contemporary visual artist born in Calcutta, presently working in Bangalore. He is the founder of TRIPPINK Tattoos, Art & Culture Studio where he practices and teaches tattoo, painting and sculpture. His artworks have been previously exhibited in Barcelona, New Delhi, Calcutta and Bangalore. \r\nRitopriyo’s creative work reverberates around the rustic mysteries of India, based on deep human emotions, also drawing inspiration from contemporary European styles. He revels in abstract expressionism inspired from life’s relationships and memories. His style of work reflects flow, movement and balance.', '2009', 'Self-taught', '', 1, '', '', '1,2,3,4,7', 2, 3000, 0, 'www.trippinktattoos.com', 'https://m.facebook.com/trippinktattoos/?ref=bookmarks', 'https://instagram.com/trippinktattoos?igshid=1cmlw07tvmjg7', '', 'https://youtube.com/c/TrippinkTattoos', '', 3, '', 0, 0, '', 1, 0, 1, 1, '2000', 1, 'Ritopriyo-Saha', 'Ritopriyo-Saha', 'Ritopriyo-Saha\r\n', 11, NULL, NULL, '2020-12-03 14:09:57', NULL),
(28, 'B6V28NZH4G', 'savi-savi', 'profile-pic-1612332140.jpg', 'Savi', 'Savi', '1982-08-07', 2, 'cherish.tattoostudio@gmail.com', '9535458887', '9902061777', '227e885ccacb9cc1eb8cb0f394dfa813', '408/5m Rama murty nagar new police station road', '660', 17, '1', '560016', ' From a  corporate  operations manager 13years of experience in retail corporate. To a passionate   tattoo artist started a journey as Arrist in 2013 and going on .Specialized in all categories of tattoos and piercings cover up specialist, customiz design  a candid photographer,a classical dancer,love the art of cooking  most of all a mother of a beautiful daughter\r\n', '2013', 'Rahul', '', 1, 'South star Dancing star Danny, Director Shreejai, actress Hamsa pratap,music director Soni Acharya,Karnataka Cricket Captain Suraj,dance choreographer Supriya and more', '', '10,16,18,23,26', 2, 5000, 0, 'https://www.cherishtattoo.com/', 'https://www.facebook.com/savitha.xavier.9', 'https://www.instagram.com/tattoo_artist_savi?r=nametag', '', 'https://youtu.be/-mZCRCmxh54', '', 3, '', 0, 0, '', 1, 0, 1, 1, '1500', 1, 'Savi-Savi', 'Savi-Savi', 'Savi-Savi\r\n', 9, NULL, NULL, '2020-12-03 14:47:18', NULL),
(29, 'YNRK09F3D2', 'krishna-roy', 'profile-pic-1612788399.jpeg', 'Krishna', 'Roy', '1993-04-19', 2, 'frozeninkofficial@gmail.com', '7042284460', '9625594564', 'b502d2c888721eb902e64c6712eb5111', '45/5C/1A East Azad Nagar, Main Road, New Delhi ', '120', 10, '1', '110051', 'A multidisciplinary visual artist; Tattooist, Sculptor, Painter and Photographer. For tattoos I am more inclined towards fusion like a mix of realism composed with geometric shapes, abstract and typos. Hence, i can customise unique conceptual tattoo designs as per your personality, thoughts and budget. Your skin is my canvas and i know how negative impact it will create if it doesn\'t come out up to the mark. So i put serious attention from design ideation to final execution and through out the after care process until its completely healed creating a master piece that everybody will envy.  As a contemporary fine art practitioner my work is inspired from study research and exploration about nature, civilisation and reflection of society what I see in my daily life; and I try to draw connection between how their act affects or impacts today’s situation as in socio political and cultural context.', '2013', 'College of art New Delhi', '', 3, '', '', '1,4,12,16,18', 2, 8000, 1, 'http://www.frozeninkandart.com', 'http://www.Facebook.com/frozeninkandart', 'http://www.Instagram.com/frozeninkandart', 'http://www.Pinterest.com/frozeninkandartt/best-tattoo-artist-in-delhi-india-krishna-Roy/', 'http://www.YouTube.com/channel/UC3scWZLZctUoGMMHRJE2Rkg?view_as=subscriber', '', 3, '', 0, 650, '10% OFF on all Portrait Tattoos', 1, 0, 1, 1, '2000', 1, 'Krishna-Roy', 'Krishna-Roy', 'Krishna-Roy\r\n', 11, NULL, NULL, '2020-12-04 04:41:36', NULL),
(31, '755B3PNSYJ', 'vaishnavi-jamdar', 'profile-pic-1607429451.jpg', 'Vaishnavi', 'Jamdar', '1998-02-21', 2, 'kayana.art21@gmail.com', '7620204840', '8147003677', '173fabee1aa8fca9b1c622d7d120e8f4', 'BTM layout 2nd stage.', '660', 17, '1', '560076', 'Hello People!\r\nI have been tattooing since a year and half. I completed my training under Aliens Tattoo School. I have always been fond of art as I believe it is the best medium to express your emotions,interests, and your own self too. \r\nMy favourite style of realism. But i tattoo old school, trash polka, line art etc. I also believe in customisation of designs as it gives a unique design for every individual.\r\nEagerly waiting to work on my next project.', '2019', 'Aliens Tattoo School', '', 2, '', '', '5,10,13,16,18', 1, 600, 1, '', '', 'https://instagram.com/kayana_art?igshttps://instagram.com/kayana_art?igshid=1if0sz970nxq7hid=1if0sz970nxq7', '', '', '', 3, '', 0, 0, 'Flat 30% off till December 30th 2020', 1, 0, 1, 0, '500', 1, 'Vaishnavi-Jamdar', 'Vaishnavi-Jamdar', 'Vaishnavi-Jamdar\r\n', 11, NULL, NULL, '2020-12-08 11:52:15', NULL),
(32, '1T6QW9VSX2', 'vansh-chhabra', '', 'Vansh', 'Chhabra', '0000-00-00', 1, 'pigmentedtattoos@gmail.com', '8629013727', '', 'd20b9098a4466cb1b519f2d6fca50cb2', '', '', 0, '', '', '', '', '', '', 0, '', '', '', 0, 0, 0, '', '', '', '', '', '', 1, '', 0, 0, '', 1, 0, 0, 0, '', 1, 'Vansh-Chhabra', 'Vansh-Chhabra', 'Vansh-Chhabra\r\n', 0, NULL, NULL, '2020-12-12 18:36:51', NULL),
(33, '4H2M4YNA5Q', 'akshya-behera', '', 'Akshya', 'Behera', '0000-00-00', 1, 'darkspeartattoos@gmail.com', '7008742845', '', 'd20b9098a4466cb1b519f2d6fca50cb2', '', '', 0, '', '', '', '', '', '', 0, '', '', '', 0, 0, 0, '', '', '', '', '', '', 1, '', 0, 0, '', 1, 0, 0, 0, '', 1, 'akshya-behera', 'Akshya Behera', 'Akshya Behera is the top tattoo artist at The Tattoo Pedia in India. Our artist gives you top quality tattoo designs and ideas for a cheap rate.', 0, NULL, NULL, '2020-12-13 14:22:03', NULL),
(34, 'Q7PJF1N6L2', 'chetan-salhotra', '', 'Chetan', 'Salhotra', '1986-09-20', 1, 'tattoosbychetan@gmail.com', '9711361010', '', 'd20b9098a4466cb1b519f2d6fca50cb2', '13-A,1st floor, Hauz Khas village', '120', 10, '1', '110016', 'Hi', '2006', '', '', 1, 'Akshdeep Nath', '', '5,16,18,23,26', 1, 1000, 1, 'www.inkspacestudio.com', '', 'www.instagram.com/Inkspace.studio', '', '', '', 3, '', 0, 0, '', 1, 0, 1, 0, '1000', 1, 'Chetan-Salhotra', 'Chetan Salhotra', 'Chetan Salhotra is the best tattoo artist at The Tattoo Pedia in India. Our artist gives you top quality tattoo design and ideas for a cheap rate.', 4, NULL, NULL, '2020-12-14 07:38:31', NULL),
(35, '817BCLU4KS', 'khushi-murpana', '', 'Khushi', 'Murpana', '1970-01-01', 2, 'murpana.khushi25@gmail.com', '9920771097', '', 'b27c5a5b7f6ad7477d1e864cd3acd6f9', 'Bandra', '672', 21, '1', '', '', '', '', '', 0, '', '', '4,9,23', 2, 5000, 0, 'xyz.com', 'https://www.instagram.com/khushi_murpana/', 'https://www.instagram.com/khushi_murpana/', 'https://www.instagram.com/khushi_murpana/', 'https://www.instagram.com/khushi_murpana/', 'https://www.instagram.com/khushi_murpana/', 3, '', 0, 0, '', 0, 0, 0, 0, '', 1, 'Khushi-Murpana', 'Khushi-Murpana', 'Khushi-Murpana\r\n', 0, NULL, NULL, '2020-12-17 08:38:29', NULL),
(100, 'R6TBJ8Q3Y8', 'jai-karan', '', 'Jai', 'Karan', '1994-06-09', 1, 'jaieyeweb@gmail.com', '9454785001', '', 'e6e061838856bf47e1de730719fb2609', '147 Sama Complex Brha Road Near Milan Lawn ', '513', 34, '1', '123456', '', '', '', '', 0, '', '', '', 0, 0, 0, '', '', '', '', '', '', 1, 'VS97Z7URY0', 0, 411, '', 0, 0, 0, 0, '', 1, 'Jai-karan', 'jai-karan', 'jai-karan\r\n', 0, NULL, NULL, '2020-12-22 05:46:33', NULL),
(103, 'BQ8799TRWH', 'keshav-singhania', '', 'keshav', 'singhania', '0000-00-00', 1, 'singhaniakeshav@yahoo.com', '9831524631', '', '5203d03e63adc8bbd71b9b117a4846c3', '', '', 0, '', '', '', '', '', '', 0, '', '', '', 0, 0, 0, '', '', '', '', '', '', 1, '2XU3CG1K5Z', 0, 100, '', 0, 0, 0, 0, '', 1, 'keshav-singhania', 'keshav-singhania', 'keshav-singhania\r\n', 0, NULL, NULL, '2020-12-23 08:17:03', NULL),
(104, '6SDLA7K1X6', 'rahul-venkat', '', 'Rahul', 'Venkat', '0000-00-00', 1, 'rahulrocks1607@gmail.com', '9833824191', '', '3f729542981e36772d89d7b7f6939e2e', '', '', 0, '', '', '', '', '', '', 0, '', '', '', 0, 0, 0, '', '', '', '', '', '', 1, '', 0, 0, '', 1, 0, 0, 0, '', 1, 'Rahul-Venkat', 'Rahul-Venkat', 'Rahul-Venkat\r\n', 0, NULL, NULL, '2020-12-24 08:41:42', NULL),
(111, 'SKN2W9F40U', 'nida-khan', '', 'Nida ', 'Khan', '0000-00-00', 2, 'khannida01724@gmail.com', '9619108857', '', '974609c33523e5254c111999fab818ac', '', '', 0, '', '', '', '', '', '', 0, '', '', '', 0, 0, 0, '', '', '', '', '', '', 1, '', 0, 0, '', 0, 0, 0, 0, '', 1, 'Nida -Khan', 'Nida -Khan', 'Nida -Khan\r\n', 0, NULL, NULL, '2020-12-27 13:05:39', NULL),
(112, '84P8C6FHBQ', 'sakshi-saboo', '', 'Sakshi ', 'Saboo', '0000-00-00', 2, 'saboosakshi8@gmail.com', '9004892117', '', '018a04efeb3d7bf0feedbab9bca47401', '', '', 0, '', '', '', '', '', '', 0, '', '', '', 0, 0, 0, '', '', '', '', '', '', 1, '', 0, 0, '', 0, 0, 0, 0, '', 1, 'Sakshi -Saboo', 'Sakshi -Saboo', 'Sakshi -Saboo\r\n', 0, NULL, NULL, '2020-12-27 13:06:13', NULL),
(116, 'WPTR84J32F', 'gavin-peter-rodrigues', 'profile-pic-1610226869.jpg', 'Gavin Peter', 'Rodrigues', '1986-07-04', 1, 'gavins.tattoo@gmail.com', '9819490290', '', '17662c763eb151fc01cf2f1e34c8efb3', 'G101 Church Hill Compound,Opp St.Thomas Church,Holy Cross Road,I.C colony, Borivali West ?https://goo.gl/maps/Pmd13sj4H7y', '672', 21, '1', '400103', '“Tattoos have power and magic all on their own. They decorate the body but they also enhance the Soul”\r\nLine\'s & Dots are my favorite... Also love doing full colour & shading work. Neatness & precision is what I aim for...\r\nI don\'t do Portraits as it ain\'t my forté', '2011', '', '', 1, '', '', '4,5,10,17,26', 1, 750, 1, '', 'https://www.facebook.com/Gavins.Tattoo/', 'https://www.instagram.com/gavinstattoo_inkbrotherz?r=nametag', '', '', '', 3, '', 0, 0, '', 1, 0, 1, 0, '1000', 1, 'Gavin Peter-Rodrigues', 'Gavin Peter-Rodrigues', 'Gavin Peter-Rodrigues\r\n', 6, NULL, NULL, '2020-12-29 12:21:22', NULL),
(117, 'Z3Q9P6EF8D', 'swapnil-parab', 'profile-pic-1609247716.jpg', 'Swapnil', 'Parab', '1986-12-21', 1, 'sp.blackpearl@gmail.com', '9820771496', '9987079105', '2f8c10c0f061e0b4158182c1912dd42a', 'Jogeshwari East', '672', 21, '1', '400060', 'This is Swapnil Parab. I am the founder and main artist at Black Pearl Ink Tattoo Studio in Mumbai. I have been a tattoo artist for more than 12 years now. After completing animation degree, I didn\'t realize when my passion for art drew me to tattoo industry. I am humbled with how my journey has unfolded over the years. I love every tattoo that I make but especially the realistic tattoos and tribal art are my favorites.', '2007', 'Australian Artist', '', 3, '', '', '7,18,19,22,26', 1, 1000, 0, 'https://www.blackpearlink.com/about-us/', 'https://www.facebook.com/swapnil.blackpearl', '', '', '', '', 3, '', 0, 0, '', 1, 0, 0, 0, '', 1, 'Swapnil-Parab', 'Swapnil-Parab', 'Swapnil-Parab\r\n', 8, NULL, NULL, '2020-12-29 12:39:58', NULL),
(118, '19UGV8N5FT', 'rajat-patidar', '', 'Rajat', 'Patidar', '0000-00-00', 1, 'rajatpatidar69@gmail.com', '9617461745', '', '7eacb36dfafe88d630bb38680add74b1', '', '', 0, '', '', '', '', '', '', 0, '', '', '', 0, 0, 0, '', '', '', '', '', '', 1, '', 0, 0, '', 1, 0, 0, 0, '', 1, 'Rajat-Patidar', 'Rajat-Patidar', 'Rajat-Patidar\r\n', 0, NULL, NULL, '2021-01-04 05:32:16', NULL),
(119, '2EQ30NZV5B', 'parth-vasani', '', 'Parth', 'Vasani ', '0000-00-00', 1, 'parthvasani44551@gmail.com', '8552954075', '', '82ce5b7cba085a534a70206cad17f6f0', '', '', 0, '', '', '', '', '', '', 0, '', '', '', 0, 0, 0, '', '', '', '', '', '', 1, '', 0, 0, '', 1, 0, 0, 0, '', 1, 'Parth-Vasani ', 'Parth-Vasani ', 'Parth-Vasani \r\n', 0, NULL, NULL, '2021-01-06 03:37:45', NULL),
(120, '5CAP3BJM39', 'shreyas-roots', 'profile-pic-1610009024.jpg', 'Shreyas ', 'Roots ', '1970-01-01', 1, 'shreysdas900@gmail.com', '7619668173', '', 'e55ff2b92f494cbd3edb37b6d3f6b851', 'Doddhihatti near revanna siddeshwara temple sakrepatna chickmangalore karnataka ', '236', 17, '1', '', 'Shreyas here, professional tattooer since 2014, i have 6 years of experience in tattooing, i specialise in traditional art, including mandalas, and geometrical tattoos, i am currently building up indian traditional style. i love to work on linework, dotwork, and blackwork. My studio located in chickmangalore karnataka, thanks for looking. ', '2014', 'Body arts bangalore ', '', 0, '', '', '4,5,7,10,21', 1, 500, 0, '', '', 'https://www.instagram.com/p/CGO7Zhzlgwz/?igshid=1tgx1d0swuk7e', '', '', '', 3, '', 0, 0, '', 1, 0, 1, 1, '1500', 1, 'Shreyas -Roots ', 'Shreyas -Roots ', 'Shreyas -Roots \r\n', 8, NULL, NULL, '2021-01-07 07:51:58', NULL),
(121, 'AWF8UD24H3', 'sabbys-studio', '', 'Sabbys ', 'Studio', '0000-00-00', 1, 'sabbysstudio@gmail.com', '9823176464', '', '27f3d52762115203c0aa688fca325aa6', '', '', 0, '', '', '', '', '', '', 0, '', '', '', 0, 0, 0, '', '', '', '', '', '', 1, '', 0, 0, '', 1, 0, 0, 0, '', 1, 'Sabbys -Studio', 'Sabbys -Studio', 'Sabbys -Studio\r\n', 0, NULL, NULL, '2021-01-08 06:59:43', NULL),
(122, 'ZVE4L89N9C', 'vigneshkumar-shiva', 'profile-pic-1610371937.jpg', 'Vigneshkumar', 'Shiva', '1985-09-14', 1, 'monktattooist@gmail.com', '9833795007', '9833795007', 'c443c6cf0ee878d581c8b142a8cca16e', 'L-7,RH-2,Sector 6, Vashi.', '676', 21, '1', '400703', 'I am Vigneshkumar Shiva - An eternal seeker & follower of Hindu Dharma. I try to spread the knowledge of this Ancient way of Life through my Artworks.\r\n\r\n Tattoo Temple 108 is my vibration out to the Universe. \r\n\r\nI have spent as many years reading scriptures & understanding their fundamental teachings as i have in perfecting my visualization & art techniques. I have been drawing since i can remember & professionally tattooing since 2010.\r\n\r\nI believe that Tattooing can and should be a Passion. In the same way your Favorite Painting, Song or Movie invokes an Emotional Response – Tattooing, at its Purest form, can be the Physical Manifestation of this Highly Personal Interaction. As a Tattoo Artist i try to Create Unique Designs for my clients & turn a part of their Body and by Extension, Them, into a Living Works of Art. I only tattoo one client a day. Please book an appointment before visiting. No direct walkins please !!! By Appointment Only !!!', '2010', 'Sabby\'s Tattoo Studio - Pune,Too many more to list.', 'Tat Cult Clothing', 3, '', '', '7,13,18,19,26', 2, 6000, 1, 'www.tattootemple.in', 'https://www.facebook.com/TattooTemple108', 'http://www.instagram.com/tattootemple108', 'https://in.pinterest.com/TattooTemple108/tattoo-temple-mumbai-india/', 'https://www.youtube.com/channel/UCKjb8wA_i-u5u79v2sXu3xQ', 'https://www.tattootemple.in/blog', 3, '', 0, 0, '', 1, 0, 1, 1, '1500', 1, 'Vigneshkumar-Shiva', 'Vigneshkumar-Shiva', 'Vigneshkumar-Shiva\r\n', 10, NULL, NULL, '2021-01-11 12:20:52', NULL),
(123, '3PMC069RTD', 'karthik-deena', '', 'Karthik', 'Deena', '0000-00-00', 1, 'deenakarthik@ymail.com', '9036983101', '', '33ba3bcc75073262c51de7b592857109', '', '', 0, '', '', '', '', '', '', 0, '', '', '', 0, 0, 0, '', '', '', '', '', '', 1, '', 0, 0, '', 1, 0, 0, 0, '', 1, 'Karthik-Deena', 'Karthik-Deena', 'Karthik-Deena\r\n', 0, NULL, NULL, '2021-01-12 13:00:54', NULL),
(124, '7WF35SQPB6', 'adishivam-cholan', 'profile-pic-1610606644.jpg', 'Adishivam', 'Cholan', '1984-07-09', 1, 'jk.tattoos@yahoo.com', '9833819580', '9022555728', 'a66f29ea976ce022b5d1d7f3b95239e1', '650,2nd Dhobi Talao Lane Rivendell House, Jagannath Shankar Seth Rd, Navajeevan Wadi, Marine Lines, Mumbai, Maharashtra 400002 ', '672', 21, '1', '400002', 'hello friends my self Adishivam sins working as a tattoo artist  from 2013 i like to satisfy my Clint keeping honesty in my work cleanses & hygienic is my nature i love all the art work  i am self-made artists i dont now how much best i am but i now that i am always success in bringing smile ? in my all client thats my award and words  they give from their heart to me its my certificate and the hug i get from them its my medal ???? ', '2013', 'Antonio Dsouza high school', 'jk tattoos studio', 3, '', '', '10,16,21,22,26', 1, 450, 1, 'https://jktattoos-studio.business.site', 'https://m.facebook.com/adishivam.tattoartist', 'www.instagram.com/jktattoostudio/', 'https://in.pinterest.com/jktattoos/', 'https://youtube.com/channel/UCXyUOwVk502aiV7lN2KypNw', '', 3, '', 0, 0, '', 1, 0, 1, 1, '500', 1, 'Adishivam-Cholan', 'Adishivam-Cholan', 'Adishivam-Cholan\r\n', 7, NULL, NULL, '2021-01-12 14:03:17', NULL),
(125, 'HPJX446S0F', 'zainab-fatehi', '', 'Zainab ', 'Fatehi ', '0000-00-00', 2, 'zfatehi40@gmail.com', '9820680944', '', 'cbeb6e14d91da1dd9a5c470474753d3b', '', '', 0, '', '', '', '', '', '', 0, '', '', '', 0, 0, 0, '', '', '', '', '', '', 1, '', 0, 0, '', 1, 0, 0, 0, '', 1, 'Zainab -Fatehi ', 'Zainab -Fatehi ', 'Zainab -Fatehi \r\n', 0, NULL, NULL, '2021-01-13 18:10:15', NULL),
(126, '9BSYKX74P9', 'kuldeep-krishna', 'profile-pic-1623339968.jpeg', 'kuldeep', 'krishna', '1989-03-30', 1, 'thedeepinktattooz@gmail.com', '8136833401', '7510760102', '10448bbd1aa14f68f4146709911ac9f4', 'First floor,MGV Towers,Pallissery, junction, Puthiya Rd', '667', 18, '1', '', 'Myself Kuldeep Krishna, Kerala-based tattoo artist specialized in Portrait & Realism. My passion for drawing pursued me to take as a drawing artist, graphic designer 3D animator. But wasn\'t exactly happy with that career. I needed a platform that can express the entire dimensions of the artist in me. Finally, my search ended up in tattooing art.', '2018', 'Suuny Bhanusali / Aliens tattoo school ', '', 1, ' radhika_venugopal_sadhika Verified ,lakshmi_nakshathra ,priya.p.varrier,Shritha shivadas ,vaiga', '', '16,18,25,26', 2, 6000, 0, 'www.thedeepink.com', 'https://www.facebook.com/kuldeepkrishna.krishna.7/', 'https://www.instagram.com/kuldeepkrishna369/', 'https://in.pinterest.com/kuldeepkrishna/_saved/', 'https://www.youtube.com/channel/UC4g8AMMwvFSBi9_OvU8cebg', '', 3, '', 0, 0, '', 1, 1, 0, 2, '', 1, 'Kuldeep-Krishna', 'Kuldeep-Krishna', 'Kuldeep-Krishna\r\n', 8, NULL, NULL, '2021-01-14 06:41:34', NULL),
(127, '5C8J2GQHY5', 'sachin-gupta', 'profile-pic-1610707782.jpg', 'Sachin', 'Gupta', '1995-01-20', 1, 'sachingupta3093@gmail.com', '9555057320', '', 'fdf7ff3534555c781e088aa9f83308d8', '1449/129, st no.2, durga puri, shahdara', '120', 10, '1', '', 'I am a carver of my experience, my story is etched in lines and shading, Though the ink carver tattoo studio is a custom design based tattoo studio in Delhi.  Moreover, got an award in Mumbai for best black n grey healed also we offer a hygienic environment which gives you the best experience.', '2009', 'Aliens,Manohar koli', '', 2, '', '', '1,11,16,17,18', 2, 1699, 1, '', '', 'https://www.instagram.com/the_ink_carver/?r=nametag', '', '', '', 3, '', 0, 0, '', 1, 0, 0, 1, '', 1, 'Sachin-Gupta', 'Sachin-Gupta', 'Sachin-Gupta\r\n', 9, NULL, NULL, '2021-01-14 14:40:37', NULL),
(128, 'AW4VE4K8Y5', 'deven-atal', 'profile-pic-1610777740.jpg', 'Deven ', 'Atal', '1993-07-10', 1, 'dfreestyletattoo2824@gmail.com', '8800326131', '', '711b2f4523d27614ddaa9fd4c282ff66', 'East Vinod Nagar, Mayur vihar phase 2 ', '120', 10, '1', '110091', 'D freestyle Tattoo \' is owned by a self taught tattoo artist in Delhi , India. With the 08 years of experience in Drawing and Painting. I started tattooing in 2014 and i just want to share my work with the world and hopefully inspire some other people to start creating some pieces of art on the own.', '2014', 'D freestyle Tattoo', '', 2, '', '', '4,10,16,17,26', 1, 800, 1, '', 'https://www.facebook.com/deven.atal.7', 'https://www.instagram.com/deven_atal/', '', 'https://www.youtube.com/channel/UCDbO0lHntfbOOKOEZqQ48Tw/featured', '', 3, '', 0, 0, '', 1, 0, 1, 2, '5000', 1, 'Deven -Atal', 'Deven -Atal', 'Deven -Atal\r\n', 9, NULL, NULL, '2021-01-16 05:03:02', NULL),
(129, '263FYAU1QP', 'kishor-govindaiah', 'profile-pic-1610863457.jpg', 'kishor', 'Govindaiah', '1983-01-16', 1, 'mgkishor.techeng@gmail.com', '7411695678', '9880904117', '2313abf6a6648755fe30ad7225c27323', 'Minchu Tattoo Studio, No,33/1 10th Main Road, Laggere MEI COLONY, BANGALORE- 560058', '660', 17, '1', '560058', 'I am a Software Engineer, Film Maker, Movie Editor, Sound Engineer, Cameraman, Photographer, \r\n\r\nand Mainly a Proud Tattoo Artist who owns Minchu Tattoo Studio and Training Centre. Have been Tattooing for 11 years and have professioncy to do all kinds of Tattoos like 3d, portrait, Geometric, Realistic and many more.', '2009', '', '', 2, '', '', '1,7,10,16,18', 1, 300, 1, '', 'https://www.facebook.com/Minchu-Tattoo-Studio-1427671450854740/', 'https://www.facebook.com/Minchu-Tattoo-Studio-1427671450854740/', '', '', '', 3, '', 0, 0, '', 1, 0, 1, 1, '300', 1, 'kishor-Govindaiah', 'kishor-Govindaiah', 'kishor-Govindaiah\r\n', 6, NULL, NULL, '2021-01-17 05:51:54', NULL),
(130, 'TZA8BG60K1', 'poorna-chandra', '', 'Poorna', 'Chandra', '0000-00-00', 1, 'poorna.c888@gmail.com', '8374307460', '', 'd4646ce83f01dbbeb3d0ad1dcffca764', '', '', 0, '', '', '', '', '', '', 0, '', '', '', 0, 0, 0, '', '', '', '', '', '', 1, '', 0, 0, '', 1, 0, 0, 0, '', 1, 'Poorna-Chandra', 'Poorna-Chandra', 'Poorna-Chandra\r\n', 0, NULL, NULL, '2021-01-17 12:19:02', NULL),
(131, 'S8Q56Z9HFE', 'narendra-patil', 'profile-pic-1628588042.jpg', 'Narendra ', 'Patil', '1994-06-21', 1, 'narendrapatil216@gmail.com', '9890665043', '', '7f6f576ef78b04996669042d170222f6', 'Shop no. 1, building no. 19, Konark Nagar society, Viman Nagar,  Pune.', '315', 21, '1', '411014', 'I\'m lead artist at our studio, where we try to give our best customisation. I came accidentally into the tattoo industry, when I was doing my engineering degree and managing a temple. But it because my passion, so I dropped engineering and started full time tattooing. As I was not exactly priest, but I was into managing a temple, and I learned spirituality in gutukul. So I have strong spiritual background and I use that knowledge as tattoo artist to practice karmyoga.', '2016', 'Sujay dantale', '', 3, '', '', '12,16,18,19,26', 2, 2000, 0, '', 'https://m.facebook.com/mouleestattooartstudio/', 'https://www.instagram.com/moulees_tattoo_art/', '', '', '', 3, '', 0, 0, '', 1, 0, 0, 1, '', 1, 'Narendra -Patil', 'Narendra -Patil', 'Narendra -Patil\r\n', 6, NULL, NULL, '2021-01-18 09:45:19', NULL),
(132, '5VKF5WA3B9', 'abhishek-goyal', '', 'Abhishek ', 'Goyal', '2002-02-08', 1, 'ag7528425@gmail.com', '7506485538', '', '73948f3a7c4eeda7ef380e3eb8164389', '302 Mahesh Kutir 14th Rd Chembur east', '672', 21, '1', '400071', '', '', '', '', 0, '', '', '', 0, 0, 0, '', '', '', '', '', '', 1, '', 0, 0, '', 0, 0, 0, 0, '', 1, 'Abhishek-Goyal', 'Abhishek-Goyal', 'Abhishek-Goyal', 0, NULL, NULL, '2021-01-21 10:11:52', NULL),
(133, 'K13W6YS6XU', 'sandeep-tp', 'profile-pic-1611905534.jpeg', 'Sandeep', 'Tp', '1995-01-15', 1, 'owltattoos1@gmail.com', '8590403460', '', '592f8e5cc335533e24dd7f3ffd6ea274', 'Owl tattoos , 60/182 A9,1st floor, k zone trade centre, near coronation theatre, Calicut ', '249', 18, '1', '673001', 'Photographer, journalist, art director turned tattoo artist. Specialised in realism , fine lines , neo tradition , dot work. Custom made designs. Learned tattoo art from aliens tattoos Mumbai. Used to work in Mumbai, Goa . Now started studios in Kerala.   I also have students learning tattoo art and digital art.             ', '2019', 'Aliens tattoo art school', '', 3, '', '', '5,13,14,16,18', 2, 3000, 1, '', 'https://www.facebook.com/owltattoos1/', 'www.Instagram.com/owl_tattoos', '', '', '', 3, '', 0, 0, 'Your birthday ?! Then the gift on us... Come to us on your birthday to get flat 20% off', 1, 0, 1, 2, '2000', 1, 'Sandeep-Tp', 'sandeep-tp', 'sandeep-tp\r\n', 10, NULL, NULL, '2021-01-29 07:06:20', NULL),
(134, 'YC4530HKTW', 'ravi-madavi', '', 'Ravi', 'Madavi', '0000-00-00', 1, 'ravi.scorpion3@gmail.com', '9923674699', '', '22f8b75d126f5096ff8c42320c6d3a14', '', '', 0, '', '', '', '', '', '', 0, '', '', '', 0, 0, 0, '', '', '', '', '', '', 1, '', 0, 0, '', 1, 0, 0, 0, '', 1, 'Ravi-Madavi', 'Ravi-Madavi', 'Ravi-Madavi\r\n', 0, NULL, NULL, '2021-02-02 05:50:30', NULL),
(135, 'N5Y62BQ2HL', 'dhruv--bahl', '', 'Dhruv ', 'Bahl', '1989-12-06', 1, 'dhruvbahl9@gmail.com', '9999090239', '', 'f4b25f0eabf9d71ed34ecd43283fdf08', 'Shop No. 282 Satya Niketan ground floor opposite venkateshwar collage', '120', 10, '1', '110021', 'Hi My Name Is Dhruv Bahl, tattooing since 2012 in different genre of tattoo but specialise in minimal, black and grey and ornamental tattoos. Successfully running my private studio since 2012 in South Campus satya niketan. Have done over 5000 tattoos since 2012 . with clients from all over country and abroad  ', '2012', 'kdz tattoos ', '', 1, 'Mia Lakra ', '', '3,4,5,10,19', 1, 700, 0, 'www.tattooclubdelhi.com', '', 'www.instagram.com/tattoo_club_dhruv', '', '', '', 3, '', 0, 0, '', 1, 0, 1, 1, '500', 1, 'Dhruv -Bahl', 'Dhruv -Bahl', 'Dhruv -Bahl\r\n', 8, NULL, NULL, '2021-02-02 05:55:43', NULL),
(136, 'Y6E6W4N7SZ', 'anokhi-roy-bhattacharya', '', 'Anokhi ', 'Roy Bhattacharya ', '0000-00-00', 2, 'anokhirb3@gmail.com', '9619744065', '', 'ac76cbd93dda6d68c2b9e91223441c86', '', '', 0, '', '', '', '', '', '', 0, '', '', '', 0, 0, 0, '', '', '', '', '', '', 1, '', 0, 0, '', 1, 0, 0, 0, '', 1, 'Anokhi -Roy Bhattacharya ', 'Anokhi -Roy Bhattacharya ', 'Anokhi -Roy Bhattacharya \r\n', 0, NULL, NULL, '2021-02-02 11:55:19', NULL),
(137, '1KQWSY667U', 'monu-yadav', '', 'Monu', 'Yadav', '1994-09-19', 1, 'monustad@gmail.com', '7838717287', '9555950517', 'fd0eabd6f1e9cb3568c47122fb39ed56', 'F1U-7, Block F 1U, Uttari Pitampura, Pitam Pura, Delhi, 110034', '773', 10, '1', '', 'I\'m an independent Tattoo artist from Delhi India. I love minimal design, bold colours, typography and geometric patterns. You can find me on instagram @whomonuyadav And Facebook @monutattoos. I’m available for work and collaborations. If you’d like to discuss your project, please feel free to message me, I’m happy to hear from you!', '2016', 'YouTube', '', 2, '', '', '5,7,12,17,26', 1, 1500, 1, '', 'https://www.facebook.com/monustad', 'https://instagram.com/whomonuyadav?utm_medium=copy_link', 'https://pin.it/66MmcwZ', '', '', 3, '', 0, 0, '', 1, 0, 1, 1, '1000', 1, 'Monu-Yadav', 'Monu-Yadav', 'Monu-Yadav', 7, NULL, NULL, '2021-02-02 17:22:33', NULL),
(138, 'E07WG7S3HK', 'jigar-parekh', 'profile-pic-1612333412.jpg', 'jigar', 'parekh', '1983-05-04', 1, 'jigarparekh83@googlemail.com', '8347462827', '', '4933b02529c96c1d6fbcf06ef0d82e74', 'A4/ Supermarket complex, Near Milk dairy, Nana Bazaar. vidyanagar, ', '150', 12, '1', '388120', 'Hi my self Jigar. I\'m an enthusiastic artist. my mastery is in portrait and hyper realism. but im very flexible to try all sort of artistic piece. my favourite artist is steve butcher. I\'m Trained from London and in India. Doing tattoo and art since 2006, Presently owner of 777 tattoo studio in vidyanagar, anand, Gujarat. India. please look for my daily updates on Instagram and Facebook.  ', '2006', 'british tattoo fedration', '', 1, 'Mamta soni , Rina soni, Mili patel , Prachi solanki', '', '16,17,18,19,26', 2, 3000, 0, '', 'https://www.facebook.com/jigs0405/', 'https://www.instagram.com/777tattoostudio/', 'https://in.pinterest.com/777tattoostudio/_created/', '', '', 3, '', 0, 0, '', 1, 0, 1, 2, '1000', 1, 'jigar-parekh', 'jigar-parekh', 'jigar-parekh\r\n', 9, NULL, NULL, '2021-02-03 06:00:27', NULL),
(139, 'JVT21MYL46', 'upendra-kumar', 'profile-pic-1612445528.jpg', 'Upendra', 'Kumar', '1999-11-13', 1, 'upendraeyeweb@gmail.com', '8920159511', '1111111111', '685c40afb162a95821486dbd8c6765f9', '6/668 sec-9 Indiranagar Lucknow', '524', 34, '1', '226016', '\r\nHii... This is Upendra ,\r\nI just wanna tell you..\r\nLast September, India was confirming nearly 100,000 new coronavirus cases a day. It was on track to overtake the United States to become the country with the highest reported COVID-19 caseload in the world. Hospitals were full. The Indian economy nosedived into an unprecedented recession.\r\n\r\nBut four months later, India\'s coronavirus numbers have plummeted. Late last month, on Jan. 26, the country\'s Health Ministry confirmed a record low of about 9,100 new daily cases — in a country of nearly 1.4 billion people. It was India\'s lowest daily tally in eight months. On Monday, India confirmed about 11,000 cases.', '1999', 'Apt Technosoft', 'Tata Consultancy', 1, 'Amir khan ', '', '1,9,27', 1, 1000, 1, 'upendra.com', 'upendra.com', 'upendra.insta.com', 'upendra.com', 'upendra.youtube.com', 'upendra.blog.com', 3, 'VS97Z7URY0', 0, 100, '25% discount', 0, 0, 1, 1, '500', 1, 'Upendra-Kumar', 'Upendra-Kumar', 'Upendra-Kumar\r\n', 0, NULL, NULL, '2021-02-04 13:25:46', NULL),
(140, '468BTJFXM7', 'eye-web-studio', 'profile-pic-1612446362.png', 'Eye Web', 'Studio', '2021-02-05', 1, 'eyewebsolution@gmail.com', '7054113080', '', '0efe7a2d4bacba9ce2eb000a9f03b312', 'Hazratganj Near krishna murti', '524', 34, '1', '226016', 'hi i am a tattoo artist baed in city of Nawabs . we have 2 shops in lucknow hi i am a tattoo artist baed in city of Nawabs . we have 2 shops in lucknow hi i am a tattoo artist baed in city of Nawabs . we have 2 shops in lucknow', '2004', 'Tattoo Guruz', '', 2, '', '', '5,8,11,14,17', 1, 2000, 1, '', '', '', '', '', '', 3, '', 0, 0, '', 0, 0, 1, 1, '500', 1, 'Eye Web-Studio', 'Eye Web-Studio', 'Eye Web-Studio\r\n', 0, NULL, NULL, '2021-02-04 13:40:51', NULL),
(141, 'TZ7779JMFK', 'mayank-mahindru', '', 'Mayank ', 'Mahindru', '1996-05-02', 1, 'mmahindru19@gmail.com', '7011017385', '8588822245', '4f2d57810280e4fc5cf36d451fe5aa07', 'House number 187  Le Dragon house , new Aruna Nagar , Majnu Ka Tila , New Delhi 110054', '120', 10, '1', '110054', 'Committed  to excellence.\r\nBest work since 2019 and leading ahead towards new era of tattoo in India . \r\nAND WE  ONLy PERSUIT EXCELLENCE .I m professional in black-out and portraits  if you guys are finding the quality so black ink atttoo is the best place to get ink . We even do customise tattoo select your fav tattoo at your budget and get the best quality work ', '1980', 'Wind star tattoo studio ', '', 3, '', '', '4,5,7,16,17', 1, 699, 0, '', '', '', '', '', '', 3, '', 0, 0, '', 1, 0, 1, 1, '1500', 1, 'Mayank -Mahindru', 'Mayank -Mahindru', 'Mayank -Mahindru\r\n', 6, NULL, NULL, '2021-02-08 08:28:53', NULL),
(142, 'G27QWAD9P6', 'mayank-mahindru-1', 'profile-pic-1612943133.jpeg', 'Mayank', 'Mahindru', '1970-01-01', 1, 'mayankmahindru57@gmail.com', '7011017385', '8588822245', '9f67453b51161ae10f271397dc1eb4f4', 'House no.187new Aruna nagar ,Majnu Ka Tila ', '120', 10, '1', '', 'I m tattooing since 2019 . Next to excellence tattoos realistic , couple tattoos , trible , blackout , shading work ,portrait and different type of tattoos with some fun . Tattoos are the scars which people want on there body and I best in giving scars to the excellence . You will have a great expiernce tattooing our studio with some Halloween ???? effect touched with some Korean culture your face tattoo at your budget come grab this offer hurry up and have great expiernce getting inked your fav tattoo with and extremely different expiernce you ever had . ', '2019', 'Windstar tattoo studio ', 'Black ink tattoo studio', 3, '', '', '4,5,7,16,17', 1, 1500, 1, '', '', '', '', '', '', 3, '', 0, 0, '', 1, 0, 1, 1, '1500', 1, 'Mayank Mahindru', 'Mayank Mahindru', 'Mayank Mahindru', 7, NULL, NULL, '2021-02-10 07:26:06', NULL),
(144, 'E7M6T3RLS5', 'aaradhya--', 'profile-pic-1624369613.jpg', 'Aaradhya', 'Garg', '2001-10-12', 2, 'rebelpokes@gmail.com', '7678477082', '7678477082', '60aaf1c5474d2849efc931372caf780f', '-', '120', 10, '1', '110020', 'I’m a self taught stick n poke tattoo artist. I like to poke people gently. I believe, in a world that constantly polices how people live in their bodies, tattoos can empower and help them find a better version of themselves. I aspire to promote meaningful tattoos instead of tattoos with meanings. A safe space for all. Homemade, machine-free permanent tattoos with safety, precaution and love.  ', '2019', 'Self Taught', '', 2, '', '', '8,12', 1, 1200, 0, '', '', 'https://www.instagram.com/pokesbyrebel/', '', '', '', 3, '', 0, 0, 'Get a 20% off if you are completely vaccinated for COVID-19.', 1, 0, 1, 2, '1100', 1, 'Aaradhya -', '', '', 7, NULL, NULL, '2021-02-21 17:30:29', NULL),
(145, 'YRF42JV67M', 'devilz-tattooz', 'profile-pic-1614157687.jpg', 'Lokesh', 'Verma', '1984-05-12', 1, 'Devilztattoozgurgaon@gmail.com', '9810364801', '9876543285', 'e4e26861515a9f133c8b4f5afb56d97c', 'M-37, 2nd Floor, Main Market, GK-1', '120', 10, '1', '122009', 'India\'s first Award-winning, internationally experienced artist Lokesh is a veteran tattoo artist who was also one of the first people to start tattooing in India. But the journey has not been easy for him. He began his pursuit at nineteen. An MBA by qualification, he strove hard to purchase the gear, even taking up a part-time position of a DJ at a local bar.\r\n\r\nLokesh is a self-trained artist and travels all across the world to work at different shops and to attend tattoo conventions. Ever since he can remember, he has been fascinated with sketching. His exceptional gift, and him treasuring it in return, brought to him audience and prizes. At fourteen, he won the 1st prize in the Inter-Asia level painting competition in Japan, organized by Mitsubishi.', '2003', 'Devilz Tattooz', '', 1, ' Remo D\'Souza, Esha Gupta, Shikhar Dhawan, Swara Bhaskar, Ishant Sharma, Taapsee Pannu, Umesh Yadav ', '', '7,17,18,20,26', 1, 2000, 0, 'https://www.tattoosnewdelhi.com/', 'https://www.facebook.com/devilztattooznewdelhi/', 'https://www.instagram.com/devilztattooz/?hl=en', 'https://in.pinterest.com/devilztattooz/_created/', 'https://www.youtube.com/channel/UCPbUQyVZWxB2aR7PLMLM-Rg', '', 3, '', 0, 0, '', 1, 1, 0, 2, '', 1, 'Devilz Tattooz', '', '', 8, NULL, NULL, '2021-02-24 07:54:13', NULL),
(146, 'SXYT1H553G', 'mukesh-tupkar', 'profile-pic-1614431896.jpg', 'Mukesh', 'Tupkar', '1986-04-01', 1, 'rksinkxposuregoa@gmail.com', '9764680075', '', '4f34664717d1faf7fe4857074ef43ce9', 'Saunta vaddo Baga calangute road near la- calepso Baga Goa', '649', 11, '1', '', 'Hi I am Mukesh Tupkar owner and Artist at Rk\'s Ink Xposure Tattoo studio in Goa. Working since 2010. Versatile artist ready to do any style of art best in realism , potraits and Coverups . People looking best creative tattoos to connect with me.We successfully run 2 branchs tattoo in Goa', '2010', 'RK\'s Ink Xposure Tattoo Studio', '', 2, '', '', '10,16,18,19,26', 2, 6000, 1, 'https://rksinkxposure.com/', 'https://www.facebook.com/tattoostudiogoaindia', 'https://www.instagram.com/rksinkxposure/', 'https://in.pinterest.com/rksinkxposure/_saved/', '', '', 3, '', 0, 0, '', 1, 0, 1, 2, '1000', 1, 'Mukesh Tupkar', '', '', 9, NULL, NULL, '2021-02-27 12:50:49', NULL),
(147, 'CWZH7AE971', 'dimpy--hb', '', 'Dimpy ', 'HB', '0000-00-00', 1, 'didatattoostudio@gmail.com', '9779900666', '', '25d40b73437e89ed6111d009792a76e8', '', '', 0, '', '', '', '', '', '', 0, '', '', '', 0, 0, 0, '', '', '', '', '', '', 1, '', 0, 0, '', 1, 0, 0, 0, '', 1, 'Dimpy  HB', '', '', 0, NULL, NULL, '2021-03-03 03:07:12', NULL);
INSERT INTO `adv_artist` (`id`, `code`, `slug`, `profile_pic`, `fname`, `lname`, `dob`, `gender`, `email`, `mobile`, `alt_mobile`, `password`, `address`, `city`, `state`, `country`, `pincode`, `artist_bio`, `work_since`, `mentor`, `sponsor`, `celeb`, `celeb_name`, `emp_type`, `cats`, `pmode`, `price`, `pshow`, `website`, `facebook`, `instagram`, `pinterest`, `youtube`, `blog_url`, `profile_step`, `ref_code`, `wallet`, `pedia_wallet`, `artist_offer`, `status`, `feature`, `direct_booking`, `piercing`, `minimum_booking_amount`, `verified`, `meta_title`, `meta_keyword`, `meta_desc`, `list_order`, `fs_date`, `fe_date`, `created`, `last_login`) VALUES
(148, 'ZGW5J6X40Q', 'sunny-bhanushali', '', 'Sunny', 'Bhanushali', '1970-01-01', 1, 'sunny.avn@gmail.com', '9920039500', '8779056596', '8c99d40df467123b9cc557bf2e75b27a', 'K2 Old Sonal Industrial Estate Link Road Malad Kanchpada, Malad West, Mumbai, Maharashtra 400064', '672', 21, '1', '', 'Sunny Bhanushali is globally renowned, and is said to be the best tattoo artist in India for his work on Photo-Realistic tattoos, Hyper-Realistic tattoos, and conceptual tattoos based on Hindu Mythology. He is not just the best tattoo artist in Mumbai, or the best tattoo artist in India. He is one of the best tattoo artists in the WORLD! ', '2007', 'S.I.A.S', '@cheyenne_tattooequipment,@eternalink,@dermalizepro,@squidster_skinmarker,@cleanyskin_tattoo_wipes', 1, 'Virat Kohli,Hardik Pandya,Ishan Kishan,Krunal Pandya,Lucian Goian,Natasa stankovic', '', '1,16,18,19,26', 2, 24000, 0, 'www.alienstattoo.com', 'https://www.facebook.com/alienstattoomalad', 'https://www.instagram.com/alienstattooindia/', 'https://www.pinterest.it/Alienstattooindia/_created/', 'https://www.youtube.com/channel/UCcKnc4ZdJGFRik6ptbyL8JQ/videos', 'https://www.alienstattoo.com/blog', 3, '', 0, 0, '', 1, 1, 0, 2, '', 1, 'Sunny Bhanushali', '', '', 7, NULL, NULL, '2021-03-05 12:40:24', NULL),
(149, 'J1C4PX3LF7', 'tript-tattooist', '', 'Tript', 'Tattooist', '0000-00-00', 1, 'tripttattooist5@gmail.com', '8585960958', '', '60856c4559eea3cd0b718841aa151e6a', '', '', 0, '', '', '', '', '', '', 0, '', '', '', 0, 0, 0, '', '', '', '', '', '', 1, '', 0, 0, '', 1, 0, 0, 0, '', 0, 'Tript Tattooist', '', '', 0, NULL, NULL, '2021-03-05 18:51:23', NULL),
(150, '1MN33LYQ2S', 'tript-tattooist-1', '', 'Tript', 'Tattooist', '0000-00-00', 1, 'tripttattooist@gmail.com', '8585960958', '', '60856c4559eea3cd0b718841aa151e6a', '', '', 0, '', '', '', '', '', '', 0, '', '', '', 0, 0, 0, '', '', '', '', '', '', 1, '', 0, 0, '', 1, 0, 0, 0, '', 1, 'Tript Tattooist', '', '', 0, NULL, NULL, '2021-03-05 18:55:50', NULL),
(151, '5LP5WH7QM9', 'devendra-palav', '', 'Devendra', 'Palav', '0000-00-00', 1, 'devendrarpalav@gmail.com', '7208116162', '', 'fb5393bda08e544b4c1db0a129b5c099', '', '', 0, '', '', '', '', '', '', 0, '', '', '', 0, 0, 0, '', '', '', '', '', '', 1, '', 0, 0, '', 1, 0, 0, 0, '', 0, 'Devendra Palav', '', '', 0, NULL, NULL, '2021-03-08 09:46:43', NULL),
(152, 'K11NQ1BSH5', 'sameer-kureshi', 'profile-pic-1615298585.jpg', 'Sameer', 'Kureshi', '1996-03-01', 1, 'sameerkureshi1396@gmail.com', '9820928087', '8483076338', '75e099f2b0c6379c077679b53a2c8e1e', 'D3/35 Asmita Jyoti Marve Rd Malad West 400064', '672', 21, '1', '', 'Design like an Alien with Sameer Kureshi, one of the lead artists at Aliens Tattoo, India\'s leading tattoo studio.\r\nSameer is one of our most creative senior Aliens. His imagination knows no bounds and he uses the stellar combination of his imagination, creativity, and artistic abilities to create a masterpiece design out of thin air! Most of the time, he does not even require references for inspiration.', '2015', 'Zilla Parishad High School Kaij,Rafik', '', 1, 'Hardik Pandya,Krunal Pandya', '', '9,10,14,18,26', 2, 8000, 0, '', '', 'https://www.instagram.com/sameerkureshi1396/', 'https://in.pinterest.com/sameerkureshi/_saved/', 'https://www.youtube.com/watch?v=6pa-dXquK8k', '', 3, '', 0, 0, '', 1, 0, 1, 2, '5000', 1, 'Sameer Kureshi', '', '', 7, NULL, NULL, '2021-03-08 10:05:53', NULL),
(153, '6EUXAYM349', 'devendra-palav-1', '', 'Devendra', 'Palav', '1970-01-01', 1, 'devendrarpalav21@gmail.com', '7208116162', '7768865397', 'fb5393bda08e544b4c1db0a129b5c099', '1/7 Shree Siddhivinayak rahivasi seva sangh, new Agripada, SantaCruz east', '672', 21, '1', '', 'Devendra Palav is a digital wizard when it comes to tattoo designing and illustration!  His designing and calligraphy skills are just amazing. If there’s a script in your mind that you want to jazz up, he is the ultimate guide!\r\n\r\nCreating outrageous fusions is his forte. Dotwork tattoos, line-work (line art tattoos), blackwork tattoos, calligraphy and script tattoos fall under his portfolio. The neatness and precision in his tattoos has given him a nation-wide recognition.  Check out his portfolio to witness some great script tattoos and customized tattoo concepts.', '2017', 'Shree Siddhivinayak Sanstha Vidyalaya', '', 1, 'Karishma Chavan ,Vaibhav Pandya,Charlie Chauhan', '', '2,4,5,7,10', 2, 8125, 0, 'www.alienstattoo.com', 'https://www.facebook.com/devendra.palav.125', 'https://www.instagram.com/devendrapalav21/', 'https://in.pinterest.com/devendrapalav/_saved/', '', 'https://www.alienstattoo.com/tattoos-by-devendra-palav', 3, '', 0, 0, '', 1, 0, 0, 2, '', 1, 'Devendra Palav', '', '', 5, NULL, NULL, '2021-03-09 14:16:55', NULL),
(154, 'ZA9FL7W55V', 'vishal-maurya', '', 'Vishal', 'Maurya', '1970-01-01', 1, 'vishalmaurya06@gmail.com', '8286402021', '8898240181', '268b9b98b7e7ae6addc09100db609a7d', 'Room no 1, Gopinath Chawl. Prabhat Colony, Santacruz East Mumbai 400055', '672', 21, '1', '', 'Vishal has had a thing for art since his school days and he aspired to become an Interior Designer. However, financial difficulties ended his hopes of ever pursuing that dream and thus he chose Tattoo Making as an alternative career option. Vishal has always been a hardworking guy and the fact that he juggled college and tattoo making for three years is a testament that. He knew that he always wanted to work with the best in the business and there was no one better than Sunny Bhanushali himself. ', '2020', 'St. Xavier,Rahul Ghare', '', 0, '', '', '2,7,10,18,19', 2, 3125, 0, 'https://www.alienstattoo.com/vishal-maurya', '', 'https://www.instagram.com/vishalmaurya068/', 'https://in.pinterest.com/vishalmaurya068/_created/', '', 'https://www.alienstattoo.com/vishal-maurya', 3, '', 0, 0, '', 1, 0, 0, 2, '', 1, 'Vishal Maurya', '', '', 5, NULL, NULL, '2021-03-11 10:11:56', NULL),
(155, '6X3E8T5YGK', 'tushar-shingare', '', 'Tushar', 'Shingare', '1970-01-01', 1, 'tushtattoo@gmail.com', '9167001791', '7208476523', 'c82b9259835d81c7c02c228a0493dc5e', 'Maheshwar Mandir Vasahat Sang, Lal Baug, Mumbai 400012', '672', 21, '1', '', '', '', '', '', 0, '', '', '2,4,5,10,14', 2, 2200, 0, '', '', 'https://www.instagram.com/tushar_s_shingare/', '', '', '', 3, '', 0, 0, '', 1, 0, 0, 2, '', 1, 'Tushar Shingare', '', '', 2, NULL, NULL, '2021-03-11 11:13:23', NULL),
(156, 'UGX4NV62R2', 'sakshi-panwar', '', 'Sakshi', 'Panwar', '1970-01-01', 1, 'sakshipanwar1806@gmail.com', '9770874579', '99288300958', '2c27b2640b148dae86c94c74213ff8fb', '8/57 Chopsani Housing Board, Jodhpur, Rajasthan', '672', 21, '1', '', '', '', '', '', 0, '', '', '7,11,12,21,23', 0, 2200, 0, '', '', 'https://www.instagram.com/_sakshi__panwar_/', '', '', '', 3, '', 0, 0, '', 1, 0, 0, 1, '', 1, 'Sakshi Panwar', '', '', 1, NULL, NULL, '2021-03-11 11:30:33', NULL),
(157, 'KG1VH28W3F', 'pooja-a-j', 'profile-pic-1629047677.jpeg', 'Pooja', 'A J', '1970-01-01', 2, 'poojaaj0814@gmail.com', '7338315099', '9902212195', 'a8b1863cfe699fc55153aad92f701f42', 'flat no. 502, fargo park building, beside greater bank, ramachandra lane extension, liberty garden, malad west, mumbai ', '672', 21, '1', '', '', '', '', '', 0, '', '', '5,7,11,12,16', 0, 2200, 0, '', 'https://www.facebook.com/people/Pooja-Ammandira-Jappu/100010188002833', 'https://www.instagram.com/pooja_ammandira_jappu/', '', '', '', 3, '', 0, 0, '', 1, 0, 0, 1, '', 1, 'Pooja A J', '', '', 2, NULL, NULL, '2021-03-11 12:03:01', NULL),
(158, 'RXW3F2J43H', 'vibhor-pratap', '', 'Vibhor', 'Pratap', '1970-01-01', 1, 'vibhorpratap15@gmail.com', '9872241515', '8427474400', '4985d2a9a91542a97be8c175c3098285', 'Flat No 14, Mahakali Caves Rd, Bindra Complex, Andheri (w)', '672', 21, '1', '', '', '', '', '', 0, '', '', '2,5,10,18,22', 2, 2200, 0, '', 'https://www.facebook.com/vibhorchauhan84', 'https://www.instagram.com/vvibhorr/', '', '', '', 3, '', 0, 0, '', 1, 0, 0, 2, '', 1, 'Vibhor Pratap', '', '', 2, NULL, NULL, '2021-03-11 13:29:46', NULL),
(159, '374QGMSBP6', 'dipti-chaurasiya', '', 'Dipti', 'Chaurasiya', '1970-01-01', 1, 'diptialienstattoo@gmail.com', '8898078128', '8080069426', '4acffdadc686199bdae71a1ba0d6fdbc', 'B-203/ Saraswati Sadan No 2, Navghar Rd, Bhayander (East), Thane-401105', '672', 21, '1', '', 'Dipti is one of the most talented Tattoo Makers in Mumbai and we are blessed to have her as part of the Aliens family. Surprisingly, Dipti has had zero experience in art before she got into the industry. Dipti was studying B.Com but she dropped out because she was not very interested in that field. Due to financial issues at home, she had to start working at the age of 18. This is when she was introduced to the tattoo making industry as she was managing a studio for a friend. Around this time, she started getting intrigued with tattoos and started her hand at Tattoo Making. Since then, there was no looking back for her and she’s been in this field for four years now. Dipti specialises in Black & Grey as well as Realism Tattoos. She has an endless list of awards to her name in various conventions since 2019. Among her many accolades, Dipti has won three awards (Best Half-Sleeve, Best Portrait and Best Large Black/Grey) in the Gujarat Tattoo Festival.', '2020', 'S.T Joseph High School', '', 0, '', '', '2,7,16,18,19', 2, 2200, 0, 'https://www.alienstattoo.com/dipti-chaurasiya', '', 'https://www.instagram.com/dipti_chaurasiya/?hl=en', '', '', 'https://www.alienstattoo.com/dipti-chaurasiya', 3, '', 0, 0, '', 1, 0, 0, 2, '', 1, 'Dipti Chaurasiya', '', '', 5, NULL, NULL, '2021-03-12 08:51:24', NULL),
(160, '22HELYW9U4', 'nitin-devlal', '', 'Nitin', 'Devlal', '0000-00-00', 1, 'Devlalnatin@gmail.com', '7838565883', '', '2cbfc6cb5cf10fe0cd10f2815de7454f', '', '', 0, '', '', '', '', '', '', 0, '', '', '', 0, 0, 0, '', '', '', '', '', '', 1, '', 0, 0, '', 1, 0, 0, 0, '', 0, 'Nitin Devlal', '', '', 0, NULL, NULL, '2021-03-12 10:36:10', NULL),
(161, 'JZB35UH2W3', 'nitin-devlal-1', '', 'Nitin', 'Devlal', '1970-01-01', 1, 'devlalnitin@gmail.com', '7838565883', '7060578840', '2cbfc6cb5cf10fe0cd10f2815de7454f', 'S/O puranchandra devlal Bajeti ward no. 1 bajeti chanak Degree college pithoragarh uttarakhand 262502', '501', 33, '1', '', 'Our very own Picasso, Nitin Devlal was always into sports as a kid. Getting an interest in tattooing came as a curveball, as he was pursuing his B.Tech degree and never thought of this as a viable career option. When, for the first time, he saw someone getting tattooed, he was hooked to this idea of bodily self-expression. Nitin went all the way from Uttarakhand to Delhi to get a tattoo machine for himself. This art left him intrigued, and he started using his family members as a canvas for budding ideas. Nitin found out about the Aliens Tattoo company and its various businesses through social media, and joined Aliens Tattoo School. After graduating with flying coloured ink, he joined Aliens Tattoo Studio in January 2020. He is still exploring his niche of art, but is heavily inclined towards colour tattoos.', '2020', 'Dayanand Inter College', '', 0, '', '', '5,7,10,11,13', 2, 2200, 0, 'https://www.alienstattoo.com/nitin-devlal', 'https://www.facebook.com/kdev.arts', 'https://www.instagram.com/nitin_devlal/?hl=en', '', '', 'https://www.alienstattoo.com/nitin-devlal', 3, '', 0, 0, '', 1, 0, 0, 1, '', 1, 'Nitin Devlal', '', '', 5, NULL, NULL, '2021-03-12 10:42:07', NULL),
(162, 'Q21X9KLZ0J', 'pratik-patkar', '', 'Pratik', 'Patkar', '1970-01-01', 1, 'pratikpatkar10@gmail.com', '8104273448', '9820662134', '3c62f598b1304a065559a06a5329b83f', 'Room No 402, Jasmin Garden Station Rd Near Shivaji Park haji Market Jambhali Naka Thane West ', '672', 21, '1', '', 'Pratik Patkar was one of the students of Aliens Tattoo School and now is a part of Aliens Tattoo Studio.\r\nMinimal and small tattoos fall under his portfolio.\r\nPratik is your go-to artist if you like small and simple art.\r\nIt\'s been a year now since he is been tattooing and his work will definitely sway your mind off.\r\nIf you\'re looking for a great minimal tattoo at an affordable price, you must scroll down to check his portfolio', '2017', 'N.E.S High School', '', 0, '', '', '3,9,16,18,19', 2, 2200, 0, 'https://www.alienstattoo.com/pratik-patkar', 'https://www.facebook.com/roberttherippe', 'https://www.instagram.com/pratikpatkar/?hl=en', '', '', 'https://www.alienstattoo.com/pratik-patkar', 3, '', 0, 0, '', 1, 0, 0, 2, '', 1, 'Pratik Patkar', '', '', 5, NULL, NULL, '2021-03-12 11:12:17', NULL),
(163, 'E3Y6T9J3CZ', 'vinesh--malviya', '', 'Vinesh ', 'Malviya', '1970-01-01', 1, 'vinesh06@gmail.com', '9619017325', '9167699821', 'd41bcf740d9c7ba885aaac0d3feaee38', 'Sant Dhanyeshwar Nagar Wagle esate thane west 400604', '672', 21, '1', '', '', '', '', '', 0, '', '', '', 0, 0, 0, '', '', '', '', '', '', 1, '', 0, 0, '', 1, 0, 0, 0, '', 1, 'Vinesh  Malviya', '', '', 0, NULL, NULL, '2021-03-12 11:47:18', NULL),
(164, '33R8VLJXT6', 'tushar-marane', '', 'Tushar', 'Marane', '1970-01-01', 1, 'maranetushar28@gmail.com', '7208476523', '9594340865', '6ab9edb74af0da26e2d1ab18e72374a8', 'Radha Krishna Chawl, Ganpati Pada, Old Belapur Road, Kelwa Thane West 65', '672', 21, '1', '', '', '', '', '', 0, '', '', '', 0, 0, 0, '', '', '', '', '', '', 1, '', 0, 0, '', 1, 0, 0, 0, '', 1, 'Tushar Marane', '', '', 0, NULL, NULL, '2021-03-12 12:14:03', NULL),
(165, 'S6J6FEY3K1', 'tenzin-tattoos', 'profile-pic-1624908498.jpg', 'Tenzin', 'Tattoos ', '1982-06-10', 1, 'tenzintattoos@gmail.com', '9891709274', '9560066166', '2bdcba1b6a30b040873be52ba505eeb7', 'TENZINTATTOOS: 42 , MGF METROPOLITAN MALL SAKET. SOUTHDELHI.', '120', 10, '1', '', 'Hi everyone , am tenzin from tenzintattoos. And 1st tibetan professional tattoo artist in exile.         I started back in 2004 to learn this tattoo art, things inspired me were the people around me who always appreciated what I created from Day 1 and since then I knew I had a long way to go.      I did take a professional training initially but since this art is pretty vast and will always get you going you learn major things while being on your journey and so did I. Standing tall after more than a decade in this profession I have now created some magnificent art pieces that have satisfied my customers to a good level.  I feel blessed today to still be associated with my clients I have rendered services to around the time I started. Trust and Hard Work builds it all.', '2005', 'Tenzintattoos Zindaa ( class) ', '', 1, 'Suresh Raina,  kapil dev wife, serial actors ', '', '7,9,10,18,21', 1, 2000, 0, 'www.tenzintattoos.com', 'https://www.facebook.com/tenzintattoo', 'https://www.instagram.com/tenzintattoos_official', 'https://www.pinterest.com/tenzintattoos', 'https://www.youtube.com/tenzintattoos', '', 3, '', 0, 0, '', 1, 1, 1, 1, '1000', 1, 'Tenzin Tattoos ', '', '', 11, NULL, NULL, '2021-03-24 13:27:40', NULL),
(166, 'X39E41CDLH', 'kuldeep-sinh-mahida', '', 'KULDEEP SINH', 'MAHIDA', '0000-00-00', 1, 'kdtattooart@gmail.com', '8401020902', '', '3ab22bee469dcce457f9f440bff269b6', '', '', 0, '', '', '', '', '', '', 0, '', '', '', 0, 0, 0, '', '', '', '', '', '', 1, '', 0, 0, '', 1, 0, 0, 0, '', 1, 'KULDEEP SINH MAHIDA', '', '', 0, NULL, NULL, '2021-03-27 07:21:30', NULL),
(167, 'GQE77TW5M4', 'sangam-ananta-koli', '', 'Sangam ananta', 'Koli', '0000-00-00', 1, 'sangamkoli111@gmail.com', '8689840896', '', '7fdf5832de8f4682b72896412027d7b7', '', '', 0, '', '', '', '', '', '', 0, '', '', '', 0, 0, 0, '', '', '', '', '', '', 1, '', 0, 0, '', 1, 0, 0, 0, '', 0, 'Sangam ananta Koli', '', '', 0, NULL, NULL, '2021-04-11 09:41:04', NULL),
(168, 'WZA4RGQ859', 'mayur-kanjiya', '', 'Mayur', 'Kanjiya', '0000-00-00', 1, 'mayurkanjiya11@gmail.com', '9067043174', '', '65b99d8746e814f420d0b42c2b476b89', '', '', 0, '', '', '', '', '', '', 0, '', '', '', 0, 0, 0, '', '', '', '', '', '', 1, '', 0, 0, '', 1, 0, 0, 0, '', 0, 'Mayur Kanjiya', '', '', 0, NULL, NULL, '2021-04-16 10:48:14', NULL),
(169, 'J4TG8X8U6E', 'ajay-solanki', '', 'Ajay', 'Solanki', '0000-00-00', 1, 'arhaan.artist@gmail.com', '9111234556', '', 'eabc8c978ee45ea74d6c7b308657645a', '', '', 0, '', '', '', '', '', '', 0, '', '', '', 0, 0, 0, '', '', '', '', '', '', 1, '', 0, 0, '', 1, 0, 0, 0, '', 0, 'Ajay Solanki', '', '', 0, NULL, NULL, '2021-05-14 13:40:53', NULL),
(170, '3ABPND0K94', 'reedhima-dev', 'profile-pic-1622830951.jpeg', 'Reedhima', 'Dev', '0000-00-00', 2, 'reedhimadev@ymail.com', '8587972308', '', '9b3a62a52e5c78c8eb732acdee73db34', '', '', 0, '', '', '', '', '', '', 0, '', '', '', 0, 0, 0, '', '', '', '', '', '', 1, '', 0, 0, '', 1, 0, 0, 0, '', 1, 'Reedhima Dev', '', '', 1, NULL, NULL, '2021-05-24 16:43:05', NULL),
(171, 'L4378XTEVS', 'allan-gois', '', 'Allan', 'Gois', '0000-00-00', 1, 'allan@alienstattoos.com', '7768865397', '', 'a0dab62f8b04cd37c6ecefff01aa84e6', '', '', 0, '', '', '', '', '', '', 0, '', '', '', 0, 0, 0, '', '', '', '', '', '', 1, '', 0, 0, '', 1, 0, 0, 0, '', 1, 'Allan Gois', '', '', 0, NULL, NULL, '2021-05-27 06:07:19', NULL),
(172, 'YRDM7H7A39', 'sue-batta', '', 'Sue', 'Batta', '0000-00-00', 1, 'hania5jan@gmail.com', '7388887772', '', '605d102ccc0b016b6fcdc9fe863d35d0', '', '', 0, '', '', '', '', '', '', 0, '', '', '', 0, 0, 0, '', '', '', '', '', '', 1, '', 0, 0, '', 1, 0, 0, 0, '', 1, 'Sue Batta', '', '', 0, NULL, NULL, '2021-05-27 07:44:04', NULL),
(173, 'GM1R57DZ0S', 'kavya-lakhera', 'profile-pic-1622185943.jpg', 'Kavya', 'Lakhera', '2005-08-02', 1, 'lakherakavya@gmail.com', '6232748433', '8225012228', 'a63d8ad2d83f51e25e449a9b9f872b71', 'Home no.479 ?ward no. 21, Sindhiya nagar , Durg , In front of sofiyaj boutique', '105', 7, '1', '491001', 'I am professional tattoo artist  . I am passionate in tattooing and a skilled artist. I am inspired by Lokesh Verma of devilz tattooz . I am fine and expert in my work . I have my own home tattoo studio  and I use only quality inks and equipment for tattoo process . And my studio is fully hygienic', '2020', 'Lokesh Verma', '', 2, '', '', '3,7,9,18,26', 1, 200, 1, '', '', '', '', '', '', 3, '', 0, 0, '', 1, 0, 1, 2, '200', 1, 'Kavya Lakhera', '', '', 9, NULL, NULL, '2021-05-28 06:44:25', NULL),
(174, '8GM94FS0LK', 'umesh-d-gangul', 'profile-pic-1622535243.jpeg', 'Umesh', 'D’gangul', '1970-01-01', 1, 'umeshgangul@gmail.com', '8888346664', '', 'c266d1162f26e9d17f732eee3bd83411', 'Blakcherry tattoo studio,kings corner,bhist  baugh road, savedi , ahmednagar ', '332', 21, '1', '', 'My self is Umesh D’gangul owner Blakcherry tattoo and art studio, its located at ahmednagar, Maharashtra. I  like to do customized work with theme. I have own style you can check on my Instagram or Facebook. I also do freelancing. I like sketching and painting , making a creative form of any object .you can check . Thanks ???? ', '2015', 'Sachin Arote', '', 2, '', '', '2,4,16,18,19', 1, 1000, 1, '', '', '', '', '', '', 3, '', 0, 0, '', 1, 0, 1, 2, '2000', 1, 'Umesh D’gangul', '', '', 7, NULL, NULL, '2021-06-01 07:52:30', NULL),
(175, '6N82T4PJMW', 'pradeep-nakarani', '', 'Pradeep', 'Nakarani', '0000-00-00', 1, 'pradeepnakarani250@gmail.com', '8866834123', '', '28b0f77d68a819c4a76a33c493d5aeda', '', '', 0, '', '', '', '', '', '', 0, '', '', '', 0, 0, 0, '', '', '', '', '', '', 1, '', 0, 0, '', 1, 0, 0, 0, '', 0, 'Pradeep Nakarani', '', '', 0, NULL, NULL, '2021-06-01 11:10:17', NULL),
(176, 'E0NC3K7GW2', 'vansh-chhabra-1', '', 'Vansh', 'Chhabra', '0000-00-00', 1, 'vansh557@gmail.com', '0862901372', '', '9db1a2c5a88cac28b397665c1d514c1c', '', '', 0, '', '', '', '', '', '', 0, '', '', '', 0, 0, 0, '', '', '', '', '', '', 1, '', 0, 0, '', 1, 0, 0, 0, '', 0, 'Vansh Chhabra', '', '', 0, NULL, NULL, '2021-06-01 18:39:04', NULL),
(177, 'WP990EAKB1', 'akriti-goel', 'profile-pic-1623664307.jpg', 'Akriti', 'Goel', '2000-04-02', 2, 'akritigoel0204@gmail.com', '9643857448', '', '07c6c70388d3cf7157ff69ffb9487762', 'Yamuna Vihar', '120', 10, '1', '', 'My natural curiosity for computers is what drove me towards my computer science degree.\r\nI am pursuing Engineering in computer science from Amity University, Noida. I am currently in 3rd year.\r\nMy studies have provided me with broad proficiency in the use of computer science tools and techniques.\r\nMy specialities include java, learning new skills, languages, problem-solving and good communication skills.\r\nWhen I am not coding, I am learning Spanish, writing articles, reading novels and blogs, and surrounding myself with extraordinary content.\r\nI enjoy meeting new people and hearing new perspectives. Reach out to talk to me about emerging tech, philosophy, Spanish and Hispanic culture.', '2018', 'Khaitan Public School', '', 1, 'Vivian Dsena,Ranveer Singh', '', '12,18,23', 2, 3000, 1, '', '', '', '', '', '', 3, '', 0, 0, '', 0, 0, 1, 1, '3000', 1, 'Akriti Goel', '', '', 0, NULL, NULL, '2021-06-02 06:52:20', NULL),
(178, '50M9FX7YJL', 'jigar-panchal', '', 'Jigar', 'Panchal', '1994-12-07', 1, 'rockingneedles94@gmail.com', '9167956523', '', '978746d92b0091ad4545f08a20f1218f', 'Shop 13, Antariksh building, opp Kanakia police station, Mira Road east', '678', 21, '1', '401107', 'My. Name is Jigar Panchal ( JØØ ) an Indian tattoo artist \r\n\r\nI realized how dynamically important colors were to me. My parents had my back and instigated me in my work. They understood my love for Art and institutionalized me to the explore the colorful world. I was scrutinized to a whole new nature of Art. Chapter by chapter I kept on experimenting. I was inquisitive on learning something new everyday.\r\n\r\nTime winged and my interest grew. Today I am a professional Artist who is unquestionably  in love with colors, calligraphy and typography.  I am gratified to see my Facebook page , which I had started Few years ago, to have gain popularity so quickly.  It has clustered a huge fan following and have TV artists talk about my talent.\r\n\r\nSome people ask me about my secret of such good Art. Well that’s the thing. There’s no secret. I sketch what I see, think and dream about. My best friend, my PEN, helps me turn my imagination into an exquisite art.', '2013', 'Body Canvas ', '', 1, '( Kishwer Merchant ), ( Suyyash Rai ), ( Eisha Singh ), ( Gurneet Chadha J, ( Veebha Anand ), ( Charlie Chauhan ), ( Sneha Ullal )', '', '7,10,18,19,23', 1, 2000, 0, 'http://www.rockingneedles.com/', 'https://www.facebook.com/rockingneedles/', 'https://www.instagram.com/rockingneedles/', 'https://in.pinterest.com/Rocking_Needles/_created/', 'https://www.youtube.com/channel/UCy4CqzuP3lTpAnMrqKaPNfg', 'https://linkin.bio/rockingneedles', 3, '', 0, 0, '', 1, 0, 1, 1, '2000', 1, 'Jigar Panchal', '', '', 6, NULL, NULL, '2021-06-02 11:50:25', NULL),
(179, 'A0L3Z5DVY2', 'sudama--kumar', 'profile-pic-1622803442.jpg', 'Sudama ', 'Tattoos ', '1992-01-14', 1, 'sudamamonu143@gmail.com', '7838534772', '9643528015', 'b860a2fe27fba19fb9b3eb7f0304755b', 'Shop no: 1170 main bazar pahar ganj', '120', 10, '1', '', 'Sudama: I m doing tattoo from 7 years I work in world best tattoo crew celebrity ink I love to do tattoo and I specialty is dot work and Maori tattoo I have be.have a team who make magical art work and I love my passion as a tattoo artist ', '2013', 'Ink school ', 'Manju henna art ', 1, 'Sapna chaodhari ,A bazz ', '', '5,7,10,16,26', 1, 500, 1, '', 'https://m.facebook.com/Sudama-tattoos-1417574985121121/', 'https://www.instagram.com/sudama_tattoos/', 'https://in.pinterest.com/sudamamonu143/', 'https://youtube.com/channel/UCpNeNslk7bdybBkkoVxB2pQ', '', 3, '', 0, 0, 'Be are also giving home service for tattoo as same price in the studios ', 1, 0, 1, 1, '200', 1, 'Sudama  kumar', '', '', 8, NULL, NULL, '2021-06-03 11:28:39', NULL),
(180, 'H3ZPDT23C9', 'mike-inkzone', 'profile-pic-1622808565.jpg', 'Mike', 'Inkzone', '1998-04-28', 1, 'mikeinkzone@gmail.com', '9067043174', '9766281329', '8170f0e81442602d37791d9b886abec1', 'Opp.Dimar Resort near Calangute - Baga cirlce', '649', 11, '1', '403516', 'Hey Myself Mike from Goa?I am self-taught Artist,\r\n‘TATTOOS ARE THE STORIES IN YOUR HEART,\r\nWRITTEN ON YOUR SKIN’\r\nEvery tattoo I do is a chance to cross paths with someone on their journey in life,to experience a moment Together to create.This isn’t just my job,Its my Craft.\r\n.\r\n.\r\n', '2018', 'Self- Thought', '', 2, '', '', '1,16,18,19,23', 2, 2000, 0, '', '', 'https://www.instagram.com/mike_inkzone?r=nametag', '', '', '', 3, '', 0, 0, '', 1, 0, 1, 2, '2000', 1, 'Mike Inkzone', '', '', 7, NULL, NULL, '2021-06-04 11:11:06', NULL),
(181, 'DCYG59UV45', 'srinath--sivam', 'profile-pic-1623047815.jpg', 'Srinath ', 'Sivam', '1988-08-03', 1, 'Srinath.Sivam@gmail.com', '9886635374', '', '30acecd1f88f06c733b74ad6303a0da4', 'Jp Nagar 8th phase', '660', 17, '1', '', 'A self taught artist aspiring to be one of the best at what I do. My motto is to explore, experiment and excel. Every day is a learning day to me. Love to do everything that has anything to do with art. Also love to teach and in turn to learn. Perseverance is my path to success. ', '2010', 'Self taught', '', 2, '', '', '4,16,17,23,26', 1, 800, 0, '', 'http://www.Facebook.com/SriTony', 'http://www.instagram.com/SrinathSivam', '', 'Www.youtube.com/c/tattoosandtalestnt', '', 3, '', 0, 0, '25% off on pre-booked appointments when booked 30 days in advance ', 1, 0, 0, 1, '', 1, 'Srinath  Sivam', '', '', 9, NULL, NULL, '2021-06-04 11:29:48', NULL),
(182, 'D7PQFZU638', 'inkprik-tattoo-studio', 'profile-pic-1622816930.JPG', 'S a', 'i', '2008-10-09', 1, 'inkprik@gmail.com', '9731756903', '9886234477', 'b99f942c9793e66096125853c7b28e74', '#3A, 3rd Ffloor, Gowthami Nest, 1st Cross, Cambridge Layout, Indiranagar', '660', 17, '1', '560008', 'SAI – INTERNATIONALLY TRAINED TATTOO ARTIST\r\nI am a tattoo artist with international work exposure. I have trained under Lancelot Wilkie, who is one of the leading tattoo artists of Guyana-South America. My learning experience of 3years under him involved a rigorous internship that helped me gain insights of the complexities of the tattooing and more importantly, solutions and methodology to become a successful tattoo artist.\r\nI have done several styles of tattoos on myself. There are about twenty plus tattoos (and still counting…) on my hands and legs that I feel represent my style and precision. A unique style on my left arm is the ambigram tattoo that reads Life and Death.', '2008', 'LanceLot Wilkie', '', 1, 'Indian Film Financier & South Indian Film Fashion Guru Ramesh Dembla, Kannada Film Actor Naveen Krishna, Rajeev, Cockroach Sudhir & Actress Mythri Gowda, Malayalam Actor Fahadh Faasil, Indian Kabbadi ', '', '9,16,19,22,26', 1, 1000, 0, 'www.inkprik.com', 'https://www.facebook.com/inkpriktattoostudio', 'https://www.instagram.com/inkprik_tattoos/', 'https://in.pinterest.com/inkprik/_saved/', 'https://www.youtube.com/channel/UC115AWDgbvJOgBzI-0pvTJg/videos', '', 3, '', 0, 0, '', 1, 0, 1, 1, '1000', 1, 'InkPrik Tattoo Studio', '', '', 9, NULL, NULL, '2021-06-04 13:59:56', NULL),
(183, '0ECJ5A88DZ', 'pratik--nagvekar', 'profile-pic-1628011131.jpg', 'Pratik ', 'Nagvekar ', '1998-10-04', 1, 'pratiknagvekar94@gmail.com', '8108089590', '', '21506fd70a6ab5bd99f1c78ba7e96d3e', 'Bhandup west,  mumbai 400078', '672', 21, '1', '400078', 'My name is Pratik Nagvekar \r\nI\'m 23 year old \r\nI doing tattoo from Las 6 years.\r\nWhen I was 18\r\nI\'m self made artisti.i have learned from previous mistakes.\r\nI follow The great artist Sunny Bhanushali sir footsteps. \r\nI provide freelance service. \r\nI planned to setup my own studio in the coming year \r\n\r\n', '2015', '', '', 2, '', '', '7,10,16,18,26', 1, 700, 0, '', '', 'https://instagram.com/p_n_tattoos?igshid=1xq6w6u52i9gd', '', '', '', 3, '', 0, 0, '', 1, 0, 0, 2, '', 1, 'Pratik  Nagvekar ', '', '', 7, NULL, NULL, '2021-06-05 10:04:06', NULL),
(184, '7F3P8URYM3', 'varun--maheshwar-manhas', 'profile-pic-1623071095.jpeg', 'Varun ', 'Maheshwar manhas', '1996-02-28', 1, 'theinkyard@gmail.com', '9596930962', '', '940b735b909116136d447ddfefa0bbab', '39 daily excelsior lane Janipur jammj', '193', 15, '1', '', '', '', '', '', 0, '', '', '1,4,7,16,18', 1, 500, 0, '', '', 'https://instagram.com/the_inkyard?utm_medium=copy_link', 'https://pin.it/6IaeQYH', 'https://youtube.com/channel/UCVzF9E7hQ7avX_bBYP6Tepw', '', 3, '', 0, 0, '', 1, 0, 0, 2, '', 1, 'Varun  Maheshwar manhas', '', '', 7, NULL, NULL, '2021-06-06 04:31:54', NULL),
(185, 'YJ77G9N5LU', 'karan--kumar', 'profile-pic-1624341348.jpg', 'Karan ', 'Kumar', '2000-10-17', 1, 'karantattooist471@gmail.com', '9837731260', '8218101186', '8d09635a76613b3029d05dc32fa0fe8d', 'Replay tattoo studioShop no. 11 rani slatanat plaza  Near sahu cinema Hazratganj, lucknow', '524', 34, '1', '226001', 'A multidisciplinary fine artist , tattoo artist, painter and a graphic designer. Iam doing my bachelors in fine arts from Techno group of institutions . Iam also selected as the youngest tattoo artist in India by INDIA BOOK OF RECORDS .For tattoos iam more inclined towards geometrical  tattoos , 3d realistic tattoos , microrealistic tattoos,  abstract  script calligraphy tattoos, maori tattoos  and types. I love to customise unique conceptual tattoo designs as per your personality, thoughts , intrests and budget. REPLAY TATTOO STUDIO is  a best and most hygienic place in LUCKNOW to get you dream tattoo, where body and art becomes one.', '2017', 'Replay tattoo studio', '', 1, 'Geeta fogat', '', '1,5,7,12,18', 1, 1000, 0, '', '', 'Www.Instagram.com/the_inkedboy_karan', '', '', '', 3, '', 0, 0, '', 1, 0, 1, 1, '1000', 1, 'Karan  Kumar', '', '', 9, NULL, NULL, '2021-06-06 06:18:12', NULL),
(186, 'RF3DS6MU84', 'akash-priyadarshi', 'profile-pic-1628587568.jpeg', 'Akash', 'Priyadarshi', '1992-05-29', 1, 'priyadarshi29592@gmail.com', '8866274149', '9904626500', '195458aed9987ba23813dc1f7cd5e784', 'D 157 first floor snehplaza IOC Road , Chandkheda  Ahmedabad', '134', 12, '1', '382424', 'Award winner at gujarat tattoo convention in realism portrait tattoo . an electrical engineer by qualification . self - trained artist. facinated about dry charcoal artwork and sketching. Ahmedabad is a top player in the category Tattoo Artists in the Ahmedabad. which continues to grow by the day. put in a lot of effort to achieve the common vision and larger goals of the company.', '2016', 'self taught artist', '', 2, '', '', '5,7,16,18,26', 1, 1000, 0, '', 'www.facebook.com/blackdroptattooart', 'www.instagram.com/blackdroptattooart', '', '', '', 3, '', 0, 0, '', 1, 0, 0, 1, '', 1, 'Akash Priyadarshi', '', '', 8, NULL, NULL, '2021-06-06 06:26:49', NULL),
(187, '82CQHN3W6M', 'deepak-muyal', '', 'Deepak', 'Muyal', '0000-00-00', 1, 'deepakmuyal@gmail.com', '8979297152', '', 'c22b7573a935e33df96223c50ba28ef0', '', '', 0, '', '', '', '', '', '', 0, '', '', '', 0, 0, 0, '', '', '', '', '', '', 1, '', 0, 0, '', 1, 0, 0, 0, '', 1, 'Deepak Muyal', '', '', 0, NULL, NULL, '2021-06-06 06:40:06', NULL),
(188, 'XN3D7EP5C2', 'harsh-adlakha', 'profile-pic-1622963176.png', 'Harsh', 'Adlakha', '1995-07-27', 1, 'adlakha_harsh@yahoo.com', '9711112864', '', '24996749c19d6aa2a2ad3783a07304c6', '4B/11 Northern Extension Area, Old Rajinder Nagar', '120', 10, '1', '', '', '', '', '', 0, '', '', '1,2,7,9,21', 1, 1200, 0, '', '', 'https://www.instagram.com/harsh_adlakha/', '', '', '', 3, '', 0, 0, '', 1, 0, 1, 1, '500', 1, 'Harsh Adlakha', '', '', 7, NULL, NULL, '2021-06-06 06:42:07', NULL),
(189, '2XN2H98DKP', 'deepak-malik', '', 'Deepak', 'Malik', '0000-00-00', 1, 'dpkmlk6@gmail.com', '9711463368', '', '23dddc85364e3d15e9f2773e661a0030', '', '', 0, '', '', '', '', '', '', 0, '', '', '', 0, 0, 0, '', '', '', '', '', '', 1, '', 0, 0, '', 1, 0, 0, 0, '', 1, 'Deepak Malik', '', '', 0, NULL, NULL, '2021-06-06 06:55:42', NULL),
(190, 'SUF4NG4C66', 'gaurav--sharma', '', 'Gaurav ', 'Sharma', '2021-02-08', 1, 'gauravsharma3147@gmail.com', '9711763512', '', '50d1844a1d15a946402f8c2d4f60999f', 'G21 plot no .15  nipun corrupte tower karkadooma community Centre  eat delhi ', '773', 10, '1', '110094', ' Hyy????\r\nIm gaurav from gaurav inc \r\n I believe in giving full of my experience and emotions in every art piece that i do  cuz you never forgot your first ???? \r\nYou can check some of my recent work in my  profile and im not good at daddy lil girl tatts ??\r\n', '1980', '', '', 3, '', '', '', 0, 0, 0, '', '', 'http://instagram.com/gauravinc.official/', '', 'https://youtube.com/channel/UCqIfs-WDhWOUFotHfthGJyQ', '', 2, '', 0, 0, '', 1, 0, 0, 0, '', 1, 'Gaurav  Sharma', '', '', 2, NULL, NULL, '2021-06-06 07:11:32', NULL),
(191, '4FS19RCQD9', 'danny-singh', 'profile-pic-1622964355.jpg', 'Danny', 'singh', '1990-05-13', 1, 'schedeleyetattoo@gmail.com', '7838067896', '7838067896', '3dba417ef6277c82283f1559bef8d62b', 'c/22 (A) Acharya niketan mayur vihar phase 1', '120', 10, '1', '110091', 'i am an visionary artist .used to love dark art and skulls but as i grow up i have started making landscapes portraits and other craft works too like handicraft stone ornament and some decorative knives.i have been tattooing since 2008.i enjoy my hobby a lot and love to work hard also want make income by my satisfaction from my art and craft . ', '2008', 'tennyson keisam,', '', 2, '', '', '5,16,17,19,22', 1, 250, 1, '', '', 'https://www.instagram.com/schedeleyetattoo/?hl=en', '', '', '', 3, '', 0, 0, '', 1, 0, 0, 2, '', 1, 'danny singh', '', '', 6, NULL, NULL, '2021-06-06 07:17:25', NULL),
(192, 'G7BJDUZ605', 'mann-sunar-tattoos', 'profile-pic-1622965296.jpeg', 'Mann Sunar', 'Tattoos', '1993-09-02', 1, 'mannsunar89@gmail.com', '9902887553', '', '7e4135f5f617de95ebecedbed60b57e6', 'Tattoo Trends , Kasavanahalli main road, below Reliance Trends, opposite SJR VERITY', '660', 17, '1', '', 'GROWN UP AT THE NORTH-EASTERN PART OF INDIA AND GOT INFLUENCED BY THE HAND POKE STYLE OF TATTOOING BY THE DIFFERENT TRIBES OF THE REGION. DID A HAND POKE TATTOO ON MYSELF AT THE AGE OF 16(JUST AN INITIAL). I REALLY LOVE TO DO BLACK & GREY, DARK ART REALISM OR JUST REALISM. IF A CLIENT COMES WITH THEIR REFERENCES I’ll TRY TO CREATE MY OWN VERSION OF IT ‘CAUSE I BELIEVE THAT WILL MAKE YOU MORE ENGAGE WITH YOUR DESIGN BEFORE TATTOOING AND IT WILL HELP YOU OUT WITH THE PROCESS. BANGALORE IS THE CITY WHERE I STARTED MY TATTOOING CAREER IN 2016. I STILL THINK THAT I HAVE A LOT OF STUFF TO LEARN AND LOT OF THINGS TO SEE. I BELIEVE IN HARD WORK AND I ALSO BELIEVE THAT THERE IS NO SHORTCUTS IN TATTOOING INDUSTRY, IF YOU WANT TO BE BETTER THEN YOU HAVE TO WORK YOUR ASS OFF. I THINK AS AN ARTIST YOU HAVE TO UPGRADE YOURSELF EACH AND EVERYDAY. I DON’T WANT TO DO THE SAME SHIT I WAS DOING 1 YEAR BEFORE.  EACH DAY LEARN SOMETHING NEW, IMPLEMENT THAT IN YOUR TATTOOING AND GIVE AN AWESOME ART PIECE TO YOUR CLIENTS.', '2016', 'Self Taught', '', 3, '', '', '1,16,18,25,26', 1, 600, 0, '', 'https://m.facebook.com/mannsunartattoos/', 'https://www.instagram.com/mann_sunar_tattoos/', '', '', '', 3, '', 0, 0, '', 1, 0, 0, 2, '', 1, 'Mann Sunar Tattoos', '', '', 8, NULL, NULL, '2021-06-06 07:26:02', NULL),
(193, '64VUPX1WC3', 'rajat--pandir', '', 'Rajat ', 'Pandir', '0000-00-00', 1, 'inkfiretattooz@gmail.com', '8295792792', '', '74cbe32e9ced7df0ac4eea251dcd130b', '', '', 0, '', '', '', '', '', '', 0, '', '', '', 0, 0, 0, '', '', '', '', '', '', 1, '', 0, 0, '', 1, 0, 0, 0, '', 1, 'Rajat  Pandir', '', '', 0, NULL, NULL, '2021-06-06 07:36:51', NULL),
(194, 'PF1WLS37Z3', 'piyush-sahay', 'profile-pic-1622966830.jpeg', 'Piyush', 'Sahay', '1994-05-18', 1, 'sagarpiyush0@gmail.com', '7257989999', '', 'c149a92f17e7adcf2736f748504502a2', 'Beside G.Kid Home School near Rose garden apartment Kantifactory road Mahatma Gandhi Nagar kankarbagh Patna', '66', 5, '1', '', '', '', '', '', 0, '', '', '1,18,20,23,26', 1, 1000, 0, '', 'https://m.facebook.com/piyush8235', 'https://www.instagram.com/demonic__inks/', '', '', '', 3, '', 0, 0, '', 1, 0, 1, 2, '1000', 1, 'Piyush Sahay', '', '', 4, NULL, NULL, '2021-06-06 07:58:38', NULL),
(195, '4J6C4DPR6G', 'gurmeet--singh', '', 'Gurmeet ', 'Singh ', '0000-00-00', 1, 'meetmj94@gmail.com', '9899795458', '', '9dfe4d86b1f2fb8bf2fa61e165f14ff4', '', '', 0, '', '', '', '', '', '', 0, '', '', '', 0, 0, 0, '', '', '', '', '', '', 1, '', 0, 0, '', 1, 0, 0, 0, '', 1, 'Gurmeet  Singh ', '', '', 0, NULL, NULL, '2021-06-06 08:06:10', NULL),
(196, 'ZV74W6CS4E', 'dixit-samaal', '', 'Dixit', 'Samaal', '1970-01-01', 1, 'dixitsamaal96@gmail.com', '9574752896', '9574752896', 'ce3fc123589cbf89c22ff705797a8dbf', 'Gandhi chowk,unjha', '137', 12, '1', '', '', '', '', '', 0, '', '', '10,16,18,23,26', 1, 400, 1, '', '', 'https://www.instagram.com/dixys_tattoos_art_studio/', 'In.pinterest.com/dixit1745/_created/', 'https://Youtube.com/c/Dixytattooartstudio', '', 3, '', 0, 0, '', 1, 0, 1, 1, '500', 1, 'Dixit Samaal', '', '', 5, NULL, NULL, '2021-06-06 09:54:13', NULL),
(197, '0JESLU4R82', 'jignesh-nagvadiya', '', 'Jignesh', 'Nagvadiya', '0000-00-00', 1, 'tattooistjack@gmail.com', '7600558613', '', '27a75d09c2381affe0ceed788f24e8c8', '', '', 0, '', '', '', '', '', '', 0, '', '', '', 0, 0, 0, '', '', '', '', '', '', 1, '', 0, 0, '', 1, 0, 0, 0, '', 1, 'Jignesh Nagvadiya', '', '', 0, NULL, NULL, '2021-06-06 10:22:22', NULL),
(198, 'G5HCEL2P37', 'riju-nath', '', 'Riju', 'Nath', '0000-00-00', 1, 'engravet@gamil.com', '9609526126', '', '21a06a631b009134fad5e0b800b866a6', '', '', 0, '', '', '', '', '', '', 0, '', '', '', 0, 0, 0, '', '', '', '', '', '', 1, '', 0, 0, '', 1, 0, 0, 0, '', 1, 'Riju Nath', '', '', 0, NULL, NULL, '2021-06-06 10:26:12', NULL),
(199, '57GFRL9ZV5', 'deepak-jalwal', 'profile-pic-1622977357.jpg', 'Deepak', 'Jalwal', '1970-01-01', 1, 'deepakjalwal120@gmail.com', '9780747345', '7814893900', '5881ea98c815ddc34e06013679c2e09a', ' Mehna chownk near lovely tv center, sucha singh street, bathinda,  punjab, 151001', '698', 28, '1', '', '', '', '', '', 0, '', '', '1,10,16,18,26', 2, 1200, 0, '', '', '', '', '', '', 3, '', 0, 0, '', 1, 0, 0, 2, '', 1, 'Deepak Jalwal', '', '', 3, NULL, NULL, '2021-06-06 11:00:28', NULL),
(200, '3DA3KZ1F5Q', 'vishal-jain', 'profile-pic-1623137080.jpg', 'Vishal', 'Jain', '1998-06-29', 1, 'zlayintattoos@gmail.com', '9752195661', '9479355999', '4c4ee3acffd693066cb5ac584701cf64', '42, dreams glori, vasupuje jain minder , gujrati coleny , babadi kala', '267', 20, '1', '462029', 'Travelling Tattoo artist working in the city of lakes . \r\n\r\nGraphic designer and Artist before being a tattoo artist. Appointment only , no walk ins , Custom projects preferable .\r\nOnly making amazing tattoos.\r\nDoing ALL styles but prefer tattoos that are not common.\r\n\r\nPlease discuss designs before finalizing so we can have something amazing .\r\n', '2019', 'Swapnil', '', 3, '', '', '10,14,16,18', 1, 350, 1, '', '', 'www.instagram.com/zlayintattoos', '', '', '', 3, '', 0, 0, '', 1, 0, 1, 2, '500', 1, 'Vishal Jain', '', '', 8, NULL, NULL, '2021-06-06 11:04:11', NULL),
(201, 'XW78PV3F8L', 'ganesh-prasad', '', 'Ganesh', 'Prasad', '0000-00-00', 1, 'ganeshprasad3096@gmail.com', '7907498568', '', '838caeb69727d117d9af18fb62a56c97', '', '', 0, '', '', '', '', '', '', 0, '', '', '', 0, 0, 0, '', '', '', '', '', '', 1, '', 0, 0, '', 1, 0, 0, 0, '', 1, 'Ganesh Prasad', '', '', 0, NULL, NULL, '2021-06-06 11:14:18', NULL),
(202, 'XVTR2K6F26', 'kamz-inkzone-tattoos', '', 'kamz', 'Inkzone Tattoos', '1993-09-07', 1, 'kamzinkzonetattoos@gmail.com', '9041197025', '9888999914', '3a4d1fc440ad2f7e6d420ebf954edf22', 'KAMZINKZONE TATTOOS 35-C,  SCO 410-11,  FIRST FLOOR', '762', 6, '1', '160022', 'Kamzinkzone is one of Best Tattoo Studio in India, Many popular TV stars get inked from us. Our Clientage is from all over world, People from Australia, New Zealand , Canada , Usa, America , Dubai , England , South Africa Come to get inked by us every year. Contact us to get high quality ink.', '2010', '', 'mtv India,Dubai Media Hub', 1, 'Paras Chhabra, Mahira Sharma, Prince Narula , Ninja , sukhi muzical Doctors,  Sara Gurpal, Sehnaz Gill, Ninja , Badshah', '', '1,16,18,23,26', 2, 15000, 1, 'www.kamzink.com', 'https://www.facebook.com/officialkamzinkzone?refsrc=http%3A%2F%2Fwww.google.com%2F&_rdr', 'https://instagram.com/kamzinkzone?utm_medium=copy_link', 'https://pin.it/7x9XIso', 'https://youtube.com/c/KAmzInkZonetattoos', '', 3, '', 0, 0, '', 1, 0, 1, 1, '100', 1, 'kamz Inkzone Tattoos', '', '', 5, NULL, NULL, '2021-06-06 12:04:44', NULL),
(203, 'F5LPS70XA5', 'nidhi--singh', '', 'Nidhi ', 'Singh', '0000-00-00', 2, 'nidoosingh12345@gmail.com', '7738739095', '', 'd8040136f8586f8917dd57f14e376b59', '', '', 0, '', '', '', '', '', '', 0, '', '', '', 0, 0, 0, '', '', '', '', '', '', 1, '', 0, 0, '', 1, 0, 0, 0, '', 1, 'Nidhi  Singh', '', '', 0, NULL, NULL, '2021-06-06 13:11:28', NULL),
(204, 'H2UT21J7DX', 'sumit--ambulkar', '', 'Sumit ', 'Ambulkar ', '0000-00-00', 1, 'sumitam75@gmail.com', '8208563990', '', 'bf4f2ffe17599cfd80e2490fd965b30c', '', '', 0, '', '', '', '', '', '', 0, '', '', '', 0, 0, 0, '', '', '', '', '', '', 1, '', 0, 0, '', 1, 0, 0, 0, '', 1, 'Sumit  Ambulkar ', '', '', 0, NULL, NULL, '2021-06-06 14:18:58', NULL),
(205, 'GJH1BVC356', 'aron-varma', '', 'Aron', 'Varma', '1989-10-25', 1, 'aronvarmatattooist@gmail.com', '7799228886', '9133228886', 'f3e30369641073eebf0aeef7afa2d779', 'Metro pillar no 1518, Dilsukhnagar main road', '602', 36, '1', '500060', 'My self aron varma tattoo artist from Hyderabad. I had 6 years of great experience in tattoos. I do all type of tattoos like geometric, armbands, polynesian, tribal, dot work, black & grey, portrait tattoos, color tattoos, lettering and customized tattoos. I have done tattoos to few celebrities like Dr. Harrsha, Neha chowdary and kushi kushi ga program director Mahesh. I hope, u will not regret from my work. I respect my clients and give them best of best results from my work. ', '2015', '', '', 1, 'Dr. Harrsha', '', '7,10,16,17,26', 1, 600, 0, '', '', '', '', '', '', 3, '', 0, 0, '', 1, 0, 1, 1, '1000', 1, 'Aron Varma', '', '', 7, NULL, NULL, '2021-06-06 18:43:32', NULL),
(206, 'F39CWZ28XS', 'purushottam-veer', '', 'Purushottam', 'Veer', '1995-06-09', 1, 'veer199509@gmail.com', '7207777350', '9010765629', '13d4152b7cab685e868a93cc44b4ecb3', 'Jamuna towers, 1st floor, shop no.103, Malakpet Opp. Yashoda Hospital metrol pillar no. 1432', '602', 36, '1', '', 'I’m a Hyderabadi Tattoo Artist Veer. What made me a Tattoo artist is pure passion, inspiration, love and fantasy for the art.\r\nOur work ethic and integrity have been ingrained here, as we often spend more time here than our own homes.I spend countless hours in designing a piece and approach every drawing as if I were doing it for myself. “What your heart desires, Is what we desire too”\'. We actually exceed what is required of us by the state health departments. This means the equipment for every tattoo that is done is completely one time use only as well as we go through a really strict medical grade sanitation procedure. We strive to create a welcoming atmosphere for ourselves and clients.', '2015', 'Mentor', 'Own', 3, '', '', '1,16,18,23,26', 1, 500, 1, '', '', 'https://www.instagram.com/v_square_hygienic_tattoos?r=nametag', '', 'https://youtube.com/channel/UCOZzJhwWh5Tg4w8H8J8IGbw', '', 3, '', 0, 0, '', 1, 0, 1, 1, '500', 1, 'Purushottam Veer', '', '', 6, NULL, NULL, '2021-06-07 04:19:06', NULL),
(207, 'TL5Q4P22AU', 'sachin--gowda', 'profile-pic-1623041209.jpeg', 'Sachin ', 'Gowda', '1995-06-19', 1, 'sachin.n.1929@gmail.com', '8884388833', '', '86c27a007c4bcc651441d055506ae631', 'LR Bande road RT Nagar  ', '660', 17, '1', '560045', 'I have been tattooing since 2018 and I was a student of aliens tattoo school 2020 batch to learn advance course of tattoo. Now I own a tattoo studio called Loveshades Tattoo Studio in Bangalore. I’m specialised in doing realistic tattoos and customised designs. We do all types of piercing. ', '2018', 'Aliens Tattoo School', '', 2, '', '', '1,7,12,16,18', 1, 700, 0, 'https://loveshades-tattoo-studio.business.site/', 'https://www.facebook.com/LoveshadesTattooStudio/', 'https://www.instagram.com/loveshades_tattoo_studio/', '', '', '', 3, '', 0, 0, '', 1, 0, 0, 1, '', 1, 'Sachin  Gowda', '', '', 9, NULL, NULL, '2021-06-07 04:22:54', NULL),
(208, 'HQ5DKTU880', 'navneet-singh', '', 'Navneet', 'Singh', '1991-10-28', 1, 'inkporttattoz@gmail.com', '9988811321', '9646999996', '3fb6d44609f92ea69e8e09afc6615c25', 'Khanna', '415', 28, '1', '141401', '', '', '', '', 0, '', '', '', 0, 0, 0, '', '', 'Ink.port', '', '', '', 1, '', 0, 0, '', 1, 0, 0, 0, '', 1, 'Navneet Singh', '', '', 0, NULL, NULL, '2021-06-07 04:47:08', NULL),
(209, 'X5C46T6QWZ', 'badshah-ashish', '', 'Badshah', 'Ashish', '0000-00-00', 1, 'redsmoketattoostudio@gmail.com', '9826536711', '', 'e7bac1c0f9863ac7c58991a31ca53ae2', '', '', 0, '', '', '', '', '', '', 0, '', '', '', 0, 0, 0, '', '', '', '', '', '', 1, '', 0, 0, '', 1, 0, 0, 0, '', 1, 'Badshah Ashish', '', '', 0, NULL, NULL, '2021-06-07 04:57:27', NULL),
(210, 'RJ0D8T4Q9P', 'megha-jeevan', '', 'Megha', 'Jeevan', '1995-09-25', 2, 'meghajeevan.mj@gmail.com', '7013194086', '8318331970', 'e16017a25151707f2d12772eff15826c', 'Manali', '176', 14, '1', '171531', '', '', '', '', 0, '', '', '', 0, 0, 0, '', '', '', '', '', '', 1, '', 0, 0, '', 1, 0, 0, 0, '', 1, 'Megha Jeevan', '', '', 0, NULL, NULL, '2021-06-07 05:20:39', NULL),
(211, 'SCF44XM9J2', 'nec-mare', 'profile-pic-1623052435.jpg', 'Nec', 'Mare', '1992-12-09', 1, 'lifeblessed270@gmail.com', '7551873264', '9623076582', '339e4223fa53c7ad161f033095074400', 'Sevoke road ShastrinagarSiliguri', '599', 35, '1', '734001', '(Self-taught Artist)\r\nSourabh\r\nIt all started when I was 20. A hidden artist was always inside me when I was a kid. In the stage of learning tattooing was a good experience but not everyone trust\'s with their skin... Those days were different. I started practicing on my own self. Days passed filling the skin with the same passion just like a writer fills his diary with ink .. \r\n\r\nI perform Black and grey tattoos and loved to do it in realistically ways. Yes, I do other form of styles too (Colour tattoos , lettering, religious japanese) ', '2017', 'Lumbini higher secondary school', '', 2, '', '', '16,17,18,19,26', 1, 400, 0, '', '', 'https://www.google.com/search?q=necmaretattoo_inn&oq=necmaretattoo_inn&aqs=chrome..69i57.11972j0j7&client=ms-android-vivo-rvo2&sourceid=chrome-mobile&ie=UTF-8', 'https://pin.it/2hNYP1L', '', '', 3, '', 0, 0, '', 1, 0, 0, 2, '', 1, 'Nec Mare', '', '', 6, NULL, NULL, '2021-06-07 05:40:47', NULL),
(212, 'WVUS42PN26', 'bhavesh-kalma', 'profile-pic-1623048770.jpeg', 'Bhavesh', 'Kalma', '1994-10-11', 1, 'bhaveshkalma@gmail.com', '8734029613', '', 'e2c49e0954d5228a5e56cd197010a5bb', '2- lunkand Garden viman nager ', '315', 21, '1', '382424', 'Mostly i do Realism, but i like to do all kind of styles. I’m exploring bio-organic and bio-mechanical also, you can see some of my artwork on my another insta page as @bioorganic. I joined Aliens tattoo in 2017 and still working with them, currently working at Aliens tattoo Pune Branch.\r\n', '2016', '', '', 2, '', '', '18,19', 2, 6000, 0, '', '', 'https://instagram.com/bhaveshkalma?utm_medium=copy_link', '', '', '', 3, '', 0, 0, '', 1, 0, 0, 2, '', 1, 'Bhavesh Kalma', '', '', 5, NULL, NULL, '2021-06-07 05:53:24', NULL),
(213, 'AP8Z0QH44R', 'omkar-nikarge', 'profile-pic-1623047646.jpg', 'Omkar', 'Nikarge', '1992-06-05', 1, 'ominikarge@gmail.com', '8655357292', '', '1166f5030977a70c5acb0d30804042df', 'Andheri, Mumbai', '672', 21, '1', '', '', '', '', '', 0, '', '', '5,9,13,21,23', 1, 750, 0, '', '', 'https://www.instagram.com/omkarnikarge', '', '', '', 3, '', 0, 0, '', 1, 0, 1, 1, '1000', 1, 'Omkar Nikarge', '', '', 4, NULL, NULL, '2021-06-07 06:19:20', NULL),
(214, '4D9VMG09ZA', 'dina-karan', 'profile-pic-1623056724.jpg', 'Dina', 'Karan', '1985-10-16', 1, 'karanarul2010@gmail.com', '8088071050', '0804958678', '33e71398451f2bc33708077263454861', '#495, 7th Main, HMT Layout, CBI Main Road, Post, Ganganagar, RT Nagar', '660', 17, '1', '560032', '\"I am Dina-Karan from Bangalore, I have 15 years of experience in the tattoo field I love to do larger black & gray pieces as well as crazy color blending. I give 110% on every tattoo no matter how big or small it may be. my customer satisfaction is my main focus and I want to help you design your tattoo and take your idea to the next level. Beyond your imagination, Immortal Creative Tattoo Studio & Academy has wanted to differentiate itself from other tattoo studios. It is our focus to provide customers with artistic tattooing, whether it is a custom-designed piece, freehand artwork, or traditional wall flash.\"', '2006', 'Punsi JK', '', 1, 'Gian Nobilee', '', '14,16,18,19,26', 1, 600, 0, 'www.immortaltattoostudio.com', 'https://www.facebook.com/karanarul2010', 'https://www.instagram.com/immortal_creative_tattoo', 'www.pinterest/karanTattoo', '', '', 3, '', 0, 0, 'Flat 50% Discount', 1, 0, 1, 1, '1000', 1, 'Dina Karan', '', '', 9, NULL, NULL, '2021-06-07 08:17:46', NULL);
INSERT INTO `adv_artist` (`id`, `code`, `slug`, `profile_pic`, `fname`, `lname`, `dob`, `gender`, `email`, `mobile`, `alt_mobile`, `password`, `address`, `city`, `state`, `country`, `pincode`, `artist_bio`, `work_since`, `mentor`, `sponsor`, `celeb`, `celeb_name`, `emp_type`, `cats`, `pmode`, `price`, `pshow`, `website`, `facebook`, `instagram`, `pinterest`, `youtube`, `blog_url`, `profile_step`, `ref_code`, `wallet`, `pedia_wallet`, `artist_offer`, `status`, `feature`, `direct_booking`, `piercing`, `minimum_booking_amount`, `verified`, `meta_title`, `meta_keyword`, `meta_desc`, `list_order`, `fs_date`, `fe_date`, `created`, `last_login`) VALUES
(215, '3P467FTBMJ', 'mukesh--waghela', 'profile-pic-1623069247.PNG', 'Mukesh ', 'Waghela', '1982-04-14', 1, 'mukeshomsai@gmail.com', '9881773312', '', '6e7cead64f2ec5198b6201553e8fb934', 'Moksha Tattoo Studio, Calangute circle, Goa', '649', 11, '1', '403516', 'Mukesh Waghela has an experience of 17 years and an international and national award-winning top rated tattoo artist in the Indian tattoo industry. He has won total of 38 tattoo awards till date and still counting.  He has served as a jury member/judging panel for several national and international tattoo festivals. Mukesh has inked several celebrities across the globe including Chris Gayle, Tapsee pannu, Raghu Ram and many more. Mukesh also hosts several tattoo trainings, seminars and workshops across the country. He is one of the senior and a living tattoo legend of Indian Tattoo Industry.\r\n\r\nMoksha Tattoo Studio has been also voted India’s one of the best tattoo studio by the UK’s famous tattoo magazine ‘Total Tattoo Time”.\r\n\r\n', '2003', 'Thailand Tattoo Center', '', 1, 'Chris Gayle, Taatsee Pannu, Raghu Ram, Ali Fazal', '', '4,9,16,18,26', 2, 10000, 0, 'https://www.mokshatattoostudio.com', 'https://www.facebook.com/MokshaTattooStudios', 'https://www.instagram.com/mokshatattoostudiogoa', '', '', '', 3, '', 0, 0, '', 1, 1, 0, 2, '', 1, 'Mukesh  Waghela', '', '', 8, NULL, NULL, '2021-06-07 12:12:34', NULL),
(216, 'MG1Z36FY0A', 'rohit--jothe', '', 'Rohit ', 'Jothe', '0000-00-00', 1, 'Rohitjothe123@gmail.com', '6260507306', '', 'd7994aae0535032c2a36eb53f5093752', '', '', 0, '', '', '', '', '', '', 0, '', '', '', 0, 0, 0, '', '', '', '', '', '', 1, '', 0, 0, '', 1, 0, 0, 0, '', 0, 'Rohit  Jothe', '', '', 0, NULL, NULL, '2021-06-07 12:50:12', NULL),
(217, '0T4UMEK94X', 'kuldeep-krishna-1', '', 'kuldeep', 'krishna', '0000-00-00', 1, 'thedeepinktattooz@gmail.com', '8136833401', '', 'ab2206948fe1ff5715e782b0ada9c408', '', '', 0, '', '', '', '', '', '', 0, '', '', '', 0, 0, 0, '', '', '', '', '', '', 1, '', 0, 0, '', 1, 0, 0, 0, '', 1, 'kuldeep krishna', '', '', 0, NULL, NULL, '2021-06-08 06:08:40', NULL),
(218, '297TPY8EVZ', 'raghav-sethi', 'profile-pic-1624996450.jpeg', 'Raghav', 'Sethi', '1970-01-01', 1, 'tattoozbyraghav@gmail.com', '9899752538', '', '65ca3f4ee450833d377dba660772d805', 'B 41 first floor Amar colony  ', '773', 10, '1', '', ' Tattoo artist  from New Delhi, working since 10 years now. In a place where there’s still very limited awareness and knowledge about tattoo art, i have worked with patience to break out of the mold and make it big in the industry.\r\nMy motto is to work hard each day, sincerely. ', '2011', 'None. ', '', 1, 'Komal Pandey ,Nitibha Kaul ,tejeshwar sandhoo,gaurav sharma ', '', '4,7,10,11,12', 1, 700, 1, 'www.thetattooshopnewdelhi.com', '', 'https://instagram.com/tattoozbyraghav?utm_medium=copy_link', '', '', '', 3, '', 0, 0, '', 1, 0, 1, 2, '2000', 1, 'Raghav Sethi', '', '', 7, NULL, NULL, '2021-06-08 06:34:49', NULL),
(219, '7ZDXYLF192', 'aditi-singh', '', 'Aditi', 'Singh', '0000-00-00', 2, 'aditi1052@gmail.com', '6202930165', '', '1e00d4fadadcdb901e22c09cc9d917e1', '', '', 0, '', '', '', '', '', '', 0, '', '', '', 0, 0, 0, '', '', '', '', '', '', 1, '', 0, 0, '', 1, 0, 0, 0, '', 1, 'Aditi Singh', '', '', 0, NULL, NULL, '2021-06-09 21:20:54', NULL),
(220, 'X7PEL676NS', 'ayaan-ansari', '', 'Ayaan', 'Ansari', '0000-00-00', 1, 'badru.ansari92@gmail.com', '9717014906', '', '7bb6e6312cf965000982d1f9db10b8f2', '', '', 0, '', '', '', '', '', '', 0, '', '', '', 0, 0, 0, '', '', '', '', '', '', 1, '', 0, 0, '', 1, 0, 0, 0, '', 0, 'Ayaan Ansari', '', '', 0, NULL, NULL, '2021-06-10 06:35:48', NULL),
(221, 'KV12PU1A7B', 'gourav-mahajan', 'profile-pic-1623316707.jpeg', 'Gourav', 'Mahajan', '1970-01-01', 1, '23gunstattoo@gmail.com', '8558883376', '01724023633', '9561106c122668e9d3b4254116c36125', 'Sector7c sco37 top floor madahya marg chandigarh ', '762', 6, '1', '', 'My name is Gourav Mahajan Qualified engineer following passion from last 8 years basically from Himachal Pradesh been working here from last 8 years inking people makes me happy wen I see the happy faces .we create Wat u aspire we provide tattoo training as well we are based in chandigarh', '2013', 'Devilz tattoo ', '', 1, 'Jasmine sandlas ,Jaystar,Sippi Gill ,Swalina ,saragurpal ', '', '3,5,9,16,21', 1, 2000, 0, '23gunstattoo.com', '', 'https://www.instagram.com/p/CPe2jceApVW/?utm_medium=copy_link', '', '', '', 3, '', 0, 0, '', 1, 0, 1, 1, '500', 1, 'Gourav Mahajan', '', '', 7, NULL, NULL, '2021-06-10 08:14:27', NULL),
(222, 'E8VADW94B3', 'suvankar-majumdar', 'profile-pic-1623326202.jpg', 'Suvankar', 'Majumdar', '1990-05-25', 1, 'screaminktattoos@gmail.com', '9810196910', '9654726864', '691ca4c2029d4999d951f4a4663bd569', 'D-76, Malviya Nagar Rd, Main Market, DDA Flats, Malviya Nagar, New Delhi, Delhi 110017', '120', 10, '1', '', 'NIFT Alumni who graduated with a degree in Fashion and Lifestyle Accessories Design. I started tattooing in 2014 and established Scream-Ink Tattoos with the idea of creating a conducive space for artists of all types. I wanted to bring together different styles and minds, in order to create  a family of unique individuals dedicated to the arts. We are now based out of a studio in South Delhi, and hope to expand soon.', '2014', 'NIFT', '', 3, '', '', '1,2,9,13,18', 2, 5000, 1, 'screaminktattoos@gmail.com', '', 'https://www.instagram.com/screaminktattoos_/?hl=en', '', '', '', 3, '', 0, 0, '', 1, 1, 1, 2, '2000', 1, 'Suvankar Majumdar', 'Suvankar Majumdar Tattoo Artist in Delhi, Delhi Tattoo Artist', 'NIFT Alumni who graduated with a degree in Fashion and Lifestyle Accessories Design. I started tattooing in 2014 and established Scream-Ink Tattoos with the idea of creating a conducive space for artists of all types. ', 13, NULL, NULL, '2021-06-10 10:45:06', NULL),
(223, '5TSL4M14CA', 'lucky--solanki', 'profile-pic-1623331280.jpg', 'Lucky ', 'Solanki', '1989-09-11', 1, 'streetculture9@gmail.com', '7666021071', '9819700071', '6e1801529c9ad795849f7b77ad17d796', '405, Sanjar Enclave, 4th floor, opposite Milap (PVR) talkies, s.v.road, Malad (west).', '672', 21, '1', '400067', 'Hi, \r\nMy self Lucky Solanki the owner of Street Culture Tattoo and Academy. I have been Tattooing since 2009, and I\'m self taught artist. I Tattoo to live. Im a versatile tattoo artist who does almost every tattoo styles, and my specialty is colour tattoo and realism tattoos.\r\nI was awarded by several awards on various international tattoo conventions but the biggest achievement was in year 2018 where I was awarded as \"BEST OF THE SHOW\" in India\'s biggest international tattoo convention (heartwork tattoo festival).\r\n\r\nBesides tattoo I also have training academy. Mentoring (teaching) is my hobby which I really enjoyed. I always wanted to create a platform where I can teach and share my tattooing skills to all the upcoming tattoo artists who really want to pursue this art form as their career. \r\n\r\nif you are tattoo lover and looking for tattoo then feel free to contact me, I would love to give you a wonderful piece of tattoo.', '2009', 'Self Taught', '', 1, 'Ruel Dausan (filmfare award winner bollywood choreographer), Ayaz Ahmed (actor), Nishchal Sharma (choreographer), Unnati Malharkar (bollywood actress), Yuvraj walmiki (indian Hocky Player)', '', '16,18,19,23,26', 1, 1000, 0, 'www.streetculturetattoo.com', '', 'https://instagram.com/lucky_solanki_09?utm_medium=copy_link', '', '', '', 3, '', 0, 0, '', 1, 0, 1, 2, '2000', 1, 'Lucky  Solanki', '', '', 11, NULL, NULL, '2021-06-10 12:35:58', NULL),
(224, 'FUB447TMZ4', 'sanjay-cruzy', 'profile-pic-1626455093.jpg', 'Sanjay', 'Cruzy', '2000-08-01', 1, 'getmecruzy@gmail.com', '7034787239', '7994799198', 'bf67481c2d063e7e4c862c9dddd20e2c', 'I\'ll reach out to clients ', '649', 11, '1', '', 'it\'s Cruzy..! As an artist i work hard to develop my arts that speaks to me and to others about the beauty exists in that art of tattooing and i try to make every artwork to breathe and to be memories to my Canvas..!! ???????? ???????????????????????? ???????????? ????????????????, ???????? ???????????????????? ???????? ????????????????????????????', '2018', 'Self-taught', 'Utopian,Bishop,Vladblad', 1, 'Priya prakash varrier,Yaami,Mirchi varsha', '', '7,13,16,18,19', 2, 2000, 0, 'https://instagram.com/cr.u.zy?utm_medium=copy_link', 'https://www.facebook.com/sanjay.sachu.507', 'https://instagram.com/cr.u.zy?utm_medium=copy_link', 'https://pin.it/4kZRpJF', 'https://youtu.be/UJ6g0mDw4Ko', '', 3, '', 0, 0, '', 1, 0, 1, 1, '499', 1, 'Sanjay Cruzy', '', '', 8, NULL, NULL, '2021-06-10 14:30:34', NULL),
(225, 'E319QPH0AX', 'sayantan-debnath', 'profile-pic-1623338240.jpg', 'Sayantan', 'Debnath', '1992-02-07', 1, 'piratedstar@gmail.com', '9547276469', '', '3e7088a4cc6d4609449f0a37f898b1ce', '5th block, koramangala', '660', 17, '1', '560095', 'Hello, people. My name is Sayantan Debnath, I\'m from Kolkata and currently tattooing in Bangalore. I\'ve been painting and sketching since childhood and like to try different mediums. I love to do mostly realism, but I change the approach according to the design and my client\'s need. Whether it\'s minimal illustration or detailed realism, I\'ve been making the custom designs my clients sice 2016. Go through my profile to have a glance of the kind of work I do. \r\nIf you love my works then get in touch to get the tattoo you\'re looking for.', '2016', 'Lokesh Verma', '', 3, '', '', '2,13,16,18,23', 2, 4000, 0, '', '', 'https://www.instagram.com/pirate_jax', '', '', '', 3, '', 0, 0, '', 1, 0, 1, 2, '1000', 1, 'Sayantan Debnath', '', '', 7, NULL, NULL, '2021-06-10 14:34:54', NULL),
(226, '3H86FQG5VZ', 'brother-tattooz', 'profile-pic-1623338296.jpeg', 'Brother', 'Tattooz', '2016-10-01', 1, 'brothertattooz@gmail.com', '9793909991', '7394906270', '6042e56358197abb9cadca11206a0e7c', '126/G/51, Infront of Prince Motors, Govind Nagar,Kanpur', '543', 34, '1', '208006', 'Situated in influential locale of Panki & Govind Nagar,Kanpur, Our Tattoo shop opened its doors in 2016 and has been a prominent provider of specialized artistic tattoo design, consulting and superior piercing services. We also provide tattoo and piercing training in our studio. Please do not hesitate to stop by or contact us with any questions. We are looking forward to meeting you.', '2016', 'Self', '', 3, '', '', '7,16,19,22,26', 1, 600, 0, 'https://brothertattooz.com/', 'https://m.facebook.com/BrotherTattooz', 'https://instagram.com/brothertattooz?utm_medium=copy_link', 'https://pin.it/2oR7W9T', 'https://youtu.be/kdj_wP5KSZg', '', 3, '', 0, 0, '', 1, 0, 1, 1, '1500', 1, 'Brother Tattooz', '', '', 10, NULL, NULL, '2021-06-10 14:45:59', NULL),
(227, 'UDHS7G830V', 'bunty-bugs', '', 'Bunty', 'bugs', '1992-10-25', 1, 'deepaknaidu7@gmail.com', '9704707249', '9703707249', '30077392b6f4d532059704b84ac82bdf', 'pvp mall road , ghiza resturant upstaris, 4 th floor ', '606', 1, '1', '520002', '', '', '', '', 0, '', '', '', 0, 0, 0, '', '', '', '', '', '', 1, '', 0, 0, '', 1, 0, 0, 0, '', 1, 'Bunty bugs', '', '', 0, NULL, NULL, '2021-06-11 03:55:26', NULL),
(228, 'SAB213PE8K', 'roni-sarkar', '', 'Roni', 'Sarkar', '0000-00-00', 1, 'roni4328@gmail.com', '8092639627', '', '0207d5e6bb1993028a5878d1716db2b2', '', '', 0, '', '', '', '', '', '', 0, '', '', '', 0, 0, 0, '', '', '', '', '', '', 1, '', 0, 0, '', 0, 0, 0, 0, '', 0, 'Roni Sarkar', '', '', 0, NULL, NULL, '2021-06-11 07:00:55', NULL),
(229, 'HTJ2V2Q4N4', 'roni-sarkar-1', '', 'Roni', 'Sarkar', '0000-00-00', 1, 'roni4238@gmail.com', '8092639624', '', '0207d5e6bb1993028a5878d1716db2b2', '', '', 0, '', '', '', '', '', '', 0, '', '', '', 0, 0, 0, '', '', '', '', '', '', 1, '', 0, 0, '', 0, 0, 0, 0, '', 0, 'Roni Sarkar', '', '', 0, NULL, NULL, '2021-06-11 07:04:30', NULL),
(230, 'FQ67A8X4DM', 'roni-sarkar-2', 'profile-pic-1623397846.jpg', 'Roni', 'Sarkar', '2021-05-14', 1, 'sarkarroni689@gmail.com', '6202930165', '7091318770', '0207d5e6bb1993028a5878d1716db2b2', 'BloodBox Tattoo Studio, second floor, naidu tower, SNP Area, Sakchi- 831001', '211', 16, '1', '831001', 'An artist is the heart of any tattoo studio and so is Roni Sarkar to us. His passion for the art can be seen from his work. he was 17 when the idea of making permanent art struck him. He built his own tattoo machine and started inking his friends and family. Wgen he saw his idea turning into a success and realised that people loved and appreciated his art, he decided to turn it into a full time profession. at the bare age of 18, he bought his first tattoo machine and opened The BloodBox Tattoo Studio.', '2011', 'self', '', 3, '', '', '10,16,18,19,26', 1, 1200, 0, 'www.ronisarkar.com', 'https://www.facebook.com/profile.php?id=100008387894948', 'www.instagram.com/_roni_sarkar/', '', 'https://www.youtube.com/channel/UCvX9imprm7zsUtOdBtOLRag', '', 3, '', 0, 0, '', 1, 0, 1, 1, '2000', 1, 'Roni Sarkar', '', '', 7, NULL, NULL, '2021-06-11 07:26:22', NULL),
(231, 'H82M8Z1RXP', 'akash-dutta', 'profile-pic-1625065510.jpg', 'Akash', 'Dutta', '1997-02-07', 1, 'dutta.akash0702@gmail.com', '7675931178', '8886088665', 'b79ab1ed05c01fe4beb9315d2092bfd8', '402, MSR TOWERS, bhandari layout road no. 4, nizampet village, Kukatpally', '602', 36, '1', '500090', 'Traditional artist straight from the streets of Assam, handpoke specialist. I love to play with colours on my canvas as well, my journey with tattooing and as an artist has been extremely insightful because it gives me a sense of peace when I start tattooing. I have been tattooing since my schooling, handpoke tattoos are my fortè and I love doing traditional work.', '2011', 'Self taught', '', 2, '', '', '8,16,18,21,22', 2, 4000, 0, '', 'https://www.facebook.com/AVtattoosandpiercing/', 'https://instagram.com/avtattoostudio?utm_medium=copy_link', '', '', '', 3, '', 0, 0, '', 1, 0, 1, 1, '1500', 1, 'Akash Dutta', '', '', 10, NULL, NULL, '2021-06-11 07:28:01', NULL),
(232, 'S8JHVAD491', 'ankit--gupta', '', 'Ankit ', 'Gupta ', '0000-00-00', 1, 'tattoo.ankit@gmail.com', '8745801112', '', '5de52ea9d787966e8b598720255a37a7', '', '', 0, '', '', '', '', '', '', 0, '', '', '', 0, 0, 0, '', '', '', '', '', '', 1, '', 0, 0, '', 1, 0, 0, 0, '', 0, 'Ankit  Gupta ', '', '', 0, NULL, NULL, '2021-06-11 07:47:58', NULL),
(233, 'BCG0J33T7A', 'divyanshu--sharma', '', 'Divyanshu ', 'Sharma ', '0000-00-00', 1, 'divyanshusharm05@gmail.com', '7999314350', '', 'cdf0f2184b739d1f170ffb207466baee', '', '', 0, '', '', '', '', '', '', 0, '', '', '', 0, 0, 0, '', '', '', '', '', '', 1, '', 0, 0, '', 1, 0, 0, 0, '', 0, 'Divyanshu  Sharma ', '', '', 0, NULL, NULL, '2021-06-11 09:22:11', NULL),
(234, 'GRVS8H4X61', 'mubii-s-tattoo', '', 'Mubii\'s', 'Tattoo ', '0000-00-00', 1, 'mubashirali0612@gmail.com', '7006695099', '', '9889337fd82fc53eddbe3bf643532165', '', '', 0, '', '', '', '', '', '', 0, '', '', '', 0, 0, 0, '', '', '', '', '', '', 1, '', 0, 0, '', 1, 0, 0, 0, '', 1, 'Mubii\'s Tattoo ', '', '', 0, NULL, NULL, '2021-06-11 09:42:02', NULL),
(235, 'TY113APF1U', 'gurveer-singh', '', 'Gurveer', 'Singh', '0000-00-00', 1, 'sgavi96@gmail.com', '8567921858', '', '9b46234f06be59105ad125fb0721bc8b', '', '', 0, '', '', '', '', '', '', 0, '', '', '', 0, 0, 0, '', '', '', '', '', '', 1, '', 0, 0, '', 1, 0, 0, 0, '', 1, 'Gurveer Singh', '', '', 0, NULL, NULL, '2021-06-11 13:02:23', NULL),
(236, '2LNTEYA580', 'deepanshu-sharma', '', 'Deepanshu', 'Sharma', '1990-11-28', 1, 'shivaaytattoos@gmail.com', '9610205442', '8949303461', '7cc5715c8c6e5387e36e45cccdc4613c', 'Shivaay Tattoo Studio, Behind midnight vegas, Malviya Nagar, Jaipur', '430', 29, '1', '302017', 'Tattoo artist Deepanshu Sharma is a professionally trained tattoo artist, trained under Sir Mukesh Waghela. Deepanshu is an MBA graduate, he choose tattooing for his excellent sketching skills on paper and love for art, enrolling himself in Moskha for tattoo training program and gaining all the knowledge and tattoo skills, On his excellent performance Deepanshu was a chosen artist to work for Moksha tattoo studio.', '2020', 'Mukesh Waghela', '', 2, '', '', '2,4,10,14,18', 1, 800, 0, '', 'https://www.facebook.com/sharma.deepm', 'https://www.instagram.com/awara_deep', '', '', '', 3, '', 0, 0, '', 1, 0, 0, 2, '', 1, 'Deepanshu Sharma', '', '', 5, NULL, NULL, '2021-06-11 13:13:36', NULL),
(237, 'NC277RXV1P', 'manoj-natraj', '', 'Manoj', 'Natraj', '0000-00-00', 1, 'manojnatraj5@gmail.com', '9791862466', '', 'caaac0b4339699ddf0258756cf8306f7', '', '', 0, '', '', '', '', '', '', 0, '', '', '', 0, 0, 0, '', '', '', '', '', '', 1, '', 0, 0, '', 1, 0, 0, 0, '', 1, 'Manoj Natraj', '', '', 0, NULL, NULL, '2021-06-11 13:34:55', NULL),
(238, '3SMTAV459B', 'shiva-sapkota', 'profile-pic-1623599362.jpg', 'shiva', 'sapkota', '1985-03-24', 1, 'prabuddhmaya22118@gmail.com', '9903884965', '9903884965', '410421923b471953e9c7d2f4b90464e8', '12/2 selimpore road .. (Dhakuria)', '600', 35, '1', '', '', '', '', '', 0, '', '', '2,4,7,16,19', 2, 3000, 1, '', 'https://www.facebook.com/PrabuddhMayaKolkata', 'https://instagram.com/prabuddhmayatattoo?utm_medium=copy_link', '', 'https://www.youtube.com/channel/UCnDMVC_85E73pBx0wWx7O3Q', '', 3, '', 0, 0, '', 1, 0, 1, 1, '3000', 1, 'Shiva Sapkota', '', '', 4, NULL, NULL, '2021-06-11 15:21:35', NULL),
(239, '2LNG925SVU', 'prijin-p', '', 'Prijin', 'P', '0000-00-00', 1, 'prijinprakash1996@gmail.com', '8129348199', '', '41704c97f085e9c46bbf014f88cb7645', '', '', 0, '', '', '', '', '', '', 0, '', '', '', 0, 0, 0, '', '', '', '', '', '', 1, '', 0, 0, '', 1, 0, 0, 0, '', 1, 'Prijin P', '', '', 0, NULL, NULL, '2021-06-11 16:17:26', NULL),
(240, 'SJQH89G95W', 'deepu-gowda', '', 'Deepu', 'Gowda', '0000-00-00', 1, 'deepudeadshot@gmail.com', '6360548343', '', 'd70d10b1b49f5e11e6109120f1a61cab', '', '', 0, '', '', '', '', '', '', 0, '', '', '', 0, 0, 0, '', '', '', '', '', '', 1, '', 0, 0, '', 1, 0, 0, 0, '', 1, 'Deepu Gowda', '', '', 0, NULL, NULL, '2021-06-11 19:37:10', NULL),
(241, 'B1P83GHY3A', 'vijay-loganathan', 'profile-pic-1623444456.jpg', 'Vijay', 'Loganathan', '1986-03-31', 1, 'tattooslogan@gmail.com', '8526666652', '9790878882', 'f3c4fa3cb2cb3331c1432ff820942ab7', '15, vijayaragavulu road,pencil factory', '466', 31, '1', '600021', 'If ur looking for a tattoo artist or piercer. finally u find it. Yes We are the first professional tattoo artist in India. With 199% hygiene amd sterilized equipment. Spec- custom design, vitiligo coverup, scar coverup, potrait, realism, color , black and grey, coverup,\r\nAny enq feel free to contact', '2010', 'Jhon', '', 3, '', '', '1,5,18,23,26', 1, 1000, 0, '', '', 'Logan.tattoos', '', '', '', 3, '', 0, 0, '', 1, 0, 1, 1, '2000', 1, 'Vijay Loganathan', '', '', 7, NULL, NULL, '2021-06-11 19:52:14', NULL),
(242, 'E12BG19WPK', 'sanket--jadhav', 'profile-pic-1623442093.jpeg', 'Sanket ', 'Jadhav', '0000-00-00', 1, 'samjadhav1234@gmail.com', '9356474169', '', '7f8d5f8a679cab17fc9983e39712f8f5', '', '', 0, '', '', '', '', '', '', 0, '', '', '', 0, 0, 0, '', '', '', '', '', '', 1, '', 0, 0, '', 1, 0, 0, 0, '', 1, 'Sanket  Jadhav', '', '', 1, NULL, NULL, '2021-06-11 20:02:11', NULL),
(243, 'DLBJE53A46', 'abhijit-varpe', '', 'Abhijit', 'Varpe', '0000-00-00', 1, 'varpeabhijit@gmail.com', '9664022959', '', '0906aa56f34bcac6b97c06c318e09da7', '', '', 0, '', '', '', '', '', '', 0, '', '', '', 0, 0, 0, '', '', '', '', '', '', 1, '', 0, 0, '', 1, 0, 0, 0, '', 1, 'Abhijit Varpe', '', '', 0, NULL, NULL, '2021-06-12 07:35:53', NULL),
(244, 'G74B9Q5RMT', 'sahil-wadhawan', '', 'Sahil', 'Wadhawan ', '1996-10-18', 1, 'sahilwadhwan9@gmail.com', '8054562475', '9625980767', '0a2a1cc548225c1e312ae2ee078edd24', '#11237 street:2 inderprasat Nagar choti haibowal ludhiana Punjab ', '415', 28, '1', '141001', '', '', '', '', 0, '', '', '', 0, 0, 0, '', '', '', '', '', '', 1, '', 0, 0, '', 1, 0, 0, 0, '', 1, 'Sahil Wadhawan ', '', '', 0, NULL, NULL, '2021-06-12 08:38:45', NULL),
(245, 'F5Q77EK0TG', 'david-d-souza', 'profile-pic-1623490460.jpg', 'David', 'D\'souza', '1995-04-14', 1, 'tattoozbadass@gmail.com', '8355858549', '8652755458', 'c8b3663657c7053b2ee8a56fa29207d6', 'Bhandup west, nearby station shop no G1 BMC market bldg ', '672', 21, '1', '400078', 'Hi,, myself david d\'souza\r\nIm a artist ( prof. Tattoo artist) i like arts & i worked tough to became a successful artist ,desired to peoples (clients) from my Tattoo arts....not only tattooz i also do sketches, crafts, paintings, sculpting...i started a tattoo ( enter in tattoo industry) in 2018 ...4 years experience in tattooz & i feel good & happy also im artist & i join to a tattoo industry ', '2019', '', '', 3, '', '', '4,7,10,16,26', 1, 800, 0, '', 'https://m.facebook.com/Tattooz.Badass/?ref=bookmarks', 'https://www.instagram.com/badasstattooz/', '', '', '', 3, '', 0, 0, '', 1, 0, 1, 2, '500', 1, 'David D\'souza', '', '', 6, NULL, NULL, '2021-06-12 08:46:59', NULL),
(246, '7G6D0EHNX0', 'eric-edward', '', 'Eric', 'Edward', '0000-00-00', 1, 'ericedwardtattoos@gmail.com', '6282690813', '', 'c5431a3b6bc8e528bd0fb02d826aa1e6', '', '', 0, '', '', '', '', '', '', 0, '', '', '', 0, 0, 0, '', '', '', '', '', '', 1, '', 0, 0, '', 1, 0, 0, 0, '', 1, 'Eric Edward', '', '', 0, NULL, NULL, '2021-06-13 04:58:25', NULL),
(247, 'XL0ESK850Y', 'pavan-verma', '', 'Pavan', 'Verma', '0000-00-00', 1, 'pavan.verma1995@gmail.com', '9793909991', '', 'ad266505a540f31131497be566d3c2e6', '', '', 0, '', '', '', '', '', '', 0, '', '', '', 0, 0, 0, '', '', '', '', '', '', 1, '', 0, 0, '', 1, 0, 0, 0, '', 1, 'Pavan Verma', '', '', 0, NULL, NULL, '2021-06-13 10:47:29', NULL),
(248, 'SE00PW63CJ', 'nitesh-soni', '', 'Nitesh', 'Soni', '1988-06-28', 1, 'soniniteshns99@gmail.com', '9974432274', '', '69fe3fbcb81b5c8423bcc904ca9b6248', 'Shop no 26-27 City Square apartment, Lunsikui', '149', 12, '1', '396445', 'Hello friends\r\nMe Nitesh Soni\r\nGujarat ke Navsari district se hu...\r\n\r\nMene 2009 se Tattoo banana start kiya tha 2009 se 2011 tak free lancing kaam kiya....fir 2011 me maine Mickey\'z Tattoo Studio Mumbai se professional certified course complete kiya tha or 2012 me Navsari me apna studio open kiya\r\n\r\nOr Tabhi se maine apne kaam ko profession nahi Passion bana liya hai.', '2009', 'Mickey\'z Tattoo Studio', '', 2, '', '', '5,7,10,19,26', 1, 1000, 0, '', 'https://www.facebook.com/nitesh.soni.3701', 'https://instagram.com/sonistattoo?utm_medium=copy_link', 'https://pin.it/50olRBP', '', '', 3, '', 0, 0, '', 1, 0, 0, 2, '900', 1, 'Nitesh Soni', '', '', 7, NULL, NULL, '2021-06-13 16:53:36', NULL),
(249, '7D2KTSR22A', 'sonam-maurya', '', 'Sonam', 'Maurya', '0000-00-00', 2, 'sonameyeweb8726@gmail.com', '8726146250', '', 'c0346850e6dc21cfdb0a9042af3cdc1f', '', '', 0, '', '', '', '', '', '', 0, '', '', '', 0, 0, 0, '', '', '', '', '', '', 1, '', 0, 0, '', 1, 0, 0, 0, '', 1, 'Sonam Maurya', '', '', 0, NULL, NULL, '2021-06-14 06:40:39', NULL),
(250, 'UT704F3BSD', 'manjunath-kolakar', 'profile-pic-1625153541.jpg', 'Manjunath', 'kolakar', '2021-07-26', 1, 'kolakarmanju@gmail.com', '8867621101', '8867621101', 'aca31b71fcd22b864538da973d5d6070', 'Top Unique TATTOOS and Art StudioBelgavi road,Channamma statue above driving school,AP:Bailhongal Dist:BelagaviPin-591102', '230', 17, '1', '591102', 'I am manjunath kolakar Art is my passion, which my engineering study free time, i got tattoo training in Bangalore & Goa and i learnt many art from professional artists from USA  artists. i am always updating my skills by attending seminars ,workshop in this TATTOO Industries.still i tested many inks results and learnt what is best ink for our Indian-skin to dark tattoo ,presently most trending organic,cruel free inks are using.Its very good result for my clients.i always care my clients as a friend and i support after also. many clients are came from other states they loved my art work & 100% satisfaction. ', '2015', 'stainly,mukeshwagela,sachine', 'Arika tattoos ,Abhishektattogizmo', 2, '', '', '10,16,17,22,26', 1, 399, 0, 'https://topuniquetattobailhongal.business.site/', 'https://www.facebook.com/uniquetattooss/?ref=pages_you_manage', 'https://www.instagram.com/topuniquetattoo/', '', '', 'https://topuniquetattobailhongal.business.site/', 3, '', 0, 0, '', 1, 0, 0, 1, '', 1, 'Manjunath kolakar', '', '', 9, NULL, NULL, '2021-06-14 08:05:45', NULL),
(251, '65U4EPXFR1', 'avishek--das', '', 'Avishek ', 'Das', '0000-00-00', 1, 'dasavishekinklink@gmail.com', '7980150355', '', '0e40153a4d762eaf021adf86758a20c2', '', '', 0, '', '', '', '', '', '', 0, '', '', '', 0, 0, 0, '', '', '', '', '', '', 1, '', 0, 0, '', 1, 0, 0, 0, '', 1, 'Avishek  Das', '', '', 0, NULL, NULL, '2021-06-14 10:24:47', NULL),
(252, 'PF6V4G61NH', 'shruti--aron', '', 'Shruti ', 'Aron', '0000-00-00', 2, 'shrutiaron@gmail.com', '9582027042', '', 'aa0de0280d8f8a933817f77ae127b544', '', '', 0, '', '', '', '', '', '', 0, '', '', '', 0, 0, 0, '', '', '', '', '', '', 1, '', 0, 0, '', 0, 0, 0, 0, '', 1, 'Shruti  Aron', '', '', 0, NULL, NULL, '2021-06-14 11:40:04', NULL),
(253, 'SU5Z7BN76T', 'gautam-chakraborty', 'profile-pic-1623760866.jpg', 'Gautam', 'Chakraborty ', '1994-04-30', 1, 'chakrabortygqutam30@gmail.com', '9613814658', '6913831183', 'cd642dd65ee3d2a1c823fbe14450cb2d', 'RUBIK INKS AND ART STUDIO, near Apsara cinema Hall, Beside u.s polo showroom  (ULUBARI, GUWAHATI) ', '632', 4, '1', '781007', 'Namaste lovely peoole. Im Gautam Chakraborty, born and raised In North East, Assam, Guwahati. I\'ve completed my graduation from commerce background on 2015. I am doing art and painting since childhood and completed my degree in fine arts in 2012. I am a self taught tattoo artist and was doing freelancing from 2012-13 but made it to the professional scene on 2015 by joining GInk tattoo and thereafter moved to Rubik ink and arts studio on 2019.  I like experimenting with all types of genres, but traditional and abstract forms attracts me the most. I believe in originality so i make the art work on my own visuals. I make tattoos as well as graffiti, wall art, painting. \r\nI\'m still learning the process and enjoying my journey.', '2015', '', '', 2, '', '', '2,16,21,23,26', 1, 1000, 1, 'www.rubikinks.com', 'https://www.facebook.com/gautam.chakrobarty', 'https://instagram.com/gautam_chakraborty_art?utm_medium=copy_link', '', '', '', 3, '', 0, 0, '', 1, 0, 1, 1, '2000', 1, 'Gautam Chakraborty ', '', '', 6, NULL, NULL, '2021-06-15 11:34:55', NULL),
(254, 'T2PQK87JU2', 'esha-varpe', 'profile-pic-1623760112.jpg', 'Esha', 'Varpe', '1985-03-30', 2, 'dreshapatil@gmail.com', '9664978998', '8779712430', '0e202014716c43524a37ec9576f965d2', 'D-1,  Sanjivani chs, plot no.7, near Suvidya school, Gorai 1, Borivali West, Mumbai 400091', '672', 21, '1', '400091', 'Belonging to a middle class Buddhist family, born and brought up in Mumbai – India, my work is purely to adorn the human skin and form. Thriving on the process of shredding beliefs of tattoos being a societal taboo, I like to create original ideas and concepts. A dental surgeon by core profession, followed by trichology and graphic design, I found my niche in design. I have been tattooing since 2016 and it has currently taken precedence over my numerous other ventures. Specializing in concept tattoos, my designs dictate an understated elegance and meticulousness. I believe in making personal pieces for each individual, which not only holds meaning, but is also a true representation of body art of the higher form.', '2016', '', '', 3, '', '', '5,7,10,12,14', 2, 4000, 0, 'www.eshavarpe.com', 'https://www.facebook.com/esha30385', 'https://www.instagram.com/eshavarpe/', 'https://in.pinterest.com/eshavarpe/', 'https://youtube.com/channel/UCEiflSseTGeeBINPbCBeJ9g', 'https://www.eshavarpe.com/blog-1', 3, '', 0, 0, '', 1, 0, 1, 2, '4000', 1, 'Esha Varpe', '', '', 8, NULL, NULL, '2021-06-15 12:04:26', NULL),
(255, '84VUHY86ZW', 'sam-soni', 'profile-pic-1628253983.jpg', 'Sam', 'Soni', '1996-07-21', 1, 'sonis9296@gmail.com', '7007306284', '8960707719', '8e659cb26b8556c79b12c5fd84709033', 'Madhuban nagar chaudi sadak alambagh lko', '524', 34, '1', '', '', '', '', '', 0, '', '', '16,18,22,23,26', 1, 500, 1, '', 'https://www.facebook.com/samsoni21796/', 'https://www.instagram.com/the_ss_tattoos_/', '', '', '', 3, '', 0, 0, 'Get your first tattoo and get 10% off', 1, 0, 1, 1, '500', 1, 'Sam Soni', '', '', 6, NULL, NULL, '2021-06-16 13:10:02', NULL),
(256, 'AC26QHB3K1', 'the-ink-boy-tattoo-studio-and-academy', 'profile-pic-1627566322.png', 'Ankit ', 'Gupta', '1994-08-06', 1, 'theinkboyindia@gmail.com', '9326658287', '8745801112', '1e07ca76fb0daaa1dfe39a859e9d54d6', 'C 34 Main Market Amar Colony Lajpat Nagar 4 110024', '120', 10, '1', '110023', 'The founder of The Ink Boy Tattoo Studio and Academy. I\'ve been in this line for over 11 years. I specialize in Realism and Portrait work. I\'m the senior most tattoo artist of the studio, while being a fun person to be with, I also maintain a proper balance between work and personal life!', '2010', 'Self taught ', '', 1, 'Ahir boxer ', '', '7,10,16,19,26', 1, 1500, 0, 'https://theinkboy.com/', 'https://www.facebook.com/ankit.gupta.792303', 'https://www.instagram.com/the_inkboy/', '', 'https://www.google.com/search?q=the+ink+boy+India+youtube&oq=the+ink+boy+India+youtube+&aqs=chrome..69i57j33i160l2.4921j0j4&client=ms-android-xiaomi-rev1&sourceid=chrome-mobile&ie=UTF-8#', '', 3, '', 0, 0, 'People who have gotten vaccinated can show their receipts and avail a 30% discount on their tattoos (T&C) ', 1, 0, 1, 1, '1000', 1, 'The Ink Boy Tattoo Studio and Academy ', '', '', 9, NULL, NULL, '2021-06-18 15:40:03', NULL),
(257, 'AS6F6VG8U1', 'amal-joseph', '', 'Amal', 'Joseph', '1994-09-18', 1, 'info@stingertattoos.com', '9633660270', '7902833902', '9f37285c46f585dab4699eedeb2c970a', ' Stinger Tattoos, Second floorAshamparambil AgenciesMaradu North, Maradu, Ernakulam,Kerala ', '252', 18, '1', '682304', 'Stinger Tattoo is one of the most established tattoo studios in Kochi. Owned by Amal Joseph, a self-trained craftsman, “Stinger Tattoo” has been running effectively for as long as 4 years. Represents considerable authority in quality and custom inking. Changing over his enthusiasm into an interest and afterwards into an effective calling Amal has turned out to set up his first studio at Bangalore for the past 2 years.\r\n\r\n \r\n\r\n“Stinger Tattoo” furnishes its customers with a great degree of black and Grey designs.', '1980', '', '', 3, '', '', '1,5,16,18,26', 1, 600, 0, 'https://www.stingertattoos.com/', '', 'https://instagram.com/stinger_tattoos?utm_medium=copy_link', '', '', '', 3, '', 0, 0, '', 1, 0, 1, 2, '1500', 1, 'Amal Joseph', '', '', 5, NULL, NULL, '2021-06-19 13:32:40', NULL),
(258, 'E0VNKT368G', 'salaam-mansuri', '', 'Salaam', 'mansuri', '0000-00-00', 1, 'salaammansuri5125@gmail.com', '9558126546', '', 'd7b9b1334389a25aaf2752678b52b7c8', '', '', 0, '', '', '', '', '', '', 0, '', '', '', 0, 0, 0, '', '', '', '', '', '', 1, '', 0, 0, '', 1, 0, 0, 0, '', 0, 'Salaam mansuri', '', '', 0, NULL, NULL, '2021-06-19 17:21:57', NULL),
(259, 'J4XUN481PK', 'rahul-singh-thakur', 'profile-pic-1624434571.jpg', 'Rahul', 'Singh thakur', '1995-02-28', 1, 'r9163758844@gmail.com', '9163758844', '', '00a586e6898412360740d09a2481fa42', 'Kolkata, keshopur, milan bazar', '600', 35, '1', '', '', '', '', '', 0, '', '', '1,4,16,23,26', 1, 700, 1, '', '', '', '', '', '', 3, '', 0, 0, '', 1, 0, 1, 1, '1000', 1, 'Rahul Singh thakur', '', '', 4, NULL, NULL, '2021-06-20 04:42:55', NULL),
(260, 'MG4S04DK1Q', 'nonie-singh', '', 'Nonie', 'Singh', '0000-00-00', 1, 'zeebodygraphics230@gmail.com', '9988007071', '', '25fd8aa7d43de2e35a89d012aef6a535', '', '', 0, '', '', '', '', '', '', 0, '', '', '', 0, 0, 0, '', '', '', '', '', '', 1, '', 0, 0, '', 1, 0, 0, 0, '', 1, 'Nonie Singh', '', '', 0, NULL, NULL, '2021-06-21 13:17:50', NULL),
(261, '7TP22RY8HW', 'akshay--kashyap', 'profile-pic-1624345269.jpeg', 'Akshay ', 'Kashyap', '1993-04-22', 1, 'akshaytattoos.india@gmail.com', '7833805504', '8544772914', '2b5738778a78aae14db78781d2a3c820', 'House no 172 Ward no 13, Kaleen, Landmark: Behind Santoshi Mata Temple, Solan.', '177', 14, '1', '173212', 'Hey guys, My name is Akshay Kashyap and I’m from Solan, Himachal Pradesh.\r\nI’m a custom tattoo artist which means I create original design from your ideas or any reference images and once a design is done it’s not repeated ever again. \r\n\r\nI have done my apprenticeship under the wings of Eric Jason D’Souza at Iron buzz Mumbai.\r\n\r\nStyles: I like to do Realism because it comes naturally to me from a very young age but I’m being versatile with different art form as styles, like Geometric, Calligraphy, Illustrative, Coverups too.\r\n\r\nI’m located at my home town SOLAN because I wanted to give good tattoos to my people here, because there were not professional tattooing happening and people were getting all scratchiest tattoos over them, so due to that I wanted to give good artwork to all. \r\n\r\nI have my private studio away from the hustle bustle of the markets where I’m working on appointment bases because I’m the only single artist working here in my studio, doing free consultations over zoom calls and having fun by giving you guys original designs/artworks. \r\n\r\nMy studio I not Dark or Gangster, it’s more bright and natural light with some of my artworks', '2015', 'Eric Jason D’Souza/Iron Buzz Tattoos ', '', 2, '', '', '7,16,17,18,26', 1, 500, 0, 'Akshaytattoos.com', 'https://www.facebook.com/akshaytattoos', 'https://www.instagram.com/akshay.tattoos/', '', 'https://www.youtube.com/channel/UCo-0h1PBEN-nwBab50hGIng', '', 3, '', 0, 0, '', 1, 0, 1, 2, '2000', 1, 'Akshay  Kashyap', '', '', 10, NULL, NULL, '2021-06-22 06:08:27', NULL),
(262, 'H5V33M2UYK', 'grandpa-inks', 'profile-pic-1624443824.jpeg', 'Grandpa', 'Inks', '1998-06-07', 1, 'gandhatejkumar@gmail.com', '8019999420', '9154466400', '7749005138e48a8510c62e8c0bcf1a76', 'Visakhapatnam ', '21', 1, '1', '', 'Hello  My self Tej , I’m doing tattoos from last five years  since 2015, i love to do line work , abstract , realism , dot works and mandalas  you can check my works in Instagram @grandpa_inks                             My studio located in Visakhapatnam Andhra Pradesh , thanks for looking. dm for ur appointment ', '2015', 'Skin machine tattoo studio', '', 2, '', '', '2,5,10,18,26', 1, 400, 0, 'https://www.picuki.com/tag/inkedbytejz', 'Facebook.com/tattoo_tej', 'Instagram.com/grandpa_inks', '', '', 'https://www.picuki.com/tag/inkedbytejz', 3, '', 0, 0, '', 1, 0, 0, 2, '', 1, 'Grandpa Inks', '', '', 10, NULL, NULL, '2021-06-22 06:39:06', NULL),
(263, 'JYT34R9BF5', 'prokash--howldaer', 'profile-pic-1624442606.jpg', 'Prokash ', 'Howldaer', '2000-12-19', 1, 'prokashhowlader3839@gmail.com', '6296703077', '8372062315', '59d7438cdfa365a54fe719eae4f8d26b', 'Ranaghat Cooper\'s Camp ', '595', 35, '1', '', 'I am prokash howlader from west bengal ranaghat i am beginner artist now I have 3 months experience in my own studio (smart ink tattoo studio) I have done moreover 40 tattoos since now. I specialy loved to do in geometric tattoo and realistic tattoo. I have done one time half sleeve.', '2021', 'Workaholik tattoo studio ,Smart ink tattoo studio ', '', 2, '', '', '4,7,16,22,23', 1, 300, 0, '', 'https://www.facebook.com/Smartink3839/', 'https://instagram.com/smartink3839?utm_medium=copy_link', 'https://pin.it/7xQpSN3', 'https://youtube.com/channel/UCk8403mxPy3C339-kT7Rfjw', '', 3, '', 0, 0, 'If follow my insta and facebook page then 20% discount of any tattoos ', 1, 0, 0, 2, '', 1, 'Prokash  Howldaer', '', '', 6, NULL, NULL, '2021-06-23 09:51:35', NULL),
(264, '01KEQ2NLP6', 'vivek-trox', '', 'vivek', 'troX', '0000-00-00', 1, 'negivivek1122@gmail.com', '9639785520', '', 'c653718aaf5bd9c65d98bfdeb9c66796', '', '', 0, '', '', '', '', '', '', 0, '', '', '', 0, 0, 0, '', '', '', '', '', '', 1, '', 0, 0, '', 1, 0, 0, 0, '', 1, 'vivek troX', '', '', 0, NULL, NULL, '2021-06-23 13:44:52', NULL),
(265, '5GDSK16VH1', 'pratik-chamling', '', 'Pratik', 'Chamling', '1991-12-22', 1, 'pratikchamling11@gmail.com', '7875524129', '9380169159', '0d96ffa3e238d76c422c19c47a38a746', 'Koramangala 7th block', '660', 17, '1', '560095', 'Trust the process ,I promise delivering quality works. Would love to work on personal designs. I specialise in neo Oriental works, like the mixture of old traditional works with new geometric and sacred patterns. Dear people can find me in my temple Redefineink tattoo studio. I am really inspired by our mother nature and the sacred geometry which I would like to implify in my tattoo designs. Love to do works close to nature and for nature. ', '2018', '', '', 2, '', '', '3,4,7,9,10', 1, 1000, 1, 'http://redefineink.com/', '', '', '', '', '', 3, '', 0, 0, '', 1, 0, 1, 1, '3000', 1, 'Pratik Chamling', '', '', 5, NULL, NULL, '2021-06-23 14:37:33', NULL),
(266, '1JVH4WAX82', 'pawandeep-singh', '', 'Pawandeep', 'Singh', '0000-00-00', 1, 'pawandeepsidhu950@gmail.com', '7888779358', '', 'e129c3e16e80ae489c00b0e32b9203a1', '', '', 0, '', '', '', '', '', '', 0, '', '', '1,16,17,18,26', 1, 500, 0, '', '', '', '', '', '', 3, '', 0, 0, '', 1, 0, 0, 2, '', 1, 'Pawandeep Singh', '', '', 2, NULL, NULL, '2021-06-24 04:39:36', NULL),
(267, '3XZP0M3EA3', 'simriti-arora', 'profile-pic-1624522636.jpeg', 'Simriti', 'Arora', '1998-06-17', 2, 'asimriti00@gmail.com', '9814002091', '7889166151', '8ebb10d488bfbcc194d6ca19d442ce6b', 'Hno 126 gokal avenue near kashmir avenue', '419', 28, '1', '', '', '', '', '', 0, '', '', '4,7,9,10,18', 1, 500, 1, '', '', 'https://www.instagram.com/artist_simriti/', 'https://in.pinterest.com/colorinkthetattoo/', 'https://m.youtube.com/?noapp=1#menu', '', 3, '', 0, 0, '', 1, 0, 0, 1, '', 1, 'Simriti Arora', '', '', 3, NULL, NULL, '2021-06-24 07:46:28', NULL),
(268, 'CXLB538D2H', 'aman--inkplay', 'profile-pic-1624531094.jpg', 'Aman ', 'Inkplay', '1996-03-01', 1, 'amanfunk4@gmail.com', '9650224592', '8588801077', '72a1ad0d63baa8129db76e3ab61af57c', 'Shop no-11 House No-R-1 Near UTTAM NAGAR West metro station Gate no-1, Uttam Nagar, New Delhi, Delhi 110059', '120', 10, '1', '110059', 'Aman inkplay tattoo studio (Best Tattoo shop / artist in delhi ) Successfully tattoo shop in uttam nagar west metro station  Working in different genres of tattooing .We aim in creating the best quality tattoos suiting the need of our clients. What are the things we deal in : • Permanent tattoo • Portrait tattoos • 3d tattoos • Geometric tattoo • Black tattoo • Coloured tattoo • Best tattoo studio in terms of hygiene and atmosphere Along with this we have a huge variety of tattoos to choose from such as angel tattoo , anchor tattoo , name tattoo ,compass tattoo and many more.The people getting tattooed by us are aware of what care we we provide with our work and till what extend we go through to help our clients . And we look forward to give them the guidance and knowledge one should know before getting a tattoo done.', '2019', 'Aman inkplay tattoo studio', '', 2, '', '', '7,10,11,12,22', 1, 2000, 0, '', 'https://www.facebook.com/Amaninkplay', 'https://instagram.com/_aman_ink_play_tattooz_?igshid=1fiu6q1rvlqz5', 'https://in.pinterest.com/', 'https://www.youtube.com/', '', 3, '', 0, 0, '', 1, 0, 0, 1, '', 1, 'Aman  Inkplay', '', '', 6, NULL, NULL, '2021-06-24 09:26:21', NULL),
(269, '9AD6LUC8V2', 'skin-craft', '', 'Skin', 'Craft', '0000-00-00', 1, 'prajunkumar@gmail.com', '7989494961', '', '0b61dd4484d90c35e87fc6ca00e7ddea', '', '', 0, '', '', '', '', '', '', 0, '', '', '', 0, 0, 0, '', '', '', '', '', '', 1, '', 0, 0, '', 1, 0, 0, 0, '', 1, 'Skin Craft', '', '', 0, NULL, NULL, '2021-06-25 20:46:22', NULL),
(270, 'DVTN7P22X2', 'sagar-debnath', 'profile-pic-1625560686.jpg', 'Sagar', 'Debnath', '1970-01-01', 1, 'sagartattooarts@gmail.com', '8850037493', '8850037493', '22762f59421796b6ec6c454ec686b96a', 'Shruti cottage, room no. 1, malwani church ,malad West,', '672', 21, '1', '', 'My journey as an artist began nearly a decade ago back in 2010, prior to that I was always quite interested in sketching and illustration since childhood and most of my free time was utilised being glued to a desk with my pencils and other materials and working my ideas out on paper. Back in those days TLC started to air different shows viz, LA Ink,Miami Ink and so on and so forth, during those days tattooing as an industry hadn\'t yet have the headstart in Mumbai, these shows are what inspired me to take up a career as a Tattoo Artist. As years went past and I continued to grow as an artist my work evolved from just making basic old-school/new-school tattoo\'s to complex work such as Realism, Oriental style, Dotwork Abstract,etc. It\'s been a great learning experience all these years with humble beginnings to ending up as one of the known artist\'s in the city, I am looking forward to broaden my insights and connect with like minded individuals/artists on this platform.\r\n', '2013', 'The Divine Image English High School', '', 3, '', '', '3,10,16,21,26', 1, 1500, 0, '', 'https://m.facebook.com/Sagartattoos', 'https://www.instagram.com/sagar_tattoos/', '', '', '', 3, '', 0, 0, '', 1, 0, 1, 2, '2000', 1, 'Sagar Debnath', '', '', 7, NULL, NULL, '2021-06-26 04:18:19', NULL),
(271, '44J1WL9UVY', 'sanket--jadhav-1', '', 'Sanket ', 'Jadhav', '1999-02-15', 1, 'sj4029222@gmail.com', '9356474169', '8983147465', '6844458ee833165b531dbad545378717', 'Calngute beach opposite \r\nShanta Durga temple first floor ', '649', 11, '1', '403114', '', '', '', '', 0, '', '', '', 0, 0, 0, '', 'https://www.facebook.com/sanket.jadhav.73550794', '', '', 'https://youtube.com/channel/UCMhCQw2nXrnY1HH1hzPFNiw', 'https://youtu.be/67FKNJmmC5I', 1, '', 0, 0, '', 1, 0, 0, 0, '', 1, 'Sanket  Jadhav', '', '', 0, NULL, NULL, '2021-06-26 13:05:27', NULL),
(272, 'A30KDSYZ73', 'narendra-bhatia', '', 'Narendra', 'Bhatia', '0000-00-00', 1, 'narenbhatia@hotmail.com', '9820158780', '', '9adae3378be56379dfd147b6f501eac1', '', '', 0, '', '', '', '', '', '', 0, '', '', '', 0, 0, 0, '', '', '', '', '', '', 1, '', 0, 0, '', 1, 0, 0, 0, '', 0, 'Narendra Bhatia', '', '', 0, NULL, NULL, '2021-06-27 16:37:56', NULL),
(273, 'UD37P2AW5L', 'shubham-rajput', '', 'Shubham', 'Rajput', '0000-00-00', 1, 'shubhamrajpu54@gmail.com', '8920899780', '', '54b02340f7a075065dcfd4cffd144989', '', '', 0, '', '', '', '', '', '', 0, '', '', '', 0, 0, 0, '', '', '', '', '', '', 1, '', 0, 0, '', 1, 0, 0, 0, '', 1, 'Shubham Rajput', '', '', 0, NULL, NULL, '2021-06-28 03:26:56', NULL),
(274, 'XQ3EYTW215', 'abhi-mondal', 'profile-pic-1625259736.jpg', 'Abhi', 'Mondal', '1994-10-09', 1, 'abhimondal888@gmail.com', '8981007753', '8777363652', 'b755bf9645c2b10f4e7c115949c5287a', 'Sarthak Apartment, 123 RN Guha Road, Nagerbazar, South Dumdum ', '748', 35, '1', '700074', 'Started my career as an IT Engineer, ended up being a tattoo artist. A journey I have made through out my life was really great. Met lot of people, amazing artists, shared our thoughts. Tattoo is real fun when you have a dedication in your art style of doing it. ', '2014', '', '', 2, '', '', '3,5,7,9,12', 1, 1000, 0, 'www.rheytattoos.com', 'www.facebook.com/abhicx', 'www.instagram.com/ovi_rheytattoos', '', '', '', 3, '', 0, 0, '', 1, 0, 1, 2, '3000', 1, 'Abhi Mondal', '', '', 6, NULL, NULL, '2021-06-28 07:02:59', NULL),
(275, 'X0DP94EH7N', 'pardeep-singh', '', 'Pardeep', 'Singh ', '0000-00-00', 1, 'pardeep11art@gmail.com', '8288916396', '', 'affe69b474649ce9c9772ee163c47f24', '', '', 0, '', '', '', '', '', '', 0, '', '', '', 0, 0, 0, '', '', '', '', '', '', 1, '', 0, 0, '', 1, 0, 0, 0, '', 1, 'Pardeep Singh ', '', '', 0, NULL, NULL, '2021-06-28 12:10:56', NULL),
(276, '27H3FMZD2G', 'rahul-attri', 'profile-pic-1624963151.jpg', 'Rahul', 'Attri', '1990-06-24', 1, 'gagsattri@gmail.com', '9711514794', '9540154748', 'a6236d8d6beb139e174f477796a085b7', 'Shop no 1/1 first floor krishna market kalkaji near agarwal sweets', '120', 10, '1', '110019', 'We are Passion Of Tattoos Tattoos studio based in South delhi Kalkaji. Renowned for wonderfully creative tattoos since 2009. We do all kind of permanent and temporary tattoos. We have experienced tattoo artist working with us. We take care of all the hygiene when it comes about ink. \r\n\r\nTattoos are the only thing that you take to the grave so when it comes to tattoos... Choose wisely..!! ', '2009', 'Self taught ', '', 3, '', '', '4,16,17,18,19', 1, 400, 1, '', 'https://www.facebook.com/PassionOfTattoos/', 'https://www.instagram.com/passionoftattoos_new_delhi/', '', '', '', 3, '', 0, 0, '', 1, 0, 1, 2, '2000', 1, 'Rahul Attri', '', '', 10, NULL, NULL, '2021-06-28 13:45:14', NULL),
(277, 'SFJR44DC61', 'utkarsh-art', '', 'Utkarsh', 'art', '0000-00-00', 1, 'utkarsh.dandriyal@gmail.co', '8445649679', '', '836bb04de698e84f5229dee6d9b9c9ec', '', '', 0, '', '', '', '', '', '', 0, '', '', '', 0, 0, 0, '', '', '', '', '', '', 1, '', 0, 0, '', 1, 0, 0, 0, '', 1, 'Utkarsh art', '', '', 0, NULL, NULL, '2021-06-29 11:33:51', NULL),
(278, 'MS2R63AK7V', 'vigneshwar-parthiban', 'profile-pic-1625044423.jpeg', 'Vigneshwar', 'Parthiban', '1992-07-10', 1, 'idtattooomr@gmail.com', '9962165423', '', 'd157aef99e2e09e1ed6ea0b125cdcdd3', 'No.2/326, Subburayan Nagar,Thuraipakkam,Chennai', '466', 31, '1', '600097', 'Professional Tattoo Studio in chennai,\r\nSpecialist in custom made tattoos, and black and grey works. realism tattoo, hyper  realism tattoo, portrait tattoo, water colour tattoos, we are taking appointments in prior booking. Doorstep service also available with studio quality. No compromise in work quality. Contact us for appointment. Located at thuraipakkam, chennai. ', '2014', 'Self taught artist', '', 3, '', '', '1,16,18,23,26', 1, 550, 1, 'https://idtattooomrvicky.business.site/', '', 'https://instagram.com/id_tattoo_studio_omr?r=nametag', '', '', 'https://idtattooomrvicky.business.site/', 3, '', 0, 0, '25% off on portrait tattoo', 1, 0, 1, 2, '1000', 1, 'Vigneshwar Parthiban', '', '', 9, NULL, NULL, '2021-06-30 08:54:33', NULL),
(279, '34CFVQ4U3A', 'raghukumar-mojo', 'profile-pic-1625052373.jpeg', 'Raghukumar', 'Mojo', '1992-01-09', 1, 'raghu0929.rv@gmail.com', '9962417133', '7010000760', '5d8a80baa1acd67f0e6b1004a2c21039', 'No.125 2nd floor M.S.koil street  Royapuram Next to Dominos pizza ', '466', 31, '1', '600013', 'Hey \r\nI’m Raghukumar aka Mojo professional tattoo artist \r\nAs well as Freestyle Bike stunt rider from Chennai \r\nIm a self learning person with creative ideas \r\nI started my tattooing career from 2017 without any Art background \r\nI have worked in multiple place in India \r\nNow own my Tattoo Studio in Chennai \r\n', '2017', 'Self taught', 'Hinal tattoo supply', 1, 'Tamilactors', '', '7,16,18,23,26', 1, 500, 1, 'Mojotattoo.in', 'https://www.facebook.com/MojoTattooStudio', 'https://www.instagram.com/p/CHPOTnmAXuo/?utm_medium=copy_link', '', '', '', 3, '', 0, 0, '', 1, 0, 1, 2, '500', 1, 'Raghukumar Mojo', '', '', 11, NULL, NULL, '2021-06-30 10:08:52', NULL),
(280, 'KH4VD63XJ7', 'sunny-sharma', '', 'sunny', 'sharma', '0000-00-00', 1, 'sunnysharma90@gmail.com', '9729181007', '', 'f9c228f840df7bb9db0f5cebee337d29', '', '', 0, '', '', '', '', '', '', 0, '', '', '', 0, 0, 0, '', '', '', '', '', '', 1, '', 0, 0, '', 1, 0, 0, 0, '', 1, 'sunny sharma', '', '', 0, NULL, NULL, '2021-06-30 13:29:53', NULL),
(281, '44CNZHYD69', 'vikas--saini', '', 'Vikas ', 'Saini', '0000-00-00', 1, 'Eternotattooz@gmail.Com', '7973997674', '', 'fe8e64697f6c5c01b0b1f3d9c43ea53f', '', '', 0, '', '', '', '', '', '', 0, '', '', '', 0, 0, 0, '', '', '', '', '', '', 1, '', 0, 0, '', 1, 0, 0, 0, '', 1, 'Vikas  Saini', '', '', 0, NULL, NULL, '2021-07-01 11:08:59', NULL),
(282, '47U7JGV5MS', 'harry--john', 'profile-pic-1625201045.jpg', 'Harry ', 'John', '1991-01-30', 1, 'harryjohn1991@yahoo.com', '9841359493', '8248474776', '417493b9614680cf1da0a05bbe71f3ac', '53/A nehru nagar 4th cross street, puliyanthope ch-12', '466', 31, '1', '', 'Hello am Harry john doing tattoo for past 7 years.  Am an well experienced and certified tattoo artist from mumbai ALIENS TATTOO SCHOOL. I am specialized in line work tattoos and geometric tattoos, neo traditional tattoos and cover up tattoos. I do all kinds of sketching, mural paintings and graffities. You can check my works.', '2014', 'Harry the artist', 'Inkspire tattoos', 3, '', '', '1,7,13,16,22', 1, 1000, 0, '', 'https://www.facebook.com/1684036755187582/posts/3039313652993212/', 'https://www.instagram.com/p/CCnNuANjS2U/?utm_medium=copy_link', '', '', '', 3, '', 0, 0, '', 1, 0, 1, 2, '500', 1, 'Harry  John', '', '', 7, NULL, NULL, '2021-07-02 04:00:22', NULL),
(283, '7WSMFL719Z', 'riju-nath-1', '', 'Riju', 'Nath', '0000-00-00', 1, 'engravet@gmail.com', '9609526126', '', '21a06a631b009134fad5e0b800b866a6', '', '', 0, '', '', '', '', '', '', 0, '', '', '', 0, 0, 0, '', '', '', '', '', '', 1, '', 0, 0, '', 1, 0, 0, 0, '', 0, 'Riju Nath', '', '', 0, NULL, NULL, '2021-07-02 06:07:43', NULL),
(284, 'QC0VPR93W0', 'abhijeet--simon', '', 'Abhijeet ', 'Simon', '0000-00-00', 1, 'inksplattertattoos@gmail.com', '9924070503', '', '9604b889be4ac1f3db52b7322ea9dd0c', '', '', 0, '', '', '', '', '', '', 0, '', '', '', 0, 0, 0, '', '', '', '', '', '', 1, '', 0, 0, '', 1, 0, 0, 0, '', 1, 'Abhijeet  Simon', '', '', 0, NULL, NULL, '2021-07-02 06:17:39', NULL);
INSERT INTO `adv_artist` (`id`, `code`, `slug`, `profile_pic`, `fname`, `lname`, `dob`, `gender`, `email`, `mobile`, `alt_mobile`, `password`, `address`, `city`, `state`, `country`, `pincode`, `artist_bio`, `work_since`, `mentor`, `sponsor`, `celeb`, `celeb_name`, `emp_type`, `cats`, `pmode`, `price`, `pshow`, `website`, `facebook`, `instagram`, `pinterest`, `youtube`, `blog_url`, `profile_step`, `ref_code`, `wallet`, `pedia_wallet`, `artist_offer`, `status`, `feature`, `direct_booking`, `piercing`, `minimum_booking_amount`, `verified`, `meta_title`, `meta_keyword`, `meta_desc`, `list_order`, `fs_date`, `fe_date`, `created`, `last_login`) VALUES
(285, '8Z3AL1XD4U', 'melvyn-shimray', '', 'melvyn', 'shimray', '0000-00-00', 1, 'lonstattoos2010@gmail.com', '9654678203', '', '55bf8fb4deef819e920ea6e9f6ad8d4b', '', '', 0, '', '', '', '', '', '', 0, '', '', '', 0, 0, 0, '', '', '', '', '', '', 1, '', 0, 0, '', 1, 0, 0, 0, '', 1, 'melvyn shimray', '', '', 0, NULL, NULL, '2021-07-02 08:00:07', NULL),
(286, '1YAPN42KQ5', 'sameer--saxena', '', 'Sameer ', 'Saxena ', '0000-00-00', 1, 'theink.corporation.tattoos@gmail.com', '8586877832', '', 'f0837c67dadcedf94d4f5296334371a0', '', '', 0, '', '', '', '', '', '', 0, '', '', '', 0, 0, 0, '', '', '', '', '', '', 1, '', 0, 0, '', 1, 0, 0, 0, '', 1, 'Sameer  Saxena ', '', '', 0, NULL, NULL, '2021-07-02 10:25:07', NULL),
(287, '42U5KMDW4B', 'ali--hussain', '', 'Ali ', 'Hussain ', '1993-05-06', 1, 'alihussainn07@gmail.com', '9819204322', '9819204322', 'bb5264a58eb41d49ce72f01e98a6b6d1', 'Mumbai / Mira Road East / Srishti Road / Cluster 2 \r\nOpposite Suriya shopping Centre ', '678', 21, '1', '401107', '', '', '', '', 0, '', '', '', 0, 0, 0, '', 'https://www.facebook.com/profile.php?id=100006703773369', 'https://instagram.com/needles_and_monkey?r=nametag', '', '', '', 1, '', 0, 0, '', 1, 0, 0, 0, '', 1, 'Ali  Hussain ', '', '', 0, NULL, NULL, '2021-07-03 12:57:10', NULL),
(288, 'J0RE974WMA', 'akshay-goenka', '', 'Akshay', 'Goenka', '1991-04-10', 1, '33kali.ink@gmail.com', '7453881133', '7042877763', '519e756635e0a65f1cf03509ac954cb1', 'Kali ink Tattoo studio, Landmark: Suchitra Bakery,Kalapahar Colony Bazar, Kamrup Metro, Guwahati (Assam)', '632', 4, '1', '781018', 'Akshay G. is a traveling Artist hailing from Guwahati, Assam. Owner of Two Self Designed Tattoo Studios under the name of ‘Kali Ink’ in Rishikesh & in Guwahati respectively. \r\nStarted tattooing back in 2013 under the training and guidance of Tattoostar Collective, Bandra (Mumbai), continuing to work in multiple studios and on Street art projects thereafter.\r\nWorking on Indian Traditional designs and Color tattoos on Indian skin tones from his Tattoo Studio setup since 2018.\r\nNo particular preference or style of tattooing.\r\n', '2013', 'Swapnil & Ilham - Tattoostar collective, Bandra,Vikas Malani - Body canvas / TRI , Bandra', '', 2, '', '', '3,5,11,19,26', 2, 3000, 0, 'https://kaliink.business.site', 'https://www.facebook.com/Kali.ink/', 'www.instagram.com/kali.ink', '', '', '', 3, '', 0, 0, '', 1, 0, 1, 1, '2000', 1, 'Akshay Goenka', '', '', 6, NULL, NULL, '2021-07-04 08:24:58', NULL),
(289, 'SV7TQM2P55', 'shubhendu--bhattacharya', '', 'Shubhendu ', 'Bhattacharya', '0000-00-00', 1, 'shubhenduofficework@gmail.com', '8240950652', '', 'f554e1f4d10d20f7f6f8fcf86789c18c', '', '', 0, '', '', '', '', '', '', 0, '', '', '', 0, 0, 0, '', '', '', '', '', '', 1, '', 0, 0, '', 1, 0, 0, 0, '', 1, 'Shubhendu  Bhattacharya', '', '', 0, NULL, NULL, '2021-07-05 04:18:09', NULL),
(290, '19XVUG9C0D', 'nilesh-shriram', '', 'Nilesh', 'Shriram', '0000-00-00', 1, 'eyeconictattoos@gmail.com', '9619454575', '', '62a8c31e0c3fc504da674800138c9eb0', '', '', 0, '', '', '', '', '', '', 0, '', '', '', 0, 0, 0, '', '', '', '', '', '', 1, '', 0, 0, '', 1, 0, 0, 0, '', 1, 'Nilesh Shriram', '', '', 0, NULL, NULL, '2021-07-07 13:47:37', NULL),
(291, 'VRKC83X73A', 'sam-yengkhom', '', 'Sam', 'Yengkhom', '0000-00-00', 1, 'samtattooartist87@gmail.com', '9711040029', '', '1908db486c0dd0a39257d97d6f353fd4', '', '', 0, '', '', '', '', '', '', 0, '', '', '', 0, 0, 0, '', '', '', '', '', '', 1, '', 0, 0, '', 1, 0, 0, 0, '', 1, 'Sam Yengkhom', '', '', 0, NULL, NULL, '2021-07-08 17:51:32', NULL),
(292, 'SR6487YBHD', 'ashish-negi', '', 'Ashish', 'negi', '0000-00-00', 1, 'ashish.negi39@gmail.com', '9999202536', '', '3d4cbee35e03fd10ecb475df262c477f', '', '', 0, '', '', '', '', '', '', 0, '', '', '', 0, 0, 0, '', '', '', '', '', '', 1, '', 0, 0, '', 1, 0, 0, 0, '', 1, 'Ashish negi', '', '', 0, NULL, NULL, '2021-07-08 18:05:00', NULL),
(293, 'KT85B5PYD6', 'shiva-dalord', '', 'shiva', 'dalord', '1991-02-12', 1, 'Shivaadalord@gmail.com', '9888641414', '6284981203', '5a0a723a036b3d5fbce9b32f3a837ad0', 'vimoksha tattoos, sco no. 61 second floor, sector 30C, chandigarh', '762', 6, '1', '160030', '', '', '', '', 0, '', '', '', 0, 0, 0, '', '', '', '', '', '', 1, '', 0, 0, '', 1, 0, 0, 0, '', 1, 'shiva dalord', '', '', 2, NULL, NULL, '2021-07-09 09:36:53', NULL),
(294, '4W1QPH4M1B', 'sundar--subramanian', 'profile-pic-1625855678.jpg', 'sundar', 'S', '1991-03-30', 1, 'sundar.dtrixx@gmail.com', '9884921313', '', '09a18c9636090a60118576f9a49fa065', '10 Sathya Moorthy Street Nehru Nagar Velachery, Apt', '466', 31, '1', '', 'Hey This is Sundar Subramanian a self learnt Tattoo artist from Chennai Tamilnadu. i started tatooing very early at my highschool now i own a tattoo studio. the travel from high school to here was not really a piece of cake for me. it took me years and years of practice to obtain the capacity to thrill u with my peice of art on u...........', '2013', 'KINGS TATTOO', '', 3, '', '', '4,9,16,18,26', 1, 1200, 0, '', 'https://www.facebook.com/sundar.dtrixx/', 'https://www.instagram.com/kingstattoosundar/', 'https://in.pinterest.com/sundardtrixx0381/', '', '', 3, '', 0, 0, '', 1, 0, 1, 1, '1200', 1, 'Sundar  Subramanian ', '', '', 9, NULL, NULL, '2021-07-09 18:05:08', NULL),
(295, 'R3Y78F7WHD', 'manikandan-subramanian', 'profile-pic-1625914259.jpg', 'Mani', 'Subramanian', '1995-10-06', 1, 'dtrixxmani6699@gmail.com', '9940010102', '', '9d02e8c79ea07394399234024906a04a', '  kvk swamy street Nehru nagar velacherry checkpost ', '466', 31, '1', '', 'AS an artist, I am essentially interested in creating work.\r\nI\'m really energetic, and a great communicator. \r\nworking in tattoo studio for 5years helped me to build confidence and taught me the importance of customer loyalty \r\nI understand my customers needs\r\nI consider myself hardworking  etc.......\r\nI\'m a good tattooist .I love being creative and coming up with my own tattoos.\r\nI enjoy researching the latest trend and experimenting with new ideas.\r\n', '2016', 'Kings Tattoo ', '', 2, '', '', '5,7,21,22,26', 1, 1200, 0, '', 'https://www.facebook.com/DTRICKS.MANI/', 'https://www.instagram.com/_atman_i/', '', '', '', 3, '', 0, 0, '', 1, 0, 0, 1, '', 1, 'Manikandan Subramanian', '', '', 6, NULL, NULL, '2021-07-10 08:33:34', NULL),
(296, '60S5ZXWPT8', 'royal-jaat', 'profile-pic-1625928925.jpeg', 'royal', 'jaat', '1996-08-10', 1, 'shabnambanu995378@gmail.com', '9953787141', '9599922954', '8bb5d034f2ee900190c77ee3f326877e', 'Royal inked tattoo studio sector 14 hudda market near im sweets gurgaon haryana', '155', 13, '1', '122001', 'hi, I’m Artist Royal , An artist truly be called professional only . as an artist I want my art to shine .the art is in my blood and its boon to me that I’m a tattoo artist where I can performed with my skills amd talent. I have 10 year of experience as a tattoo artist and I love tattooing. I always keep this thing in my mind that my client should always be happy with my art and again they come to me for tattoo.', '2012', '', '', 2, '', '', '1,4,16,19,26', 1, 800, 1, 'royalinked.com', '', 'https://instagram.com/royal_inked_14?utm_medium=copy_link', '', '', '', 3, '', 0, 0, '', 1, 0, 1, 1, '1000', 1, 'royal jaat', '', '', 7, NULL, NULL, '2021-07-10 14:30:33', NULL),
(297, 'A66M1QSWD2', 'manya-verma', '', 'Manya', 'Verma', '1987-11-12', 2, 'vermamanya81@gmail.com', '7011932264', '7011932264', '80878aba91520ce7f952415312f76d35', 'New delhi-85', '773', 10, '1', '110085', 'Im a happy tattoo artist.I live in delhi. I love tattoos. Tattoos are my life. I have tattoos on my body. Tattoos are my life. Tattoos should be mandatory.tattoos shouldnt be a problem. Tattoos are life.there are many types of tattoos. I love tattoopedia.tattoopedia is a connector which connects me with so many clients. A membership of 500 pm is not a big deal. This site helps me a lot . I love it.', '1980', 'Dps', '', 1, 'Manya verma', '', '4,5,7,15', 1, 2000, 0, '', '', '', '', '', '', 3, '', 0, 0, '', 0, 0, 1, 2, '3000', 1, 'Manya Verma', '', '', 6, NULL, NULL, '2021-07-12 18:14:58', NULL),
(298, '5HDGCV3Y42', 'romanch-soni', 'profile-pic-1626347055.jpg', 'Romanch', 'Soni', '1991-07-20', 1, 'romanchsoni.rs@gmail.com', '7359342667', '9316854746', 'c1427b37117e63f1a0dbb5e4cb6f3750', '012, samaan complex, opp. Satyam mall, jodhpur mansi road', '134', 12, '1', '380015', 'Hi I am Romanch Soni, I am an owner of ROSO Tattoo & Art Studio. I have completed \r\nfine arts commercial in 2012, I am also an illustration artist, painter, actor and storyboard artist. For me tattoo is like a meditation, whenever I am tattooing I feel soo happy from my work, and that’s why I try to give same feeling to my clients at my studio. I only use disposable materiales at my studio as much as possible so that studio and client’s hygiene can be maintain. Along with art tattooing is also connected to medical, mathematics and science, so we have to respect, understand and learn it till lifetime.', '2020', 'Self', '', 3, '', '', '16,17,18,23,25', 2, 2000, 0, 'https://rosotattooartstudio.business.site/?utm_source=gmb&utm_medium=referral', 'https://www.facebook.com/rosotattooartstudio/', 'https://www.instagram.com/rosotattooartstudio/', '', '', '', 3, '', 0, 0, '', 1, 0, 1, 2, '500', 1, 'Romanch Soni', '', '', 8, NULL, NULL, '2021-07-15 08:20:40', NULL),
(299, 'DCPA13F5K2', 'aditi--shah', '', 'Aditi ', 'Shah', '1999-11-10', 2, 'aditi.j1011@gmail.con', '9999830974', '', 'f0e2414b84e1bdb1f2934465b55dc963', 'A-57, Chhatarpur enclave, phase 2, New Delhi 110074', '773', 10, '1', '', '', '', '', '', 0, '', '', '', 0, 0, 0, '', '', '', '', '', '', 1, '', 0, 0, '', 1, 0, 0, 0, '', 1, 'Aditi  Shah', '', '', 0, NULL, NULL, '2021-07-15 08:41:07', NULL),
(300, 'HXWV2F4S96', 'pema-yangphel', 'profile-pic-1626422599.jpeg', 'Pema', 'Yangphel ', '1970-01-01', 1, 'pemayangphel@gmail.com', '8303129506', '', '5c166b52f2db94ef80c4fb8c5eb95905', 'Majnu ka Tila, Tibetan colony, house no. 137A, block no. 7, north Delhi 110054', '773', 10, '1', '', '', '', '', '', 0, '', '', '', 0, 0, 0, '', '', '', '', '', '', 1, '', 0, 0, '', 1, 0, 0, 0, '', 1, 'Pema Yangphel ', '', '', 1, NULL, NULL, '2021-07-15 08:52:01', NULL),
(301, '6V389JRNPY', 'praveen--kumar', '', 'Praveen ', 'Kumar ', '0000-00-00', 1, 'praveenkesavan72@gmail.com', '8072031646', '', '6faf87c50da808cf661c49381ce90fe6', '', '', 0, '', '', '', '', '', '', 0, '', '', '', 0, 0, 0, '', '', '', '', '', '', 1, '', 0, 0, '', 1, 0, 0, 0, '', 0, 'Praveen  Kumar ', '', '', 0, NULL, NULL, '2021-07-15 09:32:12', NULL),
(302, '3EW1HV1ML4', 'saunak--roy', 'profile-pic-1627660612.jpg', 'Saunak ', 'Roy', '1999-10-13', 1, 'saunakcruze@gmail.com', '8597682207', '', 'f0c2735ebd37f5d9c1e99c5b20b377a1', 'Kolkata', '600', 35, '1', '', 'A 21-year-old engineering dropout turned out to be a professional tattoo artist. His immense love for art and craft was always there and he started taking art seriously as a career option for the last 2 years. Saunak has Tried his hands in many art-related fields, starting from Graphic designer to commissioned painter as his part-time job until he grew his interest in tattooing and it worked pretty well for him. Realism was always the most preferred art style for him where he wants to create something unique in this genre.', '2020', 'Aliens Tattoo Art School', '', 2, '', '', '1,2,11,16,18', 1, 850, 0, '', '', 'https://www.instagram.com/saunakcruze', '', '', '', 3, '', 0, 0, '', 1, 0, 1, 2, '5000', 1, 'Saunak  Roy', '', '', 10, NULL, NULL, '2021-07-15 09:35:09', NULL),
(303, 'FW79R4XS3Q', 'adesh-shah', '', 'Adesh', 'Shah', '0000-00-00', 1, 'adeshshah91@gmail.com', '9833499007', '', '7c575e98e8699725b4776ba9d6973f4f', '', '', 0, '', '', '', '', '', '', 0, '', '', '', 0, 0, 0, '', '', '', '', '', '', 1, '', 0, 0, '', 1, 0, 0, 0, '', 1, 'Adesh Shah', '', '', 0, NULL, NULL, '2021-07-15 09:45:18', NULL),
(304, 'B3FNZU9W79', 'sneha-gangar', '', 'Sneha', 'Gangarg', '1994-05-04', 2, 'snehagangar04@gmail.com', '7276529896', '8788637129', 'fa87e6ba980d880c7536ae2cdaf69f6e', 'Dombivli east', '674', 21, '1', '', 'A fashion designer by education, a free lancing artist by choice. I\'m a tattoo artist practising tattooing since last 8+years. I am also a sketch artist, specializing in charcoal medium portraits. I love to do hyper realism artworks. I also ocassionally dabble with canvas paintings as per client requirements. I believe Client satisfaction is my prize.', '2013', 'Nikhil Parmar,Sunny Bhanushali', 'Self', 1, 'Bhargavi Chirmule,Chaitrali Gupte', '', '5,17,18,25,26', 2, 800, 0, '', '', 'https://www.instagram.com/p/CQRTwlnBI2u/?utm_medium=copy_link', '', '', '', 3, '', 0, 0, '', 1, 0, 1, 2, '500', 1, 'Sneha Gangar', '', '', 7, NULL, NULL, '2021-07-15 11:05:56', NULL),
(305, 'XR9U749DYW', 'radhika-nighoskar', 'profile-pic-1626511077.jpg', 'Radhika', 'Nighoskar', '1970-01-01', 2, 'radhikaashm@gmail.com', '8700235550', '', '100810d2ddc48566c2c67b6fed7885cb', 'Paras Tierea, sector 137', '723', 34, '1', '', 'I\'m a 21 year old tattoo artist. The co-founder of my home-studio, TheInkCorporation. I was always connected to various artforms: singing, sketching, dance, but never really thought I\'d pursue art as a career. I believe being an artist is one of the best decisions I\'ve taken, and I wish to unlearn and learn, and keep growing that way. Right now, I\'m mostly doing minimal work, along with piercings. Also working on more art forms within tattooing to progress.', '2020', 'Self-taught,workshop by Lucky Solanki sir,Workshop by Vikas Malani sir', '', 2, '', '', '5,11,12', 1, 500, 0, '', '', 'tic.india', '', '', '', 3, '', 0, 0, '', 1, 0, 1, 1, '1000', 1, 'Radhika Nighoskar', '', '', 8, NULL, NULL, '2021-07-15 11:16:51', NULL),
(306, 'DK34MQU7J2', 'vandana-karki', '', 'Vandana', 'Karki', '1999-10-02', 2, 'karkibandana24@gmail.com', '6396881401', '', 'a8003371237bdbd8012ea5ddc0dd8ba9', 'New friends colony', '773', 10, '1', '110025', '', '', '', '', 0, '', '', '', 0, 0, 0, '', '', '', '', '', '', 1, '', 0, 0, '', 1, 0, 0, 0, '', 1, 'Vandana Karki', '', '', 0, NULL, NULL, '2021-07-15 11:52:17', NULL),
(307, 'KFBU6M236N', 'gourav-mahajan-1', '', 'Gourav', 'Mahajan', '0000-00-00', 1, 'mahajan.gourav18@gmail.com', '8558883376', '', '06a5f443382dcc1538704249ea667dd9', '', '', 0, '', '', '', '', '', '', 0, '', '', '', 0, 0, 0, '', '', '', '', '', '', 1, '', 0, 0, '', 1, 0, 0, 0, '', 1, 'Gourav Mahajan', '', '', 0, NULL, NULL, '2021-07-15 12:10:34', NULL),
(308, 'C6KM4G3P4W', 'karan-kambo', 'profile-pic-1626352035.jpeg', 'Karan', 'Kambo', '1989-12-22', 1, 'arteffectstattoo@gmail.com', '9167472399', '9987125978', '77de4a1f09a294ed8aebb0286fe9a216', '106, aradhana towers, oshiwara, jogeshwari west', '672', 21, '1', '400102', 'What began as random scribbles and drawings evolved into a journey of self-expression filled with emotion and peace. While this 7 year long journey has been full of obstacles and emotional rollercoasters, what I enjoy the most about my work is the joyful experience my clients have. Since I like to create artwork which is customized to your requirement, I work with various styles, like Dot work, Line Art, Color Tattoo, Realistic Tattoo, Script Tattoo, etc. When you come down to my studio get ready to enjoy a peaceful and calming experience along with the machine’s buzz ;)', '2015', '', '', 3, '', '', '5,7,10,16,18', 1, 800, 1, 'https://www.arteffectstattoo.com/', '', 'https://www.arteffectstattoo.com/', '', '', '', 3, '', 0, 0, '', 1, 0, 1, 1, '1800', 1, 'Karan Kambo', '', '', 6, NULL, NULL, '2021-07-15 12:11:45', NULL),
(309, '1EJ4Q1K1SP', 'tattooist-kowshi-moodagadde', '', 'Tattooist kowshi', 'Moodagadde', '2021-07-15', 1, 'kowshik291996@gmail.com', '9591310025', '9591310025', '109cc81a6979affd1fd378347f4a920e', 'Kushalnagar mahilasamaja', '238', 17, '1', '571104', '', '', '', '', 0, '', '', '', 0, 0, 0, '', '', '', '', '', '', 1, '', 0, 0, '', 1, 0, 0, 0, '', 1, 'Tattooist kowshi Moodagadde', '', '', 0, NULL, NULL, '2021-07-15 12:12:47', NULL),
(310, '5NZD9CR2U6', 'anil-kumar-verma', '', 'ANIL KUMAR', 'VERMA', '0000-00-00', 1, 'inkhousetattoo2020@gmail.com', '9321095961', '', 'ec6776daaa0c3161a59aa18d2e678d10', '', '', 0, '', '', '', '', '', '', 0, '', '', '', 0, 0, 0, '', '', '', '', '', '', 1, '', 0, 0, '', 1, 0, 0, 0, '', 1, 'ANIL KUMAR VERMA', '', '', 0, NULL, NULL, '2021-07-15 12:18:06', NULL),
(311, '2L5TZQC45X', 'viren-chekhliya', '', 'Viren', 'Chekhliya', '0000-00-00', 1, 'virenchekhliya4@gmail.com', '9370627362', '', '1478f55299213023177f2037baeaff62', '', '', 0, '', '', '', '', '', '', 0, '', '', '', 0, 0, 0, '', '', '', '', '', '', 1, '', 0, 0, '', 1, 0, 0, 0, '', 0, 'Viren Chekhliya', '', '', 0, NULL, NULL, '2021-07-15 12:33:18', NULL),
(312, 'D4PYF2A41W', 'rohit-paawan', '', 'Rohit', 'Paawan ', '0000-00-00', 1, 'tattoor885@gmail.com', '8376993819', '', 'd9cd4582dec438024341f3a6bede4d27', '', '', 0, '', '', '', '', '', '', 0, '', '', '', 0, 0, 0, '', '', '', '', '', '', 1, '', 0, 0, '', 1, 0, 0, 0, '', 1, 'Rohit Paawan ', '', '', 0, NULL, NULL, '2021-07-15 12:59:28', NULL),
(313, '0Y7GPN33QM', 'prashant-paktekar', '', 'Prashant', 'Paktekar', '0000-00-00', 1, 'prashantpaktekar181@gmail.com', '9773259491', '', '114cf6f6ce16d1f231d849c14c292064', '', '', 0, '', '', '', '', '', '', 0, '', '', '', 0, 0, 0, '', '', '', '', '', '', 1, '', 0, 0, '', 1, 0, 0, 0, '', 1, 'Prashant Paktekar', '', '', 0, NULL, NULL, '2021-07-15 13:07:45', NULL),
(314, 'VJBF3M189P', 'sagar-shivashankar', '', 'Sagar', 'Shivashankar ', '0000-00-00', 1, 'sagarshivashankar@gmail.com', '6360640044', '', '126345251bbcdb1b7a4bfb27a285f18b', '', '', 0, '', '', '', '', '', '', 0, '', '', '', 0, 0, 0, '', '', '', '', '', '', 1, '', 0, 0, '', 1, 0, 0, 0, '', 1, 'Sagar Shivashankar ', '', '', 0, NULL, NULL, '2021-07-15 14:14:26', NULL),
(315, '4ZB7K9MJ7Y', 'vishal--rana', 'profile-pic-1626368075.png', 'Vishal ', 'Rana', '1993-04-24', 1, 'dragonink55@gmail.com', '7589753152', '', 'fe686941cdbb06c5e19d064e571227e1', 'Dragons tattoo studio near bala sundri mandir, jakhan, canal road ', '509', 33, '1', '', 'My self vishal singh rana . years of experience in the tattoo industry Adept at working with clients to design thoughtful and original tattoo plans. Bringing forth superior artistic ability, manual dexterity, and great attention to details. Committed to creating a hygenic , comfortable, sanitary, and calming atmosphere for clients.', '2020', 'Aliens tattoo india ', '', 2, '', '', '1,4,16,18,19', 1, 500, 0, '', '', 'https://www.instagram.com/dragons.ink/', '', '', '', 3, '', 0, 0, '', 1, 0, 1, 2, '1000', 1, 'Vishal  Rana', '', '', 11, NULL, NULL, '2021-07-15 14:29:11', NULL),
(316, 'Y728CVXM1L', 'mayur-mane', '', 'Mayur', 'Mane', '1991-07-29', 1, 'inkspressiontattooz@gmail.com', '7387515299', '9511889355', 'd5aac9f33c90e524e2ea6db2cf04569f', 'Inkspression Tattooz, 2 floor , Chandwadkar Park, Model colony chowk\r\nCollege road, opp. Nandan sweets', '330', 21, '1', '422005', '', '', '', '', 0, '', '', '', 0, 0, 0, '', 'https://facebook.com/inkspressiontattooz', 'https://instagram.com/inkspressiontattooz', '', '', '', 1, '', 0, 0, '', 1, 0, 0, 0, '', 1, 'Mayur Mane', '', '', 0, NULL, NULL, '2021-07-15 14:58:19', NULL),
(317, 'V05HD4KTC6', 'vishal-shelar', '', 'Vishal', 'Shelar', '0000-00-00', 1, 'vdshelar95@gmail.com', '8108974247', '', 'cb5e6d2123e4a06d8b2fb6ab8224593d', '', '', 0, '', '', '', '', '', '', 0, '', '', '', 0, 0, 0, '', '', '', '', '', '', 1, '', 0, 0, '', 1, 0, 0, 0, '', 0, 'Vishal Shelar', '', '', 0, NULL, NULL, '2021-07-15 15:11:51', NULL),
(318, 'XC13F35YZJ', 'anvesh--ramaiah', '', 'Anvesh ', 'Ramaiah', '1999-01-05', 1, 'anveshani1999@gmail.com', '8867261641', '', 'b203cd01153ef0e10f7f00b2761889f1', 'Matha nilaya keb layout tumkur', '239', 17, '1', '572102', '', '', '', '', 0, '', '', '', 0, 0, 0, '', '', '', '', '', '', 1, '', 0, 0, '', 1, 0, 0, 0, '', 1, 'Anvesh  Ramaiah', '', '', 0, NULL, NULL, '2021-07-15 15:12:19', NULL),
(319, 'A8Z7RG0TD9', 'priyesh-butani', '', 'Priyesh', 'Butani', '0000-00-00', 1, 'priyesh.butani@gmail.com', '9926303300', '', '0d9e0672191fe13d6ce9fce0319ba5a4', '', '', 0, '', '', '', '', '', '', 0, '', '', '', 0, 0, 0, '', '', '', '', '', '', 1, '', 0, 0, '', 1, 0, 0, 0, '', 0, 'Priyesh Butani', '', '', 0, NULL, NULL, '2021-07-15 15:28:01', NULL),
(320, 'HSF9ELB650', 'vatsal--maru', '', 'Vatsal ', 'Maru ', '0000-00-00', 1, 'vatsalmaru038@gmail.com', '9820643406', '', '65abfffee3e8266b60d724bf5bccb2a2', '', '', 0, '', '', '', '', '', '', 0, '', '', '', 0, 0, 0, '', '', '', '', '', '', 1, '', 0, 0, '', 1, 0, 0, 0, '', 1, 'Vatsal  Maru ', '', '', 0, NULL, NULL, '2021-07-15 15:38:37', NULL),
(321, '02UK7CM2SV', 'vishal-rana', '', 'Vishal', 'Rana', '0000-00-00', 1, 'vishalrana3282@gmail.com', '7589753152', '', '62651673ac4a77ea866100c52a4c2eba', '', '', 0, '', '', '', '', '', '', 0, '', '', '', 0, 0, 0, '', '', '', '', '', '', 1, '', 0, 0, '', 1, 0, 0, 0, '', 1, 'Vishal Rana', '', '', 0, NULL, NULL, '2021-07-15 16:08:52', NULL),
(322, 'P8CT0JGN78', 'badshah--ashish', '', 'Badshah ', 'Ashish', '0000-00-00', 1, 'assavner@gmail.com', '9826536711', '', '6160c4a5e80ef3e2029a30908a204c8c', '', '', 0, '', '', 'Hey guys Badshah here owner of Redsmoke tattoo studio. Our studio is Indores one of oldest tattoo studio and our speciality is working on our clients ideas and make a perfect ideal designs for them and there is only one thing we guys actual doing works on satisfaction of clients. ', '2014', 'Manjeet tattoos', '', 3, '', '', '', 0, 0, 0, '', '', '', '', '', '', 2, '', 0, 0, '', 1, 0, 0, 0, '', 1, 'Badshah  Ashish', '', '', 3, NULL, NULL, '2021-07-15 16:34:42', NULL),
(323, 'Y1E8TB54CH', 'ryan--jb-drew', '', 'Ryan', ' Jb Drew', '0000-00-00', 1, 'tattooink.fixers@gmail.com', '9953968262', '', '941aa32872deb63190c23891debcbd27', '', '', 0, '', '', '', '', '', '', 0, '', '', '', 0, 0, 0, '', '', '', '', '', '', 1, '', 0, 0, '', 1, 0, 0, 0, '', 1, 'Ryan  Jb Drew', '', '', 0, NULL, NULL, '2021-07-15 16:48:37', NULL),
(324, '9Q5X5TBE5J', 'prashant-sahu', '', 'Prashant', 'Sahu', '0000-00-00', 1, 'arttitudetattoos@gmail.com', '8143289484', '', 'e3ba551358d95c4d5ec7ac185c17ed73', '', '', 0, '', '', '', '', '', '', 0, '', '', '', 0, 0, 0, '', '', '', '', '', '', 1, '', 0, 0, '', 1, 0, 0, 0, '', 1, 'Prashant Sahu', '', '', 0, NULL, NULL, '2021-07-15 16:54:44', NULL),
(325, 'XGRL521FS8', 'vipul-parmar', '', 'Vipul', 'Parmar', '0000-00-00', 1, 'vptattoos9014@gmail.com', '9974085058', '', 'f1756533e62603597ba18be9f3767fca', '', '', 0, '', '', '', '', '', '', 0, '', '', '', 0, 0, 0, '', '', '', '', '', '', 1, '', 0, 0, '', 1, 0, 0, 0, '', 0, 'Vipul Parmar', '', '', 0, NULL, NULL, '2021-07-15 17:14:20', NULL),
(326, 'HB5LWG325R', 'utkarsh--dandriyal', '', 'Utkarsh ', 'Dandriyal', '0000-00-00', 1, 'utkarsh.dandriyal@gmail.com', '8445649679', '', '0e4774d1f50f38d305bc52cdba08448d', '', '', 0, '', '', '', '', '', '', 0, '', '', '', 0, 0, 0, '', '', '', '', '', '', 1, '', 0, 0, '', 1, 0, 0, 0, '', 1, 'Utkarsh  Dandriyal', '', '', 0, NULL, NULL, '2021-07-15 17:26:09', NULL),
(327, 'SZ03D1CW6H', 'vipul-parmar-1', '', 'Vipul', 'Parmar ', '0000-00-00', 1, 'vipulparmar9014@gmail.com', '9974085058', '', 'f1756533e62603597ba18be9f3767fca', '', '', 0, '', '', '', '', '', '', 0, '', '', '', 0, 0, 0, '', '', '', '', '', '', 1, '', 0, 0, '', 1, 0, 0, 0, '', 0, 'Vipul Parmar ', '', '', 0, NULL, NULL, '2021-07-15 17:36:08', NULL),
(328, '61RL74MDZW', 'manjunath-kolakar-1', '', 'Manjunath', 'Kolakar', '0000-00-00', 1, 'tattomanju@gmail.com', '8867621101', '', 'aca31b71fcd22b864538da973d5d6070', '', '', 0, '', '', '', '', '', '', 0, '', '', '', 0, 0, 0, '', '', '', '', '', '', 1, '', 0, 0, '', 1, 0, 0, 0, '', 0, 'Manjunath Kolakar', '', '', 0, NULL, NULL, '2021-07-15 17:58:38', NULL),
(329, 'VSN4AR3E45', 'satyakam-tripathi', '', 'Satyakam', 'Tripathi', '0000-00-00', 1, 'satyakamtripathi8@gmail.com', '8085603948', '', 'd41cdd7b13750b43c48e6e84d432f410', '', '', 0, '', '', '', '', '', '', 0, '', '', '', 0, 0, 0, '', '', '', '', '', '', 1, '', 0, 0, '', 1, 0, 0, 0, '', 0, 'Satyakam Tripathi', '', '', 0, NULL, NULL, '2021-07-15 18:19:43', NULL),
(330, 'PY79T7A1HX', 'prafull-rathod', '', 'Prafull', 'Rathod', '0000-00-00', 1, 'gink.prafull@gmail.com', '9033205321', '', '1c71ea850671706a7024409e1de997f4', '', '', 0, '', '', '', '', '', '', 0, '', '', '', 0, 0, 0, '', '', '', '', '', '', 1, '', 0, 0, '', 1, 0, 0, 0, '', 0, 'Prafull Rathod', '', '', 0, NULL, NULL, '2021-07-15 18:26:47', NULL),
(331, 'VDT289KC8Q', 'aakash--parekar', '', 'Aakash ', 'Parekar ', '0000-00-00', 1, 'akash.parekar90@gmail.com', '7566557728', '', 'a51a19ed088520331189cc6a8701367b', '', '', 0, '', '', '', '', '', '', 0, '', '', '', 0, 0, 0, '', '', '', '', '', '', 1, '', 0, 0, '', 1, 0, 0, 0, '', 0, 'Aakash  Parekar ', '', '', 0, NULL, NULL, '2021-07-15 19:16:01', NULL),
(332, 'SX8F3EQ53N', 'sujatha--srihari', '', 'Sujatha ', 'Srihari ', '0000-00-00', 2, 'Sujatha.srihari@gmail.com', '9840394629', '', 'efccb3c406a5dab2216e361e85edf035', '', '', 0, '', '', '', '', '', '', 0, '', '', '', 0, 0, 0, '', '', '', '', '', '', 1, '', 0, 0, '', 1, 0, 0, 0, '', 0, 'Sujatha  Srihari ', '', '', 0, NULL, NULL, '2021-07-15 20:12:13', NULL),
(333, 'YA324EX4SC', 'nirali--parekh', '', 'Nirali ', 'Parekh ', '0000-00-00', 2, 'nirali.nparekh@gmail.com', '7977225885', '', 'c12d8fcacbc6f88dcc2fff4b65abeb38', '', '', 0, '', '', '', '', '', '', 0, '', '', '', 0, 0, 0, '', '', '', '', '', '', 1, '', 0, 0, '', 1, 0, 0, 0, '', 0, 'Nirali  Parekh ', '', '', 0, NULL, NULL, '2021-07-15 21:50:59', NULL),
(334, '814WATGPD8', 'bijoy-mathew', '', 'Bijoy', 'Mathew', '0000-00-00', 1, 'writetobijoy01@gmail.com', '7354390075', '', '843ef3ba14b34cc7c91e5d8339ed0055', '', '', 0, '', '', '', '', '', '', 0, '', '', '', 0, 0, 0, '', '', '', '', '', '', 1, '', 0, 0, '', 1, 0, 0, 0, '', 1, 'Bijoy Mathew', '', '', 0, NULL, NULL, '2021-07-16 00:58:02', NULL),
(335, '2ZYTF4EK26', 'jigar--panchal', '', 'Jigar ', 'Panchal', '0000-00-00', 1, 'jigar.panchal46@gmail.com', '9167956523', '', '978746d92b0091ad4545f08a20f1218f', '', '', 0, '', '', '', '', '', '', 0, '', '', '', 0, 0, 0, '', '', '', '', '', '', 1, '', 0, 0, '', 1, 0, 0, 0, '', 1, 'Jigar  Panchal', '', '', 0, NULL, NULL, '2021-07-16 03:30:44', NULL),
(336, '2YD4Z4WRB2', 'rahul--singh', 'profile-pic-1629526614.jpg', 'Rahul ', 'Singh', '1991-09-06', 1, 'Zeppelintattoos@gmail.com', '9560059253', '9560059253', '40f40752887cce9528adde6ae6f2b213', '127, flat no 5Humayunpur, Safdarjung Enclave', '120', 10, '1', '110029', 'I\'m a Tattoos artist having my own studio at safdarjung Enclave by the name ZEPPELIN TATTOOS, I\'m also working as an artist for RIP Tattoos Lajpat Nagar, New Delhi\r\nI do almost all kind of Tattoos but my favourite subject is realism. Portrait Tattoos, realistic flowers, animals lion, wolf etc. ', '2017', 'mascot tattoos', '', 3, '', '', '1,5,10,18,26', 1, 600, 0, 'Www.zeppelintattoos.in', 'https://www.facebook.com/zeppelintattoos/', 'https://www.instagram.com/zeppelintattoos/', '', 'https://www.youtube.com/channel/UCNGBxyVabpxrrhywJVgWIdQ', '', 3, '', 0, 0, '', 1, 0, 1, 2, '1500', 1, 'Rahul  Singh', '', '', 10, NULL, NULL, '2021-07-16 03:58:16', NULL),
(337, '13V1XLGS6P', 'kiruukan-prem', 'profile-pic-1626413480.jpg', 'Kiruukan', 'Prem', '1994-04-30', 1, 'sarainktup@gmail.com', '8015290469', '9659090916', 'bd2b4b8cf7cb281f27bff0a5a5c1899b', '30, bridge way colony (ext)', '703', 31, '1', '641607', 'I\'m Kiruukan from tirupur, tamil nadu. Founder of Sara Ink The Hardcore. Started in 2017. There are 5 artist in our studio. We are specialised in black & grey, Realistic tattoos. First i started my tattoo carrier in The Dark Tattoos chennai as a hobby later i took as a carrier and join upbeat Ink.', '2016', 'Sunny Bhanushali,Upbeat ink,The dark tattoo', '', 3, '', '', '7,12,16,18,26', 2, 1500, 1, '', 'https://www.facebook.com/1265586203462210/posts/3975159942504809/?flite=scwspnss', 'https://www.instagram.com/p/CNPju9_j8jN/?utm_medium=copy_link', '', 'https://m.youtube.com/channel/UC1b60dZsTxSevtNNP3Ciu8Q', '', 3, '', 0, 0, '', 1, 0, 1, 2, '1000', 1, 'Kiruukan Prem', '', '', 7, NULL, NULL, '2021-07-16 04:30:17', NULL),
(338, '3CD3X69UFH', 'dwijamani-singha', '', 'Dwijamani', 'Singha', '0000-00-00', 1, 'dwijamanisingha14@gmail.com', '8822712697', '', 'a624e1393fc8e6587630be3b067082e2', '', '', 0, '', '', '', '', '', '', 0, '', '', '', 0, 0, 0, '', '', '', '', '', '', 1, '', 0, 0, '', 1, 0, 0, 0, '', 1, 'Dwijamani Singha', '', '', 0, NULL, NULL, '2021-07-16 04:36:04', NULL),
(339, 'VM61F5TA6W', 'sangrash-rai', '', 'Sangrash', 'Rai', '1998-07-08', 1, 'rsangarash@gmail.com', '9641163725', '', '2d57d0a406722c80222901dbbaa15ffe', 'Singtam Topakhani ', '764', 30, '1', '737134', 'Iam a beginner artist and trying every possible way to learn and gain knowledge about tattoo art i was studying  mechanical engineer but my love and passion was always art so after completing my diploma in mechanical engineering I started focusing only on my tattoo art so i can become a successful and famous tattoo artist oneday and trying to learn from all the sources i get by watching all the great artist work and sharing their experience while working and i hope i will become a successful artist oneday.', '2018', 'Wild ink tattoo studio ', '', 2, '', '', '4,5,12,14,19', 1, 500, 0, '', '', '', '', '', '', 3, '', 0, 0, '', 1, 0, 0, 2, '', 1, 'Sangrash Rai', '', '', 5, NULL, NULL, '2021-07-16 04:47:59', NULL),
(340, 'E3ZMS98F1U', 'priyanka-thakur', '', 'Priyanka', 'Thakur', '0000-00-00', 2, 'thakurpriyanka104@gmail.com', '7208069546', '', '002b45e76d111e26bb731ded24080d4b', '', '', 0, '', '', '', '', '', '', 0, '', '', '', 0, 0, 0, '', '', '', '', '', '', 1, '', 0, 0, '', 1, 0, 0, 0, '', 0, 'Priyanka Thakur', '', '', 0, NULL, NULL, '2021-07-16 06:30:54', NULL),
(341, '077UZ0MRAG', 'ajay-yadav', 'profile-pic-1626422073.JPG', 'Ajay', 'Yadav', '1990-07-05', 1, 'ajandart@gmail.com', '7838306007', '7982104533', '8fe4a6e706f6dbfc1c0c0f284f4802da', 'B- 105 , first floor ,lajpat Nagar 1,  New delhi', '773', 10, '1', '122052', 'I\'m Ajay.  I like to sketch and paint,  even taught sketching for a while before becoming tattoo artist. \r\n\r\nMostly self taught,  started tattooing also  by  self and ran my own studio for a while in Gurgaon for almost 2.5 years \r\n\r\n\r\nIn January 2021 joined pigmented tattoos, lajpat Nagar 1, New Delhi  as apprentice and now workinf as a full time artist in  pigmented tattoos.\r\n\r\n', '2018', 'Vansh chhabra,Hemant ,Pigmented tattoos', '', 2, '', '', '7,12,16,17,18', 1, 1000, 1, '', '', 'https://www.instagram.com/ajay_tattooer/', '', '', '', 3, '', 0, 0, '', 1, 0, 1, 2, '2000', 1, 'Ajay Yadav', '', '', 7, NULL, NULL, '2021-07-16 06:52:54', NULL),
(342, '81KUP59XBA', 'mandeep--halder', '', 'Mandeep ', 'Halder', '0000-00-00', 1, 'ariestattoosnoida@gmail.com', '9650205367', '', '1eb34e77ed426033ba60be5d9485e1a5', '', '', 0, '', '', '', '', '', '', 0, '', '', '', 0, 0, 0, '', '', '', '', '', '', 1, '', 0, 0, '', 1, 0, 0, 0, '', 1, 'Mandeep  Halder', '', '', 0, NULL, NULL, '2021-07-16 07:33:30', NULL),
(343, 'NF19A7WSE8', 'tushar--sutar', '', 'Tushar ', 'Sutar', '0000-00-00', 1, 'drawtattooart@gmail.com', '7972941482', '', '1e130811ccf092c695c37b8aa2cd6bda', '', '', 0, '', '', '', '', '', '', 0, '', '', '', 0, 0, 0, '', '', '', '', '', '', 1, '', 0, 0, '', 1, 0, 0, 0, '', 1, 'Tushar  Sutar', '', '', 0, NULL, NULL, '2021-07-16 07:35:16', NULL),
(344, 'PR8B12V9HL', 'rakesh-kashyap', '', 'Rakesh', 'Kashyap', '1983-10-10', 1, 'rak3d87@hotmail.com', '9816085587', '', 'd733be020bebbb5ccd7c8bf6dd4666be', 'SkinGraphic Tattoos \r\nAlbion house,Indira villa \r\nNeat lift the mall shimla', '184', 14, '1', '171001', '', '', '', '', 0, '', '', '', 0, 0, 0, '', '', 'https://instagram.com/skingraphic_tattoos?r=nametag', '', '', '', 1, '', 0, 0, '', 1, 0, 0, 0, '', 1, 'Rakesh Kashyap', '', '', 0, NULL, NULL, '2021-07-16 08:08:15', NULL),
(345, '3RZ8W4BCK0', 'm-suresh-shetty', 'profile-pic-1627111733.jpg', 'M suresh', 'Shetty', '1999-08-01', 1, 'suryashetty9491@gmail.com', '8309001509', '7396580820', '83e43ed0b38d158d303282f76687b7e7', 'Hyderabad', '602', 36, '1', '', '', '', '', '', 0, '', '', '7,10,16,18,23', 1, 500, 1, '', '', '', '', '', '', 3, '', 0, 0, '', 1, 0, 1, 1, '1000', 1, 'M suresh Shetty', '', '', 4, NULL, NULL, '2021-07-16 08:39:27', NULL),
(346, 'R38V71EGQS', 'samarpit-gupta', '', 'Samarpit', 'Gupta', '0000-00-00', 1, 'gsamarpit477@gmail.com', '8305590030', '', 'de8654778311f5480d0c749c5f9971c8', '', '', 0, '', '', '', '', '', '', 0, '', '', '', 0, 0, 0, '', '', '', '', '', '', 1, '', 0, 0, '', 1, 0, 0, 0, '', 1, 'Samarpit Gupta', '', '', 0, NULL, NULL, '2021-07-16 09:01:19', NULL),
(347, '13JVH17XUY', 'divyansh-sharma', '', 'Divyansh', 'Sharma', '2000-12-05', 1, 'rextiledancer@gmail.com', '9314438853', '', 'f7ccdd9ce266011f4bda9c098a374547', '1g1 vinayak nagar, near makadwali road, near St Stephen\'s school, Ajmer', '446', 29, '1', '305001', '', '', '', '', 0, '', '', '', 0, 0, 0, '', '', '', '', '', '', 1, '', 0, 0, '', 1, 0, 0, 0, '', 1, 'Divyansh Sharma', '', '', 0, NULL, NULL, '2021-07-16 09:27:49', NULL),
(348, '96Q0FHCAS7', 'deepon--barman', '', 'Deepon ', 'Barman', '0000-00-00', 1, 'amicadeepon@gmail.com', '9612319235', '', '8c1ac88b90e1542bd459194556454fd3', '', '', 0, '', '', '', '', '', '', 0, '', '', '', 0, 0, 0, '', '', '', '', '', '', 1, '', 0, 0, '', 1, 0, 0, 0, '', 0, 'Deepon  Barman', '', '', 0, NULL, NULL, '2021-07-16 09:41:24', NULL),
(349, 'Y69RJUM8Z0', 'ganesh-kulthe', '', 'Ganesh', 'Kulthe', '1991-06-05', 1, 'gktattoostudio@gmail.com', '9923545999', '9689680580', '018f713211a508f08a24c9f04ea192ad', 'Old Jalna Maharashtra', '336', 21, '1', '431203', 'I would like to work Black and grey preferably.. Try to explore new concept... I always think tattoo is part of person\'s personality so it\'s our duty make it like wise for clients...\r\nYou can see my work my Instagram profile where all my work has been posted you like to see my work...thank you', '2015', 'David vega,Akash chandani,Alan gois,Mahesh wagela', '', 2, '', '', '3,4,7,12,16', 1, 500, 0, '', '', 'Ganesha.kulthe', '', '', '', 3, '', 0, 0, '', 1, 0, 0, 2, '', 1, 'Ganesh Kulthe', '', '', 5, NULL, NULL, '2021-07-16 10:13:32', NULL),
(350, 'L55AK53EMS', 'tushar-hire', '', 'Tushar', 'Hire', '1993-12-10', 1, 'hiretushar7@gmail.com', '9689323188', '9011291177', 'ff6ec6cceb75b48156c74f8d5819cca6', 'F NO 3,4 MANGALMURTI APT VRUNDAVAN\r\nNAGAR KAMATWADE NASHIK', '330', 21, '1', '422010', '', '', '', '', 0, '', '', '', 0, 0, 0, '', 'www.fb.com/tusharts7', '', '', '', '', 1, '', 0, 0, '', 1, 0, 0, 0, '', 1, 'Tushar Hire', '', '', 0, NULL, NULL, '2021-07-16 10:58:54', NULL),
(351, 'N9DG44R1HW', 'praveer--singh', '', 'Praveer ', 'Singh', '0000-00-00', 1, 'praveersinghh@gmail.com', '7000103653', '', '5e987196f6ec03ff6af7ae119c587222', '', '', 0, '', '', '', '', '', '', 0, '', '', '', 0, 0, 0, '', '', '', '', '', '', 1, '', 0, 0, '', 1, 0, 0, 0, '', 1, 'Praveer  Singh', '', '', 0, NULL, NULL, '2021-07-16 12:01:59', NULL),
(352, '6L8VSW6M4K', 'swami-sharan', '', 'Swami', 'Sharan', '0000-00-00', 1, 'swamisharan08@gmail.com', '7906138155', '', '69c8d3058659fed22d8f9a389bba05ed', '', '', 0, '', '', '', '', '', '', 0, '', '', '', 0, 0, 0, '', '', '', '', '', '', 1, '', 0, 0, '', 1, 0, 0, 0, '', 1, 'Swami Sharan', '', '', 0, NULL, NULL, '2021-07-16 12:21:54', NULL),
(353, 'M2P6DR8GS8', 'tejas-gorivale', '', 'Tejas', 'Gorivale', '0000-00-00', 1, 'tejas.goriwale185@gmail.com', '7057815740', '', '02933e1599c27bed23aec437af14f141', '', '', 0, '', '', '', '', '', '', 0, '', '', '', 0, 0, 0, '', '', '', '', '', '', 1, '', 0, 0, '', 1, 0, 0, 0, '', 1, 'Tejas Gorivale', '', '', 0, NULL, NULL, '2021-07-16 13:03:45', NULL),
(354, 'NZYB20V66L', 'pushpendra--saini', '', 'Pushpendra ', 'Saini', '0000-00-00', 1, 'pyes703@gmail.com', '7021092858', '', 'cb7e96ad5b2ca96421bd3d55ba03e6a6', '', '', 0, '', '', '', '', '', '', 0, '', '', '', 0, 0, 0, '', '', '', '', '', '', 1, '', 0, 0, '', 1, 0, 0, 0, '', 1, 'Pushpendra  Saini', '', '', 0, NULL, NULL, '2021-07-16 14:34:28', NULL),
(355, 'TU9V36PMN9', 'abhishek-gawai', '', 'Abhishek', 'Gawai', '0000-00-00', 1, 'gawaiabhishek355@gmail.com', '6260775891', '', '46190e87d13d1b525c0c32a6c105c4a0', '', '', 0, '', '', '', '', '', '', 0, '', '', '', 0, 0, 0, '', '', '', '', '', '', 1, '', 0, 0, '', 1, 0, 0, 0, '', 1, 'Abhishek Gawai', '', '', 0, NULL, NULL, '2021-07-16 15:58:30', NULL),
(356, 'S93PF5WR4Y', 'kashish-chandna', '', 'Kashish', 'Chandna', '0000-00-00', 2, 'kwc1909@gmail.com', '9999663770', '', 'f3ff79072bdd67c2ec1f2a4a4caaa3f0', '', '', 0, '', '', '', '', '', '', 0, '', '', '', 0, 0, 0, '', '', '', '', '', '', 1, '', 0, 0, '', 1, 0, 0, 0, '', 1, 'Kashish Chandna', '', '', 0, NULL, NULL, '2021-07-16 16:00:54', NULL),
(357, '3W1CMBLN90', 'joshua-gomes', 'profile-pic-1626454463.jpeg', 'Joshua', 'Gomes', '1995-12-30', 1, 'joshua.gomes.95@gmail.com', '9167366280', '', '5fd4999db81e4631e97ec7233b049a5e', '32, Pricel Holm, Santacruz West', '672', 21, '1', '400054', 'Fresher. Budding Tattoo Artist. Currently learning. Highly motivated and creative with a willingness to learn and create wonderful art through body modification and tattoos. I’ve completed my bachelors of mass media and want to get into full time tattoo creation. This lockdown of 2020 has taught me to be creative ', '2020', 'Al Alva', '', 2, '', '', '7', 1, 1000, 0, '', '', '', '', '', '', 3, '', 0, 0, '', 1, 0, 0, 2, '', 1, 'Joshua Gomes', '', '', 6, NULL, NULL, '2021-07-16 16:39:41', NULL),
(358, '9XQWD7N41H', 'arun-kumar', 'profile-pic-1626457559.JPG', 'Arun', 'Kumar', '1998-08-25', 1, 'tattooartistarun@gmail.com', '9604930772', '9604930772', '08232b2cab4ec18fd8626b9727bc9d08', 'Bhiwandi', '672', 21, '1', '421302', 'Hi My Name Arun Kumar I need Some Knowledge from Yours i need To Grow Up More I need Some Suggestions from Yours to help our clients get them what exactly makes them happy and we can help them out further to get them what exactly makes them.\r\nHaa is a tattoo done on the best tattoo we go through to help our clients ', '2020', '', '', 2, '', '', '4,10,16,26,27', 1, 300, 0, '', '', 'https://instagram.com/ink.your.skin_?utm_medium=copy_link', '', '', '', 3, '', 0, 0, '', 1, 0, 0, 2, '', 1, 'Arun Kumar', '', '', 5, NULL, NULL, '2021-07-16 17:29:30', NULL),
(359, 'C83Z6LRG8H', 'paramjit-kumar-sahani', '', 'Paramjit Kumar', 'Sahani', '0000-00-00', 1, 'parapoo1234@gmail.com', '7002574672', '', 'f838865e1b2df51fff8d4d9429df2db5', '', '', 0, '', '', '', '', '', '', 0, '', '', '', 0, 0, 0, '', '', '', '', '', '', 1, '', 0, 0, '', 1, 0, 0, 0, '', 1, 'Paramjit Kumar Sahani', '', '', 0, NULL, NULL, '2021-07-17 00:34:08', NULL),
(360, 'G0NVZ57MT5', 'sai-kumar-endurthi', 'profile-pic-1626486060.jpeg', 'SAI KUMAR', 'ENDURTHI', '1993-10-10', 1, 'skmr709@gmail.com', '9381152682', '8341044406', '99b61bfb57190157cfc7a1748944cf36', 'Plot no 23 & 24,  Raji reddy colony ,Hasthinapuram east,Saroor nagar ,R.R District ', '602', 36, '1', '', 'Form Childhood I am artist.I completed my fine arts studies when I wrote entrance exam I got 2 Nd rank in Whole state ,I completed my tattoo course in Aliens tattoo school and completed my course with best grade and also I did job in Aliens tattoo India. I can do all mediums Tattoos. Thankyou ', '2011', 'SUNNY BHANUSHALI/ALIENS TATTOO SCHOOL', '', 2, '', '', '11,16,18,19,26', 2, 2000, 1, '', 'https://www.facebook.com/Skmr709', 'https://www.instagram.com/_sai__kumar___', 'https://in.pinterest.com/skmr709/', 'https://youtube.com/channel/UCY1oYyILmpsEZBFjlbOTX_Q', '', 3, '', 0, 0, '', 1, 0, 1, 2, '500', 1, 'SAI KUMAR ENDURTHI', '', '', 9, NULL, NULL, '2021-07-17 01:18:50', NULL),
(361, 'Z98RKAU71F', 'kamalnayan--mishra', '', 'Kamalnayan ', 'Mishra ', '0000-00-00', 1, 'm.kamalnayan@gmail.com', '9096655322', '', '0d4798054ef2bf987f0bc88371bb8ebd', '', '', 0, '', '', '', '', '', '', 0, '', '', '', 0, 0, 0, '', '', '', '', '', '', 1, '', 0, 0, '', 1, 0, 0, 0, '', 1, 'Kamalnayan  Mishra ', '', '', 0, NULL, NULL, '2021-07-17 04:54:40', NULL),
(362, 'P81EMK84BL', 'daz-prakash', '', 'Daz', 'Prakash', '1998-02-28', 1, 'wactattoo@gmail.com', '7449177868', '9840990489', 'd0cf7652c05cb1e96b190004b0f291b5', 'Wactattoo \r\nOpposite to sona college \r\nNear by thirumalai ammal mandapam, kasakaranur Salem 636005', '482', 31, '1', '636005', ' Daz from wactattoo Salem. We done best customized sleeves and realistic portraits are done. Trusted to get new ink with us checked out our profile and our experts done such a wonderful art for you . Get a free on-line consultation with free design to book your date. Spend a good time with our mentors', '2018', '', '', 2, '', '', '16,18,19,23,26', 2, 1500, 0, '', '', 'https://instagram.com/wac_tattoo?utm_medium=copy_link', '', '', '', 3, '', 0, 0, '', 1, 0, 1, 2, '2000', 1, 'Daz Prakash', '', '', 5, NULL, NULL, '2021-07-17 05:07:41', NULL),
(363, 'PH24ZDA9N7', 'amit-ap', '', 'Amit', 'Ap', '0000-00-00', 1, 'amit.pattan@gmail.com', '8050273695', '', '8ee062a3051f6907c98e4cc1c9c059cd', '', '', 0, '', '', '', '', '', '', 0, '', '', '', 0, 0, 0, '', '', '', '', '', '', 1, '', 0, 0, '', 1, 0, 0, 0, '', 1, 'Amit Ap', '', '', 0, NULL, NULL, '2021-07-17 07:24:01', NULL),
(364, 'CF645PU5LD', 'gokul-krishnan', 'profile-pic-1626508889.jpg', 'Gokul', 'Krishnan', '1998-07-12', 1, 'gokulfrases@gmail.com', '8807548697', '9566367033', '4f07a59a2e74e9ba62d42c24b787ecb5', 'Mahadev ink tattoo studioVadavalli, coimbatore', '701', 31, '1', '641041', '', '', '', '', 0, '', '', '21', 1, 500, 0, '', 'https://www.facebook.com/gokul.carzy', 'https://www.instagram.com/p/CRLDPVGFioQ/?utm_medium=copy_link', '', '', '', 3, '', 0, 0, '', 1, 0, 0, 2, '', 1, 'Gokul Krishnan', '', '', 4, NULL, NULL, '2021-07-17 07:29:15', NULL),
(365, 'K99H1JFAT4', 'vivek-patel', '', 'Vivek', 'Patel', '0000-00-00', 1, 'patelvivek101@yahoo.com', '8866393054', '', '7cdbd3e7142cc4956306982f20b271fe', '', '', 0, '', '', '', '', '', '', 0, '', '', '', 0, 0, 0, '', '', '', '', '', '', 1, '', 0, 0, '', 1, 0, 0, 0, '', 1, 'Vivek Patel', '', '', 0, NULL, NULL, '2021-07-17 07:36:24', NULL),
(366, '948GWBN3PJ', 'rohan--jadhav', '', 'Rohan ', 'Jadhav ', '2001-04-23', 1, 'rj9084834@gmail.com', '8657308809', '8850269671', 'e4d9b646b046fbe1dbcde2eb9949b60e', 'Madan appt room no 03 Kharegon kalwa thane', '672', 21, '1', '400605', '', '', '', '', 0, '', '', '', 0, 0, 0, '', '', '', '', '', '', 1, '', 0, 0, '', 1, 0, 0, 0, '', 1, 'Rohan  Jadhav ', '', '', 0, NULL, NULL, '2021-07-17 09:01:20', NULL),
(367, '7LE4DMW0R9', 'prabhjeet-singh-ps-ronnie', '', 'Prabhjeet Singh', 'PS Ronnie', '0000-00-00', 1, 'prabhjeetsingh5@gmail.com', '8588954145', '', 'dbfcee656b8aa707208a6d2a098fe877', '', '', 0, '', '', '', '', '', '', 0, '', '', '', 0, 0, 0, '', '', '', '', '', '', 1, '', 0, 0, '', 1, 0, 0, 0, '', 1, 'Prabhjeet Singh PS Ronnie', '', '', 0, NULL, NULL, '2021-07-17 10:03:55', NULL),
(368, 'PQRW715N9Z', 'nikhil-sanwariya', '', 'Nikhil', 'Sanwariya ', '1997-08-13', 1, 'tattoonik20@gmail.com', '8769158838', '8769158838', 'ae8a6169835e1e86cfd208fcc81b5d8f', 'Rk colony Bhilwara, Rajasthan 311011', '445', 29, '1', '311011', 'My name is Nikhil my commercial work and my painting related work both journey started from Ajmer Tattoo work I started from Ajmer Balaji Tattoo studio then to improve it a little more I completed fine art from Jaipur Rajasthan School of Art and now my studio is in bhilwara where i do tattoo and painting', '2016', 'Rajasthan school of art ', '', 2, '', '', '16', 1, 400, 0, '', '', 'https://www.instagram.com/nikhil_sanwariya?r=nametag', '', '', '', 3, '', 0, 0, '', 1, 0, 0, 2, '', 1, 'Nikhil Sanwariya ', '', '', 5, NULL, NULL, '2021-07-17 10:50:40', NULL),
(369, 'GVE281SFU6', 'vishnu-vasava', '', 'Vishnu', 'Vasava', '0000-00-00', 1, 'vasavavishnu7741@gmail.com', '9998944741', '', '4eaa9c62a63ded13f2b48b2240eedbce', '', '', 0, '', '', '', '', '', '', 0, '', '', '', 0, 0, 0, '', '', '', '', '', '', 1, '', 0, 0, '', 1, 0, 0, 0, '', 1, 'Vishnu Vasava', '', '', 0, NULL, NULL, '2021-07-17 10:57:03', NULL),
(370, 'C0TRGY96B9', 'sri-karthik', '', 'Sri', 'Karthik', '0000-00-00', 1, 'venomtattoos.ink@gmail.com', '8939461552', '', '8a3dc611d3f3ac4b34f10c0946f2fffd', '', '', 0, '', '', '', '', '', '', 0, '', '', '', 0, 0, 0, '', '', '', '', '', '', 1, '', 0, 0, '', 1, 0, 0, 0, '', 1, 'Sri Karthik', '', '', 0, NULL, NULL, '2021-07-17 10:59:47', NULL),
(371, 'BHV2XDN960', 'nithin--m', '', 'Nithin ', 'M', '1998-03-15', 1, 'scarboytattoosnithin@gmail.com', '9744730589', '7736350589', 'd734b9b6a2ee4caf0c5975d4a0cdd287', 'Neethubhavanpoovan vila paloorkonam nemom po', '666', 18, '1', '695020', 'Im Nithin owner of scarboy tattoos . Freelancer and a selftaught artist from kerala gods own country . I choose tattoo artist as carrer cz i love to do with passion and dedication . Many styles i can . But mostly realism tattoos are my fav .its my style realism  ', '2018', '', '', 3, '', '', '4,7,16,18,22', 1, 600, 0, '', '', 'https://www.instagram.com/scarboy_tattoos?r=nametag', '', 'https://youtu.be/yaNbpTY61gM', '', 3, '', 0, 0, '', 1, 0, 1, 2, '600', 1, 'Nithin  M', '', '', 5, NULL, NULL, '2021-07-17 11:19:04', NULL),
(372, '91MYSG6C2E', 'shashi-naik', '', 'Shashi', 'Naik', '0000-00-00', 1, 'tattoofever105@gmail.com', '9769397646', '', '38d80e5ad4ff9a206407c24657681440', '', '', 0, '', '', '', '', '', '', 0, '', '', '', 0, 0, 0, '', '', '', '', '', '', 1, '', 0, 0, '', 1, 0, 0, 0, '', 1, 'Shashi Naik', '', '', 0, NULL, NULL, '2021-07-17 11:24:53', NULL),
(373, 'LB15A9ZWT9', 'karthick-shaan', '', 'Karthick', 'Shaan', '0000-00-00', 1, 'inkdzilla@gmail.com', '9025250687', '', 'b2728cee5945d1f743e0c90b244b18ea', '', '', 0, '', '', '', '', '', '', 0, '', '', '', 0, 0, 0, '', '', '', '', '', '', 1, '', 0, 0, '', 1, 0, 0, 0, '', 1, 'Karthick Shaan', '', '', 0, NULL, NULL, '2021-07-17 12:00:58', NULL),
(374, '518PZDRV1U', 'bhargob-gogoi', 'profile-pic-1626802853.jpg', 'Bhargob', 'Gogoi', '1990-03-07', 1, 'bhargob7@gmail.com', '9101067312', '', 'f8f75b2bcea8300f8b771e6e836d33ed', 'Jorhat bongal pukhuri west Jaya Nagar, Milijuli path, Jorhat Assam-785001', '60', 4, '1', '', 'I love Tattoo. I like to do tattoos which expresses positive meaning for my clients to support and trigger positivity in everyone\'s lives and to provide best quality Tattoo service. I use vegan certified tattoo products and dermalize pro for tattoo aftercare. 100% hygienic. I provide free tattoo touch ups. Blessed', '2016', 'Workshop at aliens Tattoo', 'Intenze Tattoo Ink,Dermalize pro', 2, '', '', '10,17,18,21,22', 2, 2000, 1, '', 'https://m.facebook.com/1530017800645908/', 'https://www.instagram.com/gogoi_ink_tattoo/', '', 'https://m.youtube.com/channel/UChKD7u5AYSb_rdBlcuzM0Og', '', 3, '', 0, 0, '', 1, 0, 1, 2, '500', 1, 'Bhargob Gogoi', '', '', 11, NULL, NULL, '2021-07-17 12:21:54', NULL),
(375, '5EY6CDQ1S4', 'abhirath-n-c', '', 'Abhirath', 'N C', '0000-00-00', 1, 'pandy.abhirath.n.c@gmail.com', '8197640322', '', '0e45612f07abc7f6e4bc119d12cd1a05', '', '', 0, '', '', '', '', '', '', 0, '', '', '', 0, 0, 0, '', '', '', '', '', '', 1, '', 0, 0, '', 1, 0, 0, 0, '', 1, 'Abhirath N C', '', '', 0, NULL, NULL, '2021-07-17 12:29:56', NULL),
(376, 'TCZS3502YK', 'santosh-jagtap', '', 'Santosh', 'Jagtap', '0000-00-00', 1, 'santoshjagtap1583@gmail.com', '9225525069', '', '81595f01a98ee19b0264d951adfb7dc2', '', '', 0, '', '', '', '', '', '', 0, '', '', '', 0, 0, 0, '', '', '', '', '', '', 1, '', 0, 0, '', 1, 0, 0, 0, '', 1, 'Santosh Jagtap', '', '', 0, NULL, NULL, '2021-07-17 12:38:17', NULL),
(377, 'UP8V50TFN6', 'kanak-sinha', '', 'Kanak', 'Sinha', '0000-00-00', 1, 'sinha.kanak84@gmail.com', '8586886912', '', 'a32423ef3d1f2d8df6c98919bc0e9f18', '', '', 0, '', '', '', '', '', '', 0, '', '', '', 0, 0, 0, '', '', '', '', '', '', 1, '', 0, 0, '', 1, 0, 0, 0, '', 1, 'Kanak Sinha', '', '', 0, NULL, NULL, '2021-07-17 13:08:27', NULL),
(378, '9WAM5UH1R1', 'sean--maben-s-n', '', 'Sean ', 'Maben S N', '0000-00-00', 1, 'angelstattooartstudio@gmail.com', '8549858579', '', '6e03b79716dcbcd2f67e3b1796a602e4', '', '', 0, '', '', '', '', '', '', 0, '', '', '', 0, 0, 0, '', '', '', '', '', '', 1, '', 0, 0, '', 1, 0, 0, 0, '', 1, 'Sean  Maben S N', '', '', 0, NULL, NULL, '2021-07-17 13:53:26', NULL),
(379, 'J0CSPZ8B25', 'nawal-g', 'profile-pic-1626536937.jpg', 'Nawal', 'G', '1975-08-18', 1, 'nawal.giroti@gmail.com', '9997213332', '', '3c2367dd93df20f9cc23271600241e6c', 'shastri nagar', '542', 34, '1', '244901', 'I\'m nothing in this world......I also think that every 1 is a learner for whole life.....every step of live gives one lesson ......may be small or big....that can change the whole life......Happily do and do all the time....be happy and let other make other happy too\r\n\r\nYour time is limited, so don\'t waste it living someone else\'s life. Don\'t be trapped by dogma – which is living with the results of other people\'s thinking. -Steve Jobs', '2011', 'Nike tattoo', '', 3, '', '', '4,5,25', 1, 500, 0, '', '', '', '', '', '', 3, '', 0, 0, '', 1, 0, 0, 2, '', 1, 'Nawal G', '', '', 6, NULL, NULL, '2021-07-17 14:31:50', NULL),
(380, '2536YFCPHL', 'melvyn-shimray-1', '', 'Melvyn', 'Shimray', '0000-00-00', 1, 'lonsiruivah@yahoo.in', '9654678203', '', '256d0418350a47a06b0b7f985bc59a7c', '', '', 0, '', '', '', '', '', '', 0, '', '', '', 0, 0, 0, '', '', '', '', '', '', 1, '', 0, 0, '', 1, 0, 0, 0, '', 1, 'Melvyn Shimray', '', '', 0, NULL, NULL, '2021-07-17 15:55:01', NULL);
INSERT INTO `adv_artist` (`id`, `code`, `slug`, `profile_pic`, `fname`, `lname`, `dob`, `gender`, `email`, `mobile`, `alt_mobile`, `password`, `address`, `city`, `state`, `country`, `pincode`, `artist_bio`, `work_since`, `mentor`, `sponsor`, `celeb`, `celeb_name`, `emp_type`, `cats`, `pmode`, `price`, `pshow`, `website`, `facebook`, `instagram`, `pinterest`, `youtube`, `blog_url`, `profile_step`, `ref_code`, `wallet`, `pedia_wallet`, `artist_offer`, `status`, `feature`, `direct_booking`, `piercing`, `minimum_booking_amount`, `verified`, `meta_title`, `meta_keyword`, `meta_desc`, `list_order`, `fs_date`, `fe_date`, `created`, `last_login`) VALUES
(381, 'B76EU1LA8V', 'divine-arts--tattoos-kerala', 'profile-pic-1626544245.jpg', 'Ananthakrishnan', 'Rs', '1990-10-31', 1, 'divineartstattootvm@gmail.com', '9633045705', '919633045705', '4d79d23ad4ea197f3f310f3473c05987', 'Vellayabalam, opp rose opticals, sasthamangalam road', '666', 18, '1', '', 'I am Ananthakrishnan R S, Tattoo Artist and owner of Divine Arts Tattoos Kerala located in Trivandrum, Kerala. My tattoo career started since 2017.I was so passionate in drawing and artistic works since my childhood. Just before i came into the tattoo field i was freelance photographer and graphic designer. Then i started to work for my passion, thats leads me to be a Tattoo Artist.', '2017', 'Id tattoo studio ', '', 1, 'Sumi rashik,Ardra ,Raji menon ', '', '16,17,18,19,22', 1, 500, 0, 'www.divineartstattoos.com', 'https://m.facebook.com/135760073626545/', 'https://instagram.com/divine_arts_tattoos_kerala?utm_medium=copy_link', '', '', '', 3, '', 0, 0, '', 1, 0, 1, 2, '1000', 1, 'DIVINE ARTS  TATTOOS KERALA ', '', '', 9, NULL, NULL, '2021-07-17 16:55:56', NULL),
(382, '5WXY88ARH5', 'sunil-kumar', 'profile-pic-1626542058.jpg', 'Sunil', 'Kumar', '1993-04-04', 1, '90degreetattoostudio@gmail.com', '8872070404', '9339080005', 'd11ec1f502d68b49ae6a0b2384a92f1c', '90 Degree Tattoo studio, Bnw complex, first floor, badi haibowal Ludhiana', '415', 28, '1', '141001', 'Hi. I am sandy from punjab.  And i am a tattoo artist. Tattoo is my passion and I want to become best tattoo artist. Sunny Bhanushali sir is my favourite artist.\r\nI want to become like him. I learn tattoo from youtube\r\nOtherwise all senior artist are good in own art...................\r\nThanks', '2016', 'Amir Sheikh', '', 2, '', '', '1,16,18,19,23', 1, 500, 0, '', 'https://m.facebook.com/90degreetattoo/', 'https://instagram.com/90_degree_tattoo_studio?utm_medium=copy_link', '', '', '', 3, '', 0, 0, '', 1, 0, 0, 2, '', 1, 'Sunil Kumar', '', '', 6, NULL, NULL, '2021-07-17 16:58:35', NULL),
(383, 'VNUSHD7036', 'hardik-patel', '', 'Hardik', 'Patel', '1994-10-27', 1, 'limitless.hp@gmail.com', '6354989707', '7575011184', '27bf0274e856d75379a4b4b8ee9b65a5', 'E - 101, Aagam Vivianna, Opposite Florencce, VIP Road, Vesu', '144', 12, '1', '395005', 'I\'m a self taught professional tattoo artist and I ink humans amazing tattoos from 2015. I do all types of tattoos except tattoos with more black feelings like tribal and all, and my speciality in realistic tattoos. Somehow I managed to dive into tattoo industry professionally. I\'m great in custom designs too.', '2015', '', '', 3, '', '', '1,16,18,19,23', 1, 800, 1, '', '', 'instagram.com/limitlesstattooart.in', '', '', '', 3, '', 0, 0, '', 1, 0, 1, 1, '1000', 1, 'Hardik Patel', '', '', 5, NULL, NULL, '2021-07-17 20:23:47', NULL),
(384, 'TVGC402FQ9', 'maehek-gangwani', '', 'Maehek', 'Gangwani', '0000-00-00', 2, 'maehekkg10@gmail.com', '8080041305', '', 'ad76aae4fa175ad07c481921f45c5543', '', '', 0, '', '', '', '', '', '', 0, '', '', '', 0, 0, 0, '', '', '', '', '', '', 1, '', 0, 0, '', 0, 0, 0, 0, '', 1, 'Maehek Gangwani', '', '', 0, NULL, NULL, '2021-07-18 04:39:32', NULL),
(385, '5Q2E65YCLH', 'sakkaravarthy-vijayan', '', 'Sakkaravarthy', 'Vijayan', '0000-00-00', 1, 'artistraavana@gmail.com', '7598493925', '', 'ebf57d32711e6ec6329ea2b899cf03bb', '', '', 0, '', '', '', '', '', '', 0, '', '', '', 0, 0, 0, '', '', '', '', '', '', 1, '', 0, 0, '', 1, 0, 0, 0, '', 1, 'Sakkaravarthy Vijayan', '', '', 0, NULL, NULL, '2021-07-18 04:51:11', NULL),
(386, '2ST68ZBE1F', 'abhishek--mandal', '', 'Abhishek ', 'Mandal', '0000-00-00', 1, 'abhishekmandal071@gmail.com', '7666622596', '', '60d4d5fc36fcc5997fce9634bfe26287', '', '', 0, '', '', '', '', '', '', 0, '', '', '', 0, 0, 0, '', '', '', '', '', '', 1, '', 0, 0, '', 1, 0, 0, 0, '', 1, 'Abhishek  Mandal', '', '', 0, NULL, NULL, '2021-07-18 11:55:18', NULL),
(387, '3SBT5Y76RK', 'aman-sodhi', '', 'aman', 'sodhi', '0000-00-00', 1, 'aman03sodhi@gmail.com', '7696911008', '', '345ab18077232cfc18fef73fce305cc3', '', '', 0, '', '', '', '', '', '', 0, '', '', '', 0, 0, 0, '', '', '', '', '', '', 1, '', 0, 0, '', 1, 0, 0, 0, '', 0, 'aman sodhi', '', '', 0, NULL, NULL, '2021-07-18 16:56:05', NULL),
(388, 'G1K1AW3P4R', 'arjun-kalepu', 'profile-pic-1627060840.jpg', 'Arjun', 'Kalepu', '1987-10-02', 1, 'arjun4k@gmail.com', '9966664613', '9885100885', '561f1aeef30f8ec81fba484a35b028ca', 'Hno 3-4-757/36,APHB ,first floor ,Plot No 1/A, Street No.12, beside shaymala devi womens college, Barkatpura, Hyderabad, Telangana 500027', '602', 36, '1', '500027', '', '', '', '', 0, '', '', '2,16,18,21,26', 2, 2500, 0, 'www.inkstreettattoos.com', 'https://www.facebook.com/arjun4m', 'https://www.instagram.com/inkstreettattoos_hyderabad', '', '', '', 3, '', 0, 0, '', 1, 0, 1, 1, '500', 1, 'Arjun Kalepu', '', '', 7, NULL, NULL, '2021-07-19 15:29:51', NULL),
(389, 'SK33BU90GM', 'anandraj-subramanian', '', 'AnandRaj', 'Subramanian', '0000-00-00', 1, 'andraj235@gmail.com', '9952982533', '', '9d20bb9f4df15ddd2cf16ed2f34e0c16', '', '', 0, '', '', '', '', '', '', 0, '', '', '', 0, 0, 0, '', '', '', '', '', '', 1, '', 0, 0, '', 1, 0, 0, 0, '', 1, 'AnandRaj Subramanian', '', '', 0, NULL, NULL, '2021-07-21 06:54:40', NULL),
(390, 'S8PAQ4G6F2', 'le-wolf--tattoos', '', 'Le-Wolf ', 'Tattoos ', '0000-00-00', 1, 'lewolftattos@gmail.com', '7305598718', '', '3573025f00b56c4f07ea2905b4c9d6f1', '', '', 0, '', '', '', '', '', '', 0, '', '', '', 0, 0, 0, '', '', '', '', '', '', 1, '', 0, 0, '', 1, 0, 0, 0, '', 1, 'Le-Wolf  Tattoos ', '', '', 0, NULL, NULL, '2021-07-21 10:50:15', NULL),
(391, 'VZW486JQ1K', 'jack-paul', '', 'jack', 'paul', '0000-00-00', 1, 'maps.apihyd@gmail.com', '9100935261', '', '55938c795c782671a9ccf30d3142b99e', '', '', 0, '', '', '', '', '', '', 0, '', '', '', 0, 0, 0, '', '', '', '', '', '', 1, '', 0, 0, '', 1, 0, 0, 0, '', 0, 'jack paul', '', '', 0, NULL, NULL, '2021-07-21 10:56:54', NULL),
(392, '66UHSMTJ14', 'dipesh--vadher', '', 'Dipesh ', 'Vadher', '0000-00-00', 1, 'electron.dipesh@icloud.com', '7433968559', '', '3ec8ddc08fba9da772e09f9c03335789', '', '', 0, '', '', '', '', '', '', 0, '', '', '', 0, 0, 0, '', '', '', '', '', '', 1, '', 0, 0, '', 1, 0, 0, 0, '', 1, 'Dipesh  Vadher', '', '', 0, NULL, NULL, '2021-07-21 18:27:01', NULL),
(393, 'A94QHRW95K', 'parul--chaturvedi', '', 'Parul ', 'Chaturvedi', '0000-00-00', 2, 'parulchaturvedi48@gmail.com', '9910556198', '', '1b3d247c69632f10f1b0c8f1012c8df0', '', '', 0, '', '', '', '', '', '', 0, '', '', '', 0, 0, 0, '', '', '', '', '', '', 1, '', 0, 0, '', 1, 0, 0, 0, '', 1, 'Parul  Chaturvedi', '', '', 0, NULL, NULL, '2021-07-22 10:52:53', NULL),
(394, 'FW35Z7BM1G', 'nikhil-mittu-nikhil-mittu', 'profile-pic-1627051868.jpg', 'Nikhil mittu', 'Nikhil mittu', '1995-04-06', 1, 'nikhilmittu06@gmail.com', '9704144610', '', '5e32250414260b2b2c76192b9c33436e', 'Ink street tattoos,barkathpura,', '602', 36, '1', '500027', 'I am nikhil.i like doing drawing s from my childhood,during my intermediate I got intrested in tattooing then I started searched about tattooing training then I get to know about about angels tattoo studio then I completed my training there I  joined ink street tattoo studio one of the best studio in hyderabad.if you people want neat and clean works book your appointment with me', '2015', 'Amin/angels tattoo studio Hyderabad', '', 2, '', '', '5,7,12,14,19', 1, 500, 1, '', 'https://www.facebook.com/nikhil.mittu.37', 'https://www.instagram.com/nikhilmittu', 'https://in.pinterest.com/nikhilmittu/', '', '', 3, '', 0, 0, '', 1, 0, 1, 1, '500', 1, 'Nikhil mittu Nikhil mittu', '', '', 7, NULL, NULL, '2021-07-23 14:13:45', NULL),
(395, 'KNAE30V6M1', 'nithin--cho2', 'profile-pic-1627052519.jpg', 'Nithin ', 'Cho2', '2021-07-23', 1, 'nithinchotu34876@gmail.com', '6303361094', '06303361094', '048daf503f010604d0cd0c072eff0fd2', '3-4-101/6 barkatpura', '602', 36, '1', '', 'My self Nitin when I was studying my intermediate I got interested in tattooing then I searched about tattoo studios in Hyderabad I got to know about ink Street tattoo studio Hyderabad,I joined there for training incomplete my training and they gave me job in their studio and I am completing my 2nd year tattooing field', '2018', 'Arjun/ink Street tattoos Hyderabad', '', 2, '', '', '5,7,10,12,14', 1, 500, 1, '', 'https://www.facebook.com/nithi.chotu.7', 'https://www.instagram.com/nithincho2', '', '', '', 3, '', 0, 0, '', 1, 0, 1, 1, '500', 1, 'Nithin  Cho2', '', '', 7, NULL, NULL, '2021-07-23 14:41:07', NULL),
(396, 'F91U10MLZJ', 'heera-roy', 'profile-pic-1627110190.jpg', 'Heera', 'Roy', '1970-01-01', 1, 'heeraroy98@gmail.com', '8372069224', '', '79bca8796f8b7d6e32ff2ccdaf19ee65', 'Falakata, station road', '593', 35, '1', '', '', '', '', '', 0, '', '', '3,9,13,16,18', 1, 500, 1, '', '', '', '', '', '', 3, '', 0, 0, 'Half sleeve in 5000, full sleeve tattoo in 10k', 1, 0, 1, 1, '1000', 1, 'Heera Roy', '', '', 5, NULL, NULL, '2021-07-24 06:57:37', NULL),
(397, 'RK3EG8F6W6', 'bishal--ghosh', 'profile-pic-1627112094.jpg', 'BISHAL ', 'GHOSH', '1994-12-24', 1, 'pureinktattooindia@gmail.com', '9706575700', '7002553050', '6e722c35176ec3911b78afda6d3019d5', 'VISHRANTI COMPLEX, RANGAGORA ROAD ,DURGABARI ,TINSUKIA, ASSAM', '44', 4, '1', '786125', 'PURE Ink Tattoo Studio is the top rated studio in Tinsukia Assam .\r\nWe are known for providing high quality hygiene standards and an amazing  Ink and tattoo designs By Artist : BISHAL GHOSH.        PURE Ink Tattoo Studio is the top rated studio in Tinsukia Assam .\r\nWe are known for providing high quality hygiene standards and an amazing  Ink and tattoo designs By Artist : BISHAL GHOSH', '2017', 'self', 'self', 3, '', '', '4,19,22,25,26', 1, 300, 0, 'https://www.google.com/search?q=pure+ink+tattoo+in+india&oq=pure&aqs=chrome.1.69i57j35i39j0i131i433j46i199i291i433j0i433.2196j0j4&client=ms-android-xiaomi-rev2&sourceid=chrome-mobile&ie=UTF-8', 'https://www.facebook.com/pureinktattooindia/', 'https://instagram.com/pureinktattooindia?utm_medium=copy_link', 'https://pin.it/6E55jND', 'https://youtube.com/channel/UCaikCnP88z-gCK7LQEsTZqg', '', 3, '', 0, 0, '', 1, 0, 0, 1, '', 1, 'BISHAL  GHOSH', '', '', 9, NULL, NULL, '2021-07-24 07:00:18', NULL),
(398, '4YTK3L97PR', 'love-kush', '', 'Love', 'Kush', '2003-09-23', 1, 'lovekush18605@gmail.com', '7838823923', '8076177781', 'c5b1c29a89e80c639ed49d46fe858bd5', 'Sec 29 hudda market opposite by carewell hospital  ', '159', 13, '1', '', '', '', '', '', 0, '', '', '', 0, 0, 0, '', 'https://www.facebook.com/lovely.samrty', 'instagram.com/loveinktattooz?igshid=1nbgqvw2ants8', 'https://pin.it/YIQobE0', 'https://youtube.com/channel/UC2bcS_G82OijYSbtPslp06Q', 'https://youtube.com/channel/UC2bcS_G82OijYSbtPslp06Q', 1, '', 0, 0, '', 1, 0, 0, 0, '', 1, 'Love Kush', '', '', 0, NULL, NULL, '2021-07-24 07:21:31', NULL),
(399, '4TW0LV9M5N', 'akhil--patel', '', 'Akhil ', 'Patel ', '1992-03-05', 1, 'relictattoosbyakhil@gmail.com', '9979710509', '', '54d10fed9690ad709c21497bda6c1cff', '201, Yogiraj Apartment, 45-B Nutan Bharat Society, opp pefeteria,near Baroda high school,Alkapuri ', '131', 12, '1', '', '', '', '', '', 0, '', '', '', 0, 0, 0, '', '', '', '', '', '', 1, '', 0, 0, '', 1, 0, 0, 0, '', 1, 'Akhil  Patel ', '', '', 0, NULL, NULL, '2021-07-24 08:47:08', NULL),
(400, '8RL46E5GMX', 'chinmay-sarmalkar', '', 'Chinmay', 'sarmalkar', '0000-00-00', 1, 'bodygraphicsbgt@gmail.com', '8779901212', '', 'dfb12bb74482a62e82ca50c463296fda', '', '', 0, '', '', '', '', '', '', 0, '', '', '', 0, 0, 0, '', '', '', '', '', '', 1, '', 0, 0, '', 1, 0, 0, 0, '', 1, 'Chinmay sarmalkar', '', '', 0, NULL, NULL, '2021-07-24 10:00:33', NULL),
(401, 'DHG9B9PL95', 'ramendra-tattoobaba', '', 'Ramendra', 'Tattoobaba', '0000-00-00', 1, 'ramendradoshi@gmail.com', '7727011412', '', '588645ccf145dd543b402468428b15a9', '', '', 0, '', '', '', '', '', '', 0, '', '', '', 0, 0, 0, '', '', '', '', '', '', 1, '', 0, 0, '', 1, 0, 0, 0, '', 1, 'Ramendra Tattoobaba', '', '', 0, NULL, NULL, '2021-07-24 11:06:45', NULL),
(402, 'Q1JY1L7E8Z', 'tamandeep--singh', '', 'tamandeep ', 'singh', '1998-01-22', 1, 'tamandhaliwal37@gmail.com', '9914031091', '', '37bab6a8d1e7322fccef0844502a476d', 'sector =19D chandigarh  dida tattoo studio', '762', 6, '1', '160019', '', '', '', '', 0, '', '', '', 0, 0, 0, '', '', '', '', '', '', 1, '', 0, 0, '', 1, 0, 0, 0, '', 1, 'tamandeep  singh', '', '', 0, NULL, NULL, '2021-07-24 14:59:03', NULL),
(403, 'H6SB51AZF4', 'dimpy-hb', '', 'DIMPY', 'HB', '1989-01-12', 1, 'devilindarkart@gmail.com', '9779900666', '9779900666', 'b1bb7f124643bbc903b4fb4af762cd30', 'SCO-20, 2nd floor, Sector-19D, Chandigarh  ', '762', 6, '1', '160047', '', '', '', '', 0, '', '', '', 0, 0, 0, '', 'https://www.facebook.com/harjinder.dimpy', 'https://instagram.com/dimpyhbtattoo?utm_medium=copy_link', '', '', '', 1, '', 0, 0, '', 1, 0, 0, 0, '', 1, 'DIMPY HB', '', '', 0, NULL, NULL, '2021-07-24 15:13:49', NULL),
(404, 'G9KC5WS47B', 'pardeep-dahiya', '', 'Pardeep', 'Dahiya', '0000-00-00', 1, 'pardeepdahiyas@gmail.com', '8814966096', '', '5d1439357569dd72506e681971353be0', '', '', 0, '', '', '', '', '', '', 0, '', '', '', 0, 0, 0, '', '', '', '', '', '', 1, '', 0, 0, '', 1, 0, 0, 0, '', 1, 'Pardeep Dahiya', '', '', 0, NULL, NULL, '2021-07-24 15:35:34', NULL),
(405, 'S7ACEL85D9', 'maddyzink--tattoos', '', 'MaddyZink ', 'Tattoos', '0000-00-00', 1, 'manindersingh1896@gmail.com', '9996122723', '', '07e2742f759fd7d3d8b04674410092dd', '', '', 0, '', '', '', '', '', '', 0, '', '', '', 0, 0, 0, '', '', '', '', '', '', 1, '', 0, 0, '', 1, 0, 0, 0, '', 1, 'MaddyZink  Tattoos', '', '', 0, NULL, NULL, '2021-07-24 16:53:30', NULL),
(406, '4HRJZ6K2F8', 'naval-sood', '', 'Naval', 'Sood', '0000-00-00', 1, 'sood1642@gmail.com', '6280202532', '', 'ea64b989e48b85ca0c91e90d6b1d9236', '', '', 0, '', '', '', '', '', '', 0, '', '', '', 0, 0, 0, '', '', '', '', '', '', 1, '', 0, 0, '', 1, 0, 0, 0, '', 1, 'Naval Sood', '', '', 0, NULL, NULL, '2021-07-25 08:43:30', NULL),
(407, 'R20Y9MZ1BX', 'deep-mardolkar', '', 'Deep', 'Mardolkar', '0000-00-00', 1, 'dpmardolkar@gmail.com', '9307855936', '', 'f384c2149836b2d1a77f33b56804a080', '', '', 0, '', '', '', '', '', '', 0, '', '', '', 0, 0, 0, '', '', '', '', '', '', 1, '', 0, 0, '', 1, 0, 0, 0, '', 1, 'Deep Mardolkar', '', '', 0, NULL, NULL, '2021-07-25 09:01:09', NULL),
(408, 'Q7A17GR6HT', 'ishwar--solanki', '', 'Ishwar ', 'Solanki', '0000-00-00', 1, 'issolanki92@gmail.com', '9602544030', '', '4d193776df84b5c0c4f2a36e882986cf', '', '', 0, '', '', '', '', '', '', 0, '', '', '', 0, 0, 0, '', '', '', '', '', '', 1, '', 0, 0, '', 1, 0, 0, 0, '', 1, 'Ishwar  Solanki', '', '', 0, NULL, NULL, '2021-07-25 09:33:02', NULL),
(409, 'NGS2DL383B', 'narendran-m', '', 'NARENDRAN', 'M', '0000-00-00', 1, 'kingcastletattoos@gmail.com', '9361099690', '', '33afb5e098c746942e34d8c06350bdd1', '', '', 0, '', '', '', '', '', '', 0, '', '', '', 0, 0, 0, '', '', '', '', '', '', 1, '', 0, 0, '', 1, 0, 0, 0, '', 1, 'NARENDRAN M', '', '', 0, NULL, NULL, '2021-07-25 16:26:33', NULL),
(410, '75Y20CNXMH', 'abhishek-kaushik', '', 'Abhishek', 'Kaushik', '0000-00-00', 1, 'sunnyrock003@gmail.com', '7837151037', '', '660fc5a00f3704812e05289fb9f27753', '', '', 0, '', '', '', '', '', '', 0, '', '', '', 0, 0, 0, '', '', '', '', '', '', 1, '', 0, 0, '', 1, 0, 0, 0, '', 1, 'Abhishek Kaushik', '', '', 0, NULL, NULL, '2021-07-26 04:40:20', NULL),
(411, '6UZLH010NR', 'sanju-inkz', '', 'Sanju', 'Inkz', '2021-09-21', 1, 'sanjuartistsanju@gmail.com', '9149089450', '9149089450', '3806c82a62438c00d4d133f867063a80', 'Ramganga Vihar Front of Shidhawali sports Shop Moradabad ', '120', 10, '1', '110001', '', '', '', '', 0, '', '', '', 0, 0, 0, '', 'https://www.facebook.com/shubham.upadhyay.37853734', 'https://instagram.com/theinkztattoostudio?utm_medium=copy_link', '', 'https://youtube.com/channel/UCWdZT8qeApbqZZme-s9ANdg', '', 1, '', 0, 0, '', 1, 0, 0, 0, '', 1, 'Sanju Inkz', '', '', 0, NULL, NULL, '2021-07-26 07:25:13', NULL),
(412, 'VE29WT0UA9', 'tamil--selvan', '', 'Tamil ', 'selvan', '2021-05-16', 1, 'sandy361596@gmail.com', '9080827114', '9840662540', 'ce661f72cc882b2966801f9d00660728', 'No:9 magizhampoo maligai mgr road nanganallur Chennai-61', '466', 31, '1', '600061', '', '', '', '', 0, '', '', '', 0, 0, 0, '', '', '', '', '', '', 1, '', 0, 0, '', 1, 0, 0, 0, '', 1, 'Tamil  selvan', '', '', 0, NULL, NULL, '2021-07-26 07:25:40', NULL),
(413, '3X65ACJ4FQ', 'tarun-arora', 'profile-pic-1629619780.JPG', 'Tarun', 'Arora', '1970-01-01', 1, 'tarunarora1255@gmail.com', '9855951502', '9855951502', 'ed4e7298b1f3f1a3e233e7385e788d85', 'zorba tattoo Above musa\'s Collection, laxman jhulla, market,', '736', 33, '1', '', '', '', '', '', 0, '', '', '', 0, 0, 0, 'https://zorba-tattoo-piercing.business.site/', '', '', '', '', '', 1, '', 0, 0, '', 1, 0, 0, 0, '', 1, 'Tarun Arora', '', '', 3, NULL, NULL, '2021-07-26 11:41:30', NULL),
(414, '6TN7Y5WJV3', 'gourav-sehgal', '', 'Gourav', 'Sehgal', '0000-00-00', 1, 'sehgalgaurav853@gmail.com', '9877321825', '', '00cd2ff45dab1768a98a792781fca3df', '', '', 0, '', '', '', '', '', '', 0, '', '', '', 0, 0, 0, '', '', '', '', '', '', 1, '', 0, 0, '', 1, 0, 0, 0, '', 1, 'Gourav Sehgal', '', '', 0, NULL, NULL, '2021-07-27 02:54:12', NULL),
(415, 'A46HSV1DB9', 'arunima-madan', '', 'Arunima', 'Madan', '0000-00-00', 2, 'madanarunima14@gmail.com', '9810707634', '', '3eb8598f85a158be7e500ef1fb019bad', '', '', 0, '', '', '', '', '', '', 0, '', '', '', 0, 0, 0, '', '', '', '', '', '', 1, '', 0, 0, '', 0, 0, 0, 0, '', 0, 'Arunima Madan', '', '', 0, NULL, NULL, '2021-07-27 05:32:31', NULL),
(416, 'JWXF23Q3V9', 'anmol-singh', 'profile-pic-1628588213.JPG', 'Anmol', 'Singh', '1970-01-01', 1, 'anmolsingh.as389@gmail.com', '8639251058', '', 'f2d3cefdfee82cd8ec8b136369df2a8c', 'hazari hotel, 13/1/565, Mangalhat Rd, Dilawar Gunj Colony', '602', 36, '1', '', 'My name is Anmol singh, I was born in 1998. Tattoo culture found me in 2015, that is when I decided this is what I want to do, to create art on skin not on just paper. In 2018 I opened my own tattoo studio, where I practiced tattoo artistry for 2 years. However, I felt that I had limited opportunities in the countryside.', '2018', 'Sunny Bhanushali', '', 3, '', '', '4,16,17,19,26', 1, 400, 1, '', 'https://www.facebook.com/anmolsingggh/', 'https://www.instagram.com/anmol.tattooss/', '', '', '', 3, '', 0, 0, '', 1, 0, 0, 2, '', 1, 'Anmol Singh', '', '', 8, NULL, NULL, '2021-07-27 05:43:15', NULL),
(417, 'MT8F26E5VC', 'jitsu-rai', '', 'Jitsu', 'Rai', '0000-00-00', 1, 'merodauko@gmail.com', '9862251811', '', '2b1216e2e1e6806c173281d53ff48367', '', '', 0, '', '', '', '', '', '', 0, '', '', '', 0, 0, 0, '', '', '', '', '', '', 1, '', 0, 0, '', 1, 0, 0, 0, '', 0, 'Jitsu Rai', '', '', 0, NULL, NULL, '2021-07-27 08:37:55', NULL),
(418, '07MHB4D1XE', 'jobin-jobin', '', 'Jobin', 'Jobin', '0000-00-00', 1, 'jobin123.mrmonk@gmail.com', '9207777296', '', 'd2a40d619677bb04d7ed1680aca14d21', '', '', 0, '', '', '', '', '', '', 0, '', '', '', 0, 0, 0, '', '', '', '', '', '', 1, '', 0, 0, '', 1, 0, 0, 0, '', 0, 'Jobin Jobin', '', '', 0, NULL, NULL, '2021-07-27 12:16:18', NULL),
(419, 'QNVJ283MB1', 'kamal-das-kasaragod', '', 'Kamal das', 'Kasaragod', '1997-06-21', 1, 'blackpearlksd@gmail.com', '9037279403', '9037279403', '77a88503291df9523e6eafb3cb6b7460', 'Blackpearl Tattoo & Art Studio, opposite Karntaka bank, \r\nCitycentre building, \r\nBank road', '250', 18, '1', '671121', '', '', '', '', 0, '', '', '', 0, 0, 0, 'https://instagram.com/blackpearl_tattoo_kasaragod?utm_medium=copy_link', '', 'https://instagram.com/blackpearl_tattoo_kasaragod?utm_medium=copy_link', '', '', '', 1, '', 0, 0, '', 1, 0, 0, 0, '', 1, 'Kamal das Kasaragod', '', '', 0, NULL, NULL, '2021-07-27 18:12:38', NULL),
(420, 'Q81S53REYC', 'karthik-raana--m', '', 'Karthik Raana ', 'M', '0000-00-00', 1, 'karthik02raana05@gmail.com', '9943311009', '', '54ffdfded187f4e6da6f74961ba08aae', '', '', 0, '', '', '', '', '', '', 0, '', '', '', 0, 0, 0, '', '', '', '', '', '', 1, '', 0, 0, '', 1, 0, 0, 0, '', 1, 'Karthik Raana  M', '', '', 2, NULL, NULL, '2021-07-27 18:20:34', NULL),
(421, 'PRLY4W48D2', 'shrishti-aggarwal-2', 'profile-pic-1627565428.jpg', 'Shrishti', 'Aggarwal', '1993-09-18', 2, 'cookingcouplet@gmail.com', '9703677722', '', '5203d03e63adc8bbd71b9b117a4846c3', 'Dhoot Time Residency', '772', 13, '1', '122102', 'Hi! I am a tattoo artist from Delhi specializing in portrait, realism, 3D, geometric, mandala, animal tattoo styles. I own a studio in Delhi, Gurugram and Noida by the name of Shrishti tattoo studio. I also teach tattooing to interested learners.\r\nVisit my studio to get inked from the best.', '2018', 'aliens,devils', 'bishop,chennyne', 1, 'deepika,anushka,priyanka chopra', '', '9,10,11,17,25', 1, 2000, 1, '', '', '', '', '', '', 3, '', 1800, 10, '5% off on any bill amount', 0, 0, 1, 1, '2000', 1, 'Shrishti Aggarwal', '', '', 0, NULL, NULL, '2021-07-29 13:01:07', NULL),
(422, '7WT0CX21QU', 'deepak-kabir', '', 'Deepak', 'Kabir', '0000-00-00', 1, 'karmatattooclub@gmail.com', '9599777184', '', '7ab7d2773302674daa583505a2a514a3', '', '', 0, '', '', '', '', '', '', 0, '', '', '', 0, 0, 0, '', '', '', '', '', '', 1, '', 0, 0, '', 1, 0, 0, 0, '', 1, 'Deepak Kabir', '', '', 0, NULL, NULL, '2021-07-29 15:52:44', NULL),
(423, 'FG4BQC48M4', 'avijit--saha', 'profile-pic-1627576726.jpg', 'Avijit ', 'Saha', '1990-05-02', 1, 'fdavijit@gmail.com', '0177666660', '', 'e980eb28c13d09ec6aa549b9e2923c33', 'Mirpur DOHS, Road 10, Avenue 3, House 719', '774', 37, '3', '', 'Avijit Saha is an aspiring and talented professional artist from Bangladesh, with a great passion for tattooing. He is the first Bangladeshi Tattoo artist, who is certified by one of the very first renown tattoo school in India ( Alien’s Tattoo School). He is also a top-notch Fashion designer and Stylist in the city. He started tattooing in the year 2016. His passion for tattooing is so infectious that people with no inclination to get inked go back with his art embedded in their body! In August 2017 it was a huge leap taken by him to open his tattoo studio in the city and as well in the poshest area. \r\n\r\nAvijit has experience with many tattoo styles, such as traditional Japanese, Realism, and black & gray. His dream is to traveling and tattooing people all over the world also he is trying to educate people of the city about tattooing in every way. He believes in staying “you can never stop growing and increasing your skills as an artist. Inactivity leads to laziness in one’s art. Therefore, I strive to actively seek out any and all opportunities to better myself and my skills as a tattoo artist.\r\n', '2016', 'Aliens Tattoo School', '', 1, 'Ishrat Zaheen Ahmed,Black Zang', '', '5,9,13,17,18', 2, 3000, 0, 'https://inkparktattoo.com', 'https://www.facebook.com/FDAvijit/', 'https://www.instagram.com/fdavijit_saha', '', 'https://www.youtube.com/InkParkTattooStudio', '', 3, '', 0, 0, '', 1, 1, 0, 2, '', 1, 'Avijit  Saha', '', '', 11, NULL, NULL, '2021-07-29 16:35:54', NULL),
(424, 'Y9ZE0SG2W1', 'rakesh-nalliboina', '', 'Rakesh', 'Nalliboina', '0000-00-00', 1, 'rakeshnalliboina@gmail.com', '9347179138', '', '790bf6117bfc81626d32c702f743ba21', '', '', 0, '', '', '', '', '', '', 0, '', '', '', 0, 0, 0, '', '', '', '', '', '', 1, '', 0, 0, '', 1, 0, 0, 0, '', 1, 'Rakesh Nalliboina', '', '', 0, NULL, NULL, '2021-07-30 03:31:40', NULL),
(425, 'Q0B3RZNF70', 'vikas-reddy--vikas', 'profile-pic-1627625381.jpg', 'Vikas Reddy ', 'Vikas', '1999-03-09', 1, 'vikasreddy9160@gmail.com', '9160700629', '9160700629', 'd3f474f0e6f1e116f22a01e5b640adbe', 'Medchal , Hyderabad', '602', 36, '1', '501401', '', '', '', '', 0, '', '', '2,16,18,21,26', 1, 500, 0, '', '', 'vikasreddy9160@gmail.com', '', '', '', 3, '', 0, 0, '', 1, 0, 1, 1, '200', 1, 'Vikas Reddy  Vikas', '', '', 4, NULL, NULL, '2021-07-30 05:11:56', NULL),
(426, 'N11SBJ7Z6U', 'suman-bhandari', '', 'Suman', 'Bhandari ', '0000-00-00', 1, 'sbinkofficial19@gmail.com', '7889372932', '', '3af50a4e53b978f9286724de8fc46040', '', '', 0, '', '', '', '', '', '', 0, '', '', '', 0, 0, 0, '', '', '', '', '', '', 1, '', 0, 0, '', 1, 0, 0, 0, '', 1, 'Suman Bhandari ', '', '', 0, NULL, NULL, '2021-07-30 15:34:26', NULL),
(427, 'EQY9J59HW3', 'deepak-m-c', 'profile-pic-1627747801.jpeg', 'Deepak', 'M C', '1995-05-26', 1, 'deepakips2026@gmail.com', '7907309744', '9633166238', '883f63ab50e2ccdd77fd8cb1f4360eb4', 'Moolayil (H) , Vellangallur P.0, Thrissur-680662 ,Kerala', '669', 18, '1', '680662', 'I’m a travelling tattoo artist from Kerala. D-art Tattoo is the brand which I nurtured to be established. My tattoo passion more lies into realistic and portrait tattoos. I would love to travel, explore and learn more and more on tattoos. I always preferred to do unique and customised tattoo designs. ', '2018', 'Jessie ( Verve tattoo Studio)', '', 3, '', '', '1,12,16,18,25', 1, 600, 0, '', 'www.facebook.com/deepakmc2026', 'www.instagram.com/d_art_tattoo_', '', '', '', 3, '', 0, 0, '', 1, 0, 0, 2, '', 1, 'Deepak M C', '', '', 9, NULL, NULL, '2021-07-31 14:14:34', NULL),
(428, 'BKS45W5A0F', 'hrishi-verma', '', 'Hrishi', 'Verma', '0000-00-00', 1, 'hrishiverma95@gmail.com', '7007236530', '', '9084adba104927762a2ad588d7bd1de1', '', '', 0, '', '', '', '', '', '', 0, '', '', '', 0, 0, 0, '', '', '', '', '', '', 1, '', 0, 0, '', 1, 0, 0, 0, '', 1, 'Hrishi Verma', '', '', 0, NULL, NULL, '2021-07-31 16:12:20', NULL),
(429, 'S5G3YBQR48', 'aaditya--sharma', 'profile-pic-1627754956.jpg', 'Aaditya ', 'Sharma', '1993-11-17', 1, 'bikanertattoo@gmail.com', '7412944699', '9116911932', '684903aa50c45494124431d91a812141', 'Skinbuzz Tattooz\r\nShop No. LG 04 ,underground Heeralal mall,opp bikaner railway station.', '436', 29, '1', '334001', 'Myself Aaditya  sharma ,I am 28 year old. \r\nI am Basically from Sri Ganganagar ,Rajasthan.\r\nI started tattooing in 2016,from chandigarh\r\nI am Self taught artist ,\r\nI am Specialised in black n grey art work ,realism and portraits, can do all types of tattoos, recently Completed certified Advance tattoo course  from ALIENS TATTOO SCHOOL, Mumbai, In august 2020. I have my studio  in Bikaner which is named as SKINBUZZ TATTOOZ.  \r\nWe believe that \r\n(Every Tattoo Tells A story)\r\n', '2016', 'Aliens Tattoo school,Mumbai', '', 2, '', '', '13,16,17,18,26', 1, 600, 0, 'www.bikanertattoo.com', '', '', '', '', '', 3, '', 0, 0, '', 1, 0, 1, 2, '10000', 1, 'Aaditya  Sharma', '', '', 7, NULL, NULL, '2021-07-31 17:55:28', NULL),
(430, 'H9M9UF6QS8', 'shiva-tattoo', '', 'shiva', 'tattoo', '0000-00-00', 1, 'shivatattoo07@gmail.com', '9567727906', '', '08591dafe74a3d9e1c5b2746bfae072d', '', '', 0, '', '', '', '', '', '', 0, '', '', '', 0, 0, 0, '', '', '', '', '', '', 1, '', 0, 0, '', 1, 0, 0, 0, '', 1, 'shiva tattoo', '', '', 0, NULL, NULL, '2021-07-31 19:30:36', NULL),
(431, 'L67DZN31AE', 'bishal-chandra--roy', '', 'Bishal chandra ', 'Roy', '0000-00-00', 1, 'bishalroy514@gmail.com', '1636512188', '', 'cf264313934b0f9dc468d4bf28fca8d1', '', '', 0, '', '', '', '', '', '', 0, '', '', '', 0, 0, 0, '', '', '', '', '', '', 1, '', 0, 0, '', 1, 0, 0, 0, '', 0, 'Bishal chandra  Roy', '', '', 0, NULL, NULL, '2021-08-01 17:24:12', NULL),
(432, '08JPC3G0YS', 'bishal-roy', 'profile-pic-1627842821.jpg', 'Bishal', 'Roy', '2030-11-01', 1, 'roybishal674@gmail.com', '1636512188', '01308427262', 'cf264313934b0f9dc468d4bf28fca8d1', 'Keranigonj 1310', '774', 37, '3', '', 'Bishal chandra roy is an aspiring and talented professional artist from Bangladesh, with a great passion for tattooing. He is the first Bangladeshi Tattoo artist, who is certified by one of the very first renown tattoo school in bangladesh ( inkpark tattoo studio).  He started tattooing in the year 2018. His passion for tattooing is so infectious that people with no inclination to get inked go back with his art embedded in their body! In August 2020 it was a huge leap taken by him to open his tattoo studio in the city and as well in the poshest area. Bishal has experience with many tattoo styles, such as traditional Japanese, Realism, and black & gray. His dream is to traveling and tattooing people all over the world also he is trying to educate people of the city about tattooing in every way. He believes in staying “you can never stop growing and increasing your skills as an artist. Inactivity leads to laziness in one’s art. Therefore, I strive to actively seek out any and all opportunities to better myself and my skills as a tattoo artist.', '2019', 'Inkdrop', 'Inkdrop', 1, 'Chandu sarker', '', '', 0, 0, 0, '', 'https://www.facebook.com/roy.babu.1840', 'https://www.instagram.com/invites/contact/?i=zf712o6vjqgk&utm_content=9sf59b2', '', '', '', 2, '', 0, 0, '', 1, 0, 0, 0, '', 1, 'Bishal Roy', '', '', 4, NULL, NULL, '2021-08-01 18:11:42', NULL),
(433, '8AJ43BFR2U', 'deepak-tattoo', 'profile-pic-1627902294.jpeg', 'Deepak', 'Tattoo ', '1996-05-10', 1, 'clmdeepak@gmail.co m', '9094155130', '9092314360', '7c72b4693228cc2f98a8c2ec258c0d2f', 'No 123, dr.ambethkar anger , 1st cross street,Adambakkam, Chennai - 600088', '466', 31, '1', '600088', 'We’ll traind in realism art and I have 4 years of experience in this field and classes are too taken from there student prospective and we have some cool atmosphere over here and feel free to come and consult with us and am so proud to be a tattoo artist', '2017', '', '', 2, '', '', '4,10,14,16,18', 1, 600, 0, '', '', 'https://instagram.com/deepak_tatoo?utm_medium=copy_link', '', '', '', 3, '', 0, 0, '', 1, 0, 1, 2, '1500', 1, 'Deepak Tattoo ', '', '', 6, NULL, NULL, '2021-08-02 10:41:35', NULL),
(434, '5R6ACQVP35', 'micky--kavithya', 'profile-pic-1627990787.jpeg', 'Micky ', 'Kavithya ', '1970-01-01', 1, 'luvkavithiya123@gmail.com', '9763720852', '', '50d13f3857d066e25c4755f67c218aa0', 'opposite The Ronil Royal Resort, Baga, Goa 403516', '649', 11, '1', '', 'My name is micky Kavithiya I’m professional tattoo artist I have  5year experience in tattooing  and I’m from Goa I work in Shivavalley tattoo studio my favorite subject to tattoo are Miniature, Black & Gray , Realism, Portrait, mandala, dot work ,ColourTattoo & customized art work  I did take a professional training initially but since this art is pretty vast and will always get you going you learn major things while being on your journey and so did I. Standing tall after more than a decade in this profession I have now created some magnificent art pieces that have satisfied my customers to a good level. I feel blessed today to still be associated with my clients I have rendered services to around the time I started. Trust and Hard Work builds it all.', '2016', 'Self thought artist ', '', 3, '', '', '1,7,16,18,23', 1, 700, 0, '', 'https://m.facebook.com/micky10kavithiya/', 'https://www.instagram.com/micky10kavithiya/', '', '', '', 3, '', 0, 0, '', 1, 0, 1, 2, '500', 1, 'Micky  Kavithya ', '', '', 8, NULL, NULL, '2021-08-03 07:00:46', NULL),
(435, '750U0KZMCA', 'rhett-cameron', '', 'Rhett', 'Cameron', '1988-01-25', 1, 'rhett.c.cameron@gmail.com', '8420219132', '8582991660', '2d9748a28ff95d73f8ab97867af12ac3', '26 Sarat Bose road', '600', 35, '1', '700019', '\r\nTime is not an issue for me..you don\'t have pick one out from a catalog or get one off the internet...the choice is still yours but for those who constantly ponder about what to get..I help you design and give you a tattoo that is made only for you and not a replica, you don\'t have pick one out from a catalog or get one off the internet...the choice is still yours but for those who constantly ponder about what to get..I help you design and give you a tattoo that is made only for you', '2019', '', '', 3, '', '', '3,5,7,9,26', 1, 300, 0, '', 'facebook.com/rhettcameron', 'instagram.com/rhettcameron', '', '', '', 3, '', 0, 0, '', 1, 0, 1, 2, '2000', 1, 'Rhett Cameron', '', '', 5, NULL, NULL, '2021-08-03 08:55:53', NULL),
(436, '8VKR2G94TD', 'mohit--verma', '', 'Mohit ', 'Verma', '0000-00-00', 1, 'mohit.mhow@gmail.com', '8989548401', '', '1b09a7b58b55157403ffed742d6898b3', '', '', 0, '', '', '', '', '', '', 0, '', '', '', 0, 0, 0, '', '', '', '', '', '', 1, '', 0, 0, '', 1, 0, 0, 0, '', 0, 'Mohit  Verma', '', '', 0, NULL, NULL, '2021-08-06 11:44:17', NULL),
(437, '3LBS21TRF8', 'allan--f-gois', 'profile-pic-1628346066.jpeg', 'Allan ', 'F Gois', '1994-09-15', 1, '123allangois@gmail.com', '9833065209', '', 'cf98dab2a8a3f46135e97cba1506d33f', 'A-13, lubin apartment, tank road, Domnic colony, orlem, malad west', '672', 21, '1', '400064', 'My name is Allan Gois, one of the senior tattoo artists at Aliens Tattoo India. I have been tattooing since the last 6 years.\r\nI specialize in realistic and hyperealtic tattoos which are mainly based on Indian mythology. I also enjoy doing colour tattoos, specially the abstract watercolour tattoos. \r\n…', '2014', 'Aliens Tattoo School', '', 1, 'Hardik Pandya, ishan Kishan', '', '2,16,18,19,26', 2, 12000, 0, 'https://www.alienstattoo.com/tattoos-by-allan-gois', '', 'https://instagram.com/allan_f_gois?utm_medium=copy_link', '', 'https://youtube.com/channel/UC6Z2GfQVGSTeWWRDqBcrtFg', '', 3, '', 0, 0, '', 1, 0, 0, 2, '', 1, 'Allan  F Gois', '', '', 6, NULL, NULL, '2021-08-07 14:00:19', NULL),
(438, 'V1TG65KP1E', 'micky10kavithiya--kavithiya', '', 'Micky10kavithiya ', 'Kavithiya ', '0000-00-00', 1, 'luvkavithiya123@gmail.con', '9763720852', '', '15dd3295e789f243a66501f1ddeee7ff', '', '', 0, '', '', '', '', '', '', 0, '', '', '', 0, 0, 0, '', '', '', '', '', '', 1, '', 0, 0, '', 0, 0, 0, 0, '', 1, 'Micky10kavithiya  Kavithiya ', '', '', 0, NULL, NULL, '2021-08-09 10:37:37', NULL),
(439, 'A4B3U4Z9TN', 'dipti-chaurasiya-1', 'profile-pic-1628617467.jpeg', 'Dipti', 'Chaurasiya ', '1998-04-25', 2, 'diptichaurasiya25@gmail.com', '8898078128', '', '4acffdadc686199bdae71a1ba0d6fdbc', 'B-203,Saraswati Sadan no2,navghar rd,bhayander east,thane-401105', '672', 21, '1', '', 'Love to do Black and grey Realism tattoos,color tattoos as well.Multi award winner.love to explore creative designs.Leading a happy tattooing world.Never give up attitude helped out me the most.My artwork speaks louder than me.As I am from non art background,but when it comes to tattooing;there is no looking back then.', '2016', 'Lucky Solanki/Sunny Bhanushali/Allan Gois', '', 1, 'Pranav Chandran ,Rasika Sunil ', '', '2,11,16,18,23', 2, 6000, 0, 'www.alienstattoo.com', 'https://www.facebook.com/profile.php?id=100005962336615', 'https://instagram.com/dipti_chaurasiya?utm_medium=copy_link', '', '', '', 3, '', 0, 0, '', 1, 0, 1, 2, '10000', 1, 'Dipti Chaurasiya ', '', '', 8, NULL, NULL, '2021-08-10 17:41:27', NULL),
(440, '7MD6WQ9CP8', 'ratnesh-shinde', '', 'Ratnesh', 'Shinde', '0000-00-00', 1, 'ratzbruzo21@gmail.com', '9967462178', '', 'cced13a6ffae81e59c9665ddd1ad5ed4', '', '', 0, '', '', '', '', '', '', 0, '', '', '', 0, 0, 0, '', '', '', '', '', '', 1, '', 0, 0, '', 1, 0, 0, 0, '', 1, 'Ratnesh Shinde', '', '', 0, NULL, NULL, '2021-08-11 11:24:44', NULL),
(441, 'LGP1X6CA33', 'macho-tattoos', '', 'Macho', 'Tattoos', '0000-00-00', 1, 'machotattoos0919@gmail.com', '8074947211', '', '9a46bbbdd021c50b525c1a972b5a0f64', '', '', 0, '', '', '', '', '', '', 0, '', '', '', 0, 0, 0, '', '', '', '', '', '', 1, '', 0, 0, '', 1, 0, 0, 0, '', 1, 'Macho Tattoos', '', '', 0, NULL, NULL, '2021-08-11 11:30:25', NULL),
(442, 'FEZ2HJG421', 'sagar-chaudhary', '', 'Sagar', 'Chaudhary', '0000-00-00', 1, 'artist.sagarchaudhary@gmail.com', '9326485105', '', '175f99200945bcae80543c2c54f17689', '', '', 0, '', '', '', '', '', '', 0, '', '', '', 0, 0, 0, '', '', '', '', '', '', 1, '', 0, 0, '', 1, 0, 0, 0, '', 1, 'Sagar Chaudhary', '', '', 0, NULL, NULL, '2021-08-15 16:22:40', NULL),
(443, '0XFNT2QD30', 'debjyoti-ghosh', 'profile-pic-1629052327.jpg', 'Debjyoti', 'Ghosh', '1997-02-02', 1, 'debjyotighosh0202@gmail.com', '8343024677', '8391835997', '2a45ea0f0af6476cd51ac207e2331f0f', 'bhyabla kalibari, basirhat, 24pgs north, west bengal, India', '589', 35, '1', '743422', 'For as long as I can remember, I\'ve been a huge fan of art. My first art teacher introduced me to fine arts. Since then, I\'ve tried to learn more about art on my own, which is how I discovered tattooing. I was fascinated by the subject, so I decided to get a tattoo. At the age of 16, I saved up my pocket money and got a tattoo on my right arm from lizard\'s skin tattoos in Kolkata, and I was so taken with the experience that I decided to pursue a career as a tattoo artist. Later in life, I became disoriented for a time. I was running my family\'s business, and it was becoming quite stressful for me, so I decided to give tattooing a try. After some research, I traveled to Mumbai in December of 2020 to attend Aliens Tattoo School, and that\'s when my adventure as a tattoo artist began.\r\nMy goal is to give individuals tattoos that have a huge positive impact on their lives, much like a tattoo changed mine.', '2020', 'Aliens Tattoo School', '', 2, '', '', '1,2,13,16,18', 1, 500, 0, '', 'https://www.facebook.com/Debjyoti-Ghosh-107145148201232', 'https://www.instagram.com/2_debjyoti_2/', '', '', '', 3, '', 0, 0, '', 1, 0, 0, 2, '', 1, 'Debjyoti Ghosh', '', '', 6, NULL, NULL, '2021-08-15 16:38:52', NULL),
(444, 'GEX82V5US7', 'swapnali-khot', '', 'Swapnali', 'Khot', '0000-00-00', 2, 'swapnalivmohite94@gmail.com', '7972875178', '', 'ad3840a5e34475bf7cbf281d1cbc5d5d', '', '', 0, '', '', '', '', '', '', 0, '', '', '', 0, 0, 0, '', '', '', '', '', '', 1, '', 0, 0, '', 1, 0, 0, 0, '', 1, 'Swapnali Khot', '', '', 0, NULL, NULL, '2021-08-15 17:34:07', NULL),
(445, '01CFD3GNE2', 'mubashir--bashir--beigh', 'profile-pic-1629054429.jpg', 'Mubashir  Bashir ', 'Beigh', '0000-00-00', 1, 'mubiistattoostudio@gmail.com', '7006695099', '', '61f40044c61ae4a3f9f65841c5be83ad', '', '', 0, '', '', '', '', '', '', 0, '', '', '', 0, 0, 0, '', '', '', '', '', '', 1, '', 0, 0, '', 1, 0, 0, 0, '', 1, 'Mubashir  Bashir  Beigh', '', '', 1, NULL, NULL, '2021-08-15 19:03:05', NULL),
(446, 'Y7X7F4AGV0', 'venky-tattooz', '', 'venky', 'tattooz', '0000-00-00', 1, 'venkateshpatil2892@gmail.com', '8147275397', '', '42c6f8e49632da41e211bf466547ecda', '', '', 0, '', '', '', '', '', '', 0, '', '', '', 0, 0, 0, '', '', '', '', '', '', 1, '', 0, 0, '', 1, 0, 0, 0, '', 1, 'venky tattooz', '', '', 0, NULL, NULL, '2021-08-16 02:54:28', NULL),
(447, 'Z8FD761CAY', 'agni-bhuva', '', 'Agni', 'Bhuva', '0000-00-00', 1, 'agnibhuva@gmail.com', '8106036565', '', '944b7548eab22221ea52c5a99f22d83c', '', '', 0, '', '', '', '', '', '', 0, '', '', '', 0, 0, 0, '', '', '', '', '', '', 1, '', 0, 0, '', 1, 0, 0, 0, '', 1, 'Agni Bhuva', '', '', 0, NULL, NULL, '2021-08-16 05:37:16', NULL),
(448, 'E7MGPF98L8', 'gourav-soni', '', 'gourav', 'soni', '0000-00-00', 1, 'gouravsoni2929.gs@gmail.com', '9729291229', '', '259aa1097326aadc9ee2031595c0a5b6', '', '', 0, '', '', '', '', '', '', 0, '', '', '', 0, 0, 0, '', '', '', '', '', '', 1, '', 0, 0, '', 1, 0, 0, 0, '', 1, 'gourav soni', '', '', 0, NULL, NULL, '2021-08-16 05:51:44', NULL),
(449, '2LZ2RX9Y4C', 'rishikesh--cs', '', 'Rishikesh ', 'Cs', '0000-00-00', 1, 'rktittu368@gmail.com', '8428198980', '', '39601a75b5ea2c6dfa2f280ce9f409ea', '', '', 0, '', '', '', '', '', '', 0, '', '', '', 0, 0, 0, '', '', '', '', '', '', 1, '', 0, 0, '', 1, 0, 0, 0, '', 1, 'Rishikesh  Cs', '', '', 0, NULL, NULL, '2021-08-16 07:23:52', NULL),
(450, 'UT3W18PX4Q', 'sahil--vajantri', '', 'Sahil ', 'Vajantri ', '0000-00-00', 1, 'sahilwajantri101@gmail.com', '7208193521', '', '5163329a46483f2c8b45ea8e154ca8b4', '', '', 0, '', '', '', '', '', '', 0, '', '', '', 0, 0, 0, '', '', '', '', '', '', 1, '', 0, 0, '', 1, 0, 0, 0, '', 1, 'Sahil  Vajantri ', '', '', 0, NULL, NULL, '2021-08-16 08:36:48', NULL),
(451, 'X6281LMFSD', 'prakhar-verma', '', 'Prakhar', 'Verma', '0000-00-00', 1, 'prakharverma2122@gmail.com', '8587962449', '', '684f952eba9818d31f6dcfe0d96720d6', '', '', 0, '', '', '', '', '', '', 0, '', '', '', 0, 0, 0, '', '', '', '', '', '', 1, '', 0, 0, '', 1, 0, 0, 0, '', 1, 'Prakhar Verma', '', '', 0, NULL, NULL, '2021-08-16 09:00:27', NULL),
(452, '2NPQX9R9Z2', 'prince-ramteke', '', 'Prince', 'Ramteke', '0000-00-00', 1, 'p654948@gmail.com', '8806361231', '', '63b3626e153d98f4ff5fb9eba7125b6f', '', '', 0, '', '', '', '', '', '', 0, '', '', '', 0, 0, 0, '', '', '', '', '', '', 1, '', 0, 0, '', 1, 0, 0, 0, '', 1, 'Prince Ramteke', '', '', 0, NULL, NULL, '2021-08-16 12:01:27', NULL),
(453, '69PZD41GEV', 'piyush-kumar', '', 'Piyush', 'Kumar', '0000-00-00', 1, 'indianartist9442@gmail.com', '9871332335', '', '52e52a3e9e687900d69f083b8eae0cc7', '', '', 0, '', '', '', '', '', '', 0, '', '', '', 0, 0, 0, '', '', '', '', '', '', 1, '', 0, 0, '', 1, 0, 0, 0, '', 1, 'Piyush Kumar', '', '', 0, NULL, NULL, '2021-08-16 15:01:03', NULL),
(454, 'JW8HKLV482', 'parvez-shaikh', '', 'parvez', 'shaikh', '0000-00-00', 1, 'parvezshaikh1414@gmail.com', '9967980556', '', '074a916cf03741cdd7a04a9f22178845', '', '', 0, '', '', '', '', '', '', 0, '', '', '', 0, 0, 0, '', '', '', '', '', '', 1, '', 0, 0, '', 1, 0, 0, 0, '', 1, 'parvez shaikh', '', '', 0, NULL, NULL, '2021-08-16 17:50:05', NULL),
(455, '0XEF5Q7ZA3', 'monica-m', '', 'Monica', 'M', '0000-00-00', 2, 'monamonu78@gmail.com', '8904293401', '', 'c6d30feca9c79424dc8d445f995c8a6d', '', '', 0, '', '', '', '', '', '', 0, '', '', '', 0, 0, 0, '', '', '', '', '', '', 1, '', 0, 0, '', 0, 0, 0, 0, '', 0, 'Monica M', '', '', 0, NULL, NULL, '2021-08-18 09:25:43', NULL),
(456, '58Z8JYGN0C', 'monica-m-1', 'profile-pic-1629303969.jpeg', 'Monica', 'M', '1970-01-01', 2, 'monamonu@gmail.com', '8553162785', '', 'c6d30feca9c79424dc8d445f995c8a6d', 'Bangalore', '660', 17, '1', '', '', '', '', '', 0, '', '', '5,7,10,11,12', 1, 0, 0, '', '', 'https://instagram.com/m_o_n_i_c_a_._a_r_t_i_s_t', '', '', '', 3, '', 0, 0, '', 1, 0, 0, 1, '', 1, 'Monica M', '', '', 3, NULL, NULL, '2021-08-18 15:02:07', NULL),
(457, 'XVJ491U6SW', 'john-tattooz', 'profile-pic-1629375494.jpg', 'John', 'Tattooz', '0000-00-00', 1, 'johntattoo8755@gmail.com', '8755892777', '', 'a948326d81e37b96fac162cbb75dc2b2', '', '', 0, '', '', '', '', '', '', 0, '', '', '', 0, 0, 0, '', '', '', '', '', '', 1, '', 0, 0, '', 1, 0, 0, 0, '', 1, 'John Tattooz', '', '', 1, NULL, NULL, '2021-08-19 07:16:23', NULL),
(458, 'Y0RQX99H8N', 'harsh-sahare', '', 'Harsh', 'Sahare', '0000-00-00', 1, 'harsh.sahare@gmail.com', '6263677976', '', '1b2bf31c0db4e5201707e2c84d71f190', '', '', 0, '', '', '', '', '', '', 0, '', '', '', 0, 0, 0, '', '', '', '', '', '', 1, '', 0, 0, '', 1, 0, 0, 0, '', 1, 'Harsh Sahare', '', '', 0, NULL, NULL, '2021-08-20 07:01:28', NULL),
(459, '3EA53SK3YX', 'sumanta-d-dasgupta', 'profile-pic-1629454465.jpeg', 'Sumanta', 'Dasgupta', '1995-12-15', 1, 'dipankardasgupa2018@gmail.com', '9382196743', '8116027888', '91842be1cd4511c52f5583ab2e921bb9', 'Burdwan, Kalnagate.', '592', 35, '1', '713103', 'I\'m Ah Self Tought Tattoo Artist.. When I Started Tattooing There was no one who Help Me Out of This. Tattooing Isn\'t Joke Right!\r\nBecause of Skin is Priceless Thing You Can\'t Ruin Others Skin , If You can\'t do Tattooing. Thats Why Everyone Should Get Proper Training Of Tattoo Arts.', '2017', 'Mr. Avik Paul', '', 2, '', '', '5,7,10,14,17,18,22,23,26', 1, 1000, 0, '', '', '', '', '', '', 3, '', 0, 0, '', 1, 0, 1, 2, '', 1, 'Sumanta D Dasgupta', '', '', 7, NULL, NULL, '2021-08-20 08:22:30', NULL),
(460, 'Z3QSG32EH1', 'aki-tarp', 'profile-pic-1629460960.jpeg', 'Aki', 'Taro ', '1997-01-06', 2, 'akansha654456@gmail.con', '7827411923', '', 'c3e3bd6f49ce3d5342627adf5f93e219', 'Mahaveer enclave Palam Dabri marg ', '773', 10, '1', '', 'Hello I’m Aki from Darjeeling and I’ve done my tattoo apprenticeship from pigmented tattoos and now I’m a professional tattoo artist. My art style is dark anime and mix of Japanese style and I’m trying to work on that and make it better, I’ve worked with rebel ink also and since pandemic happened I’m trying my best to learn and grow ', '2019', 'Pigmented tattoos ', '', 2, '', '', '9', 1, 1500, 0, '', 'https://www.facebook.com/akansha.shoun.3', 'https://instagram.com/ink.you.and.me?r=nametag', '', '', '', 3, '', 0, 0, '', 1, 0, 1, 2, '500', 1, 'Aki Tarp ', '', '', 7, NULL, NULL, '2021-08-20 11:47:35', NULL),
(461, 'XGLR4A309T', 'aki-taro', '', 'Aki', 'Taro', '0000-00-00', 2, 'akansha654456@gmail.com', '7827411923', '', 'c3e3bd6f49ce3d5342627adf5f93e219', '', '', 0, '', '', '', '', '', '', 0, '', '', '', 0, 0, 0, '', '', '', '', '', '', 1, '', 0, 0, '', 0, 0, 0, 0, '', 1, 'Aki Taro', '', '', 0, NULL, NULL, '2021-08-20 15:30:17', NULL),
(462, '7WBK4A3R4X', 'rakesh--tupkar', '', 'Rakesh ', 'Tupkar', '0000-00-00', 1, 'tupkarrakeshtupkar@gmila.com', '9822163891', '', '43a93fd07d8590109a6480591426d4db', '', '', 0, '', '', '', '', '', '', 0, '', '', '', 0, 0, 0, '', '', '', '', '', '', 1, '', 0, 0, '', 1, 0, 0, 0, '', 1, 'Rakesh  Tupkar', '', '', 0, NULL, NULL, '2021-08-20 17:47:43', NULL),
(463, '3U1NFZ9S6Y', 'danish-ahmed', 'profile-pic-1629691730.jpg', 'Danish', 'Ahmed', '1996-09-23', 1, 'danishtattooz10@gmail.com', '9779778179', '', '317d6d0ca8e0795823d8c2897960b20a', 'SCO-6,Ground Floor,Sector-10', '166', 13, '1', '134109', 'Danish Ahmed\r\n\r\nFounder of Danish Tattooz House\r\n\r\nTalk about pure young talent and Danish’s work will blow your mind. From dot-work tattoos, portrait tattoos, realism to new school tattoos, Danish has a portfolio that’s too diverse and exquisite for his age. More than a decade’s experience, Danish has been delivering over 96% of positive happy clients. ', '2013', '', '', 1, 'Pawandeep Rajan,Simran Chaudhary', '', '5,10,18,19,26', 1, 1500, 0, 'www.danishtattoozhouse.com', 'https://www.facebook.com/Danishtattoopkl/', 'https://www.instagram.com/danishtattoozhouse/', 'https://in.pinterest.com/danishtattoo/_created/', 'https://www.youtube.com/c/DanishTattoozHousePanchkula', '', 3, '', 0, 0, '', 1, 0, 0, 1, '', 1, 'Danish Ahmed', '', '', 7, NULL, NULL, '2021-08-23 04:01:27', NULL),
(464, 'GUP9YZ891J', 'dixit-samaal-1', 'profile-pic-1629789045.jpg', 'Dixit', 'Samaal', '1996-08-02', 1, 'dixitsaaal096@gmail.com', '9574752896', '8849787348', 'e662e66e22ed2a7a053c82087e7ecd8c', 'Dixy\'s tattoo art studioNear unjha nagar palika,Gandhi chowk', '137', 12, '1', '384170', 'Hello...my name is dixit samaal ..I have been tattooing since 2014 .\r\n  I specialise in black and grey tattoos and also customisation work..if you want a great art and great design please visit our studio personally .I m sure you will be happy..\r\nSpread art and love..\r\n  We have a nice environment in our studio.very good caring staff with lovely art forms.', '2014', '', '', 2, '', '', '2,3,4,5,7,10,14,16,19,21,22,23,24,26', 1, 400, 0, '', 'https://www.facebook.com/dixit.darji.58', 'https://www.instagram.com/dixys_tattoos_art_studio', 'www.pinterest.com/dixit1745', 'https://www.youtube.com/c/Dixytattooartstudio', '', 3, '', 0, 0, '', 1, 0, 1, 1, '', 1, 'Dixit Samaal', '', '', 6, NULL, NULL, '2021-08-24 06:28:51', NULL);

--
-- Triggers `adv_artist`
--
DROP TRIGGER IF EXISTS `artist_ref_code`;
DELIMITER $$
CREATE TRIGGER `artist_ref_code` AFTER INSERT ON `adv_artist` FOR EACH ROW INSERT INTO adv_ref_code SET ref_code = NEW.code, name=NEW.fname, type=1
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `adv_attributes`
--

DROP TABLE IF EXISTS `adv_attributes`;
CREATE TABLE IF NOT EXISTS `adv_attributes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `value` varchar(100) NOT NULL,
  `order` int(11) NOT NULL,
  `att_group_id` int(11) NOT NULL DEFAULT '1',
  `status` int(11) NOT NULL DEFAULT '0',
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `adv_attribute_group`
--

DROP TABLE IF EXISTS `adv_attribute_group`;
CREATE TABLE IF NOT EXISTS `adv_attribute_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(200) NOT NULL,
  `public_name` varchar(200) NOT NULL,
  `status` int(11) NOT NULL DEFAULT '0',
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `adv_bank_master`
--

DROP TABLE IF EXISTS `adv_bank_master`;
CREATE TABLE IF NOT EXISTS `adv_bank_master` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `bank_name` varchar(250) NOT NULL,
  `ifsc_code` varchar(250) NOT NULL,
  `branch` varchar(1000) NOT NULL,
  `status` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=145 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `adv_bank_master`
--

INSERT INTO `adv_bank_master` (`id`, `bank_name`, `ifsc_code`, `branch`, `status`) VALUES
(1, 'Axis Bank Ltd.', '', '', 1),
(2, 'Bandhan Bank Ltd.', '', '', 1),
(3, 'CSB Bank Limited', '', '', 1),
(4, 'City Union Bank Ltd.', '', '', 1),
(5, 'DCB Bank Ltd.', '', '', 1),
(6, 'Dhanlaxmi Bank Ltd.', '', '', 1),
(8, 'HDFC Bank Ltd.', '', '', 1),
(9, 'ICICI Bank Ltd', '', '', 1),
(10, 'Induslnd Bank Ltd.', '', '', 1),
(11, 'IDFC FIRST Bank Limited', '', '', 1),
(12, 'Jammu & Kashmir Bank Ltd.', '', '', 1),
(13, 'Karnataka Bank Ltd.', '', '', 1),
(14, 'Karur Vysya Bank Ltd.', '', '', 1),
(15, 'Kotak Mahindra Bank Ltd.', '', '', 1),
(16, 'Lakshmi Vilas Bank Ltd.', '', '', 1),
(17, 'Nainital Bank Ltd.', '', '', 1),
(18, 'RBL Bank Ltd.', '', '', 1),
(19, 'South Indian Bank Ltd.', '', '', 1),
(20, 'Tamilnad Mercantile Bank Ltd.', '', '', 1),
(21, 'YES Bank Ltd.', '', '', 1),
(22, 'IDBI Bank Limited', '', '', 1),
(23, 'Australia and New Zealand Banking Group Ltd.', '', '', 1),
(24, 'National Australia Bank', '', '', 1),
(25, 'Westpac Banking Corporation', '', '', 1),
(26, 'Bank of Bahrain & Kuwait BSC', '', '', 1),
(27, 'AB Bank Ltd.', '', '', 1),
(28, 'Sonali Bank Ltd.', '', '', 1),
(29, 'Bank of Nova Scotia', '', '', 1),
(30, 'Industrial & Commercial Bank of China Ltd', '', '', 1),
(31, 'BNP Paribas', '', '', 1),
(32, 'Credit Agricole Corporate & Investment Bank', '', '', 1),
(33, 'Societe Generale', '', '', 1),
(34, 'Deutsche Bank', '', '', 1),
(35, 'HSBC Ltd #', '', '', 1),
(36, 'PT Bank Maybank Indonesia TBK', '', '', 1),
(37, 'Mizuho Bank Ltd.', '', '', 1),
(38, 'Sumitomo Mitsui Banking Corporation', '', '', 1),
(39, 'The Bank of Tokyo- Mitsubishi UFJ, Ltd.', '', '', 1),
(40, 'Cooperatieve Rabobank U.A.', '', '', 1),
(41, 'Doha Bank', '', '', 1),
(42, 'Qatar National Bank SAQ', '', '', 1),
(43, 'JSC VTB Bank', '', '', 1),
(44, 'Sberbank', '', '', 1),
(45, 'DBS Bank Ltd.', '', '', 1),
(46, 'United Overseas Bank Ltd.', '', '', 1),
(47, 'FirstRand Bank Ltd.', '', '', 1),
(48, 'Shinhan Bank', '', '', 1),
(49, 'Woori Bank', '', '', 1),
(50, 'KEB Hana Bank', '', '', 1),
(51, 'Industrial Bank of Korea #', '', '', 1),
(52, 'Bank of Ceylon', '', '', 1),
(53, 'Credit Suisse A.G', '', '', 1),
(54, 'CTBC Bank Co., Ltd.', '', '', 1),
(55, 'Krung Thai Bank Public Co. Ltd.', '', '', 1),
(56, 'Abu Dhabi Commercial Bank Ltd.', '', '', 1),
(57, 'Mashreq Bank PSC', '', '', 1),
(58, 'First Abu Dhabi Bank PJSC', '', '', 1),
(59, 'Emirates NBD Bank PJSC', '', '', 1),
(60, 'Barclays Bank Plc.', '', '', 1),
(61, 'Standard Chartered Bank', '', '', 1),
(62, 'The Royal Bank of Scotland plc', '', '', 1),
(63, 'American Express Banking Corp.', '', '', 1),
(64, 'Bank of America', '', '', 1),
(65, 'Citibank N.A.', '', '', 1),
(66, 'J.P. Morgan Chase Bank N.A.', '', '', 1),
(67, 'Assam Gramin Vikash Bank', '', '', 1),
(68, 'Andhra Pradesh Grameena Vikas Bank', '', '', 1),
(69, 'Andhra Pragathi Grameena Bank', '', '', 1),
(70, 'Arunachal Pradesh Rural Bank', '', '', 1),
(71, 'Aryavart Bank', '', '', 1),
(72, 'Bangiya Gramin Vikash Bank', '', '', 1),
(73, 'Baroda Gujarat Gramin Bank', '', '', 1),
(74, 'Baroda Rajasthan Kshetriya Gramin Bank', '', '', 1),
(75, 'Baroda UP Bank', '', '', 1),
(76, 'Chaitanya Godavari GB', '', '', 1),
(77, 'Chhattisgarh Rajya Gramin Bank', '', '', 1),
(78, 'Dakshin Bihar Gramin Bank', '', '', 1),
(79, 'Ellaquai Dehati Bank', '', '', 1),
(80, 'Himachal Pradesh Gramin Bank', '', '', 1),
(81, 'J&K Grameen Bank', '', '', 1),
(82, 'Jharkhand Rajya Gramin Bank', '', '', 1),
(83, 'Karnataka Gramin Bank', '', '', 1),
(84, 'Karnataka Vikas Gramin Bank', '', '', 1),
(85, 'Kerala Gramin Bank', '', '', 1),
(86, 'Madhya Pradesh Gramin Bank', '', '', 1),
(87, 'Madhyanchal Gramin Bank', '', '', 1),
(88, 'Maharashtra Gramin Bank', '', '', 1),
(89, 'Manipur Rural Bank', '', '', 1),
(90, 'Meghalaya Rural Bank', '', '', 1),
(91, 'Mizoram Rural Bank', '', '', 1),
(92, 'Nagaland Rural Bank', '', '', 1),
(93, 'Odisha Gramya Bank', '', '', 1),
(94, 'Paschim Banga Gramin Bank', '', '', 1),
(95, 'Prathama U.P. Gramin Bank', '', '', 1),
(96, 'Puduvai Bharathiar Grama Bank', '', '', 1),
(97, 'Punjab Gramin Bank', '', '', 1),
(98, 'Rajasthan Marudhara Gramin Bank', '', '', 1),
(99, 'Saptagiri Grameena Bank', '', '', 1),
(100, 'Sarva Haryana Gramin Bank', '', '', 1),
(101, 'Saurashtra Gramin Bank', '', '', 1),
(102, 'Tamil Nadu Grama Bank', '', '', 1),
(103, 'Telangana Grameena Bank', '', '', 1),
(104, 'Tripura Gramin Bank', '', '', 1),
(105, 'Uttar Bihar Gramin Bank', '', '', 1),
(106, 'Utkal Grameen Bank', '', '', 1),
(107, 'Uttarbanga Kshetriya Gramin Bank', '', '', 1),
(108, 'Vidharbha Konkan Gramin Bank', '', '', 1),
(109, 'Uttarakhand Gramin Bank', '', '', 1),
(110, 'National Bank for Agriculture and Rural Development', '', '', 1),
(111, 'Export-Import Bank of India', '', '', 1),
(112, 'National Housing Bank', '', '', 1),
(113, 'Small Industries Development Bank of India', '', '', 1),
(114, 'Bank of Baroda', '', '', 1),
(115, 'Bank of India', '', '', 1),
(116, 'Bank of Maharashtra', '', '', 1),
(117, 'Canara Bank', '', '', 1),
(118, 'Central Bank of India', '', '', 1),
(119, 'Indian Bank', '', '', 1),
(120, 'Indian Overseas Bank', '', '', 1),
(121, 'Punjab & Sind Bank', '', '', 1),
(122, 'Punjab National Bank', '', '', 1),
(123, 'State Bank of India', '', '', 1),
(124, 'UCO Bank', '', '', 1),
(125, 'Union Bank of India', '', '', 1),
(126, 'Airtel Payments Bank Ltd', '', '', 1),
(127, 'India Post Payments Bank Ltd', '', '', 1),
(128, 'FINO Payments Bank Ltd', '', '', 1),
(129, 'Paytm Payments Bank Ltd', '', '', 1),
(130, 'Jio Payments Bank Ltd', '', '', 1),
(131, 'NSDL Payments Bank Limited', '', '', 1),
(132, 'Au Small Finance Bank Ltd.', '', '', 1),
(133, 'Capital Small Finance Bank Ltd', '', '', 1),
(134, 'Fincare Small Finance Bank Ltd.', '', '', 1),
(135, 'Equitas Small Finance Bank Ltd', '', '', 1),
(136, 'ESAF Small Finance Bank Ltd.', '', '', 1),
(137, 'Suryoday Small Finance Bank Ltd.', '', '', 1),
(138, 'Ujjivan Small Finance Bank Ltd.', '', '', 1),
(139, 'Utkarsh Small Finance Bank Ltd.', '', '', 1),
(140, 'North East Small finance Bank Ltd', '', '', 1),
(141, 'Jana Small Finance Bank Ltd', '', '', 1),
(142, 'Coastal Local Area Bank Ltd', '', '', 1),
(143, 'Krishna Bhima Samruddhi LAB Ltd', '', '', 1),
(144, 'Subhadra Local Bank Ltd', '', '', 1);

-- --------------------------------------------------------

--
-- Table structure for table `adv_banner`
--

DROP TABLE IF EXISTS `adv_banner`;
CREATE TABLE IF NOT EXISTS `adv_banner` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `bnr_image` varchar(255) NOT NULL,
  `status` tinyint(4) NOT NULL DEFAULT '1',
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `adv_cart`
--

DROP TABLE IF EXISTS `adv_cart`;
CREATE TABLE IF NOT EXISTS `adv_cart` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL DEFAULT '0',
  `user_type` int(11) NOT NULL DEFAULT '0' COMMENT '1 for artist, 2 for enthusiast',
  `shop_id` int(11) NOT NULL DEFAULT '0',
  `product_id` int(11) NOT NULL DEFAULT '0',
  `product_name` varchar(250) NOT NULL,
  `qty` int(11) NOT NULL DEFAULT '0',
  `attribute` varchar(200) NOT NULL,
  `price` double NOT NULL DEFAULT '0',
  `sell_price` double NOT NULL DEFAULT '0',
  `shipping_charge` varchar(100) NOT NULL,
  `total` double NOT NULL,
  `status` int(11) NOT NULL DEFAULT '1',
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `adv_city`
--

DROP TABLE IF EXISTS `adv_city`;
CREATE TABLE IF NOT EXISTS `adv_city` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `state_id` int(11) NOT NULL,
  `city` varchar(255) NOT NULL,
  `status` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=883 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `adv_city`
--

INSERT INTO `adv_city` (`id`, `state_id`, `city`, `status`) VALUES
(1, 1, 'Nellore', 1),
(2, 1, 'Cuddapah', 1),
(3, 1, 'Karim Nagar', 1),
(4, 1, 'Kurnool', 1),
(5, 1, 'West Godavari', 1),
(6, 1, 'Srikakulam', 1),
(7, 1, 'Anantpur', 1),
(8, 1, 'Adilabad', 1),
(9, 1, 'Chittor', 1),
(10, 1, 'east Godavari', 1),
(11, 1, 'Guntur', 1),
(13, 1, 'Khammam', 1),
(14, 1, 'Krishna', 1),
(15, 1, 'Mehboobnagar', 1),
(16, 1, 'Medak', 1),
(17, 1, 'Nalgonda', 1),
(18, 1, 'Nizamabad', 1),
(19, 1, 'Prakasam', 1),
(20, 1, 'Ranga Reddy', 1),
(21, 1, 'Vishakapatnam', 1),
(22, 1, 'Vizianagaram', 1),
(23, 1, 'Warangal', 1),
(24, 2, 'Diban Valley( Anini Valley)', 1),
(25, 2, 'East Kameng Seppa', 1),
(26, 2, 'Itanagar', 1),
(27, 2, 'East Siang(Passighat)', 1),
(28, 2, 'Lohit(Tezu)', 1),
(29, 2, 'Lower Subansiri(Ziro)', 1),
(30, 2, 'Khonsa', 1),
(31, 2, 'Roin', 1),
(32, 2, 'Tawang', 1),
(33, 2, 'Changalang', 1),
(34, 2, 'Dibang Valley', 1),
(35, 2, 'Daporijo', 1),
(36, 2, 'Bomdila', 1),
(37, 2, 'Alog( West Siang )', 1),
(38, 3, 'Andaman', 1),
(39, 3, 'Nicobar', 1),
(40, 4, 'Karimganj', 1),
(41, 4, 'Darrang', 1),
(42, 4, 'Dibrugarh', 1),
(43, 4, 'Morigaon', 1),
(44, 4, 'Tinsukia', 1),
(45, 4, 'Bongaigaon', 1),
(46, 4, 'Nalbari', 1),
(47, 4, 'Kokrajhar', 1),
(48, 4, 'Kamrup', 1),
(49, 4, 'Karbi-Anglong', 1),
(50, 4, 'Nagaon', 1),
(51, 4, 'N.C.Hills', 1),
(52, 4, 'Dhemaji', 1),
(53, 4, 'Hailakandi', 1),
(54, 4, 'Lakhimpur', 1),
(55, 4, 'Sonitpur', 1),
(56, 4, 'Dhubri', 1),
(57, 4, 'Goalpara', 1),
(58, 4, 'Barpeta', 1),
(59, 4, 'Golaghat', 1),
(60, 4, 'Jorhat', 1),
(61, 4, 'Sibsagar', 1),
(62, 4, 'Cachar', 1),
(63, 5, 'Muzaffarpur', 1),
(64, 5, 'Jehanabad', 1),
(65, 5, 'Gaya', 1),
(66, 5, 'Patna', 1),
(67, 5, 'Saran( Chapra )', 1),
(68, 5, 'Darbhanga', 1),
(69, 5, 'Saharsa', 1),
(70, 5, 'Purnea', 1),
(71, 5, 'Bhagalpur', 1),
(72, 5, 'Munger', 1),
(73, 5, 'Aurangabad', 1),
(74, 5, 'Bhojpur(Arah)', 1),
(75, 5, 'Begusarai', 1),
(76, 5, 'East Champaran', 1),
(77, 5, 'Gopalganj', 1),
(78, 5, 'Jamui', 1),
(79, 5, 'Katihar', 1),
(80, 5, 'Khagaria', 1),
(81, 5, 'Madhepura', 1),
(82, 5, 'Madhubani', 1),
(83, 5, 'Nalanda', 1),
(84, 5, 'Nawada', 1),
(85, 5, 'Rohtas(Sasaram)', 1),
(86, 5, 'Samastipur', 1),
(87, 5, 'Sitamarhi', 1),
(88, 5, 'Siwan', 1),
(89, 5, 'Vaishali(Hajipur)', 1),
(90, 5, 'West Champaran', 1),
(91, 5, 'Kishanganj', 1),
(92, 5, 'Araria', 1),
(93, 5, 'Bhabua', 1),
(94, 5, 'Banka', 1),
(95, 5, 'Buxar', 1),
(96, 5, 'Supaul', 1),
(97, 5, 'Sekhpura', 1),
(98, 5, 'Seohar', 1),
(99, 5, 'Lakhisarai', 1),
(101, 7, 'Bastar', 1),
(102, 7, 'Bilaspur', 1),
(103, 7, 'Dantewada', 1),
(104, 7, 'Dhamtari', 1),
(105, 7, 'Durg', 1),
(106, 7, 'Janjgir-Champa', 1),
(107, 7, 'Jashpur', 1),
(108, 7, 'Kanker', 1),
(109, 7, 'Kawardha', 1),
(110, 7, 'Korba', 1),
(111, 7, 'Koriya', 1),
(112, 7, 'Mahasamund', 1),
(113, 7, 'Raigarh', 1),
(114, 7, 'Rajnandgaon', 1),
(115, 7, 'Surguja', 1),
(116, 7, 'Raipur', 1),
(117, 8, 'Dadra', 1),
(119, 9, 'Diu', 1),
(120, 10, 'Delhi', 1),
(130, 12, 'Panchmahals', 1),
(131, 12, 'Vadodara', 1),
(132, 12, 'Amrela', 1),
(133, 12, 'Kheda', 1),
(134, 12, 'Ahmedabad', 1),
(135, 12, 'Valsad', 1),
(136, 12, 'Junagadh', 1),
(137, 12, 'Mehsana', 1),
(138, 12, 'Banaskantha', 1),
(139, 12, 'Gandhinagar', 1),
(140, 12, 'Bharuch', 1),
(141, 12, 'Dangs', 1),
(142, 12, 'Jamnagar', 1),
(143, 12, 'Rajkot', 1),
(144, 12, 'Surat', 1),
(145, 12, 'Sabarkantha', 1),
(146, 12, 'Kutch', 1),
(147, 12, 'Bhavnagar', 1),
(148, 12, 'Surendranagar', 1),
(149, 12, 'Navsari', 1),
(150, 12, 'Anand', 1),
(151, 12, 'Narmada', 1),
(152, 12, 'Patan', 1),
(153, 12, 'Porbander', 1),
(154, 12, 'Dahod', 1),
(155, 13, 'Gurgaon', 1),
(156, 13, 'Rohtak', 1),
(157, 13, 'Ambala', 1),
(158, 13, 'Bhiwani', 1),
(159, 13, 'Faridabad', 1),
(160, 13, 'Hissar', 1),
(161, 13, 'Jind', 1),
(162, 13, 'Kaithal', 1),
(163, 13, 'Karnal', 1),
(164, 13, 'Kurukshetra', 1),
(165, 13, 'Mahendragarh', 1),
(166, 13, 'Panchkula', 1),
(167, 13, 'Panipat', 1),
(168, 13, 'Sonipat', 1),
(169, 13, 'Yamunanagar', 1),
(170, 13, 'Sirsa', 1),
(171, 13, 'Rewari', 1),
(172, 13, 'Jhanjhar', 1),
(173, 13, 'Fatehabad', 1),
(174, 14, 'Sirmour', 1),
(175, 14, 'Hamirpur', 1),
(176, 14, 'Kullu', 1),
(177, 14, 'Solan', 1),
(178, 14, 'Mandi', 1),
(179, 14, 'Chamba', 1),
(180, 14, 'Bilaspur', 1),
(181, 14, 'Kangra', 1),
(182, 14, 'Kinnaur', 1),
(183, 14, 'Lahaul-Spiti', 1),
(184, 14, 'Shimla', 1),
(185, 14, 'Una', 1),
(186, 15, 'Kathua', 1),
(187, 15, 'Badgan', 1),
(188, 15, 'Poonch', 1),
(189, 15, 'Rajauri', 1),
(190, 15, 'Baramula', 1),
(191, 15, 'Doda', 1),
(192, 15, 'Udhampur', 1),
(193, 15, 'Jammu', 1),
(194, 15, 'Kupwara', 1),
(195, 15, 'Pulwama', 1),
(196, 15, 'Anantnag', 1),
(197, 15, 'Srinagar', 1),
(198, 15, 'Leh', 1),
(199, 15, 'Kargil', 1),
(200, 16, 'Deoghar', 1),
(201, 16, 'Dhanbad', 1),
(202, 16, 'Giridih', 1),
(203, 16, 'Godda', 1),
(204, 16, 'Gumla', 1),
(205, 16, 'Hazaribagh', 1),
(206, 16, 'Lohardaga', 1),
(207, 16, 'Palamu', 1),
(208, 16, 'Ranchi', 1),
(209, 16, 'Dumka', 1),
(210, 16, 'Chaibasa(West Singhbhum)', 1),
(211, 16, 'Jamshedpur(East Singhbhum)', 1),
(212, 16, 'Bokaro', 1),
(213, 16, 'Chatra', 1),
(214, 16, 'Garhwa', 1),
(215, 16, 'Koderma', 1),
(216, 16, 'Pakur', 1),
(217, 16, 'Sahebganj', 1),
(218, 16, 'Simdega', 1),
(219, 16, 'Latehar', 1),
(220, 16, 'Saraikela', 1),
(221, 16, 'Jamtara', 1),
(222, 17, 'Mysore', 1),
(223, 17, 'Gulberga', 1),
(224, 17, 'Chitradurga', 1),
(225, 17, 'Kolar', 1),
(226, 17, 'Bijapur', 1),
(227, 17, 'Dakshina Kannada', 1),
(228, 17, 'Raichur', 1),
(229, 17, 'Bellary', 1),
(230, 17, 'Belgaum', 1),
(231, 17, 'Hassan', 1),
(232, 17, 'Dharwad', 1),
(234, 17, 'Shimoga', 1),
(235, 17, 'Mandya', 1),
(236, 17, 'Chickmagalur', 1),
(238, 17, 'Madikeri', 1),
(239, 17, 'Tumkur', 1),
(240, 17, 'Bidar', 1),
(241, 17, 'Karwar', 1),
(242, 17, 'Udupi', 1),
(243, 17, 'Davanagare', 1),
(244, 17, 'Chamrajnagar', 1),
(245, 17, 'Koppal', 1),
(246, 17, 'Haveri', 1),
(247, 17, 'Gadak', 1),
(248, 17, 'Yadgir', 1),
(249, 18, 'Kozhikode', 1),
(250, 18, 'Kasaragod', 1),
(251, 18, 'Idukki', 1),
(252, 18, 'Ernakulam', 1),
(253, 18, 'Cannanore', 1),
(254, 18, 'Mallapuram', 1),
(255, 18, 'Palghat', 1),
(256, 18, 'Pathanamthitta', 1),
(257, 18, 'Quilon', 1),
(258, 18, 'Trichur', 1),
(259, 18, 'Wayanad', 1),
(260, 18, 'Trivandrum', 1),
(261, 18, 'Kottayam', 1),
(262, 18, 'Alapuzzha', 1),
(263, 19, 'Lakshadeep', 1),
(264, 20, 'Sindi', 1),
(265, 20, 'Vidisha', 1),
(266, 20, 'Jabalpur', 1),
(267, 20, 'Bhopal', 1),
(268, 20, 'Hoshangabad', 1),
(269, 20, 'Indore', 1),
(270, 20, 'Rewa', 1),
(271, 20, 'Satna', 1),
(272, 20, 'Shahdol', 1),
(273, 20, 'Chhindwara', 1),
(274, 20, 'Ratlam', 1),
(275, 20, 'Balaghat', 1),
(276, 20, 'Betul', 1),
(277, 20, 'Bhind', 1),
(278, 20, 'Mandla', 1),
(279, 20, 'Chhattarpur', 1),
(280, 20, 'Damoh', 1),
(281, 20, 'Datia', 1),
(282, 20, 'Dewas', 1),
(283, 20, 'Dhar', 1),
(284, 20, 'Guna', 1),
(285, 20, 'Gwalior', 1),
(286, 20, 'Jhabua', 1),
(287, 20, 'Sehore', 1),
(288, 20, 'Mandsaur', 1),
(289, 20, 'Narsinghpur', 1),
(290, 20, 'Panna', 1),
(291, 20, 'Raisen', 1),
(292, 20, 'Rajgarh', 1),
(293, 20, 'Sagar', 1),
(294, 20, 'Seoni', 1),
(295, 20, 'Morena', 1),
(296, 20, 'Shivpuri', 1),
(297, 20, 'Shajapur', 1),
(298, 20, 'Tikamgarh', 1),
(299, 20, 'Ujjain', 1),
(300, 20, 'Khandwa', 1),
(301, 20, 'Khargone', 1),
(302, 20, 'Dindori', 1),
(303, 20, 'Umaria', 1),
(304, 20, 'Badwani', 1),
(305, 20, 'Sheopur', 1),
(306, 20, 'Katni', 1),
(307, 20, 'Neemuch', 1),
(308, 20, 'Harda', 1),
(309, 20, 'Anooppur', 1),
(310, 20, 'Burhanpur', 1),
(311, 20, 'Ashoknagar', 1),
(312, 21, 'Aurangabad', 1),
(314, 21, 'Nagpur', 1),
(315, 21, 'Pune', 1),
(316, 21, 'Akola', 1),
(317, 21, 'Chandrapur', 1),
(318, 21, 'Jalgaon', 1),
(319, 21, 'Parbhani', 1),
(320, 21, 'Sholapur', 1),
(321, 21, 'Thane', 1),
(322, 21, 'Latur', 1),
(324, 21, 'Buldhana', 1),
(325, 21, 'Dhule', 1),
(326, 21, 'Kolhpur', 1),
(327, 21, 'Nanded', 1),
(328, 21, 'Raigad', 1),
(329, 21, 'Amravati', 1),
(330, 21, 'Nashik', 1),
(331, 21, 'Wardha', 1),
(332, 21, 'Ahmednagar', 1),
(333, 21, 'Beed', 1),
(334, 21, 'Bhandara', 1),
(335, 21, 'Gadchiroli', 1),
(336, 21, 'Jalna', 1),
(337, 21, 'Osmanabad', 1),
(338, 21, 'Ratnagiri', 1),
(339, 21, 'Sangli', 1),
(340, 21, 'Satara', 1),
(341, 21, 'Sindudurg', 1),
(342, 21, 'Yavatmal', 1),
(343, 21, 'Nandurbar', 1),
(344, 21, 'Washim', 1),
(345, 21, 'Gondia', 1),
(346, 21, 'Hingoli', 1),
(347, 22, 'Imphal East', 1),
(348, 22, 'Imphal West', 1),
(349, 22, 'Thoubal', 1),
(350, 22, 'Bishnupur', 1),
(351, 22, 'Chandel', 1),
(352, 22, 'Churachandpur', 1),
(353, 22, 'Senapati', 1),
(354, 22, 'Ukhrul', 1),
(355, 22, 'Tamenglong', 1),
(356, 23, 'Ri-Bhoi District', 1),
(361, 23, 'Jaintia Hill', 1),
(363, 24, 'Luglei District', 1),
(364, 24, 'Chimtipui District', 1),
(366, 24, 'Champhai', 1),
(367, 24, 'Mamit', 1),
(368, 24, 'Kolasib', 1),
(369, 24, 'Serchhip', 1),
(370, 24, 'Lawngtlai', 1),
(371, 25, 'Wokha', 1),
(372, 25, 'Phek', 1),
(373, 25, 'Tuensang', 1),
(374, 25, 'Mon', 1),
(375, 25, 'Kohima', 1),
(376, 25, 'Zunheboto', 1),
(377, 25, 'Mokokchung', 1),
(378, 25, 'Dimapur', 1),
(379, 26, 'Khurda', 1),
(380, 26, 'Navaragpur', 1),
(381, 26, 'Navapada', 1),
(382, 26, 'Gajapati', 1),
(383, 26, 'Boudh', 1),
(384, 26, 'Bhadrak', 1),
(385, 26, 'Ganjam', 1),
(386, 26, 'Dhenkanal', 1),
(387, 26, 'Angul', 1),
(388, 26, 'Puri', 1),
(389, 26, 'Cuttak', 1),
(390, 26, 'Sambalpur', 1),
(391, 26, 'Kalhandi', 1),
(392, 26, 'Koraput', 1),
(393, 26, 'Phulbani', 1),
(394, 26, 'Balangir', 1),
(395, 26, 'Bargah', 1),
(396, 26, 'Deogarh', 1),
(397, 26, 'Jagatsinghpur', 1),
(398, 26, 'Jajpur', 1),
(399, 26, 'Jharsuguda', 1),
(400, 26, 'Kendrapara', 1),
(401, 26, 'Malkangiri', 1),
(402, 26, 'Nayagarh', 1),
(403, 26, 'Rayagada', 1),
(404, 26, 'Sonepur', 1),
(405, 26, 'Balasore', 1),
(406, 26, 'Mayurbhanj', 1),
(407, 26, 'Keonjhar', 1),
(408, 26, 'Sundergarh', 1),
(409, 27, 'Karikal', 1),
(410, 27, 'Mahe', 1),
(411, 27, 'Yaman', 1),
(412, 27, 'Pondicherry', 1),
(413, 28, 'Sangrur', 1),
(414, 28, 'Jalandhar', 1),
(415, 28, 'Ludhiana', 1),
(416, 28, 'Bhatinda', 1),
(417, 28, 'Kapurthala', 1),
(418, 28, 'Patiala', 1),
(419, 28, 'Amritsar', 1),
(420, 28, 'Ferozepur', 1),
(421, 28, 'Fatehgarh Saheb', 1),
(422, 28, 'Ropar', 1),
(423, 28, 'Gurdaspur', 1),
(424, 28, 'Hosiarpur', 1),
(425, 28, 'Faridkot', 1),
(426, 28, 'Mansa', 1),
(427, 28, 'Moga', 1),
(428, 28, 'Muktsar', 1),
(429, 28, 'Navansahar', 1),
(430, 29, 'Jaipur', 1),
(431, 29, 'Barmer', 1),
(432, 29, 'Dungarpur', 1),
(433, 29, 'Jodhpur', 1),
(434, 29, 'Kota', 1),
(435, 29, 'Udaipur', 1),
(436, 29, 'Bikaner', 1),
(437, 29, 'Dausa', 1),
(438, 29, 'Bundi', 1),
(439, 29, 'Sikar', 1),
(440, 29, 'Tonk', 1),
(441, 29, 'Jaisalmer', 1),
(442, 29, 'Nagaur', 1),
(443, 29, 'Rajsamand', 1),
(444, 29, 'Banswara', 1),
(445, 29, 'Bhilwara', 1),
(446, 29, 'Ajmer', 1),
(447, 29, 'Alwar', 1),
(448, 29, 'Bharatpur', 1),
(449, 29, 'Chittorgarh', 1),
(450, 29, 'Churu', 1),
(451, 29, 'Dholpur', 1),
(452, 29, 'Ganganagar', 1),
(453, 29, 'Jalor', 1),
(454, 29, 'Jhalawar', 1),
(455, 29, 'Jhunjhunu', 1),
(456, 29, 'Pali', 1),
(457, 29, 'Sawai Madhopur', 1),
(458, 29, 'Sirohi', 1),
(459, 29, 'Baran', 1),
(460, 29, 'Hanumangarh', 1),
(461, 29, 'Karauli', 1),
(466, 31, 'Chennai', 1),
(467, 31, 'Coimbotore', 1),
(468, 31, 'Cuddalorei', 1),
(469, 31, 'Dharmapuri', 1),
(470, 31, 'Dindigul', 1),
(471, 31, 'Erode', 1),
(472, 31, 'Kancheepuram', 1),
(474, 31, 'Karur', 1),
(475, 31, 'Madurai', 1),
(476, 31, 'Nagapattinam', 1),
(477, 31, 'Namakkal', 1),
(479, 31, 'Perambalur', 1),
(480, 31, 'Pudukkottai', 1),
(481, 31, 'Ramanathapuram', 1),
(482, 31, 'Salem', 1),
(483, 31, 'Sivaganga', 1),
(484, 31, 'Thanjavur', 1),
(485, 31, 'Theni', 1),
(486, 31, 'Thoothkudi', 1),
(487, 31, 'Tiruchiorappalli', 1),
(488, 31, 'Tirunelveli', 1),
(489, 31, 'Tiruvallur', 1),
(490, 31, 'Tiruvannamalai', 1),
(491, 31, 'Tiruvarur', 1),
(492, 31, 'Vellore', 1),
(493, 31, 'Villupuram', 1),
(494, 31, 'Virudhunagar', 1),
(499, 33, 'Nainital', 1),
(500, 33, 'Almora', 1),
(501, 33, 'Pitoragarh', 1),
(502, 33, 'Udhamsingh Nagar', 1),
(503, 33, 'Bageshwar', 1),
(504, 33, 'Champawat', 1),
(508, 33, 'Uttarkashi', 1),
(509, 33, 'Dehradun', 1),
(510, 33, 'Rudraprayag', 1),
(511, 33, 'Haridwar', 1),
(512, 34, 'Allahabad', 1),
(513, 34, 'Aligarh', 1),
(514, 34, 'Bareilly', 1),
(515, 34, 'Gonda', 1),
(516, 34, 'Hardoi', 1),
(517, 34, 'Kanpur Dehat', 1),
(518, 34, 'Ghaziabad', 1),
(519, 34, 'Unnav', 1),
(520, 34, 'Varanasi', 1),
(521, 34, 'Faizabad', 1),
(523, 34, 'Jhansi', 1),
(524, 34, 'Lucknow', 1),
(525, 34, 'Agra', 1),
(526, 34, 'Meerut', 1),
(527, 34, 'Moradabad', 1),
(528, 34, 'Barabanki', 1),
(529, 34, 'Mainpuri', 1),
(530, 34, 'Etawah', 1),
(531, 34, 'Gazipur', 1),
(532, 34, 'Etah', 1),
(533, 34, 'Muzaffar Nagar', 1),
(534, 34, 'Saharanpur', 1),
(536, 34, 'Mathura', 1),
(537, 34, 'Firozabad', 1),
(538, 34, 'Budaun', 1),
(539, 34, 'Shahjahanpur', 1),
(540, 34, 'Pilibhit', 1),
(541, 34, 'Bijnor', 1),
(542, 34, 'Rampur', 1),
(543, 34, 'Kanpur', 1),
(544, 34, 'Farrukhabad', 1),
(545, 34, 'Fatehpur', 1),
(546, 34, 'Pratapgarh', 1),
(547, 34, 'Jalaun', 1),
(548, 34, 'Hamirpur', 1),
(549, 34, 'Lalitpur', 1),
(550, 34, 'Mirzapur', 1),
(551, 34, 'Basti', 1),
(552, 34, 'Deoria', 1),
(553, 34, 'Raebareili', 1),
(554, 34, 'Sitapur', 1),
(555, 34, 'Banda', 1),
(556, 34, 'Lakhimpur-Khedi', 1),
(557, 34, 'Bahraich', 1),
(558, 34, 'Sultanpur', 1),
(559, 34, 'Mau', 1),
(560, 34, 'Azamgarh', 1),
(561, 34, 'Jaunpur', 1),
(563, 34, 'Bhadoi', 1),
(564, 34, 'Padrauna', 1),
(565, 34, 'Maharajganj', 1),
(566, 34, 'Siddharth Nagar', 1),
(567, 34, 'Sunbhadra', 1),
(568, 34, 'Mahoba', 1),
(569, 34, 'Ambedkarnagar', 1),
(570, 34, 'Gautam Bodda Nagar', 1),
(571, 34, 'Maha Maya Nagar', 1),
(572, 34, 'jyotiba Phoole Nagar', 1),
(573, 34, 'Kaushambi', 1),
(574, 34, 'Shooji Maharaj', 1),
(575, 34, 'Chandauli', 1),
(576, 34, 'Balrampur', 1),
(577, 34, 'Shravati', 1),
(578, 34, 'Bagpat', 1),
(579, 34, 'Kanooj', 1),
(580, 34, 'Oraiyya', 1),
(581, 34, 'Sant Kabir Nagar', 1),
(582, 35, 'Howrah', 1),
(583, 35, 'Darjeeling', 1),
(584, 35, 'Medinipur', 1),
(585, 35, 'Murshidabad', 1),
(586, 35, 'Coochbehar', 1),
(587, 35, 'Malda', 1),
(588, 35, 'Birbhum', 1),
(589, 35, 'North 24 Parganas', 1),
(590, 35, 'South 24 Parganas', 1),
(591, 35, 'Bankura', 1),
(592, 35, 'Bardhaman', 1),
(593, 35, 'Jalpaiguri', 1),
(594, 35, 'Hooghly', 1),
(595, 35, 'Nadia', 1),
(596, 35, 'Dakshin Dinajpur', 1),
(597, 35, 'Purulia', 1),
(598, 35, 'Uttar Dinajpur', 1),
(599, 35, 'Siliguri', 1),
(600, 35, 'Kolkata', 1),
(602, 36, 'Hyderabad', 1),
(605, 1, 'Visakhapatnam', 1),
(606, 1, 'Vijayawada', 1),
(607, 1, 'Kakinada', 1),
(608, 1, 'Rajahmundry', 1),
(609, 1, 'Tirupati', 1),
(610, 1, 'Kadapa', 1),
(611, 1, 'Eluru', 1),
(612, 1, 'Anantapur', 1),
(613, 1, 'Vijayanagaram', 1),
(614, 1, 'Tenali', 1),
(615, 1, 'Ongole', 1),
(616, 1, 'Nandyal', 1),
(617, 1, 'Chittoor', 1),
(618, 1, 'Machilipatnam', 1),
(619, 1, 'Adoni', 1),
(620, 1, 'Proddatur', 1),
(621, 1, 'Hindupur', 1),
(622, 1, 'Bhimavaram', 1),
(623, 1, 'Madanapalle', 1),
(624, 1, 'Guntakal', 1),
(625, 1, 'Dharmavaram', 1),
(626, 1, 'Gudivada', 1),
(627, 1, 'Narasaraopet', 1),
(628, 1, 'Tadipatri', 1),
(629, 1, 'Kavali', 1),
(630, 1, 'Tadepalligudem', 1),
(631, 1, 'Amaravati', 1),
(632, 4, 'Guwahati', 1),
(633, 4, 'Silchar', 1),
(634, 4, 'Tezpur', 1),
(635, 5, 'Bihar Sharif', 1),
(636, 5, 'Purnia', 1),
(637, 5, 'Arrah', 1),
(638, 5, 'Chapra', 1),
(640, 5, 'Sasaram', 1),
(641, 5, 'Hajipur', 1),
(642, 5, 'Dehri', 1),
(644, 5, 'Motihari', 1),
(645, 5, 'Jamalpur', 1),
(647, 7, 'Bhilai', 1),
(648, 9, 'Daman', 1),
(649, 11, 'Goa', 1),
(650, 12, 'Gandhidham', 1),
(651, 12, 'Nadiad', 1),
(652, 12, 'Morbi', 1),
(653, 12, 'Surendranagar Dudhrej', 1),
(654, 15, 'Kashmir', 1),
(655, 16, 'Jamshedpur', 1),
(656, 16, 'Mango', 1),
(657, 16, 'Phusro', 1),
(658, 16, 'Ramgarh', 1),
(659, 16, 'Medininagar', 1),
(660, 17, 'Bangalore', 1),
(661, 17, 'Hubli–Dharwad', 1),
(662, 17, 'Gulbarga', 1),
(663, 17, 'Mangalore', 1),
(664, 17, 'Davanagere', 1),
(665, 17, 'Hospet', 1),
(666, 18, 'Thiruvananthapuram', 1),
(667, 18, 'Kochi', 1),
(668, 18, 'Kollam', 1),
(669, 18, 'Thrissur', 1),
(670, 18, 'Alappuzha', 1),
(672, 21, 'Mumbai', 1),
(673, 21, 'Pimpri-Chinchwad', 1),
(674, 21, 'Kalyan-Dombivli', 1),
(675, 21, 'Vasai-Virar', 1),
(676, 21, 'Navi Mumbai', 1),
(677, 21, 'Solapur', 1),
(678, 21, 'Mira-Bhayandar', 1),
(679, 21, 'Bhiwandi', 1),
(680, 21, 'Kolhapur', 1),
(681, 21, 'Ulhasnagar', 1),
(682, 21, 'Sangli-Miraj & Kupwad', 1),
(683, 21, 'Malegaon', 1),
(684, 21, 'Ichalkaranji', 1),
(685, 21, 'Ambarnath', 1),
(686, 21, 'Bhusawal', 1),
(687, 21, 'Panvel', 1),
(688, 21, 'Bandra', 1),
(689, 22, 'Imphal', 1),
(690, 23, 'Garo Hill', 1),
(691, 23, 'Khasi Hill', 1),
(693, 26, 'Bhubaneswar', 1),
(694, 26, 'Cuttack', 1),
(695, 26, 'Rourkela', 1),
(696, 26, 'Berhampur', 1),
(697, 27, 'Ozhukarai', 1),
(698, 28, 'Bathinda', 1),
(699, 28, 'Phagwara', 1),
(700, 29, 'Sri Ganganagar', 1),
(701, 31, 'Coimbatore', 1),
(702, 31, 'Tiruchirappalli', 1),
(703, 31, 'Tiruppur', 1),
(704, 31, 'Ambattur', 1),
(705, 31, 'Avadi', 1),
(706, 31, 'Tiruvottiyur', 1),
(707, 31, 'Thoothukudi', 1),
(708, 31, 'Nagercoil', 1),
(709, 31, 'Pallavaram', 1),
(710, 31, 'Kumbakonam', 1),
(711, 31, 'Hosur', 1),
(712, 31, 'Karaikudi', 1),
(713, 31, 'Kanniyakumari', 1),
(714, 31, 'Nilgiris', 1),
(715, 36, 'Karimnagar', 1),
(717, 36, 'Mahbubnagar', 1),
(718, 36, 'Suryapet', 1),
(719, 36, 'Miryalaguda', 1),
(720, 32, 'Agartala', 1),
(721, 32, 'Dhalai', 1),
(722, 34, 'Gorakhpur', 1),
(723, 34, 'Noida', 1),
(724, 34, 'Loni', 1),
(725, 34, 'Muzaffarnagar', 1),
(726, 34, 'Hapur', 1),
(727, 34, 'Bulandshahr', 1),
(728, 34, 'Sambhal', 1),
(729, 34, 'Amroha', 1),
(730, 34, 'Raebareli', 1),
(731, 34, 'Orai', 1),
(732, 34, 'Unnao', 1),
(733, 34, 'Ballia', 1),
(734, 33, 'Chamoli', 1),
(735, 33, 'Garhwal', 1),
(736, 33, 'Tehri', 1),
(737, 35, 'Durgapur', 1),
(738, 35, 'Asansol', 1),
(739, 35, 'Maheshtala', 1),
(740, 35, 'Rajpur Sonarpur', 1),
(741, 35, 'Gopalpur', 1),
(742, 35, 'Bhatpara', 1),
(743, 35, 'Panihati', 1),
(744, 35, 'Kamarhati', 1),
(745, 35, 'Kulti', 1),
(746, 35, 'Bally', 1),
(747, 35, 'Barasat', 1),
(748, 35, 'Dumdum', 1),
(749, 35, 'Baranagar', 1),
(750, 35, 'Uluberia', 1),
(751, 35, 'Naihati', 1),
(752, 35, 'Bidhannagar', 1),
(753, 35, 'Kharagpur', 1),
(754, 35, 'Haldia', 1),
(755, 35, 'Madhyamgram', 1),
(756, 35, 'Berhampore', 1),
(757, 35, 'Raiganj', 1),
(758, 35, 'Serampore', 1),
(759, 35, 'Chinsurah', 1),
(760, 5, 'Bettiah', 1),
(761, 5, 'Danapur', 1),
(762, 6, 'Chandigarh', 1),
(764, 30, 'Gangtok', 1),
(765, 36, 'Warangal', 1),
(766, 36, 'Nizamabad', 1),
(767, 36, 'Khammam', 1),
(768, 36, 'Ramagundam', 1),
(769, 36, 'Secunderabad', 1),
(770, 20, 'Singrauli', 1),
(771, 24, 'Aizawl', 1),
(772, 13, 'Gurugram', 1),
(773, 10, 'New  Delhi', 1),
(774, 37, 'Dhaka', 1),
(775, 38, 'Barguna', 1),
(776, 38, 'Barisal', 1),
(777, 38, 'Bhola', 1),
(778, 38, 'Jhalokati', 1),
(779, 38, 'Patuakhali', 1),
(780, 38, 'Pirojpur', 1),
(781, 39, 'Bandarban', 1),
(782, 39, 'Brahmanbaria', 1),
(783, 39, 'Chandpur', 1),
(784, 39, 'Chittagong', 1),
(785, 39, 'Comilla', 1),
(786, 39, 'Cox\'s Bazar', 1),
(787, 39, 'Feni', 1),
(788, 39, 'Khagrachhari', 1),
(789, 39, 'Lakshmipur', 1),
(790, 39, 'Noakhali', 1),
(791, 39, 'Rangamati', 1),
(792, 37, 'Dhaka', 1),
(793, 37, 'Faridpur', 1),
(794, 37, 'Gazipur', 1),
(795, 37, 'Gopalganj', 1),
(796, 37, 'Jamalpur', 1),
(797, 37, 'Kishoreganj', 1),
(798, 37, 'Madaripur', 1),
(799, 37, 'Manikganj', 1),
(800, 37, 'Munshiganj', 1),
(801, 37, 'Mymensingh', 1),
(802, 37, 'Narayanganj', 1),
(803, 37, 'Narsingdi', 1),
(804, 37, 'Netrakona', 1),
(805, 37, 'Rajbari', 1),
(806, 37, 'Shariatpur', 1),
(807, 37, 'Sherpur', 1),
(808, 37, 'Tangail', 1),
(809, 41, 'Bagerhat', 1),
(810, 41, 'Chuadanga', 1),
(811, 41, 'Jessore', 1),
(812, 41, 'Jhenaidah', 1),
(813, 41, 'Khulna', 1),
(814, 41, 'Kushtia', 1),
(815, 41, 'Magura', 1),
(816, 41, 'Meherpur', 1),
(817, 41, 'Narail', 1),
(818, 41, 'Satkhira', 1),
(819, 42, 'Bogra', 1),
(820, 42, 'Joypurhat', 1),
(821, 42, 'Naogaon', 1),
(822, 42, 'Natore', 1),
(823, 42, 'Nawabganj', 1),
(824, 42, 'Pabna', 1),
(825, 42, 'Rajshahi', 1),
(826, 42, 'Sirajganj', 1),
(827, 43, 'Dinajpur', 1),
(828, 43, 'Gaibandha', 1),
(829, 43, 'Kurigram', 1),
(830, 43, 'Lalmonirhat', 1),
(831, 43, 'Nilphamari', 1),
(832, 43, 'Panchagarh', 1),
(833, 43, 'Rangpur', 1),
(834, 43, 'Thakurgaon', 1),
(835, 44, 'Habiganj', 1),
(836, 44, 'Moulvibazar', 1),
(837, 44, 'Sunamganj', 1),
(838, 44, 'Sylhet', 1),
(839, 45, 'Bumthang', 1),
(840, 46, 'Chhukha', 1),
(841, 47, 'Dagana', 1),
(842, 48, 'Gasa', 1),
(843, 49, 'Haa', 1),
(844, 50, 'Lhuentse', 1),
(845, 51, 'Mongar', 1),
(846, 52, 'Paro', 1),
(847, 53, 'Pema Gatshel', 1),
(848, 54, 'Punakha', 1),
(849, 55, 'Samdrup Jongkhar', 1),
(850, 56, 'Samtse', 1),
(851, 57, 'Sarpang', 1),
(852, 58, 'Thimphu', 1),
(853, 59, 'Trashigang', 1),
(854, 60, 'Trashi Yangtse', 1),
(855, 61, 'Trongsa', 1),
(856, 62, 'Tsirang', 1),
(857, 63, 'Wangdue Phodrang', 1),
(858, 64, 'Zhemgang', 1),
(859, 65, 'Jitpur', 1),
(860, 65, 'Bhaktapur', 1),
(861, 65, 'Kirtipur', 1),
(862, 65, 'Panauti', 1),
(863, 65, 'Bidur', 1),
(864, 70, 'Biratnagar', 1),
(865, 70, 'Dharan', 1),
(866, 70, 'Itahari', 1),
(867, 71, 'Bharatpur', 1),
(868, 71, 'Birganj', 1),
(869, 71, 'Hetauda', 1),
(870, 72, 'Butwal', 1),
(871, 72, 'Bhairahawa', 1),
(872, 72, 'Palpa', 1),
(873, 73, 'Dhangadhi', 1),
(874, 73, 'Tikapur', 1),
(875, 73, 'Godawari', 1),
(876, 74, 'Janakpur', 1),
(877, 75, 'Nepalganj', 1),
(878, 75, 'Gulariya', 1),
(879, 75, 'Birendranagar', 1),
(880, 76, 'Tulsipur', 1),
(881, 77, 'Hanumannagar', 1),
(882, 77, 'Siraha', 1);

-- --------------------------------------------------------

--
-- Table structure for table `adv_cron_package_log`
--

DROP TABLE IF EXISTS `adv_cron_package_log`;
CREATE TABLE IF NOT EXISTS `adv_cron_package_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `log_desc` text NOT NULL,
  `status` int(11) NOT NULL DEFAULT '0',
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `adv_product_view`
--

DROP TABLE IF EXISTS `adv_product_view`;
CREATE TABLE IF NOT EXISTS `adv_product_view` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `shop_id` int(11) NOT NULL DEFAULT '0',
  `product_id` int(11) NOT NULL DEFAULT '0',
  `ip_address` varchar(100) NOT NULL,
  `city` varchar(100) NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `adv_shop_address`
--

DROP TABLE IF EXISTS `adv_shop_address`;
CREATE TABLE IF NOT EXISTS `adv_shop_address` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL DEFAULT '0',
  `user_type` int(11) NOT NULL DEFAULT '0',
  `type` int(11) NOT NULL DEFAULT '1',
  `name` varchar(150) NOT NULL,
  `mobile` varchar(10) NOT NULL,
  `address_1` varchar(250) NOT NULL,
  `address_2` varchar(250) NOT NULL,
  `landmark` varchar(200) NOT NULL,
  `city` int(11) NOT NULL DEFAULT '0',
  `state` int(11) NOT NULL DEFAULT '0',
  `pincode` varchar(20) NOT NULL,
  `status` int(11) NOT NULL DEFAULT '1',
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `adv_shop_category`
--

DROP TABLE IF EXISTS `adv_shop_category`;
CREATE TABLE IF NOT EXISTS `adv_shop_category` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `parent_id` int(11) NOT NULL DEFAULT '0',
  `category_name` varchar(250) NOT NULL,
  `slug` text NOT NULL,
  `sort_order` int(11) NOT NULL,
  `meta_title` varchar(250) NOT NULL,
  `meta_keyword` varchar(250) NOT NULL,
  `fee_comm` int(11) NOT NULL,
  `meta_desc` varchar(250) NOT NULL,
  `status` int(11) NOT NULL DEFAULT '0',
  `craeted` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `adv_shop_coupon`
--

DROP TABLE IF EXISTS `adv_shop_coupon`;
CREATE TABLE IF NOT EXISTS `adv_shop_coupon` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(250) NOT NULL,
  `code` varchar(100) NOT NULL,
  `type` int(11) NOT NULL DEFAULT '0',
  `val` varchar(100) NOT NULL,
  `max_val` varchar(100) NOT NULL,
  `cart_limit` varchar(100) NOT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `adv_shop_finance`
--

DROP TABLE IF EXISTS `adv_shop_finance`;
CREATE TABLE IF NOT EXISTS `adv_shop_finance` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `shop_id` int(11) NOT NULL DEFAULT '0',
  `type` int(11) NOT NULL DEFAULT '0',
  `description` varchar(250) NOT NULL,
  `amount` double NOT NULL DEFAULT '0',
  `charges` double NOT NULL DEFAULT '0',
  `mode` int(11) NOT NULL DEFAULT '0',
  `total` int(11) NOT NULL DEFAULT '0',
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `adv_shop_main_banner`
--

DROP TABLE IF EXISTS `adv_shop_main_banner`;
CREATE TABLE IF NOT EXISTS `adv_shop_main_banner` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `banner_title` varchar(200) NOT NULL,
  `banner_url` varchar(250) NOT NULL,
  `sort_order` int(11) NOT NULL DEFAULT '0',
  `banner_image` varchar(200) NOT NULL,
  `status` int(11) NOT NULL DEFAULT '1',
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `adv_shop_mini_banner`
--

DROP TABLE IF EXISTS `adv_shop_mini_banner`;
CREATE TABLE IF NOT EXISTS `adv_shop_mini_banner` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `banner_title` varchar(200) NOT NULL,
  `banner_url` varchar(250) NOT NULL,
  `sort_order` int(11) NOT NULL DEFAULT '0',
  `banner_image` varchar(200) NOT NULL,
  `status` int(11) NOT NULL DEFAULT '1',
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `adv_shop_orders`
--

DROP TABLE IF EXISTS `adv_shop_orders`;
CREATE TABLE IF NOT EXISTS `adv_shop_orders` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order_id` varchar(200) NOT NULL,
  `user_id` int(11) NOT NULL DEFAULT '0',
  `user_type` int(11) NOT NULL DEFAULT '0',
  `amount` double NOT NULL DEFAULT '0',
  `ship_amount` double NOT NULL DEFAULT '0',
  `discount` double NOT NULL DEFAULT '0',
  `cpn_id` int(11) NOT NULL DEFAULT '0',
  `cpn_type` int(11) NOT NULL DEFAULT '0',
  `cpn_code` varchar(100) NOT NULL,
  `cpn_amt` double NOT NULL,
  `total` double NOT NULL DEFAULT '0',
  `pay_status` int(11) NOT NULL DEFAULT '0',
  `razorpay_id` varchar(250) NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `adv_shop_order_address`
--

DROP TABLE IF EXISTS `adv_shop_order_address`;
CREATE TABLE IF NOT EXISTS `adv_shop_order_address` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order_id` int(11) NOT NULL DEFAULT '0',
  `name` varchar(200) NOT NULL,
  `mobile` varchar(20) NOT NULL,
  `address` text NOT NULL,
  `city` varchar(150) NOT NULL,
  `state` varchar(150) NOT NULL,
  `pincode` varchar(10) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `adv_shop_order_log`
--

DROP TABLE IF EXISTS `adv_shop_order_log`;
CREATE TABLE IF NOT EXISTS `adv_shop_order_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order_id` int(11) NOT NULL DEFAULT '0',
  `product_id` int(11) NOT NULL DEFAULT '0',
  `ord_pr_id` int(11) NOT NULL DEFAULT '0',
  `status` int(11) NOT NULL DEFAULT '0',
  `message` text,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `adv_shop_order_products`
--

DROP TABLE IF EXISTS `adv_shop_order_products`;
CREATE TABLE IF NOT EXISTS `adv_shop_order_products` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order_id` int(11) NOT NULL,
  `shop_id` int(11) NOT NULL DEFAULT '0',
  `user_id` int(11) NOT NULL DEFAULT '0',
  `user_type` int(11) NOT NULL DEFAULT '0',
  `product_id` int(11) NOT NULL DEFAULT '0',
  `variants` varchar(250) NOT NULL,
  `qty` int(11) NOT NULL DEFAULT '0',
  `amount` double NOT NULL DEFAULT '0',
  `subtotal` double NOT NULL DEFAULT '0',
  `ship_charge` double NOT NULL DEFAULT '0',
  `total` double NOT NULL DEFAULT '0',
  `web_charge` double NOT NULL,
  `status` int(11) NOT NULL DEFAULT '0',
  `courier_company` varchar(250) NOT NULL,
  `tracking_url` text NOT NULL,
  `cancel_status` int(11) NOT NULL DEFAULT '0',
  `cancel_reason` varchar(250) NOT NULL,
  `cancel_by` int(11) NOT NULL DEFAULT '0',
  `received_by` varchar(250) NOT NULL,
  `return_date` date DEFAULT NULL,
  `return_status` int(11) NOT NULL DEFAULT '0',
  `return_reason` varchar(250) NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `adv_shop_product`
--

DROP TABLE IF EXISTS `adv_shop_product`;
CREATE TABLE IF NOT EXISTS `adv_shop_product` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `shop_id` int(11) NOT NULL DEFAULT '0',
  `product_id` varchar(150) NOT NULL,
  `product_name` varchar(250) NOT NULL,
  `slug` varchar(200) NOT NULL,
  `product_type` varchar(250) NOT NULL,
  `made_by` varchar(250) NOT NULL,
  `made_year` int(11) NOT NULL,
  `category` text NOT NULL,
  `var_group` int(11) NOT NULL,
  `variants` text NOT NULL,
  `sort_order` int(11) NOT NULL DEFAULT '0',
  `product_desc` longtext NOT NULL,
  `section` int(11) NOT NULL DEFAULT '0',
  `price` double NOT NULL DEFAULT '0',
  `sell_price` int(11) NOT NULL DEFAULT '0',
  `qty` int(11) NOT NULL DEFAULT '0',
  `delivery` varchar(250) NOT NULL,
  `delivery_opt` varchar(200) NOT NULL,
  `days1` varchar(120) NOT NULL,
  `days2` varchar(100) NOT NULL,
  `delivery_type` int(11) NOT NULL DEFAULT '0',
  `delivery_fee` int(11) NOT NULL DEFAULT '0',
  `shop_feature` int(11) NOT NULL DEFAULT '0',
  `shop_feature_ord` int(11) NOT NULL DEFAULT '0',
  `status` int(11) NOT NULL DEFAULT '1',
  `product_return` int(11) NOT NULL DEFAULT '0',
  `return_days` int(11) NOT NULL DEFAULT '0',
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `adv_shop_product_image`
--

DROP TABLE IF EXISTS `adv_shop_product_image`;
CREATE TABLE IF NOT EXISTS `adv_shop_product_image` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `shop_id` int(11) NOT NULL DEFAULT '0',
  `product_id` varchar(100) NOT NULL,
  `product_image` varchar(255) NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `adv_shop_product_review`
--

DROP TABLE IF EXISTS `adv_shop_product_review`;
CREATE TABLE IF NOT EXISTS `adv_shop_product_review` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL DEFAULT '0',
  `user_type` int(11) NOT NULL DEFAULT '0',
  `product_id` int(11) NOT NULL,
  `review` longtext NOT NULL,
  `rating` int(11) NOT NULL DEFAULT '0',
  `status` int(11) NOT NULL DEFAULT '0',
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `adv_shop_product_variant`
--

DROP TABLE IF EXISTS `adv_shop_product_variant`;
CREATE TABLE IF NOT EXISTS `adv_shop_product_variant` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  `pro_id` int(11) NOT NULL DEFAULT '0',
  `var_id` int(11) NOT NULL DEFAULT '0',
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `adv_shop_product_video`
--

DROP TABLE IF EXISTS `adv_shop_product_video`;
CREATE TABLE IF NOT EXISTS `adv_shop_product_video` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `shop_id` int(11) NOT NULL DEFAULT '0',
  `product_id` int(11) NOT NULL DEFAULT '0',
  `video_name` varchar(250) NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `adv_shop_review`
--

DROP TABLE IF EXISTS `adv_shop_review`;
CREATE TABLE IF NOT EXISTS `adv_shop_review` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(200) NOT NULL,
  `user_id` int(11) NOT NULL DEFAULT '0',
  `user_type` int(11) NOT NULL DEFAULT '0',
  `message` varchar(250) NOT NULL,
  `shop_rating` int(11) NOT NULL DEFAULT '0',
  `status` int(11) NOT NULL DEFAULT '1',
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `adv_shop_section`
--

DROP TABLE IF EXISTS `adv_shop_section`;
CREATE TABLE IF NOT EXISTS `adv_shop_section` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `shop_id` int(11) NOT NULL DEFAULT '0',
  `shop_section` varchar(250) NOT NULL,
  `status` varchar(250) NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `adv_shop_settelment`
--

DROP TABLE IF EXISTS `adv_shop_settelment`;
CREATE TABLE IF NOT EXISTS `adv_shop_settelment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `shop_id` int(11) NOT NULL DEFAULT '0',
  `amount` double NOT NULL DEFAULT '0',
  `remark` varchar(250) NOT NULL,
  `status` int(11) NOT NULL DEFAULT '0',
  `created` date DEFAULT NULL,
  `modify_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `adv_shop_views`
--

DROP TABLE IF EXISTS `adv_shop_views`;
CREATE TABLE IF NOT EXISTS `adv_shop_views` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ip_address` varchar(100) NOT NULL,
  `city` varchar(200) NOT NULL,
  `shop_id` int(11) NOT NULL DEFAULT '0',
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `adv_store`
--

DROP TABLE IF EXISTS `adv_store`;
CREATE TABLE IF NOT EXISTS `adv_store` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(100) NOT NULL,
  `store_name` varchar(160) NOT NULL,
  `owner_name` varchar(160) NOT NULL,
  `owner_id` int(11) NOT NULL DEFAULT '0',
  `owner_type` int(11) NOT NULL DEFAULT '0',
  `store_img` varchar(250) NOT NULL,
  `slug` varchar(200) NOT NULL,
  `pan_no` varchar(100) NOT NULL,
  `gst_no` varchar(100) NOT NULL,
  `bank_name` varchar(100) NOT NULL,
  `bank_acc_no` varchar(100) NOT NULL,
  `bank_ifsc` varchar(100) NOT NULL,
  `branch_name` varchar(200) NOT NULL,
  `about_shop` text NOT NULL,
  `shop_desc` varchar(200) NOT NULL,
  `meta_title` varchar(250) NOT NULL,
  `meta_keyword` varchar(250) NOT NULL,
  `meta_desc` varchar(250) NOT NULL,
  `announcement` text NOT NULL,
  `policy` text NOT NULL,
  `bnr_type` int(11) NOT NULL DEFAULT '0',
  `big_bnr` varchar(250) NOT NULL,
  `mini_bnr` varchar(250) NOT NULL,
  `four_bnr` text NOT NULL,
  `wallet` double NOT NULL DEFAULT '0',
  `status` int(11) NOT NULL DEFAULT '0',
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `adv_wishlist`
--

DROP TABLE IF EXISTS `adv_wishlist`;
CREATE TABLE IF NOT EXISTS `adv_wishlist` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL DEFAULT '0',
  `user_type` int(11) NOT NULL DEFAULT '0' COMMENT '1 for artist, 2 for enthusiast',
  `shop_id` int(11) NOT NULL DEFAULT '0',
  `product_id` int(11) NOT NULL DEFAULT '0',
  `product_name` varchar(250) NOT NULL,
  `qty` int(11) NOT NULL DEFAULT '0',
  `attribute` varchar(200) NOT NULL,
  `price` double NOT NULL DEFAULT '0',
  `sell_price` double NOT NULL DEFAULT '0',
  `shipping_charge` varchar(100) NOT NULL,
  `total` double NOT NULL,
  `status` int(11) NOT NULL DEFAULT '1',
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
