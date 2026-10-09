# Control de Finanzas — SwiftUI

Conversión a **SwiftUI** de la app Android *"Semana4-Moviles"* (Java + Room + MVVM).
Aplicación nativa de iOS para el control de finanzas personales: registrar
ingresos/egresos, ver el balance total y un resumen mensual con gráfico.

## 📱 Requisitos

- **Xcode 15 o superior**
- **iOS 17.0+** (usa `@Observable` y SwiftData)
- Opcional: **XcodeGen** (`brew install xcodegen`) para generar el `.xcodeproj`

## 🚀 Cómo abrir / compilar el proyecto

### Opción A — XcodeGen (recomendada)

```bash
cd swiftui/ControlFinanzas
brew install xcodegen          # solo la primera vez
xcodegen generate              # crea ControlFinanzas.xcodeproj
open ControlFinanzas.xcodeproj
```

### Opción B — Proyecto nuevo desde Xcode

1. Xcode → *File ▸ New ▸ Project… ▸ iOS ▸ App*.
2. Nombre: **ControlFinanzas**, Interface: **SwiftUI**, Language: **Swift**.
3. Arrastra la carpeta `Sources/` completa dentro del proyecto.
4. Copia `Resources/Assets.xcassets` sobre el del proyecto nuevo.

Ejecuta con **⌘R** en un simulador de iPhone.

## 🗂️ Estructura

```
ControlFinanzas/
├── project.yml                      # spec de XcodeGen
├── Resources/Assets.xcassets/       # AppIcon + AccentColor (#4CAF50)
└── Sources/
    ├── App/ControlFinanzasApp.swift # @main + ModelContainer + RootView (Toolbar + FAB)
    ├── Models/Transaction.swift     # @Model (antes: @Entity de Room)
    ├── ViewModels/FinanceViewModel.swift
    ├── Theme/AppTheme.swift         # colores y formateo de moneda
    ├── Views/
    │   ├── HomeView.swift           # antes: FirstFragment + fragment_first.xml
    │   └── AddMovementView.swift    # antes: SecondFragment + fragment_second.xml
    └── Components/
        ├── BalanceCard.swift
        ├── MonthlySummaryCard.swift
        ├── MonthlyBarChart.swift    # antes: MonthlyChartView.java (Canvas)
        ├── TransactionRow.swift     # antes: item_transaction.xml + Adapter
        └── FloatingActionButton.swift
```

## 🔄 Mapeo Android → SwiftUI

| Android (original)                        | SwiftUI (este proyecto)                        |
|-------------------------------------------|------------------------------------------------|
| `@Entity Transaction` (Room)              | `@Model final class Transaction` (SwiftData)   |
| `AppDatabase` (Room `finance_database`)   | `ModelContainer(for: Transaction.self)`        |
| `TransactionDao.getAllTransactions()`     | `@Query(sort: \.date, order: .reverse)`        |
| `TransactionRepository` + `ExecutorService` | `FinanceViewModel` (métodos `insert`/`delete`) |
| `TransactionViewModel` (`LiveData`)       | `FinanceViewModel` (`@Observable`)             |
| `MainActivity` + `nav_graph.xml`          | `RootView` + `NavigationStack` + `.sheet`      |
| `activity_main.xml` (Toolbar + FAB)       | `.toolbar` + `FloatingActionButton` overlay    |
| `FirstFragment` + `fragment_first.xml`    | `HomeView` + `BalanceCard` + `MonthlySummaryCard` |
| `SecondFragment` + `fragment_second.xml`  | `AddMovementView` (Form)                       |
| `RecyclerView` + `TransactionAdapter`     | `ForEach` + `TransactionRow`                   |
| `MonthlyChartView` (Canvas custom)        | `MonthlyBarChart` (SwiftUI `Canvas`)           |
| `Color.parseColor("#4CAF50")`             | `AppTheme.income`                              |
| `SimpleDateFormat("MMMM yyyy", es-ES)`    | `DateFormatter(locale: es_ES)`                 |
| `Toast.makeText(...)`                     | Overlay de confirmación                        |

## ✅ Funcionalidades

- **Balance total** en tiempo real (Ingresos − Egresos).
- **Resumen mensual**: navegación de meses (◀ ▶), gráfico de barras
  Ingresos/Egresos con porcentajes y animación de entrada.
- **Registro de movimientos**: tipo (Ingreso/Egreso), cantidad, categoría y
  forma de pago (Efectivo, Tarjeta, Yape).
- **Historial reciente** ordenado por fecha (verde = ingreso, rojo = egreso).
- **Persistencia local** con SwiftData.
- **Modo oscuro** automático (colores del sistema).

## 🎨 Colores

| Uso              | Hex       | SwiftUI                  |
|------------------|-----------|--------------------------|
| Ingresos / FAB   | `#4CAF50` | `AppTheme.income`        |
| Egresos          | `#F44336` | `AppTheme.expense`       |
| Rejilla gráfico  | `#E0E0E0` | `AppTheme.grid`          |

## ⚠️ Notas de la conversión

- Este proyecto se generó en un entorno **Linux sin Xcode**, por lo que **no se
  ha podido compilar** aquí. El código está escrito para **Xcode 15+ / iOS 17+**;
  revisa los `#Preview` para validar cada vista rápidamente.
- La vista de gráfico es una **reimplementación 1:1** de `MonthlyChartView.java`
  usando `Canvas` de SwiftUI (mismas proporciones, rejilla discontinua, barras
  redondeadas, importes y etiquetas con porcentaje).
