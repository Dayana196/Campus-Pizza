# 🍕 Base de Datos - Pizzería Campus

## 📋 Descripción del Proyecto

Este proyecto consiste en el diseño y creación de una base de datos para la gestión de una **pizzería**, desarrollada en **MySQL**.  
El objetivo principal es administrar la información de clientes, pedidos, productos, ingredientes, direcciones y pagos, garantizando la integridad y eficiencia de los datos mediante el uso de claves primarias y foráneas.

## ✨ Estructura del Proyecto

El repositorio contiene los siguientes archivos:

- **`pizzeria.sql`** → Script principal con la creación de la base de datos y sus tablas.  
- **`pizzeria_ddl.sql`** → Contiene las sentencias DDL (Data Definition Language): creación de tablas, relaciones, índices, etc.  
- **`pizzeria_dml.sql`** → Contiene las sentencias DML (Data Manipulation Language): inserción de datos de prueba.  
- **`drawSQL-image-export.png`** → Diagrama entidad–relación del modelo de la base de datos.  
- **`README.md`** → Documento descriptivo del proyecto.

## ⭐ Modelo Entidad–Relación

El diseño fue realizado en **DrawSQL**, e incluye las siguientes entidades principales:

- **Cliente** → Almacena información personal de los clientes (nombre, correo, teléfono, fecha de registro).  
- **Dirección** → Relacionada con el cliente. Permite registrar varias direcciones (casa, trabajo, etc.).  
- **Producto** → Catálogo de productos (pizzas, bebidas, postres, etc.).  
- **Ingrediente** → Lista de ingredientes disponibles.  
- **Producto_Ingrediente** → Relación *muchos a muchos* entre productos e ingredientes.  
- **Adición** → Elementos extra que el cliente puede agregar al pedido (queso extra, borde relleno, etc.).  
- **Producto_Adición** → Relación entre productos y adiciones.  
- **Combo** → Agrupa productos o variantes.  
- **Combo_Item** → Define qué productos componen cada combo.  
- **Pedido** → Registra los pedidos realizados por los clientes, con fecha, tipo de entrega y totales.  
- **Pago** → Almacena la información del pago asociado a cada pedido.  
- **Menu_Item** y **Producto_Variant** → Permiten manejar variaciones del producto (por ejemplo, tamaños, precios o disponibilidad).

## 🔗 Relaciones Principales

- Un **cliente** puede tener **muchas direcciones** (1:N).  
- Un **pedido** pertenece a un **cliente** (N:1).  
- Un **pedido** tiene un **pago** asociado (1:1).  
- Un **producto** puede tener **muchos ingredientes** (N:M).  
- Un **combo** puede incluir varios **productos o variantes** (N:M).

## ⚙️ Configuración e Instalación

1. Abre **MySQL Workbench** o tu terminal de MySQL.  
2. Crea la base de datos ejecutando el siguiente comando:

   ```sql
   CREATE DATABASE IF NOT EXISTS pizzeria_sql;
   USE pizzeria_sql;
   ```

3. Ejecuta el script **`pizzeria.sql`** para crear las tablas:  

   ```sql
   SOURCE pizzeria.sql;
   ```

4. (Opcional) Inserta datos de prueba con el archivo **`pizzeria_dml.sql`**:

   ```sql
   SOURCE pizzeria_dml.sql;
   ```

## 🖥️ Tecnologías Utilizadas

- **MySQL** (motor de base de datos)
- **SQL (DDL / DML)**  
- **DrawSQL** (para el modelado del diagrama entidad-relación)
- **Visual Studio Code** (entorno de desarrollo)
- **Docker** (contenedor `pizzeria_sql`)

## 💗 Autora

**Dayana Barbosa**  
Proyecto: *Gestión de base de datos – Pizzería Campus*  
📅 2025  
