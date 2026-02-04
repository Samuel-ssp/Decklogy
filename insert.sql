-- ==========================================================
-- DECKLOGY - SCRIPT DE INSTALACIÓN (VERSIÓN FINAL LIMPIA)
-- ==========================================================

--  CREACIÓN DE TABLAS
-- ----------------------------------------------------------

-- Tabla: usuarios
CREATE TABLE usuarios (
    id_usuario INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL UNIQUE,
    contrasena VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    rol ENUM('admin', 'player') NOT NULL DEFAULT 'player',
    puntuacion INT DEFAULT 0
);

-- Tabla: iconos
CREATE TABLE iconos (
    id_icono INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL UNIQUE,
    codigo CHAR(5) NOT NULL
);

-- Tabla: zonas
CREATE TABLE zonas (
    id_zona INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL UNIQUE,
    imagenZona VARCHAR(255),
    imagenCartas VARCHAR(255),
    imagenEventos VARCHAR(255),
    fondoZona VARCHAR(255) 
);

-- Tabla: eventos
CREATE TABLE eventos (
    id_evento INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL UNIQUE,
    descripcion VARCHAR(255),
    dano TINYINT UNSIGNED NOT NULL DEFAULT 0,
    turnos_duracion INT NOT NULL,
    id_zona INT NOT NULL,
    id_icono INT,
    esta_en_carta BOOLEAN NOT NULL DEFAULT 0,
    FOREIGN KEY (id_zona) REFERENCES zonas(id_zona) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_icono) REFERENCES iconos(id_icono) ON DELETE SET NULL ON UPDATE CASCADE
);

-- Tabla: cartas
CREATE TABLE cartas (
    id_carta INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL UNIQUE,
    descripcion VARCHAR(255),
    curacion TINYINT UNSIGNED NOT NULL,
    id_zona INT NOT NULL,
    elimina_id_evento INT,
    id_icono INT,
    FOREIGN KEY (id_zona) REFERENCES zonas(id_zona) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (elimina_id_evento) REFERENCES eventos(id_evento) ON DELETE SET NULL ON UPDATE CASCADE,
    FOREIGN KEY (id_icono) REFERENCES iconos(id_icono) ON DELETE SET NULL ON UPDATE CASCADE
);

-- ==========================================================
-- INSERCIÓN DE DATOS
-- ==========================================================

--  INSERTAR ICONOS (40 Total)
INSERT INTO iconos (nombre, codigo) VALUES
-- Básicos
('Reciclaje', '♻️'), ('Árbol', '🌳'), ('Agua Limpia', '💧'), ('Sol', '☀️'), ('Viento', '💨'),
('Corazón', '❤️'), ('Personas', '👥'), ('Libro', '📚'), ('Ley', '⚖️'), ('Energía', '⚡'),
('Contaminación', '🏭'), ('Fuego', '🔥'), ('Basura', '🗑️'), ('Plástico', '🥤'), ('Advertencia', '⚠️'),
('Prohibido', '⛔'), ('Petróleo', '🛢️'), ('Temperatura', '🌡️'), ('Sequía', '🏜️'), ('Peligro', '☠️'),
-- Naturaleza
('Animal', '🐾'), ('Pez', '🐟'), ('Hoja', '🍃'), ('Flor', '🌼'), ('Tierra', '🌍'),
('Nube', '☁️'), ('Arcoíris', '🌈'), ('Montaña', '⛰️'), ('Volcán', '🌋'), ('Tornado', '🌪️'),
('Lluvia', '🌧️'), ('Planta', '🌱'), ('Flor Blanca', '🌸'), ('Abeja', '🐝'), ('Pájaro', '🐦'),
('Ballena', '🐋'), ('Tortuga', '🐢'), ('Cactus', '🌵'), ('Isla', '🏝️'), ('Burbuja', '🫧');

--  INSERTAR ZONAS
INSERT INTO zonas (nombre, imagenZona, imagenCartas, imagenEventos, fondoZona) VALUES
('Bosque', '../imagenes/zonas/Bosque.png', '../imagenes/cartas/cartaBosque.png', '../imagenes/eventos/eventoBosque.png', '../imagenes/fondo/fondoBosque.png'),   -- ID 1
('Ciudad', '../imagenes/zonas/Ciudad.png', '../imagenes/cartas/cartaCiudad.png', '../imagenes/eventos/eventoCiudad.png', '../imagenes/fondo/fondoCiudad.png'),   -- ID 2
('Mar', '../imagenes/zonas/Mar.png', '../imagenes/cartas/cartaMar.png', '../imagenes/eventos/eventoMar.png', '../imagenes/fondo/fondoMar.png'),              -- ID 3
('Desierto', '../imagenes/zonas/Desierto.png', '../imagenes/cartas/cartaDesierto.png', '../imagenes/eventos/eventoDesierto.png', '../imagenes/fondo/fondoDesierto.png'), -- ID 4
('Infinito', '../imagenes/zonas/Infinito.png', NULL, NULL, '../imagenes/fondo/fondoInfinito.png'); 

-- Ajuste para la zona infinito (Mover ID 5 a ID 0)
-- Uso como bandera para el modo infinito
UPDATE zonas SET id_zona = 0 WHERE nombre = "Infinito";

--  INSERTAR EVENTOS (PROBLEMAS)
-- --- ZONA 1: BOSQUE ---
INSERT INTO eventos (nombre, descripcion, dano, turnos_duracion, id_zona, id_icono, esta_en_carta) VALUES
('Plaga Forestal', 'Insectos que matan árboles debilitados por el estrés térmico.', 15, 4, 1, 20, 0), 
('Fragmentación', 'Carreteras que aíslan poblaciones animales, impidiendo su reproducción.', 20, 5, 1, 16, 0), 
('Vertidos Tóxicos', 'Químicos industriales filtrados que envenenan el agua subterránea.', 20, 3, 1, 20, 0), 
('Suelo Erosionado', 'La tierra pierde su capa fértil y se vuelve estéril.', 15, 4, 1, 19, 0), 
('Flora Invasora', 'Plantas exóticas que compiten deslealmente con las nativas.', 15, 4, 1, 15, 0), 
('Desajuste Fenológico', 'Las plantas florecen antes de que lleguen sus polinizadores.', 35, 6, 1, 18, 0), 
('Tala Ilegal', 'Mafias que extraen maderas preciosas sin control.', 35, 4, 1, 17, 0), 
('Contaminación Lumínica', 'Luz artificial que desorienta aves y altera ciclos nocturnos.', 15, 3, 1, 10, 0), 
('Mega-Incendio', 'Fuego de alta intensidad, imposible de apagar solo con agua.', 40, 3, 1, 12, 0), 
('Monocultivo Verde', 'Plantaciones de una sola especie donde no vive fauna local.', 20, 5, 1, 11, 0); 

-- --- ZONA 2: CIUDAD ---
INSERT INTO eventos (nombre, descripcion, dano, turnos_duracion, id_zona, id_icono, esta_en_carta) VALUES
('Ansiedad Urbana', 'Estrés crónico derivado del ruido y la falta de pausa.', 25, 4, 2, 15, 0), 
('Fast Fashion', 'Ropa de baja calidad que genera montañas de basura textil.', 30, 5, 2, 13, 0), 
('Obsolescencia', 'Aparatos diseñados para romperse y forzar nueva compra.', 35, 3, 2, 11, 0), 
('Aislamiento Social', 'Soledad no deseada y ruptura de los lazos vecinales.', 20, 4, 2, 7, 0), 
('Comida Chatarra', 'Dieta ultraprocesada que daña la salud física y mental.', 25, 3, 2, 19, 0), 
('Esmog Tóxico', 'Nube de polución que causa enfermedades respiratorias graves.', 35, 5, 2, 11, 0), 
('Inundación Urbana', 'El asfalto impide que la tierra absorba la lluvia torrencial.', 35, 3, 2, 30, 0), 
('Isla de Calor', 'El cemento retiene el calor, elevando la temperatura nocturna.', 20, 4, 2, 18, 0), 
('Tráfico Colapsado', 'Congestión que roba tiempo de vida y genera gases nocivos.', 20, 3, 2, 16, 0), 
('Publicidad Invasiva', 'Estímulos constantes para crear necesidades falsas.', 15, 4, 2, 9, 0); 

-- --- ZONA 3: MAR ---
INSERT INTO eventos (nombre, descripcion, dano, turnos_duracion, id_zona, id_icono, esta_en_carta) VALUES
('Acidificación', 'El exceso de CO2 vuelve el agua ácida, disolviendo conchas.', 15, 4, 3, 20, 0), 
('Microplásticos', 'Partículas invisibles que confunden a los peces con alimento.', 35, 6, 3, 14, 0), 
('Minería Submarina', 'Máquinas gigantes que remueven el fondo buscando metales.', 25, 3, 3, 11, 0), 
('Blanqueamiento', 'El coral expulsa sus algas vitales por el calor del agua.', 35, 5, 3, 18, 0), 
('Zona Muerta', 'Áreas sin oxígeno por culpa de fertilizantes agrícolas.', 25, 5, 3, 20, 0), 
('Vertido de Crudo', 'Fugas de petróleo que impregnan aves y costas.', 60, 4, 3, 17, 0), 
('Pesca Fantasma', 'Redes abandonadas que siguen atrapando animales por décadas.', 35, 5, 3, 13, 0), 
('Pesca de Arrastre', 'Redes con plomos que destruyen el hábitat del fondo marino.', 45, 3, 3, 19, 0), 
('Turismo Irresponsable', 'Anclas y buzos que rompen corales y molestan fauna.', 20, 3, 3, 15, 0), 
('Especies Invasoras', 'Animales traídos en cascos de barcos que alteran el equilibrio.', 30, 4, 3, 12, 0); 

-- --- ZONA 4: DESIERTO ---
INSERT INTO eventos (nombre, descripcion, dano, turnos_duracion, id_zona, id_icono, esta_en_carta) VALUES
('Avance del Desierto', 'La arena invade tierras que antes eran fértiles.', 20, 5, 4, 19, 0), 
('Tormenta de Polvo', 'Aire irrespirable que transporta enfermedades y arena.', 25, 3, 4, 30, 0), 
('Salinización', 'Riego incorrecto que deja sales tóxicas en el suelo.', 25, 4, 4, 20, 0), 
('Caza Furtiva', 'Matanza de animales raros para trofeos o medicina tradicional.', 45, 4, 4, 15, 0), 
('Crisis Hídrica', 'Falta de agua potable por mala gestión y sequía extrema.', 40, 6, 4, 18, 0), 
('Sobrepastoreo', 'Ganado que come las plantas antes de que den semillas.', 35, 4, 4, 21, 0), 
('Acuífero Agotado', 'Pozos ilegales que extraen agua más rápido de lo que se recarga.', 45, 5, 4, 19, 0), 
('Erosión Eólica', 'El viento se lleva la capa fértil de suelos desnudos.', 25, 4, 4, 5, 0), 
('Éxodo Climático', 'Familias obligadas a emigrar porque la tierra ya no produce.', 25, 4, 4, 7, 0), 
('Rally Off-Road', 'Vehículos recreativos que destrozan la superficie del desierto.', 20, 2, 4, 11, 0); 


--  INSERTAR CARTAS (SOLUCIONES)
INSERT INTO cartas (nombre, descripcion, curacion, id_zona, elimina_id_evento, id_icono) VALUES
('Control Biológico', 'Introducir insectos benéficos en lugar de pesticidas.', 35, 1, 1, 21),
('Corredor de Vida', 'Puentes naturales que reconectan zonas aisladas.', 35, 1, 2, 23),
('Bio-Remediación', 'Uso de hongos y bacterias para limpiar suelos tóxicos.', 30, 1, 3, 3),
('Agricultura Regenerativa', 'Técnicas que devuelven nutrientes y vida al suelo.', 40, 1, 4, 2),
('Restauración Nativa', 'Retirada manual de invasoras y siembra de especies locales.', 35, 1, 5, 7),
('Polinización Asistida', 'Ayuda manual y protección de colmenas silvestres.', 35, 1, 6, 26),
('Trazabilidad de Madera', 'Sellos tecnológicos que certifican que la madera es legal.', 35, 1, 7, 8),
('Cielos Oscuros', 'Regulación de luces LED y horarios de apagado nocturno.', 30, 1, 8, 4),
('Pastoreo Preventivo', 'Rebaños controlados que limpian el monte para evitar incendios.', 30, 1, 9, 21),
('Diversificación', 'Plantar mezcla de especies para crear un ecosistema real.', 30, 1, 10, 2);

-- --- CARTAS CIUDAD (Soluciones 11-20) ---
INSERT INTO cartas (nombre, descripcion, curacion, id_zona, elimina_id_evento, id_icono) VALUES
('Salud Mental Pública', 'Acceso gratuito a psicología y espacios verdes de calma.', 35, 2, 11, 6),
('Moda Sostenible', 'Fomento de ropa ética, duradera y de segunda mano.', 35, 2, 12, 1),
('Derecho a Reparar', 'Leyes que obligan a las empresas a permitir arreglos.', 45, 2, 13, 8),
('Centro Comunitario', 'Espacios vecinales gratuitos para combatir la soledad.', 40, 2, 14, 7),
('Huerto Urbano', 'Alimentos frescos locales y conexión con la naturaleza.', 30, 2, 15, 32),
('Transporte Verde', 'Movilidad eléctrica y pública masiva para limpiar el aire.', 45, 2, 16, 5),
('Ciudad Esponja', 'Pavimentos permeables que absorben el agua de lluvia.', 30, 2, 17, 3),
('Techo Verde', 'Jardines en azoteas que aíslan y refrescan el edificio.', 30, 2, 18, 23),
('Carril Bici', 'Infraestructura segura y conectada para bicicletas.', 35, 2, 19, 1),
('Consumo Consciente', 'Educación crítica para diferenciar necesidad de deseo.', 30, 2, 20, 8);

-- --- CARTAS MAR (Soluciones 21-30) ---
INSERT INTO cartas (nombre, descripcion, curacion, id_zona, elimina_id_evento, id_icono) VALUES
('Cultivo de Algas', 'Las macroalgas absorben CO2 y reducen la acidez local.', 30, 3, 21, 32),
('Prohibición Plásticos', 'Eliminación legal estricta de plásticos de un solo uso.', 35, 3, 22, 16),
('Tratado de Alta Mar', 'Protección legal internacional contra la minería submarina.', 35, 3, 23, 9),
('Super-Corales', 'Cría científica de corales resistentes a altas temperaturas.', 45, 3, 24, 22),
('Filtros Agrícolas', 'Barreras vegetales que evitan que nitratos lleguen al mar.', 40, 3, 25, 3),
('Esponjas Nano', 'Materiales avanzados que absorben solo aceite, no agua.', 45, 3, 26, 2),
('Buzos Recolectores', 'Equipos especializados en retirar redes fantasma del fondo.', 35, 3, 27, 7),
('Pesca Artesanal', 'Apoyo a pescadores locales que usan métodos sostenibles.', 45, 3, 28, 22),
('Boyas Ecológicas', 'Sistemas de amarre que flotan y no tocan el fondo marino.', 20, 3, 29, 3),
('Agua de Lastre Limpia', 'Tratamiento del agua de los barcos para no mover especies.', 30, 3, 30, 2);

-- --- CARTAS DESIERTO (Soluciones 31-40) ---
INSERT INTO cartas (nombre, descripcion, curacion, id_zona, elimina_id_evento, id_icono) VALUES
('Gran Muralla Verde', 'Barrera continental de árboles para frenar la arena.', 35, 4, 31, 2),
('Fijación de Dunas', 'Plantas pioneras que atrapan el suelo y cortan el viento.', 35, 4, 32, 23),
('Tecnología de Riego', 'Sistemas inteligentes por goteo que ahorran agua y evitan sal.', 30, 4, 33, 3),
('Ecoturismo Responsable', 'Ingresos alternativos para locales que sustituyen la caza.', 45, 4, 34, 15),
('Cosecha de Lluvia', 'Sistemas para capturar y almacenar cada gota que cae.', 35, 4, 35, 3),
('Ganadería Rotativa', 'Mover animales constantemente para regenerar el pasto.', 35, 4, 36, 21),
('Clausura de Pozos', 'Control legal estricto sobre la extracción de agua profunda.', 45, 4, 37, 9),
('Agricultura sin Labranza', 'Sembrar sin arar para proteger la estructura del suelo.', 25, 4, 38, 38),
('Ayuda Humanitaria', 'Refugios y recursos dignos para comunidades desplazadas.', 35, 4, 39, 6), 
('Zonas de Exclusión', 'Áreas prohibidas para vehículos para permitir regeneración.', 25, 4, 40, 16);
/* PODER BORRAR TODAS LAS TABLAS Y CONTENIDOS DE LA BASE DE DATOS */



-- Desactivar revisión de claves foráneas para poder borrar en cualquier orden
SET FOREIGN_KEY_CHECKS = 0;

-- Borrar tablas si existen
DROP TABLE IF EXISTS cartas;
DROP TABLE IF EXISTS eventos;
DROP TABLE IF EXISTS zonas;
DROP TABLE IF EXISTS iconos;
DROP TABLE IF EXISTS usuarios;

-- Reactivar revisión de claves foráneas
SET FOREIGN_KEY_CHECKS = 1;
*/