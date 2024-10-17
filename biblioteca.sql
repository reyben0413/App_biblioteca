-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 15-10-2024 a las 16:01:12
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `biblioteca`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categorias`
--

CREATE TABLE `categorias` (
  `id` int(11) NOT NULL,
  `nombre` varchar(40) NOT NULL,
  `descripcion` text NOT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `categorias`
--

INSERT INTO `categorias` (`id`, `nombre`, `descripcion`, `fecha_creacion`) VALUES
(1, 'Ficción', 'Libros de narrativa.	', '2024-10-11 19:20:00'),
(2, 'Ciencia', 'Libros de ciencias.', '2024-10-11 19:21:00'),
(3, 'Historia', 'Libros sobre hechos históricos.	', '2024-10-11 19:22:00'),
(4, 'Fantasía', 'Libros de mundos imaginarios y magia.', '2024-10-11 19:23:00'),
(5, 'Tecnología', 'Libros sobre avances tecnológicos.', '2024-10-11 19:24:00'),
(6, 'Biografía', 'Historias de vida de personajes famosos.	', '2024-10-11 19:25:00'),
(7, 'Salud', 'Libros sobre bienestar y salud.', '2024-10-11 19:26:00'),
(8, 'Ciencia Ficción', 'Libros de ciencia futurista e imaginaria.	', '2024-10-11 19:27:00'),
(9, 'Arte', 'Libros sobre historia y apreciación del arte.', '2024-10-11 19:28:00'),
(10, 'Educación', 'Libros para enseñanza y aprendizaje.', '2024-10-11 19:29:00');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `libros`
--

CREATE TABLE `libros` (
  `id` int(11) NOT NULL,
  `titulo` varchar(255) NOT NULL,
  `autor` varchar(100) NOT NULL,
  `isbn` varchar(20) NOT NULL,
  `año` year(4) NOT NULL,
  `descripcion` text NOT NULL,
  `id_categoria` int(11) NOT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `imagen_url` varchar(2000) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `libros`
--

INSERT INTO `libros` (`id`, `titulo`, `autor`, `isbn`, `año`, `descripcion`, `id_categoria`, `fecha_creacion`, `imagen_url`) VALUES
(2, 'Breve historia del tiempo', 'Stephen Hawking', '9780553380163', '1988', 'Una introducción a los conceptos básicos de la cosmología, incluyendo agujeros negros y el Big Bang.', 2, '2024-10-13 15:43:13', 'https://images.cdn3.buscalibre.com/fit-in/360x360/c1/d5/c1d562eb8d27c7af22c9f981f4de04f1.jpg'),
(3, 'Sapiens: De animales a dioses', 'Yuval Noah Harari', '9780062316110', '2011', 'Una breve historia de la humanidad, desde los primeros humanos hasta la era moderna.', 3, '2024-10-13 15:44:16', 'https://images.cdn2.buscalibre.com/fit-in/360x360/ac/8e/ac8ea53ec2e38d62ece0ee3cb06821fe.jpg'),
(4, 'El señor de los anillos', 'J.R.R. Tolkien', '9780544003415', '1954', 'Un relato épico de la lucha por la Tierra Media, que enfrenta a hobbits, elfos, enanos y humanos contra el malvado Sauron.', 4, '2024-10-13 15:47:02', 'https://images.cdn1.buscalibre.com/fit-in/360x360/66/1a/661a3760157941a94cb8db3f5a9d5060.jpg'),
(5, 'El código Da Vinci', 'Dan Brown', '9780307474278', '2003', 'Una novela de suspenso que combina ciencia, religión y arte en una búsqueda por descubrir un antiguo secreto.', 5, '2024-10-13 15:54:59', 'https://images.cdn3.buscalibre.com/fit-in/360x360/d2/74/d2745514f8ea4de663d5c8c659a162b2.jpg'),
(6, 'Steve Jobs', 'Walter Isaacson', '9781451648539', '2011', 'Una biografía detallada de Steve Jobs, el visionario fundador de Apple.', 6, '2024-10-13 15:56:28', 'https://images.cdn2.buscalibre.com/fit-in/360x360/a6/3e/a63e18012fd18538c858d7d217fc4d12.jpg'),
(7, 'El poder del metabolismo', 'Frank Suárez', '9780978843752', '2007', 'Una guía sobre cómo mejorar el metabolismo para una mejor salud y control de peso.', 7, '2024-10-13 15:57:18', 'https://images.cdn1.buscalibre.com/fit-in/360x360/b3/6b/b36b19f7dc1eaeb65f0ce752603b9c11.jpg'),
(8, 'Dune', 'Frank Herbert', '9780441172719', '1965', 'Una de las mejores novelas de ciencia ficción, que explora la política, religión y ecología en un futuro distante.', 8, '2024-10-13 15:58:25', 'https://images.cdn3.buscalibre.com/fit-in/360x360/0c/00/0c00cbb74142643771a16065636dd0e3.jpg'),
(9, 'Historia del arte', 'H.W. Janson', '9780133897568', '1962', 'Un texto fundamental sobre la evolución del arte desde los tiempos prehistóricos hasta la modernidad.', 9, '2024-10-13 16:00:01', 'https://images.cdn3.buscalibre.com/fit-in/360x360/9b/67/9b67d7e09ef65e0d3a4eaa53c06a3db4.jpg'),
(10, 'El cerebro del niño', 'Daniel J. Siegel', '9780345548061', '2011', 'Una guía basada en neurociencia para ayudar a los padres a criar hijos emocionalmente sanos.', 10, '2024-10-13 16:07:58', 'https://images.cdn1.buscalibre.com/fit-in/360x360/93/6f/936f8d5ef960d284caf6a1702145f9ea.jpg');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `id` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `email` varchar(255) NOT NULL,
  `contraseña` varchar(15) NOT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id`, `nombre`, `email`, `contraseña`, `fecha_creacion`) VALUES
(1, 'Juan Pérez', 'juan.perez@email.com', 'contrasena123', '2019-08-15 15:20:30'),
(2, 'María García', 'maria.garcia@email.com', 'secreta456', '2019-07-22 19:05:00'),
(3, 'Carlos Sánchez', 'carlos.sanchez@email.com', 'clave789', '2019-09-10 14:45:50'),
(4, 'Lucía Fernández', 'lucia.fernandez@email.com', 'password321', '2019-06-30 23:15:20'),
(5, 'José Martínez', 'jose.martinez@email.com', 'admin654', '2019-05-12 18:40:10');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `categorias`
--
ALTER TABLE `categorias`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `libros`
--
ALTER TABLE `libros`
  ADD PRIMARY KEY (`id`),
  ADD KEY `categoria1` (`id_categoria`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `categorias`
--
ALTER TABLE `categorias`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT de la tabla `libros`
--
ALTER TABLE `libros`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `libros`
--
ALTER TABLE `libros`
  ADD CONSTRAINT `categoria1` FOREIGN KEY (`id_categoria`) REFERENCES `categorias` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
