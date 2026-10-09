# 💰 Control de Finanzas — SwiftUI

### Aplicación móvil nativa para iOS | Desarrollo de Aplicaciones Móviles

## 📌 Descripción del proyecto

**Control de Finanzas** es una aplicación móvil nativa para iOS desarrollada utilizando Swift y SwiftUI, cuyo propósito es facilitar la administración y el seguimiento de las finanzas personales mediante una interfaz moderna, intuitiva y funcional.

Este proyecto surge como una adaptación de nuestra aplicación Android **Semana4-Moviles**, desarrollada originalmente en Java, utilizando Room para la persistencia de datos y el patrón arquitectónico MVVM.

El objetivo de esta nueva implementación es trasladar las principales funcionalidades del aplicativo Android al ecosistema iOS, aprovechando las herramientas nativas de Apple para desarrollar una solución organizada, eficiente y adaptable.

La aplicación permite registrar ingresos y egresos, consultar el balance financiero, visualizar el historial de movimientos y analizar los resultados mensuales mediante gráficos interactivos.

Asimismo, incorpora persistencia local mediante SwiftData, permitiendo conservar los movimientos registrados sin depender de una conexión permanente a Internet.

---

## 👥 Integrantes del equipo

| Integrante | Responsabilidad |
|---|---|
| **Olivera Segura, Luis Alejandro** | Líder de Proyecto / Scrum Master |
| **Espinal Morillas, Sergio Antonio Sebastian** | Desarrollador UI/UX (Diseño de Interfaz) |
| **Arquiñigo Rojas, Abad Junior** | Administrador de Base de Datos (Backend Local) |
| **Landeo Castillo, Félix Rubén** | Desarrollador de Lógica de Negocio |
| **Vela Bravo, Glen Galahad** | Desarrollador de Integración y Pruebas (QA) |
| **Zarate Mamani, Junior Del Piero** | Documentador Técnico / DevOps |

## 🎯 Objetivos

### Objetivo general

Desarrollar una aplicación móvil nativa para iOS que permita administrar las finanzas personales mediante el registro de movimientos, el cálculo automático del balance y la visualización de información financiera.

### Objetivos específicos

- Adaptar las funcionalidades principales de la aplicación Android al entorno iOS.
- Implementar una interfaz nativa utilizando SwiftUI.
- Aplicar el patrón arquitectónico MVVM para organizar el código.
- Implementar almacenamiento persistente mediante SwiftData.
- Automatizar el cálculo de ingresos, egresos y balance financiero.
- Incorporar gráficos para el análisis mensual de movimientos.
- Mantener una interfaz adaptable al modo claro y oscuro del sistema operativo.

---

## 📱 Funcionalidades principales

### 1. Balance financiero

La pantalla principal muestra el balance total, calculado automáticamente a partir de los movimientos registrados.

**Balance = Total de ingresos − Total de egresos**

Esto permite consultar el estado financiero sin realizar cálculos manuales.

### 2. Registro de movimientos

La aplicación incorpora un formulario para registrar operaciones financieras.

Cada movimiento contiene:

- Tipo de operación: ingreso o egreso.
- Monto de la transacción.
- Categoría del movimiento.
- Método de pago: efectivo, tarjeta o Yape.
- Fecha de registro.

Los movimientos se incorporan al historial y se consideran en los cálculos financieros.

### 3. Historial de transacciones

Permite visualizar los movimientos registrados, ordenados por fecha desde el más reciente.

Se utilizan indicadores visuales para identificar cada operación:

- 🟢 Verde: ingresos.
- 🔴 Rojo: egresos.

### 4. Resumen financiero mensual

La aplicación permite consultar los resultados correspondientes a diferentes meses.

Esta sección incluye:

- Total de ingresos mensuales.
- Total de egresos mensuales.
- Comparación visual entre ingresos y gastos.
- Navegación entre periodos mediante controles de desplazamiento.

### 5. Gráficos financieros

Se implementó un gráfico de barras utilizando `Canvas` de SwiftUI, que permite representar visualmente los ingresos y egresos.

El gráfico incorpora barras redondeadas, líneas de referencia, porcentajes, etiquetas y animaciones de entrada.

### 6. Persistencia local

Los registros financieros se almacenan utilizando SwiftData, una tecnología de Apple que permite trabajar con modelos persistentes de manera integrada con SwiftUI.

La persistencia permite conservar los datos entre diferentes sesiones de uso.

### 7. Interfaz adaptable

La aplicación utiliza colores dinámicos del sistema, permitiendo adaptarse automáticamente a las configuraciones de apariencia clara y oscura de iOS.

---

## 🛠️ Tecnologías utilizadas

| Tecnología | Función |
|---|---|
| Swift 5.9 | Lenguaje principal de programación |
| SwiftUI | Desarrollo de interfaces de usuario |
| SwiftData | Persistencia y gestión local de datos |
| Observation (`@Observable`) | Gestión de estado observable |
| MVVM | Organización arquitectónica |
| Canvas | Representación de gráficos financieros |
| NavigationStack | Navegación entre vistas |
| Xcode 15+ | Entorno de desarrollo |
| XcodeGen | Generación del proyecto Xcode |
| iOS 17.0+ | Plataforma de ejecución |

## 🏗️ Arquitectura del proyecto

Para organizar los componentes de la aplicación se utiliza el patrón **Model-View-ViewModel (MVVM)**.

### Model

Se encarga de representar y almacenar la información financiera.

El modelo `Transaction` utiliza la anotación `@Model` de SwiftData para representar los movimientos.

### View

Contiene las vistas responsables de mostrar información y permitir la interacción con el usuario.

Las interfaces se desarrollan mediante componentes declarativos de SwiftUI.

### ViewModel

Gestiona la lógica de presentación y las operaciones relacionadas con los movimientos financieros.

`FinanceViewModel` utiliza `@Observable` para facilitar la actualización del estado de las vistas.

La arquitectura permite mantener separadas la presentación, los datos y la lógica de funcionamiento, contribuyendo a una mejor organización y mantenimiento del código.

---

## 📂 Estructura del proyecto

```text
ControlFinanzas/
│
├── project.yml
│
├── Resources/
│   └── Assets.xcassets/
│
└── Sources/
    │
    ├── App/
    │   └── ControlFinanzasApp.swift
    │
    ├── Models/
    │   └── Transaction.swift
    │
    ├── ViewModels/
    │   └── FinanceViewModel.swift
    │
    ├── Theme/
    │   └── AppTheme.swift
    │
    ├── Views/
    │   ├── HomeView.swift
    │   └── AddMovementView.swift
    │
    └── Components/
        ├── BalanceCard.swift
        ├── MonthlySummaryCard.swift
        ├── MonthlyBarChart.swift
        ├── TransactionRow.swift
        └── FloatingActionButton.swift
```

### Descripción de los componentes

| Archivo | Función |
|---|---|
| `ControlFinanzasApp.swift` | Punto de entrada y configuración principal |
| `Transaction.swift` | Modelo de transacciones financieras |
| `FinanceViewModel.swift` | Gestión de operaciones y lógica de presentación |
| `AppTheme.swift` | Definición de colores y formatos |
| `HomeView.swift` | Pantalla principal de finanzas |
| `AddMovementView.swift` | Formulario para registrar movimientos |
| `BalanceCard.swift` | Componente del balance financiero |
| `MonthlySummaryCard.swift` | Resumen de ingresos y gastos mensuales |
| `MonthlyBarChart.swift` | Gráfico de barras financiero |
| `TransactionRow.swift` | Representación individual de movimientos |
| `FloatingActionButton.swift` | Botón flotante para registrar operaciones |

---

## 🔄 Adaptación de Android a iOS

La aplicación se desarrolló tomando como referencia las funcionalidades del proyecto Android original.

Para esta implementación se reemplazaron componentes de Android por sus equivalentes en el ecosistema Apple.

| Android | iOS / SwiftUI |
|---|---|
| Java | Swift |
| XML Layouts | SwiftUI |
| Room Database | SwiftData |
| `@Entity` | `@Model` |
| LiveData | `@Observable` |
| MainActivity | RootView |
| Fragments | Views |
| RecyclerView | ForEach |
| Navigation Component | NavigationStack |
| Canvas personalizado | SwiftUI Canvas |
| FloatingActionButton | Componente flotante personalizado |
| TransactionRepository | FinanceViewModel |

La adaptación permitió conservar la finalidad del proyecto original utilizando las herramientas nativas de iOS.

---

## ⚙️ Requisitos del sistema

Para ejecutar el proyecto es necesario contar con:

- Computadora con macOS.
- Xcode 15 o superior.
- iOS 17.0 o superior como plataforma de destino.
- Swift 5.9.
- XcodeGen, para generar automáticamente el proyecto.
- Simulador de iPhone o dispositivo físico compatible.

## 🚀 Instalación y ejecución

### Opción 1: Utilizando XcodeGen

**1. Clonar el repositorio**

```bash
git clone <URL_DEL_REPOSITORIO>
```

**2. Acceder al directorio del proyecto**

```bash
cd swiftui/ControlFinanzas
```

**3. Instalar XcodeGen**

```bash
brew install xcodegen
```

**4. Generar el proyecto de Xcode**

```bash
xcodegen generate
```

**5. Abrir el proyecto**

```bash
open ControlFinanzas.xcodeproj
```

**6. Ejecutar la aplicación**

Seleccionar un simulador compatible y utilizar `⌘ + R` para compilar y ejecutar el proyecto.

### Opción 2: Configuración manual en Xcode

1. Abrir Xcode.
2. Seleccionar `File > New > Project`.
3. Elegir `iOS > App`.
4. Asignar el nombre `ControlFinanzas`.
5. Seleccionar Swift como lenguaje.
6. Seleccionar SwiftUI como interfaz.
7. Incorporar el contenido de la carpeta `Sources`.
8. Agregar los recursos de `Assets.xcassets`.
9. Configurar el destino de ejecución.
10. Compilar y ejecutar la aplicación.

---

## 🗄️ Persistencia de datos

Para la administración de la información se utiliza SwiftData.

El modelo `Transaction` representa los movimientos financieros y permite almacenar la información necesaria para realizar los cálculos de balance y resúmenes mensuales.

La integración con SwiftUI se realiza mediante herramientas como:

- `@Model`: definición de modelos persistentes.
- `ModelContainer`: configuración del almacenamiento.
- `@Query`: consulta de registros almacenados.
- `@Observable`: actualización del estado de presentación.

La consulta de movimientos contempla un ordenamiento descendente por fecha, permitiendo visualizar primero las operaciones más recientes.

---

## 🎨 Diseño de interfaz

La aplicación mantiene una línea visual enfocada en la claridad de la información financiera.

Se utilizaron tarjetas de información, controles de navegación, botones flotantes y gráficos.

### Paleta de colores

| Elemento | Color | Código |
|---|---|---|
| Ingresos | Verde | `#4CAF50` |
| Egresos | Rojo | `#F44336` |
| Líneas del gráfico | Gris | `#E0E0E0` |

El color verde representa operaciones positivas, mientras que el rojo permite identificar rápidamente los gastos.

La interfaz también aprovecha los colores dinámicos del sistema para adaptarse al modo claro y oscuro.

---

## 🧪 Pruebas y validación

Para validar el funcionamiento del proyecto se consideran los siguientes escenarios:

| Prueba | Resultado esperado |
|---|---|
| Registrar un ingreso | Incorporar el movimiento y actualizar el balance |
| Registrar un egreso | Registrar el gasto y descontarlo del saldo |
| Consultar movimientos | Mostrar los registros ordenados por fecha |
| Cambiar de mes | Actualizar el resumen del periodo seleccionado |
| Consultar el gráfico | Representar ingresos y egresos mensuales |
| Reiniciar la aplicación | Conservar los datos almacenados |
| Cambiar la apariencia de iOS | Adaptar la interfaz al tema del sistema |

Estas pruebas representan los criterios funcionales de validación del proyecto.

**Estado de compilación:** la documentación original indica que el código fue preparado en un entorno Linux sin Xcode, por lo que la compilación y ejecución en un entorno Apple se encuentran pendientes de validación.

---

## 📈 Posibles mejoras

Entre las mejoras que podrían incorporarse en futuras versiones se encuentran:

- Presupuestos mensuales por categoría.
- Metas de ahorro.
- Reportes financieros descargables.
- Notificaciones de gastos y pagos.
- Filtros de búsqueda avanzados.
- Sincronización de datos mediante servicios en la nube.
- Estadísticas financieras adicionales.
- Autenticación de usuarios.
- Respaldo y recuperación de información.

Estas funcionalidades se consideran posibles ampliaciones y no forman parte de las características confirmadas de la versión actual.

---

## 📚 Conclusiones

El desarrollo de **Control de Finanzas para iOS** permite aplicar los conocimientos adquiridos en el curso de Desarrollo de Aplicaciones Móviles, especialmente en programación nativa, diseño de interfaces, gestión de datos y arquitectura de software.

A través de este proyecto logramos trasladar el diseño funcional de una aplicación Android al ecosistema iOS, utilizando SwiftUI y SwiftData como tecnologías principales.

La organización mediante MVVM contribuye a mantener una estructura modular, mientras que la incorporación de gráficos y componentes visuales facilita la interpretación de los movimientos financieros.

Este trabajo constituye una base para continuar implementando nuevas funcionalidades relacionadas con la administración de finanzas personales y mejorar progresivamente la experiencia de usuario.

---

## 📄 Información académica

**Proyecto:** Control de Finanzas — SwiftUI  
**Curso:** Desarrollo de Aplicaciones Móviles  
**Área:** Ingeniería de Sistemas  
**Plataforma:** iOS  
**Lenguaje:** Swift 5.9  
**Framework:** SwiftUI  
**Arquitectura:** MVVM  
**Año:** 2026

---

**Desarrollado por el equipo de Desarrollo de Aplicaciones Móviles — 2026.**
