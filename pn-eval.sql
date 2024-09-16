-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1
-- Généré le : lun. 16 sep. 2024 à 14:50
-- Version du serveur : 10.4.32-MariaDB
-- Version de PHP : 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `pn-eval`
--

-- --------------------------------------------------------

--
-- Structure de la table `client`
--

CREATE TABLE `client` (
  `id` int(10) UNSIGNED NOT NULL,
  `prenom` varchar(255) NOT NULL,
  `nom` varchar(255) NOT NULL,
  `mail` varchar(255) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `client`
--

INSERT INTO `client` (`id`, `prenom`, `nom`, `mail`, `created_at`) VALUES
(13143359, 'Augustin', 'Verissimo', 'augustin.verissimo@gmail.com', '2024-09-16 14:12:38'),
(13143360, 'Maxime', 'Demons', 'maxime.demons@gmail.com', '2024-09-16 14:16:36'),
(13143361, 'Rodrigue', 'Klein', 'Rodrigue.Klein@gmail.com', '2024-09-16 14:16:50');

-- --------------------------------------------------------

--
-- Structure de la table `commande`
--

CREATE TABLE `commande` (
  `date` date NOT NULL,
  `ref_client` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `commande`
--

INSERT INTO `commande` (`date`, `ref_client`) VALUES
('2024-09-16', 13143359),
('2024-09-16', 13143360);

-- --------------------------------------------------------

--
-- Structure de la table `detail_commande`
--

CREATE TABLE `detail_commande` (
  `commande_id` int(11) DEFAULT NULL,
  `produit` varchar(50) DEFAULT NULL,
  `quantite` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `detail_commande`
--

INSERT INTO `detail_commande` (`commande_id`, `produit`, `quantite`) VALUES
(1, 'Mistral', 2),
(1, 'Harmattan', 1),
(2, 'Zéphyr', 3),
(2, 'Sirocco', 3),
(13143359, 'Mistral', 2),
(13143359, 'Harmattan', 1),
(13143360, 'Zéphyr', 3),
(13143360, 'Sirocco', 3);

-- --------------------------------------------------------

--
-- Structure de la table `produit`
--

CREATE TABLE `produit` (
  `id` int(10) UNSIGNED NOT NULL,
  `nom` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `prix` int(10) UNSIGNED NOT NULL,
  `stock` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `produit`
--

INSERT INTO `produit` (`id`, `nom`, `description`, `prix`, `stock`) VALUES
(1, 'Zéphyr', 'vent d\'ouest doux et chaud.', 1500, 5),
(2, 'Mistral', 'vent du nord ou nord-ouest, soufflant violemment, en toutes saisons, dans la vallée du Rhône', 750, 13),
(3, 'Alizé', 'vent régulier dans la zone inter-tropicale. Il est de nord-est dans l’hémisphère nord et de sud-est dans l’hémisphère sud', 2300, 7),
(4, 'Sirocco', 'vent brûlant du sud, sec et chaud charriant du sable du sahara pouvant atteindre l\'Espagne, la France et l\'Italie', 3200, 3),
(5, 'Harmattan', 'alizé continental : vent de nord-est, très sec, soufflant en hiver et au printemps en Afrique occidentale', 2900, 4);

-- --------------------------------------------------------

--
-- Doublure de structure pour la vue `vue_commandes`
-- (Voir ci-dessous la vue réelle)
--
CREATE TABLE `vue_commandes` (
`prenom` varchar(255)
,`nom` varchar(255)
,`date` date
,`produit` varchar(50)
,`quantite` int(11)
);

-- --------------------------------------------------------

--
-- Structure de la vue `vue_commandes`
--
DROP TABLE IF EXISTS `vue_commandes`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vue_commandes`  AS SELECT `c`.`prenom` AS `prenom`, `c`.`nom` AS `nom`, `co`.`date` AS `date`, `dc`.`produit` AS `produit`, `dc`.`quantite` AS `quantite` FROM ((`client` `c` join `commande` `co` on(`c`.`id` = `co`.`ref_client`)) join `detail_commande` `dc` on(`co`.`ref_client` = `dc`.`commande_id`)) ;

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `client`
--
ALTER TABLE `client`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `mail` (`mail`);

--
-- Index pour la table `commande`
--
ALTER TABLE `commande`
  ADD PRIMARY KEY (`ref_client`);

--
-- Index pour la table `produit`
--
ALTER TABLE `produit`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `nom` (`nom`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `client`
--
ALTER TABLE `client`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13143362;

--
-- AUTO_INCREMENT pour la table `produit`
--
ALTER TABLE `produit`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
