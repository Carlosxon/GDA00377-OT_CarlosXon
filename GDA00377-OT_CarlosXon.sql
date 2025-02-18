USE [master]
GO
/****** Object:  Database [GDA00377-OT_CarlosXon]    Script Date: 18/12/2024 12:03:37 ******/
CREATE DATABASE [GDA00377-OT_CarlosXon]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'GDA00377-OT_CarlosXon', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\GDA00377-OT_CarlosXon.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'GDA00377-OT_CarlosXon_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\GDA00377-OT_CarlosXon_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [GDA00377-OT_CarlosXon] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [GDA00377-OT_CarlosXon].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [GDA00377-OT_CarlosXon] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [GDA00377-OT_CarlosXon] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [GDA00377-OT_CarlosXon] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [GDA00377-OT_CarlosXon] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [GDA00377-OT_CarlosXon] SET ARITHABORT OFF 
GO
ALTER DATABASE [GDA00377-OT_CarlosXon] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [GDA00377-OT_CarlosXon] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [GDA00377-OT_CarlosXon] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [GDA00377-OT_CarlosXon] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [GDA00377-OT_CarlosXon] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [GDA00377-OT_CarlosXon] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [GDA00377-OT_CarlosXon] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [GDA00377-OT_CarlosXon] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [GDA00377-OT_CarlosXon] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [GDA00377-OT_CarlosXon] SET  ENABLE_BROKER 
GO
ALTER DATABASE [GDA00377-OT_CarlosXon] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [GDA00377-OT_CarlosXon] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [GDA00377-OT_CarlosXon] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [GDA00377-OT_CarlosXon] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [GDA00377-OT_CarlosXon] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [GDA00377-OT_CarlosXon] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [GDA00377-OT_CarlosXon] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [GDA00377-OT_CarlosXon] SET RECOVERY FULL 
GO
ALTER DATABASE [GDA00377-OT_CarlosXon] SET  MULTI_USER 
GO
ALTER DATABASE [GDA00377-OT_CarlosXon] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [GDA00377-OT_CarlosXon] SET DB_CHAINING OFF 
GO
ALTER DATABASE [GDA00377-OT_CarlosXon] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [GDA00377-OT_CarlosXon] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [GDA00377-OT_CarlosXon] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [GDA00377-OT_CarlosXon] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'GDA00377-OT_CarlosXon', N'ON'
GO
ALTER DATABASE [GDA00377-OT_CarlosXon] SET QUERY_STORE = ON
GO
ALTER DATABASE [GDA00377-OT_CarlosXon] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [GDA00377-OT_CarlosXon]
GO
/****** Object:  Table [dbo].[Productos]    Script Date: 18/12/2024 12:03:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Productos](
	[idProductos] [int] IDENTITY(1,1) NOT NULL,
	[CategoriaProductos_idCategoriaProductos] [int] NULL,
	[usuarios_idusuarios] [int] NULL,
	[nombre] [varchar](45) NULL,
	[marca] [varchar](45) NULL,
	[codigo] [varchar](45) NULL,
	[stock] [float] NULL,
	[estados_idestados] [int] NULL,
	[precio] [float] NULL,
	[fecha_creacion] [datetime] NULL,
	[foto] [varbinary](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[idProductos] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [dbo].[ProductosActivosEnStock]    Script Date: 18/12/2024 12:03:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[ProductosActivosEnStock] AS
SELECT 
    idProductos,
    nombre,
    stock,
    precio
FROM 
    Productos
WHERE 
    estados_idestados = 1 AND stock > 0;
GO
/****** Object:  Table [dbo].[Orden]    Script Date: 18/12/2024 12:03:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orden](
	[idOrden] [int] IDENTITY(1,1) NOT NULL,
	[usuarios_idusuarios] [int] NULL,
	[estados_idestados] [int] NULL,
	[fecha_creacion] [datetime] NULL,
	[nombre_completo] [varchar](245) NULL,
	[direccion] [varchar](45) NULL,
	[telefono] [varchar](45) NULL,
	[correo_electronico] [varchar](45) NULL,
	[fecha_entrega] [date] NULL,
	[total_orden] [float] NULL,
PRIMARY KEY CLUSTERED 
(
	[idOrden] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[TotalOrdenesAgosto2024]    Script Date: 18/12/2024 12:03:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[TotalOrdenesAgosto2024] AS
SELECT 
    SUM(total_orden) AS TotalQuetzales
FROM 
    Orden
WHERE 
    MONTH(fecha_creacion) = 8 AND YEAR(fecha_creacion) = 2024;
GO
/****** Object:  Table [dbo].[Clientes]    Script Date: 18/12/2024 12:03:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Clientes](
	[idClientes] [int] IDENTITY(1,1) NOT NULL,
	[razon_social] [varchar](245) NULL,
	[nombre_comercial] [varchar](245) NULL,
	[direccion_entrega] [varchar](45) NULL,
	[telefono] [varchar](45) NULL,
	[email] [varchar](45) NULL,
PRIMARY KEY CLUSTERED 
(
	[idClientes] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[usuarios]    Script Date: 18/12/2024 12:03:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[usuarios](
	[idusuarios] [int] IDENTITY(1,1) NOT NULL,
	[rol_idrol] [int] NULL,
	[estados_idestados] [int] NULL,
	[correo_electronico] [varchar](45) NOT NULL,
	[nombre_completo] [varchar](245) NULL,
	[password] [varchar](45) NULL,
	[telefono] [varchar](45) NULL,
	[fecha_nacimiento] [date] NULL,
	[fecha_creacion] [datetime] NULL,
	[Clientes_idClientes] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[idusuarios] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[Top10ClientesMayorConsumo]    Script Date: 18/12/2024 12:03:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[Top10ClientesMayorConsumo] AS
SELECT TOP 10
    c.razon_social,
    SUM(o.total_orden) AS TotalConsumo
FROM 
    Orden o
JOIN 
    usuarios u ON o.usuarios_idusuarios = u.idusuarios
JOIN 
    Clientes c ON u.Clientes_idClientes = c.idClientes
GROUP BY 
    c.razon_social
ORDER BY 
    TotalConsumo DESC;


GO
/****** Object:  Table [dbo].[OrdenDetalles]    Script Date: 18/12/2024 12:03:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrdenDetalles](
	[idOrdenDetalles] [int] IDENTITY(1,1) NOT NULL,
	[Orden_idOrden] [int] NULL,
	[Productos_idProductos] [int] NULL,
	[cantidad] [int] NULL,
	[precio] [float] NULL,
	[subtotal] [float] NULL,
PRIMARY KEY CLUSTERED 
(
	[idOrdenDetalles] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[Top10ProductosMasVendidos]    Script Date: 18/12/2024 12:03:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[Top10ProductosMasVendidos] AS
SELECT TOP 10
    p.nombre,
    SUM(od.cantidad) AS CantidadVendida
FROM 
    OrdenDetalles od
JOIN 
    Productos p ON od.Productos_idProductos = p.idProductos
GROUP BY 
    p.nombre
ORDER BY 
    CantidadVendida ASC;
GO
/****** Object:  Table [dbo].[CategoriaProductos]    Script Date: 18/12/2024 12:03:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CategoriaProductos](
	[idCategoriaProductos] [int] IDENTITY(1,1) NOT NULL,
	[usuarios_idusuarios] [int] NULL,
	[nombre] [varchar](45) NULL,
	[estados_idestados] [int] NULL,
	[fecha_creacion] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[idCategoriaProductos] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[estados]    Script Date: 18/12/2024 12:03:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[estados](
	[idestados] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [varchar](45) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[idestados] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[rol]    Script Date: 18/12/2024 12:03:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[rol](
	[idrol] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [varchar](45) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[idrol] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[CategoriaProductos] ON 

INSERT [dbo].[CategoriaProductos] ([idCategoriaProductos], [usuarios_idusuarios], [nombre], [estados_idestados], [fecha_creacion]) VALUES (2, 2, N'Teclado', 1, CAST(N'2024-12-18T00:00:00.000' AS DateTime))
INSERT [dbo].[CategoriaProductos] ([idCategoriaProductos], [usuarios_idusuarios], [nombre], [estados_idestados], [fecha_creacion]) VALUES (3, 3, NULL, NULL, CAST(N'2024-12-18T10:48:07.857' AS DateTime))
INSERT [dbo].[CategoriaProductos] ([idCategoriaProductos], [usuarios_idusuarios], [nombre], [estados_idestados], [fecha_creacion]) VALUES (4, 4, N'Mouse', 1, CAST(N'2024-10-18T00:00:00.000' AS DateTime))
INSERT [dbo].[CategoriaProductos] ([idCategoriaProductos], [usuarios_idusuarios], [nombre], [estados_idestados], [fecha_creacion]) VALUES (8, 2, N'Monitor', 1, CAST(N'2024-12-18T00:00:00.000' AS DateTime))
INSERT [dbo].[CategoriaProductos] ([idCategoriaProductos], [usuarios_idusuarios], [nombre], [estados_idestados], [fecha_creacion]) VALUES (9, 3, N'Sillas', 1, CAST(N'2024-12-18T10:51:00.707' AS DateTime))
SET IDENTITY_INSERT [dbo].[CategoriaProductos] OFF
GO
SET IDENTITY_INSERT [dbo].[Clientes] ON 

INSERT [dbo].[Clientes] ([idClientes], [razon_social], [nombre_comercial], [direccion_entrega], [telefono], [email]) VALUES (1, N'Juan Pérez', N'JP Store', N'Avenida 123, Ciudad', N'12345678', N'juanperez@example.com')
INSERT [dbo].[Clientes] ([idClientes], [razon_social], [nombre_comercial], [direccion_entrega], [telefono], [email]) VALUES (2, N'María López', N'ML Market', N'Calle Falsa 456, Ciudad', N'87654321', N'marialopez@example.com')
INSERT [dbo].[Clientes] ([idClientes], [razon_social], [nombre_comercial], [direccion_entrega], [telefono], [email]) VALUES (3, N'Carlos García', N'CG Supplies', N'Boulevard 789, Ciudad', N'11223344', N'carlosg@example.com')
INSERT [dbo].[Clientes] ([idClientes], [razon_social], [nombre_comercial], [direccion_entrega], [telefono], [email]) VALUES (4, N'Juan Pérez', N'JP Store', N'Avenida 123, Ciudad', N'12345678', N'juanperez@example.com')
INSERT [dbo].[Clientes] ([idClientes], [razon_social], [nombre_comercial], [direccion_entrega], [telefono], [email]) VALUES (5, N'María López', N'ML Market', N'Calle Falsa 456, Ciudad', N'87654321', N'marialopez@example.com')
INSERT [dbo].[Clientes] ([idClientes], [razon_social], [nombre_comercial], [direccion_entrega], [telefono], [email]) VALUES (6, N'Carlos García', N'CG Supplies', N'Boulevard 789, Ciudad', N'11223344', N'carlosg@example.com')
SET IDENTITY_INSERT [dbo].[Clientes] OFF
GO
SET IDENTITY_INSERT [dbo].[estados] ON 

INSERT [dbo].[estados] ([idestados], [nombre]) VALUES (1, N'Activo')
INSERT [dbo].[estados] ([idestados], [nombre]) VALUES (2, N'Inactivo')
SET IDENTITY_INSERT [dbo].[estados] OFF
GO
SET IDENTITY_INSERT [dbo].[Orden] ON 

INSERT [dbo].[Orden] ([idOrden], [usuarios_idusuarios], [estados_idestados], [fecha_creacion], [nombre_completo], [direccion], [telefono], [correo_electronico], [fecha_entrega], [total_orden]) VALUES (1, 2, 1, CAST(N'2024-12-17T16:18:22.977' AS DateTime), N'Juan Pérez', N'Avenida 123, Ciudad', N'12345678', N'juanperez@example.com', CAST(N'2024-08-15' AS Date), 100)
INSERT [dbo].[Orden] ([idOrden], [usuarios_idusuarios], [estados_idestados], [fecha_creacion], [nombre_completo], [direccion], [telefono], [correo_electronico], [fecha_entrega], [total_orden]) VALUES (2, 3, 1, CAST(N'2024-12-17T16:18:22.977' AS DateTime), N'María López', N'Calle Falsa 456, Ciudad', N'87654321', N'marialopez@example.com', CAST(N'2024-08-16' AS Date), 500)
INSERT [dbo].[Orden] ([idOrden], [usuarios_idusuarios], [estados_idestados], [fecha_creacion], [nombre_completo], [direccion], [telefono], [correo_electronico], [fecha_entrega], [total_orden]) VALUES (3, 4, 1, CAST(N'2024-12-17T16:18:22.977' AS DateTime), N'Carlos García', N'Boulevard 789, Ciudad', N'11223344', N'carlosg@example.com', CAST(N'2024-08-17' AS Date), 900)
INSERT [dbo].[Orden] ([idOrden], [usuarios_idusuarios], [estados_idestados], [fecha_creacion], [nombre_completo], [direccion], [telefono], [correo_electronico], [fecha_entrega], [total_orden]) VALUES (6, 3, 1, CAST(N'2024-12-18T10:52:26.440' AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL)
SET IDENTITY_INSERT [dbo].[Orden] OFF
GO
SET IDENTITY_INSERT [dbo].[OrdenDetalles] ON 

INSERT [dbo].[OrdenDetalles] ([idOrdenDetalles], [Orden_idOrden], [Productos_idProductos], [cantidad], [precio], [subtotal]) VALUES (1, 2, 2, 10, 2.5, 25)
INSERT [dbo].[OrdenDetalles] ([idOrdenDetalles], [Orden_idOrden], [Productos_idProductos], [cantidad], [precio], [subtotal]) VALUES (2, 3, 3, 20, 1.2, 24)
INSERT [dbo].[OrdenDetalles] ([idOrdenDetalles], [Orden_idOrden], [Productos_idProductos], [cantidad], [precio], [subtotal]) VALUES (3, 2, 2, 50, 0.9, 45)
INSERT [dbo].[OrdenDetalles] ([idOrdenDetalles], [Orden_idOrden], [Productos_idProductos], [cantidad], [precio], [subtotal]) VALUES (4, 3, 3, 30, 2.5, 75)
SET IDENTITY_INSERT [dbo].[OrdenDetalles] OFF
GO
SET IDENTITY_INSERT [dbo].[Productos] ON 

INSERT [dbo].[Productos] ([idProductos], [CategoriaProductos_idCategoriaProductos], [usuarios_idusuarios], [nombre], [marca], [codigo], [stock], [estados_idestados], [precio], [fecha_creacion], [foto]) VALUES (2, 2, 2, N'Leche Entera', N'LALA', N'LE001', 50, 1, 100, CAST(N'2024-12-17T16:17:33.417' AS DateTime), NULL)
INSERT [dbo].[Productos] ([idProductos], [CategoriaProductos_idCategoriaProductos], [usuarios_idusuarios], [nombre], [marca], [codigo], [stock], [estados_idestados], [precio], [fecha_creacion], [foto]) VALUES (3, 3, 3, N'Pan Integral', N'Bimbo', N'PI002', 30, 1, 200, CAST(N'2024-12-17T16:17:33.417' AS DateTime), NULL)
INSERT [dbo].[Productos] ([idProductos], [CategoriaProductos_idCategoriaProductos], [usuarios_idusuarios], [nombre], [marca], [codigo], [stock], [estados_idestados], [precio], [fecha_creacion], [foto]) VALUES (4, 4, 4, N'Arroz Blanco', N'Diana', N'AR003', 100, 1, 300, CAST(N'2024-12-17T16:17:33.417' AS DateTime), NULL)
SET IDENTITY_INSERT [dbo].[Productos] OFF
GO
SET IDENTITY_INSERT [dbo].[rol] ON 

INSERT [dbo].[rol] ([idrol], [nombre]) VALUES (1, N'Administrador')
INSERT [dbo].[rol] ([idrol], [nombre]) VALUES (2, N'Gerente')
INSERT [dbo].[rol] ([idrol], [nombre]) VALUES (3, N'Vendedor')
SET IDENTITY_INSERT [dbo].[rol] OFF
GO
SET IDENTITY_INSERT [dbo].[usuarios] ON 

INSERT [dbo].[usuarios] ([idusuarios], [rol_idrol], [estados_idestados], [correo_electronico], [nombre_completo], [password], [telefono], [fecha_nacimiento], [fecha_creacion], [Clientes_idClientes]) VALUES (2, 1, 1, N'juanperez@example.com', N'Juan Pérez', N'password123', N'12345678', CAST(N'1990-01-01' AS Date), CAST(N'2024-12-17T16:15:35.343' AS DateTime), 1)
INSERT [dbo].[usuarios] ([idusuarios], [rol_idrol], [estados_idestados], [correo_electronico], [nombre_completo], [password], [telefono], [fecha_nacimiento], [fecha_creacion], [Clientes_idClientes]) VALUES (3, 1, 1, N'marialopez@example.com', N'María López', N'password456', N'87654321', CAST(N'1985-02-15' AS Date), CAST(N'2024-12-17T16:15:35.343' AS DateTime), 2)
INSERT [dbo].[usuarios] ([idusuarios], [rol_idrol], [estados_idestados], [correo_electronico], [nombre_completo], [password], [telefono], [fecha_nacimiento], [fecha_creacion], [Clientes_idClientes]) VALUES (4, 2, 2, N'carlosg@example.com', N'Carlos García', N'password789', N'11223344', CAST(N'1988-03-20' AS Date), CAST(N'2024-12-17T16:15:35.343' AS DateTime), 3)
SET IDENTITY_INSERT [dbo].[usuarios] OFF
GO
ALTER TABLE [dbo].[CategoriaProductos] ADD  DEFAULT (getdate()) FOR [fecha_creacion]
GO
ALTER TABLE [dbo].[Orden] ADD  DEFAULT (getdate()) FOR [fecha_creacion]
GO
ALTER TABLE [dbo].[Productos] ADD  DEFAULT (getdate()) FOR [fecha_creacion]
GO
ALTER TABLE [dbo].[usuarios] ADD  DEFAULT (getdate()) FOR [fecha_creacion]
GO
ALTER TABLE [dbo].[CategoriaProductos]  WITH CHECK ADD FOREIGN KEY([estados_idestados])
REFERENCES [dbo].[estados] ([idestados])
GO
ALTER TABLE [dbo].[CategoriaProductos]  WITH CHECK ADD FOREIGN KEY([usuarios_idusuarios])
REFERENCES [dbo].[usuarios] ([idusuarios])
GO
ALTER TABLE [dbo].[Orden]  WITH CHECK ADD FOREIGN KEY([estados_idestados])
REFERENCES [dbo].[estados] ([idestados])
GO
ALTER TABLE [dbo].[Orden]  WITH CHECK ADD FOREIGN KEY([usuarios_idusuarios])
REFERENCES [dbo].[usuarios] ([idusuarios])
GO
ALTER TABLE [dbo].[OrdenDetalles]  WITH CHECK ADD FOREIGN KEY([Orden_idOrden])
REFERENCES [dbo].[Orden] ([idOrden])
GO
ALTER TABLE [dbo].[OrdenDetalles]  WITH CHECK ADD FOREIGN KEY([Productos_idProductos])
REFERENCES [dbo].[Productos] ([idProductos])
GO
ALTER TABLE [dbo].[Productos]  WITH CHECK ADD FOREIGN KEY([CategoriaProductos_idCategoriaProductos])
REFERENCES [dbo].[CategoriaProductos] ([idCategoriaProductos])
GO
ALTER TABLE [dbo].[Productos]  WITH CHECK ADD FOREIGN KEY([estados_idestados])
REFERENCES [dbo].[estados] ([idestados])
GO
ALTER TABLE [dbo].[Productos]  WITH CHECK ADD FOREIGN KEY([usuarios_idusuarios])
REFERENCES [dbo].[usuarios] ([idusuarios])
GO
ALTER TABLE [dbo].[usuarios]  WITH CHECK ADD FOREIGN KEY([Clientes_idClientes])
REFERENCES [dbo].[Clientes] ([idClientes])
GO
ALTER TABLE [dbo].[usuarios]  WITH CHECK ADD FOREIGN KEY([estados_idestados])
REFERENCES [dbo].[estados] ([idestados])
GO
ALTER TABLE [dbo].[usuarios]  WITH CHECK ADD FOREIGN KEY([rol_idrol])
REFERENCES [dbo].[rol] ([idrol])
GO
/****** Object:  StoredProcedure [dbo].[InactivarProducto]    Script Date: 18/12/2024 12:03:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InactivarProducto]
    @idProductos INT,
    @idestados INT
AS
BEGIN
    UPDATE Productos
    SET estados_idestados = @idestados
    WHERE idProductos = @idProductos;
END;
GO
/****** Object:  StoredProcedure [dbo].[InsertarUsuario]    Script Date: 18/12/2024 12:03:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertarUsuario]
    @rol_idrol INT,
    @estados_idestados INT,
    @correo_electronico VARCHAR(45),
    @nombre_completo VARCHAR(245),
    @password VARCHAR(45),
    @telefono VARCHAR(45),
    @fecha_nacimiento DATE,
    @Clientes_idClientes INT
AS
BEGIN
    INSERT INTO usuarios (rol_idrol, estados_idestados, correo_electronico, nombre_completo, password, telefono, fecha_nacimiento, Clientes_idClientes)
    VALUES (@rol_idrol, @estados_idestados, @correo_electronico, @nombre_completo, @password, @telefono, @fecha_nacimiento, @Clientes_idClientes);
END;
GO
USE [master]
GO
ALTER DATABASE [GDA00377-OT_CarlosXon] SET  READ_WRITE 
GO
