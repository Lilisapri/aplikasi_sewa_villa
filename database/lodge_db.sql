-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Aug 08, 2024 at 09:49 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 7.4.26

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `lodge_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `accommodations`
--

CREATE TABLE `accommodations` (
  `id` int(30) NOT NULL,
  `accommodation` text NOT NULL,
  `description` text NOT NULL,
  `price` float NOT NULL,
  `date_created` datetime NOT NULL DEFAULT current_timestamp(),
  `date_updated` datetime DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `accommodations`
--

INSERT INTO `accommodations` (`id`, `accommodation`, `description`, `price`, `date_created`, `date_updated`) VALUES
(1, 'Accom101', '&lt;p&gt;&lt;span style=&quot;color: rgb(0, 0, 0); font-family: &amp;quot;Open Sans&amp;quot;, Arial, sans-serif; text-align: justify;&quot;&gt;Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas imperdiet sodales neque semper egestas. Sed fermentum, felis sed ornare scelerisque, quam nisi convallis augue, non porta leo arcu ac nulla. Nam et blandit ipsum. Mauris pulvinar enim et velit luctus efficitur. Curabitur eu nisi sit amet erat imperdiet suscipit. Praesent vitae gravida sem. Curabitur sed justo ac mauris pellentesque convallis ac nec massa. Aenean eleifend nunc est, et iaculis nunc venenatis sit amet. Mauris fringilla vitae ante vulputate iaculis. Suspendisse gravida vulputate laoreet. Nam aliquam efficitur nisi id malesuada. Aliquam turpis leo, ornare vel pellentesque et, tincidunt eget elit.&lt;/span&gt;&lt;br&gt;&lt;/p&gt;', 200, '2021-07-24 09:50:49', '2021-07-24 14:48:07'),
(2, 'Accom102', '&lt;p&gt;&lt;span style=&quot;color: rgb(0, 0, 0); font-family: &amp;quot;Open Sans&amp;quot;, Arial, sans-serif; text-align: justify;&quot;&gt;Cras tellus eros, vehicula quis eros et, auctor interdum nisl. Vestibulum cursus pretium odio a venenatis. Suspendisse id ante cursus, fermentum mi ac, imperdiet purus. Phasellus ut enim et dui maximus tincidunt id sit amet purus. Mauris viverra, erat ut feugiat commodo, sapien felis tincidunt tellus, a euismod nibh est non mi. Aenean blandit augue finibus urna lacinia eleifend. Nunc pretium sollicitudin lacus vitae mollis. Sed porttitor in quam nec sodales. Etiam dignissim augue auctor, faucibus massa id, congue tellus.&lt;/span&gt;&lt;br&gt;&lt;/p&gt;', 500, '2021-07-24 09:53:20', '2021-07-24 14:48:16'),
(4, 'villa di bandung', '&lt;p&gt;kami menyediakan vila di bandung ciwiday&lt;br&gt;&lt;/p&gt;', 700000, '2023-05-25 10:55:17', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `bookings`
--

CREATE TABLE `bookings` (
  `id` int(30) NOT NULL,
  `user_id` int(30) NOT NULL,
  `room_id` int(30) NOT NULL,
  `date_in` date NOT NULL,
  `date_out` date NOT NULL,
  `accommodation_ids` text NOT NULL,
  `room_rate_sub` float NOT NULL,
  `accommodation_sub` float NOT NULL,
  `total_amount` float NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 0 COMMENT '0=pending, 1=Approved,2=Cancelled',
  `date_created` datetime NOT NULL DEFAULT current_timestamp(),
  `date_updated` datetime DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `bookings`
--

INSERT INTO `bookings` (`id`, `user_id`, `room_id`, `date_in`, `date_out`, `accommodation_ids`, `room_rate_sub`, `accommodation_sub`, `total_amount`, `status`, `date_created`, `date_updated`) VALUES
(1, 6, 1, '2021-07-27', '2021-07-28', '1,2', 2500, 700, 3200, 1, '2021-07-24 13:30:22', '2023-05-25 10:54:33');

-- --------------------------------------------------------

--
-- Table structure for table `inquiry`
--

CREATE TABLE `inquiry` (
  `id` int(30) NOT NULL,
  `name` text DEFAULT NULL,
  `email` text DEFAULT NULL,
  `subject` varchar(250) NOT NULL,
  `message` text DEFAULT NULL,
  `status` tinyint(4) NOT NULL DEFAULT 0,
  `date_created` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `inquiry`
--

INSERT INTO `inquiry` (`id`, `name`, `email`, `subject`, `message`, `status`, `date_created`) VALUES
(1, 'John Smith', 'jsmith@sample.com', 'Sample', 'Sample Only', 1, '2021-07-24 14:24:31');

-- --------------------------------------------------------

--
-- Table structure for table `review`
--

CREATE TABLE `review` (
  `id` int(11) NOT NULL,
  `nama` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `rating` tinyint(4) NOT NULL,
  `message` text NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `review`
--

INSERT INTO `review` (`id`, `nama`, `email`, `rating`, `message`, `created_at`) VALUES
(1, 'arum', 'aarum@gmail.com', 5, 'good', '2024-08-06 04:57:08'),
(2, 'lilis', 'lilis@gmail.com', 4, 'verry good', '2024-08-04 04:57:57'),
(3, 'mia', 'mia@gmail.com', 5, 'soooo happy ', '2024-08-05 04:58:29'),
(4, 'anjeng', 'anjeng@gmail.com', 5, 'so far so good', '2024-08-02 04:59:09'),
(0, 'arum', 'aarum5056@gmai.com', 4, 'verygoodddd', '2024-08-06 06:23:38'),
(0, 'yaya', 'yaya@gmail.com', 5, 'dekat ', '2024-08-06 06:27:37'),
(0, 'ayang', 'aayang@gmail.com', 4, 'gooddddd very good', '2024-08-06 06:31:13'),
(0, 'kiki', 'aarum5056@gmai.com', 5, 'booo', '2024-08-06 06:49:20'),
(0, 'arum baik', 'aarum5056@gmai.com', 5, 'very good', '2024-08-06 06:54:41'),
(0, 'lisa ayang', 'aaa@gmail.com', 1, 'soo gooodd', '2024-08-06 07:00:54'),
(0, 'athur', 'athur@gmail.com', 5, 'soo for so good', '2024-08-06 07:27:51'),
(0, 'dd', 'dd@gmail.com', 5, 'dd', '2024-08-06 07:39:53'),
(0, 'arum yaya', 'aarum5056@gmai.com', 5, 'soooo', '2024-08-06 07:41:04'),
(0, 'Tami', 'aarum5056@gmai.com', 5, 'i like this', '2024-08-06 07:52:16'),
(0, 'caca', 'caca@gmail.com', 5, 'caca cantik', '2024-08-07 01:43:08');

-- --------------------------------------------------------

--
-- Table structure for table `room_list`
--

CREATE TABLE `room_list` (
  `id` int(30) NOT NULL,
  `room` text NOT NULL,
  `description` text NOT NULL,
  `price` float NOT NULL,
  `status` tinyint(1) NOT NULL COMMENT '1 = Available, 2 = Unavailable',
  `upload_path` text DEFAULT NULL,
  `date_created` datetime NOT NULL DEFAULT current_timestamp(),
  `date_updated` datetime DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `room_list`
--

INSERT INTO `room_list` (`id`, `room`, `description`, `price`, `status`, `upload_path`, `date_created`, `date_updated`) VALUES
(1, 'vila puncak', '&lt;p style=&quot;margin-right: 0px; margin-bottom: 15px; margin-left: 0px; padding: 0px; text-align: justify; color: rgb(0, 0, 0); font-family: &amp;quot;Open Sans&amp;quot;, Arial, sans-serif;&quot;&gt;Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas imperdiet sodales neque semper egestas. Sed fermentum, felis sed ornare scelerisque, quam nisi convallis augue, non porta leo arcu ac nulla. Nam et blandit ipsum. Mauris pulvinar enim et velit luctus efficitur. Curabitur eu nisi sit amet erat imperdiet suscipit. Praesent vitae gravida sem. Curabitur sed justo ac mauris pellentesque convallis ac nec massa. Aenean eleifend nunc est, et iaculis nunc venenatis sit amet. Mauris fringilla vitae ante vulputate iaculis. Suspendisse gravida vulputate laoreet. Nam aliquam efficitur nisi id malesuada. Aliquam turpis leo, ornare vel pellentesque et, tincidunt eget elit.&lt;/p&gt;&lt;p style=&quot;margin-right: 0px; margin-bottom: 15px; margin-left: 0px; padding: 0px; text-align: justify; color: rgb(0, 0, 0); font-family: &amp;quot;Open Sans&amp;quot;, Arial, sans-serif;&quot;&gt;Cras tellus eros, vehicula quis eros et, auctor interdum nisl. Vestibulum cursus pretium odio a venenatis. Suspendisse id ante cursus, fermentum mi ac, imperdiet purus. Phasellus ut enim et dui maximus tincidunt id sit amet purus. Mauris viverra, erat ut feugiat commodo, sapien felis tincidunt tellus, a euismod nibh est non mi. Aenean blandit augue finibus urna lacinia eleifend. Nunc pretium sollicitudin lacus vitae mollis. Sed porttitor in quam nec sodales. Etiam dignissim augue auctor, faucibus massa id, congue tellus.&lt;/p&gt;', 2500, 1, 'uploads/room_1', '2021-07-24 10:22:15', '2023-05-25 10:56:41'),
(2, 'villa bandung', '&lt;p&gt;&lt;span style=&quot;color: rgb(0, 0, 0); font-family: &amp;quot;Open Sans&amp;quot;, Arial, sans-serif; text-align: justify;&quot;&gt;Vestibulum ornare ligula a leo imperdiet, sit amet consectetur justo maximus. Phasellus nec arcu vitae diam volutpat eleifend non non sem. Mauris non ante vel lorem aliquet tristique a sit amet odio. Proin et leo non magna volutpat hendrerit sagittis ac ante. Cras auctor risus in lectus porttitor tincidunt. Suspendisse eu purus id ipsum molestie pharetra in at turpis. Quisque venenatis a purus eu facilisis. Nam sit amet condimentum sapien. Etiam egestas dapibus risus. Vestibulum vehicula pharetra nulla, in vestibulum felis. In aliquam orci libero. Fusce ornare consequat metus elementum eleifend.&lt;/span&gt;&lt;br&gt;&lt;/p&gt;', 150000, 1, 'uploads/room_2', '2021-07-24 14:38:31', '2023-05-25 10:58:00'),
(3, 'villa bandung', '&lt;p&gt;kami menyediakan villa di bandung&lt;br&gt;&lt;/p&gt;', 7000000, 1, 'uploads/room_3', '2023-05-25 10:56:04', '2023-05-25 10:56:04');

-- --------------------------------------------------------

--
-- Table structure for table `system_info`
--

CREATE TABLE `system_info` (
  `id` int(30) NOT NULL,
  `meta_field` text NOT NULL,
  `meta_value` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `system_info`
--

INSERT INTO `system_info` (`id`, `meta_field`, `meta_value`) VALUES
(1, 'name', 'Aplikasi Penyewaan VIlla'),
(6, 'short_name', 'Sewa Villa php'),
(11, 'logo', 'uploads/1627090380_logo3.jpg'),
(13, 'user_avatar', 'uploads/user_avatar.jpg'),
(14, 'cover', 'uploads/1684986840_Rekomendasi-Penginapan-Villa-di-Bogor.webp');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(50) NOT NULL,
  `firstname` varchar(250) NOT NULL,
  `lastname` varchar(250) NOT NULL,
  `email` text NOT NULL,
  `contact` varchar(50) NOT NULL,
  `username` text NOT NULL,
  `password` text NOT NULL,
  `avatar` text DEFAULT NULL,
  `last_login` datetime DEFAULT NULL,
  `type` tinyint(1) NOT NULL DEFAULT 0,
  `date_added` datetime NOT NULL DEFAULT current_timestamp(),
  `date_updated` datetime DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `contact`, `username`, `password`, `avatar`, `last_login`, `type`, `date_added`, `date_updated`) VALUES
(1, 'Adminstrator', 'Admin', '', '', 'admin', '827ccb0eea8a706c4c34a16891f84e7b', 'uploads/1627090380_avatar.png', NULL, 1, '2021-01-20 14:02:37', '2024-08-08 09:05:53'),
(6, 'John', 'Smith', 'jsmith@sample.com', '09123456789', 'jsmith', '1254737c076cf867dc53d60a0364f38e', NULL, NULL, 0, '2021-07-24 10:41:04', '2021-07-24 10:57:40'),
(7, '', '', '', '', 'arum', '12345', NULL, NULL, 0, '2024-08-08 09:07:38', NULL),
(8, '', '', '', '', 'arum', '1234', NULL, NULL, 0, '2024-08-08 09:14:48', NULL),
(9, '', '', '', '', 'arum', '1234', NULL, NULL, 0, '2024-08-08 09:19:03', NULL),
(10, '', '', '', '', 'arum', '1234', NULL, NULL, 0, '2024-08-08 09:23:42', NULL),
(11, '', '', '', '', 'lisa', '1234', NULL, NULL, 0, '2024-08-08 09:30:16', NULL),
(12, '', '', '', '', 'arum', '123', NULL, NULL, 0, '2024-08-08 11:24:09', NULL),
(13, '', '', '', '', 'arum', '123', NULL, NULL, 0, '2024-08-08 11:24:54', NULL),
(14, '', '', '', '', 'arum', '123', NULL, NULL, 0, '2024-08-08 11:25:19', NULL),
(15, '', '', '', '', 'arum', '123', NULL, NULL, 0, '2024-08-08 11:25:41', NULL),
(16, '', '', '', '', 'arum', '123', NULL, NULL, 0, '2024-08-08 11:26:03', NULL),
(17, '', '', '', '', 'arum', '123', NULL, NULL, 0, '2024-08-08 11:27:26', NULL),
(18, '', '', '', '', 'arum', '123', NULL, NULL, 0, '2024-08-08 11:27:46', NULL),
(19, '', '', '', '', 'arum', '123', NULL, NULL, 0, '2024-08-08 11:28:51', NULL),
(20, '', '', '', '', 'arum', '123', NULL, NULL, 0, '2024-08-08 11:30:21', NULL),
(21, '', '', '', '', 'arum', '123', NULL, NULL, 0, '2024-08-08 11:31:08', NULL),
(22, '', '', '', '', 'lisa', '123', NULL, NULL, 0, '2024-08-08 14:27:34', NULL),
(23, '', '', '', '', 'tari', '123', NULL, NULL, 0, '2024-08-08 14:49:00', NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `accommodations`
--
ALTER TABLE `accommodations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `bookings`
--
ALTER TABLE `bookings`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `inquiry`
--
ALTER TABLE `inquiry`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `room_list`
--
ALTER TABLE `room_list`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `system_info`
--
ALTER TABLE `system_info`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `accommodations`
--
ALTER TABLE `accommodations`
  MODIFY `id` int(30) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `bookings`
--
ALTER TABLE `bookings`
  MODIFY `id` int(30) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `inquiry`
--
ALTER TABLE `inquiry`
  MODIFY `id` int(30) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `room_list`
--
ALTER TABLE `room_list`
  MODIFY `id` int(30) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `system_info`
--
ALTER TABLE `system_info`
  MODIFY `id` int(30) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(50) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
