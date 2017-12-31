-- phpMyAdmin SQL Dump
-- version 4.6.5.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 31, 2017 at 10:39 PM
-- Server version: 10.1.21-MariaDB
-- PHP Version: 5.6.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `koeldb`
--

-- --------------------------------------------------------

--
-- Table structure for table `albums`
--

CREATE TABLE `albums` (
  `id` int(10) UNSIGNED NOT NULL,
  `artist_id` int(10) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `cover` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `albums`
--

INSERT INTO `albums` (`id`, `artist_id`, `name`, `cover`, `created_at`, `updated_at`) VALUES
(1, 1, 'Unknown Album', 'unknown-album.png', '2017-12-24 01:42:12', '2017-12-24 01:42:12'),
(6, 2, 'Wind Octet in E flat major, Op. 103', '', '2018-01-01 02:08:40', '2018-01-01 02:08:40'),
(7, 2, 'Ein ungefärbt Gemüte, BWV 24', '', '2018-01-01 02:08:40', '2018-01-01 02:08:40');

-- --------------------------------------------------------

--
-- Table structure for table `artists`
--

CREATE TABLE `artists` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `image` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `artists`
--

INSERT INTO `artists` (`id`, `name`, `image`, `created_at`, `updated_at`) VALUES
(1, 'Unknown Artist', NULL, '2017-12-24 01:42:12', '2017-12-24 01:42:12'),
(2, 'Various Artists', NULL, '2017-12-24 01:28:02', '2017-12-24 01:28:02'),
(6, 'Soni Ventorum & Guests', NULL, '2018-01-01 02:04:12', '2018-01-01 02:04:12');

-- --------------------------------------------------------

--
-- Table structure for table `interactions`
--

CREATE TABLE `interactions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `song_id` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL,
  `liked` tinyint(1) NOT NULL DEFAULT '0',
  `play_count` int(11) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `listen_time` double(8,2) NOT NULL DEFAULT '0.00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `interactions`
--

INSERT INTO `interactions` (`id`, `user_id`, `song_id`, `liked`, `play_count`, `created_at`, `updated_at`, `listen_time`) VALUES
(11, 1, '321516276cf968cd97c8f9e75c193201', 0, 2, '2018-01-01 02:09:25', '2018-01-01 02:10:51', 55.52),
(12, 1, '974b29cffbc84136014d832de145be31', 0, 1, '2018-01-01 02:09:51', '2018-01-01 02:10:11', 40.69),
(13, 1, '5fc731ddb2c27c88e93297ebdc26dfe4', 0, 3, '2018-01-01 02:11:47', '2018-01-01 02:12:40', 43.99),
(14, 22, '321516276cf968cd97c8f9e75c193201', 0, 2, '2018-01-01 02:16:50', '2018-01-01 02:17:34', 97.07),
(15, 22, '974b29cffbc84136014d832de145be31', 0, 1, '2018-01-01 02:17:09', '2018-01-01 02:17:10', 186.65),
(16, 23, '5fc731ddb2c27c88e93297ebdc26dfe4', 0, 1, '2018-01-01 02:18:31', '2018-01-01 02:18:32', 26.70);

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_10_12_000000_create_users_table', 1),
(2, '2014_10_12_100000_create_password_resets_table', 1),
(3, '2015_11_23_074600_create_artists_table', 1),
(4, '2015_11_23_074709_create_albums_table', 1),
(5, '2015_11_23_074713_create_songs_table', 1),
(6, '2015_11_23_074723_create_playlists_table', 1),
(7, '2015_11_23_074733_create_interactions_table', 1),
(8, '2015_11_23_082854_create_playlist_song_table', 1),
(9, '2015_11_25_033351_create_settings_table', 1),
(10, '2015_12_18_072523_add_preferences_to_users_table', 1),
(11, '2015_12_22_092542_add_image_to_artists_table', 1),
(12, '2016_03_20_134512_add_track_into_songs', 1),
(13, '2016_04_15_121215_add_is_complilation_into_albums', 1),
(14, '2016_04_15_125237_add_contributing_artist_id_into_songs', 1),
(15, '2016_04_16_082627_create_various_artists', 1),
(16, '2016_06_16_134516_cascade_delete_user', 1),
(17, '2016_07_09_054503_fix_artist_autoindex_value', 1),
(18, '2017_04_21_092159_copy_artist_to_contributing_artist', 1),
(19, '2017_04_22_161504_drop_is_complication_from_albums', 1),
(20, '2017_04_29_025836_rename_contributing_artist_id', 2),
(21, '2017_11_27_184010_add_disc_into_songs', 2),
(22, '2017_12_25_185024_add_wpid_field_to_users_table', 3),
(23, '2016_06_01_000001_create_oauth_auth_codes_table', 4),
(24, '2016_06_01_000002_create_oauth_access_tokens_table', 4),
(25, '2016_06_01_000003_create_oauth_refresh_tokens_table', 4),
(26, '2016_06_01_000004_create_oauth_clients_table', 4),
(27, '2016_06_01_000005_create_oauth_personal_access_clients_table', 4),
(28, '2017_12_30_171702_add_listentime_to_interactions_table', 5),
(29, '2017_12_31_161541_create_play_log_table', 6);

-- --------------------------------------------------------

--
-- Table structure for table `oauth_access_tokens`
--

CREATE TABLE `oauth_access_tokens` (
  `id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `client_id` int(11) NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `scopes` text COLLATE utf8mb4_unicode_ci,
  `revoked` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `expires_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `oauth_access_tokens`
--

INSERT INTO `oauth_access_tokens` (`id`, `user_id`, `client_id`, `name`, `scopes`, `revoked`, `created_at`, `updated_at`, `expires_at`) VALUES
('03d336390bf9121f487f81544e9827e578b261414d6ffeba56fe6db61f121a8962929b77db6a5c97', NULL, 3, NULL, '[]', 0, '2017-12-31 04:32:18', '2017-12-31 04:32:18', '2018-12-30 23:32:18'),
('05a4964af7ee240050f12166743cf95c705b97d1dd6dfd57b4dc8422f64f9165387d5397ca09e2bf', NULL, 3, NULL, '[]', 0, '2017-12-31 09:50:41', '2017-12-31 09:50:41', '2018-12-31 04:50:41'),
('13b11d7ea89d221f3ca03b3fb3e7e4428c2814015c505255adfd24d5861ead7d41101b68ef7bfde7', NULL, 3, NULL, '[]', 0, '2017-12-31 04:31:24', '2017-12-31 04:31:24', '2018-12-30 23:31:24'),
('15548baec1a2cc28974c831ffe6e1eb0bd66b363934bbb1399448a3a9b1f8b0f9a5bbe91eeaf6505', NULL, 3, NULL, '[]', 0, '2017-12-31 09:49:02', '2017-12-31 09:49:02', '2018-12-31 04:49:02'),
('1584b2d1c3d51cc886bbe4e21081e782149f77751379d392d0ab6d11932f9ab9a7e81fe4babe7e10', NULL, 3, NULL, '[]', 0, '2017-12-31 09:46:13', '2017-12-31 09:46:13', '2018-12-31 04:46:13'),
('1c5a70bdbc2bfd9a837d8be7f5568686ff403eb3502e414d4db83eb796f0a82cb899717eae0521df', NULL, 3, NULL, '[]', 0, '2018-01-01 01:49:33', '2018-01-01 01:49:33', '2018-12-31 20:49:33'),
('1c620fa176c812f82530e14e3e582aa68a7ecb384b2a949f4380aa730abc1a39a602e79f7f9ed837', NULL, 3, NULL, '[]', 0, '2017-12-31 03:52:54', '2017-12-31 03:52:54', '2018-12-30 22:52:54'),
('1f4561718fd75aa4bfe9ec3b657b23a4c46f0f73f168eec81d9e57011d9d1f3deba73070c7ea181b', NULL, 3, NULL, '[]', 0, '2017-12-31 08:54:12', '2017-12-31 08:54:12', '2018-12-31 03:54:12'),
('222efd258745b51315f454585ac152d321d22f15fd364c368ebf3a89993d9bba703695a557b2a3fb', NULL, 3, NULL, '[]', 0, '2018-01-01 01:50:34', '2018-01-01 01:50:34', '2018-12-31 20:50:34'),
('22b9b2bee954c46a635ef4db5b20b09b1b65bd19cc80d526acb83adb3d388c96ebdd055daa803a32', NULL, 3, NULL, '[]', 0, '2017-12-31 03:49:24', '2017-12-31 03:49:24', '2018-12-30 22:49:24'),
('25582d572a39a9c7b23760850428a4d41d63ef9a58d9fb4b4fc97c3a583a9982b6cb6bbcf0fa86c4', NULL, 3, NULL, '[]', 0, '2017-12-31 04:34:07', '2017-12-31 04:34:07', '2018-12-30 23:34:07'),
('27befd13ac09ff0fd75f20ac81b69e81c358042463446701c6b3e02815b571418c03740091c02c41', NULL, 3, NULL, '[]', 0, '2017-12-31 09:16:12', '2017-12-31 09:16:12', '2018-12-31 04:16:12'),
('28a9610c2417a449d6bfb5b2337e43ab4993ee94f1311fa686004e9d9f418a13e812b1e80506c346', NULL, 3, NULL, '[]', 0, '2018-01-01 01:49:08', '2018-01-01 01:49:08', '2018-12-31 20:49:08'),
('297a9c2826447c5a24587911915cc5b994ff39b9f017db5a3846ffdf5a0fcfd0a69e459f8dc6f1eb', NULL, 3, NULL, '[]', 0, '2017-12-31 03:39:03', '2017-12-31 03:39:03', '2018-12-30 22:39:03'),
('2b58d67858c2772206711e0b2bc11cb1d9b8d8a5dc86369e902f0484c2dcd08eb113b6ddbd3817ef', NULL, 3, NULL, '[]', 0, '2017-12-31 09:23:21', '2017-12-31 09:23:21', '2018-12-31 04:23:21'),
('2b96def7f3613d4d5513998bfe82d5266c9ac84ab8fb0694068f56d08401f0edd214324f3995849b', NULL, 3, NULL, '[]', 0, '2017-12-31 04:30:09', '2017-12-31 04:30:09', '2018-12-30 23:30:09'),
('2bcebb353b2435c6f74a00b9d2ad6a56ed7f731dcda701c107be735fcd4e617af2e90849033bfaf7', NULL, 3, NULL, '[]', 0, '2017-12-31 08:54:49', '2017-12-31 08:54:49', '2018-12-31 03:54:49'),
('2d8ecf991d565199f3b26b45eeaf4df72d2af98633bd76de9a68350d640d559dd8787f1766fdeb34', NULL, 3, NULL, '[]', 0, '2017-12-31 03:40:21', '2017-12-31 03:40:21', '2018-12-30 22:40:21'),
('2fe3f1b55c522cd67dd41393db2964192df5c67db13db26aefe3ccc313e4ca64ffdaee9af8bd2230', NULL, 3, NULL, '[]', 0, '2017-12-31 07:27:26', '2017-12-31 07:27:26', '2018-12-31 02:27:26'),
('348678d59589d15f53a91c1879059d8ff2f928e5c5ebad18c5d3030c6fecb3686d9310fa937b3954', NULL, 3, NULL, '[]', 0, '2017-12-31 03:33:14', '2017-12-31 03:33:14', '2018-12-30 22:33:14'),
('36fcb0f8512d5ee830edc9de214727bea47158c966e0de4c7aa569e705a9f5a86550abf70000593a', NULL, 3, NULL, '[]', 0, '2017-12-31 04:10:21', '2017-12-31 04:10:21', '2018-12-30 23:10:21'),
('39d49fc36096177a14899c43c52bc8b242a7f8fe130f085f83662667800dd7462ed549ddfcd29370', NULL, 3, NULL, '[]', 0, '2017-12-31 08:55:13', '2017-12-31 08:55:13', '2018-12-31 03:55:13'),
('3cf78dd8456bc95137c2eb42dc3291ce5647ac026d221be93ff53280b067d618e77b6714c11473df', NULL, 3, NULL, '[]', 0, '2018-01-01 01:32:27', '2018-01-01 01:32:27', '2018-12-31 20:32:27'),
('3dba0498e029151750bb18f6c32dbc113021dfd1ce43dd0a0587c839bcd9fee15c8ceeb355a44369', NULL, 3, NULL, '[]', 0, '2017-12-31 03:43:25', '2017-12-31 03:43:25', '2018-12-30 22:43:25'),
('3e2433825258a4cb6c17940906c46b75328cca904a0456c09dbb57347295371f92530dc211edd98c', NULL, 3, NULL, '[]', 0, '2017-12-31 08:55:29', '2017-12-31 08:55:29', '2018-12-31 03:55:29'),
('3eddd81a0d4df2d9568ef2331c7c842f88d8875b1606ab901d7c35989841279bb27c593f56fdbb9c', NULL, 3, NULL, '[]', 0, '2017-12-31 03:46:55', '2017-12-31 03:46:55', '2018-12-30 22:46:55'),
('51ebc53602e1a5362e8f43fe16a2407a3c44e2d72a8971bc7ae1e9755f54b3a8d17c8e646d357912', NULL, 3, NULL, '[]', 0, '2017-12-31 03:51:02', '2017-12-31 03:51:02', '2018-12-30 22:51:02'),
('57baed7d8b6d1b08d495069d2ffd4030b12234386dae4b5bb00ef8c8ced0962323dfc110cb5ada02', NULL, 3, NULL, '[]', 0, '2017-12-31 07:06:10', '2017-12-31 07:06:10', '2018-12-31 02:06:10'),
('5815f2080d55b7586cd931344de62a412cea3a836ba952144ea96f80267760e4e88bca89c77cc9bf', NULL, 3, NULL, '[]', 0, '2017-12-31 04:08:13', '2017-12-31 04:08:13', '2018-12-30 23:08:13'),
('59877e5a7892ae324df8f445a4a636e20a005838c277e246e4b55b844b9ed4b9376fbf9acee0f8c7', NULL, 3, NULL, '[]', 0, '2017-12-31 03:47:57', '2017-12-31 03:47:57', '2018-12-30 22:47:57'),
('5be5dff3bfe662272f3cf19b643014da84e40ba83bd6fcefde2c92045e2bc45844fd380bd19db55f', NULL, 3, NULL, '[]', 0, '2017-12-31 08:52:07', '2017-12-31 08:52:07', '2018-12-31 03:52:07'),
('5f30f1c6048b0c49ec4c8bd49b23b9c75144d70fa821731bc2579d2eac22775e894560843dad75cd', NULL, 3, NULL, '[]', 0, '2017-12-31 08:53:51', '2017-12-31 08:53:51', '2018-12-31 03:53:51'),
('6100f5b878696e92e57ffcf583a04e720af11c3fc255fa626fa3f5c3148ca40f704b35dd7c23c59a', NULL, 3, NULL, '[]', 0, '2017-12-31 03:46:35', '2017-12-31 03:46:35', '2018-12-30 22:46:35'),
('65a145967ab809db5b5de9f55adb1aca12d26d9124077f8efb0225e5811d6dc74df9330b95bf91d9', NULL, 3, NULL, '[]', 0, '2017-12-31 04:30:38', '2017-12-31 04:30:38', '2018-12-30 23:30:38'),
('672598594ddb89e8fac56913ea9a6371b0cc43241e2e4ffea59997cedf91b53f2eb7b43e11eeaa3d', NULL, 3, NULL, '[]', 0, '2017-12-31 07:05:14', '2017-12-31 07:05:14', '2018-12-31 02:05:14'),
('69df4b44d8867a529fd843f091947f0587fb76fac44d88ed1e9416af32c11b29273781f00afec425', NULL, 3, NULL, '[]', 0, '2017-12-31 07:16:48', '2017-12-31 07:16:48', '2018-12-31 02:16:48'),
('6b8fbc85fb9b1b347a756653e28cd54a192c7c92ca8c38c62cb1baaef02bcdd4cb30bbedf1be4438', NULL, 3, NULL, '[]', 0, '2017-12-31 03:43:05', '2017-12-31 03:43:05', '2018-12-30 22:43:05'),
('6d99591208d68e664fd4c91ad03ac75d2e3ae09ec95c4327b061ffaf37ea9596a60831d709352475', NULL, 3, NULL, '[]', 0, '2017-12-31 10:59:03', '2017-12-31 10:59:03', '2018-12-31 05:59:03'),
('6f87a6a810f066278831e0f8ccb1ad7a548b11fdcbb9f95c8b2c36b6d05a0779b5b1d7718ad71917', NULL, 3, NULL, '[]', 0, '2017-12-31 09:54:06', '2017-12-31 09:54:06', '2018-12-31 04:54:06'),
('6ff3d1edf653528a28d56e2d260119e56003d807fc5177be149130f620e75a5a84b328c59264a71b', NULL, 3, NULL, '[]', 0, '2017-12-31 09:16:36', '2017-12-31 09:16:36', '2018-12-31 04:16:36'),
('737203cb483e92c4103ea51fce91238ea629c1aa56de6938e58391cc39194cbab5a371f1c5fa5de5', NULL, 3, NULL, '[]', 0, '2017-12-31 03:47:15', '2017-12-31 03:47:15', '2018-12-30 22:47:15'),
('7486fda7f9e09f2a9c59c8d4c00e56fef5194135dd1696a4a49606993b8b71f8f3d6b485c4165a5d', NULL, 3, NULL, '[]', 0, '2017-12-31 04:19:44', '2017-12-31 04:19:44', '2018-12-30 23:19:44'),
('78e31599568f5a71abb0361ea18a2b2f1ac110817c6b354631db573b80b69c0f49c56210fa5341af', NULL, 3, NULL, '[]', 0, '2017-12-31 09:50:39', '2017-12-31 09:50:39', '2018-12-31 04:50:39'),
('7a65da50a46a2829882cf049c09e534bcbccb0d577d159b7933181275e62da78ef6b4c072d9d0889', NULL, 3, NULL, '[]', 0, '2017-12-31 10:12:02', '2017-12-31 10:12:02', '2018-12-31 05:12:02'),
('7b7f170c6131a7c0f6cb5f13a43fd04be99eee7c1bea89b84be068f2f35ce60ef9c3826c59f950f1', NULL, 3, NULL, '[]', 0, '2017-12-31 10:06:07', '2017-12-31 10:06:07', '2018-12-31 05:06:07'),
('7cead3e51e32e9cf3ed747e9cf6f6419740fe8ef614dd011d6046bc65d18d126ce0201660d767938', NULL, 3, NULL, '[]', 0, '2017-12-31 03:38:17', '2017-12-31 03:38:17', '2018-12-30 22:38:17'),
('7ec17ae09230e5673d497c434ee011ab88d15e17d3d746f0a4ab02ce79b0b885c33b2ba65cba01e9', NULL, 3, NULL, '[]', 0, '2017-12-31 07:03:39', '2017-12-31 07:03:39', '2018-12-31 02:03:39'),
('8256fa1628fc9a979ec5c508f3261666dc3f9c6509ee78aa4e5ac3642c8195f8c8694f2f8ffdc678', NULL, 3, NULL, '[]', 0, '2018-01-01 02:19:37', '2018-01-01 02:19:37', '2018-12-31 21:19:37'),
('84e2de9d79d000fbe151ead3e9c82d910bc9703448f33d2ea7422ecc90a3cf2fcba7f671e4dd3757', NULL, 3, NULL, '[]', 0, '2017-12-31 03:50:37', '2017-12-31 03:50:37', '2018-12-30 22:50:37'),
('89454c230106f49c48795d5bc44061aa10ffb931d0ddfd32e98547f79f55b7869ec41456bd0c0a97', NULL, 3, NULL, '[]', 0, '2017-12-31 04:21:26', '2017-12-31 04:21:26', '2018-12-30 23:21:26'),
('8e28762b7ff263be4d901c93f448d54e5482aad07625cd39438a81ec14d2d2f16e264786632a9850', NULL, 3, NULL, '[]', 0, '2017-12-31 10:46:15', '2017-12-31 10:46:15', '2018-12-31 05:46:15'),
('926e863f4496d3499283676e4f0acb7b44fb98f1692bcf5dfec6998e95ec97b5244be94ef8f389a5', NULL, 3, NULL, '[]', 0, '2018-01-01 01:09:01', '2018-01-01 01:09:01', '2018-12-31 20:09:01'),
('98f173b779cd68c04134fc74a67ca6dd9aa10a9fdc6e8c907bf466d893f5a01ec8df4761a95362de', NULL, 3, NULL, '[]', 0, '2017-12-31 03:49:11', '2017-12-31 03:49:11', '2018-12-30 22:49:11'),
('9d0a1900131c24ff0b43b5e2e36ba9828f40d4b55898fa17d3732a9e8bf20ec7a33702874c42e54d', NULL, 3, NULL, '[]', 0, '2017-12-31 11:02:42', '2017-12-31 11:02:42', '2018-12-31 06:02:42'),
('a033a61b33ca31edca7b3f61d882c50dce7c0649fc90d7e14224f8d55972f80c368fa8cd64e4d558', NULL, 3, NULL, '[]', 0, '2017-12-31 03:50:41', '2017-12-31 03:50:41', '2018-12-30 22:50:41'),
('a6886ac6c32859d5529f47cd7fe7c776097fe2151ece745e3c584f00a8ff379e8dcff0354fac0a31', NULL, 3, NULL, '[]', 0, '2017-12-31 08:51:31', '2017-12-31 08:51:31', '2018-12-31 03:51:31'),
('a6ca014c4fd053d550c59eec1420fc68db3a7e5f828752e7b24f81b9575ee0d2a37929264842fc22', NULL, 3, NULL, '[]', 0, '2017-12-31 10:06:16', '2017-12-31 10:06:16', '2018-12-31 05:06:16'),
('a8473b6f6f9403c0a6d83a87c495608fc0059b989ea0c395c2c5d10e3aa4965a06080fcd06536f53', NULL, 3, NULL, '[]', 0, '2017-12-31 03:48:30', '2017-12-31 03:48:30', '2018-12-30 22:48:30'),
('b09c55cdbafe2d578e7d8541a8dd50e0e1c6e92ad29be9692216d6c98b62e37e71e76ae663bbeefd', NULL, 3, NULL, '[]', 0, '2017-12-31 04:34:18', '2017-12-31 04:34:18', '2018-12-30 23:34:18'),
('bece2ce4129378a16acd5e92384059c69d352c7a09cfa85f0003f7a476823423e842559c19735d02', NULL, 3, NULL, '[]', 0, '2017-12-31 09:50:42', '2017-12-31 09:50:42', '2018-12-31 04:50:42'),
('c375f048b8ab6cf53c38c3819a0b749d3fc83a827400f22fb80b94619fc6b021fa6ecb67deea7394', NULL, 3, NULL, '[]', 0, '2018-01-01 01:31:09', '2018-01-01 01:31:09', '2018-12-31 20:31:09'),
('c479646bca7351f6785ebc03b5ee77e9afb261529d8204b546c26339ee1647a38ad67fb800b4b475', NULL, 3, NULL, '[]', 0, '2017-12-31 09:01:48', '2017-12-31 09:01:48', '2018-12-31 04:01:48'),
('c7ca99e9df91ca4e5e3c395339b42276e39f98b46b0f7b98f7209362943e6decba53854d43396f38', NULL, 3, NULL, '[]', 0, '2017-12-31 07:25:22', '2017-12-31 07:25:22', '2018-12-31 02:25:22'),
('cb8a0bf3ad8782a596a6be5212c1441cabfbfd16f1b3b1a540d744c5ed0d9fc15fa697987da1630f', NULL, 3, NULL, '[]', 0, '2017-12-31 09:36:07', '2017-12-31 09:36:07', '2018-12-31 04:36:07'),
('ccd1087346c602e8cff36b49103edf035fbce532b71a88170d85ce7e6428b4d219226516e66dbe38', NULL, 3, NULL, '[]', 0, '2017-12-31 04:34:26', '2017-12-31 04:34:26', '2018-12-30 23:34:26'),
('cd1f616b2e3ec80c045c4bae6b7fb9475d3cfbb7cb1da7c67265c86fb2f0e6cd4ccfe0037bfb5308', NULL, 3, NULL, '[]', 0, '2017-12-31 02:36:22', '2017-12-31 02:36:22', '2018-12-30 21:36:22'),
('ce15c8ad1fd9565d3479f9d4843bd11635baad4fcdae0f37ca70dfd67f24aa7753737a1625e7b20b', NULL, 3, NULL, '[]', 0, '2017-12-31 03:49:01', '2017-12-31 03:49:01', '2018-12-30 22:49:01'),
('daf1c3ffe0c6e4226a1f6c297bceb6f77374f30cd19593b09b12e675c1d6b0834465d68e0aff847d', NULL, 3, NULL, '[]', 0, '2017-12-31 04:31:49', '2017-12-31 04:31:49', '2018-12-30 23:31:49'),
('e0a054cb5edb284e4761d58d3372719d34040e5253ce372b1b6d4233bf6eb61ce21b869ab77f0edd', NULL, 3, NULL, '[]', 0, '2017-12-31 11:56:46', '2017-12-31 11:56:46', '2018-12-31 06:56:46'),
('e8e08285bf43f229e859658587f6608b3135b2ece7c9854c3827edbad9f97385ee8d75d3674a559c', NULL, 3, NULL, '[]', 0, '2017-12-31 03:50:07', '2017-12-31 03:50:07', '2018-12-30 22:50:07'),
('e9735c786b85af39721a84fdb4cc6de7d768953e8342ac72d7d5ab197ce292abdc6f4c191585c0eb', NULL, 3, NULL, '[]', 0, '2017-12-31 09:44:35', '2017-12-31 09:44:35', '2018-12-31 04:44:35'),
('e9bbcf7cab7fcb2a4ed01837e8dd5ae6739d766ab52c6a4895626c068035612b2f277755bbfc704d', NULL, 3, NULL, '[]', 0, '2017-12-31 11:57:09', '2017-12-31 11:57:09', '2018-12-31 06:57:09'),
('eacd7da76a858788cc4d8318084bd471ba14564b9ee777531027895cd7ae9eac5d88121c7981c140', NULL, 3, NULL, '[]', 0, '2017-12-31 04:08:39', '2017-12-31 04:08:39', '2018-12-30 23:08:39'),
('ed995f0a1d568e41c2afa04ce406d054bde39c3b47b81e17f9ace37a2a46fdc477844fb52af32c13', NULL, 3, NULL, '[]', 0, '2017-12-31 04:32:45', '2017-12-31 04:32:45', '2018-12-30 23:32:45'),
('ee59ab591c654884d9f6ebdab2c9799c56dca66f59e7dd4f670e64514f48c86a9b915c1371230776', NULL, 3, NULL, '[]', 0, '2017-12-28 23:37:22', '2017-12-28 23:37:22', '2018-12-28 18:37:22'),
('eed9e98c0efcd37cf40254f4542d301aec13edb995a4ea925b416332831830413b53034da83c57a1', NULL, 3, NULL, '[]', 0, '2017-12-31 09:06:58', '2017-12-31 09:06:58', '2018-12-31 04:06:58'),
('ef96a7e8c1c2ef698976af6ca3e0dfe2990f8414410dd3b39b1998e0877f2d734686c6a8aa2e7b81', NULL, 3, NULL, '[]', 0, '2017-12-31 10:57:18', '2017-12-31 10:57:18', '2018-12-31 05:57:18'),
('f3c5cf89d6d3ee016207ef437869866b9ba8563c694f5c8d206abc13108611ea51cd5c2f73629d35', NULL, 3, NULL, '[]', 0, '2017-12-31 04:33:35', '2017-12-31 04:33:35', '2018-12-30 23:33:35'),
('f8223abb2bba5be42765f6ee239d380d2003bfa9717e88f406b5cb87b976629809853aa58c7ed29d', NULL, 3, NULL, '[]', 0, '2017-12-31 10:04:17', '2017-12-31 10:04:17', '2018-12-31 05:04:17'),
('f84c8e93d7603cce44115201d6733924bb4864e09a7a8fe66333fd9eddfee8ce4320ecfbedbd0171', NULL, 3, NULL, '[]', 0, '2017-12-31 04:21:04', '2017-12-31 04:21:04', '2018-12-30 23:21:04'),
('fab8f1cde812d25160378de8d51c5f4ee3d802e3d671d2dadbf987ffb959cd3c0891f229fbdd0658', NULL, 3, NULL, '[]', 0, '2017-12-31 09:32:57', '2017-12-31 09:32:57', '2018-12-31 04:32:57'),
('fe2e3347d37e082cf966669b4ed620f791e932b2f6a5dd14004bdf54025523e693cb0a0f86bc33ce', NULL, 3, NULL, '[]', 0, '2017-12-31 07:15:34', '2017-12-31 07:15:34', '2018-12-31 02:15:34');

-- --------------------------------------------------------

--
-- Table structure for table `oauth_auth_codes`
--

CREATE TABLE `oauth_auth_codes` (
  `id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` int(11) NOT NULL,
  `client_id` int(11) NOT NULL,
  `scopes` text COLLATE utf8mb4_unicode_ci,
  `revoked` tinyint(1) NOT NULL,
  `expires_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `oauth_clients`
--

CREATE TABLE `oauth_clients` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `secret` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `redirect` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `personal_access_client` tinyint(1) NOT NULL,
  `password_client` tinyint(1) NOT NULL,
  `revoked` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `oauth_clients`
--

INSERT INTO `oauth_clients` (`id`, `user_id`, `name`, `secret`, `redirect`, `personal_access_client`, `password_client`, `revoked`, `created_at`, `updated_at`) VALUES
(1, NULL, ' Personal Access Client', 'i25ODRd9PN1dm4rwnSblVEm9yLc3vIpQSdE0289G', 'http://localhost', 1, 0, 0, '2017-12-28 23:18:15', '2017-12-28 23:18:15'),
(2, NULL, ' Password Grant Client', 'ZvesqEZRsgVjqSJSWAMF5iWBb1hywlm3vNG7VZhA', 'http://localhost', 0, 1, 0, '2017-12-28 23:18:15', '2017-12-28 23:18:15'),
(3, 1, 'WPAccess', 'U7d8HSSvsRz8WzL6YIGGdjB1nuhtws7RxWgFycjT', 'http://localhost/auth/callback', 0, 0, 0, '2017-12-28 23:22:15', '2017-12-28 23:22:15');

-- --------------------------------------------------------

--
-- Table structure for table `oauth_personal_access_clients`
--

CREATE TABLE `oauth_personal_access_clients` (
  `id` int(10) UNSIGNED NOT NULL,
  `client_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `oauth_personal_access_clients`
--

INSERT INTO `oauth_personal_access_clients` (`id`, `client_id`, `created_at`, `updated_at`) VALUES
(1, 1, '2017-12-28 23:18:15', '2017-12-28 23:18:15');

-- --------------------------------------------------------

--
-- Table structure for table `oauth_refresh_tokens`
--

CREATE TABLE `oauth_refresh_tokens` (
  `id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `access_token_id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `revoked` tinyint(1) NOT NULL,
  `expires_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `password_resets`
--

CREATE TABLE `password_resets` (
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `playlists`
--

CREATE TABLE `playlists` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `playlist_song`
--

CREATE TABLE `playlist_song` (
  `id` int(10) UNSIGNED NOT NULL,
  `playlist_id` int(10) UNSIGNED NOT NULL,
  `song_id` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `play_log`
--

CREATE TABLE `play_log` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `song_id` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `play_log`
--

INSERT INTO `play_log` (`id`, `user_id`, `song_id`, `created_at`, `updated_at`) VALUES
(13, 1, '321516276cf968cd97c8f9e75c193201', '2017-12-14 02:09:25', '2017-12-14 02:09:25'),
(14, 1, '974b29cffbc84136014d832de145be31', '2018-01-01 02:09:51', '2018-01-01 02:09:51'),
(15, 1, '321516276cf968cd97c8f9e75c193201', '2018-01-01 02:10:50', '2018-01-01 02:10:50'),
(16, 1, '5fc731ddb2c27c88e93297ebdc26dfe4', '2018-01-01 02:11:47', '2018-01-01 02:11:47'),
(17, 1, '5fc731ddb2c27c88e93297ebdc26dfe4', '2018-01-01 02:12:19', '2018-01-01 02:12:19'),
(18, 1, '5fc731ddb2c27c88e93297ebdc26dfe4', '2018-01-10 02:12:38', '2018-01-10 02:12:38'),
(19, 22, '321516276cf968cd97c8f9e75c193201', '2018-01-01 02:16:50', '2018-01-01 02:16:50'),
(20, 22, '974b29cffbc84136014d832de145be31', '2018-01-01 02:17:09', '2018-01-01 02:17:09'),
(21, 22, '321516276cf968cd97c8f9e75c193201', '2018-01-01 02:17:33', '2018-01-01 02:17:33'),
(22, 23, '5fc731ddb2c27c88e93297ebdc26dfe4', '2018-01-01 02:18:31', '2018-01-01 02:18:31');

-- --------------------------------------------------------

--
-- Table structure for table `settings`
--

CREATE TABLE `settings` (
  `key` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` text COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `settings`
--

INSERT INTO `settings` (`key`, `value`) VALUES
('media_path', 's:6:\"C:\\mp3\";');

-- --------------------------------------------------------

--
-- Table structure for table `songs`
--

CREATE TABLE `songs` (
  `id` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL,
  `album_id` int(10) UNSIGNED NOT NULL,
  `artist_id` int(10) UNSIGNED DEFAULT NULL,
  `title` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `length` double(8,2) NOT NULL,
  `track` int(11) DEFAULT NULL,
  `disc` int(11) NOT NULL DEFAULT '1',
  `lyrics` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `path` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `mtime` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `songs`
--

INSERT INTO `songs` (`id`, `album_id`, `artist_id`, `title`, `length`, `track`, `disc`, `lyrics`, `path`, `mtime`, `created_at`, `updated_at`) VALUES
('321516276cf968cd97c8f9e75c193201', 6, 6, 'Andante', 489.35, 0, 1, '', 'C:\\mp3\\3284_imslp64984-pmlp27872-3beethoven2-c6fa7eef-a32f-404b-9f62-409c3f48ec7b.mp3', 1514754450, '2018-01-01 02:04:12', '2018-01-01 02:08:40'),
('5fc731ddb2c27c88e93297ebdc26dfe4', 7, 1, 'Chorale', 154.15, 0, 1, '', 'C:\\mp3\\4211_ein-ungefarbt-gemuthe-bwv-24-chorale-organ-arr-1800d353-fa92-4a03-916f-5326e0513890.mp3', 1514754514, '2018-01-01 02:08:40', '2018-01-01 02:08:40'),
('974b29cffbc84136014d832de145be31', 6, 6, 'Allegro', 460.43, 0, 1, '', 'C:\\mp3\\3284_imslp64983-pmlp27872-2beethoven1-5131ff00-a9b3-49f9-b8fa-9916c825aa7c.mp3', 1514754412, '2018-01-01 02:04:12', '2018-01-01 02:08:40');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_admin` tinyint(1) NOT NULL DEFAULT '0',
  `preferences` text COLLATE utf8mb4_unicode_ci,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `wpid` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `password`, `is_admin`, `preferences`, `remember_token`, `created_at`, `updated_at`, `wpid`) VALUES
(1, 'salman', 'salmank94@gmail.com', '$2y$10$xJ.MY0OvHHqW.dCzo2YTFOCD7rLxCSuwuIfxN7uILulCT5bNUlFOO', 1, NULL, NULL, '2017-12-24 01:42:12', '2018-01-01 01:49:34', '1'),
(22, 'New KoelUser', 'newkoeluser@newkoeluser.com', '$2y$10$rZ5bRHUb50UXE45znaAFAePdlI44m8K7OZy1dDD6IDRR/i9wOMUBG', 0, NULL, NULL, '2018-01-01 01:50:34', '2018-01-01 01:50:34', '40'),
(23, 'CreatingFromKoel', 'fromkoel@fromkoel.com', '$2y$10$gVF3aHvtMHtAKO3AqRTccemVHRmOH0.tTs6Zk.JytinFM5uH0B/I6', 0, NULL, NULL, '2018-01-01 01:51:33', '2018-01-01 01:51:33', '41');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `albums`
--
ALTER TABLE `albums`
  ADD PRIMARY KEY (`id`),
  ADD KEY `albums_artist_id_foreign` (`artist_id`);

--
-- Indexes for table `artists`
--
ALTER TABLE `artists`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `artists_name_unique` (`name`);

--
-- Indexes for table `interactions`
--
ALTER TABLE `interactions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `interactions_user_id_foreign` (`user_id`),
  ADD KEY `interactions_song_id_foreign` (`song_id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `oauth_access_tokens`
--
ALTER TABLE `oauth_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD KEY `oauth_access_tokens_user_id_index` (`user_id`);

--
-- Indexes for table `oauth_auth_codes`
--
ALTER TABLE `oauth_auth_codes`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `oauth_clients`
--
ALTER TABLE `oauth_clients`
  ADD PRIMARY KEY (`id`),
  ADD KEY `oauth_clients_user_id_index` (`user_id`);

--
-- Indexes for table `oauth_personal_access_clients`
--
ALTER TABLE `oauth_personal_access_clients`
  ADD PRIMARY KEY (`id`),
  ADD KEY `oauth_personal_access_clients_client_id_index` (`client_id`);

--
-- Indexes for table `oauth_refresh_tokens`
--
ALTER TABLE `oauth_refresh_tokens`
  ADD PRIMARY KEY (`id`),
  ADD KEY `oauth_refresh_tokens_access_token_id_index` (`access_token_id`);

--
-- Indexes for table `password_resets`
--
ALTER TABLE `password_resets`
  ADD KEY `password_resets_email_index` (`email`),
  ADD KEY `password_resets_token_index` (`token`);

--
-- Indexes for table `playlists`
--
ALTER TABLE `playlists`
  ADD PRIMARY KEY (`id`),
  ADD KEY `playlists_user_id_foreign` (`user_id`);

--
-- Indexes for table `playlist_song`
--
ALTER TABLE `playlist_song`
  ADD PRIMARY KEY (`id`),
  ADD KEY `playlist_song_playlist_id_foreign` (`playlist_id`),
  ADD KEY `playlist_song_song_id_foreign` (`song_id`);

--
-- Indexes for table `play_log`
--
ALTER TABLE `play_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `play_log_user_id_foreign` (`user_id`),
  ADD KEY `play_log_song_id_foreign` (`song_id`);

--
-- Indexes for table `settings`
--
ALTER TABLE `settings`
  ADD PRIMARY KEY (`key`);

--
-- Indexes for table `songs`
--
ALTER TABLE `songs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `songs_album_id_foreign` (`album_id`),
  ADD KEY `songs_artist_id_foreign` (`artist_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `albums`
--
ALTER TABLE `albums`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;
--
-- AUTO_INCREMENT for table `artists`
--
ALTER TABLE `artists`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
--
-- AUTO_INCREMENT for table `interactions`
--
ALTER TABLE `interactions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;
--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;
--
-- AUTO_INCREMENT for table `oauth_clients`
--
ALTER TABLE `oauth_clients`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `oauth_personal_access_clients`
--
ALTER TABLE `oauth_personal_access_clients`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `playlists`
--
ALTER TABLE `playlists`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `playlist_song`
--
ALTER TABLE `playlist_song`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `play_log`
--
ALTER TABLE `play_log`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;
--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;
--
-- Constraints for dumped tables
--

--
-- Constraints for table `albums`
--
ALTER TABLE `albums`
  ADD CONSTRAINT `albums_artist_id_foreign` FOREIGN KEY (`artist_id`) REFERENCES `artists` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `interactions`
--
ALTER TABLE `interactions`
  ADD CONSTRAINT `interactions_song_id_foreign` FOREIGN KEY (`song_id`) REFERENCES `songs` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `interactions_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `playlists`
--
ALTER TABLE `playlists`
  ADD CONSTRAINT `playlists_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `playlist_song`
--
ALTER TABLE `playlist_song`
  ADD CONSTRAINT `playlist_song_playlist_id_foreign` FOREIGN KEY (`playlist_id`) REFERENCES `playlists` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `playlist_song_song_id_foreign` FOREIGN KEY (`song_id`) REFERENCES `songs` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `play_log`
--
ALTER TABLE `play_log`
  ADD CONSTRAINT `play_log_song_id_foreign` FOREIGN KEY (`song_id`) REFERENCES `songs` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `play_log_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `songs`
--
ALTER TABLE `songs`
  ADD CONSTRAINT `songs_album_id_foreign` FOREIGN KEY (`album_id`) REFERENCES `albums` (`id`),
  ADD CONSTRAINT `songs_artist_id_foreign` FOREIGN KEY (`artist_id`) REFERENCES `artists` (`id`) ON DELETE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
