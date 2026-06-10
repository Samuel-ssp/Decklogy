# Decklogy 🌍🃏

![Estado: Completado](https://img.shields.io/badge/Estado-Completado-success)
![Propósito: Educativo](https://img.shields.io/badge/Propósito-Educativo-blue)
![Arquitectura: MVC](https://img.shields.io/badge/Arquitectura-PHP%20MVC-orange)

## 📖 Sobre el Proyecto
**Decklogy** es una aplicación web y juego de cartas nacido como un **proyecto académico**. Su objetivo principal es **concienciar sobre el medio ambiente** y las soluciones ecológicas de una manera lúdica e interactiva ("aprender jugando"). 

A través de sus mecánicas, los jugadores interactúan con cartas y zonas de juego que representan distintas problemáticas ambientales y sus respectivas soluciones, fomentando la educación ecológica.

Este repositorio está enlazado desde mi currículum para mostrar tanto el propósito educativo del software como la estructura técnica detrás de su desarrollo.

## ✨ Características Principales
- **Enfoque Educativo**: Temática centrada en el medio ambiente, donde el progreso en el juego enseña sobre sostenibilidad.
- **Sistema de Usuarios**: Registro, inicio de sesión seguro y gestión de perfiles personalizados.
- **Gestión Integral de Cartas**: Sistema CRUD completo que permite crear, listar, modificar y eliminar las cartas del juego.
- **Zonas y Tablero Dinámico**: Administración visual de las zonas de juego donde transcurre la partida.
- **Ranking y Puntuaciones**: Sistema para llevar el registro del desempeño de los jugadores.

## 🛠️ Arquitectura y Tecnologías
El proyecto fue construido en PHP y estructurado de forma que demuestra la evolución del aprendizaje técnico, dividiéndose en dos enfoques:

1. **Arquitectura MVC (`/php`)**:
   - Implementa el patrón **Modelo-Vista-Controlador (MVC)**, demostrando buenas prácticas de ingeniería de software.
   - Enrutamiento centralizado y seguro a través de `index.php`.
   - Vistas dinámicas para todas las secciones interactivas.

2. **Versión Procedimental (`/no-mvc`)**:
   - Una versión inicial del proyecto construida sin separación estricta, lo que sirve para ilustrar el contraste y la mejora hacia la arquitectura MVC.

### Stack Tecnológico
- **Backend**: PHP puro.
- **Frontend**: HTML5, CSS3, JavaScript (Vanilla).
- **Base de Datos**: MySQL/MariaDB.
- **Servidor Web**: Apache (compatible con entorno XAMPP).

## 🚀 Instalación y Despliegue Local
Si deseas probar el proyecto en tu máquina local, sigue estos pasos:

1. Clona o descarga este repositorio en el directorio de tu servidor web local (ej. `C:\xampp\htdocs\Decklogy`).
2. Importa el archivo `insert.sql` en tu gestor de base de datos MySQL (por ejemplo, PHPMyAdmin) para generar la base de datos `decklogy` junto con todas sus tablas y datos iniciales.
3. El sistema está preconfigurado para conectarse mediante el usuario `root` sin contraseña en `localhost`. 
   *(Para modificarlo, edita los archivos `configdb.php` dentro de `php/config/` y `no-mvc/config/`).*
4. Accede a la aplicación desde tu navegador navegando a `http://localhost/Decklogy`.
