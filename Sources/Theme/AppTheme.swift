//
//  AppTheme.swift
//  ControlFinanzas
//
//  Centraliza los colores y métricas que en Android estaban dispersos entre
//  res/values/colors.xml, themes.xml y los valores "hardcodeados" en Java
//  (Color.parseColor("#4CAF50") etc.).
//

import SwiftUI

enum AppTheme {

    // MARK: Colores de acento (idénticos a los del proyecto Android)

    /// Verde usado para ingresos y balance positivo.  (#4CAF50)
    static let income = Color(red: 0x4C / 255, green: 0xAF / 255, blue: 0x50 / 255)

    /// Rojo usado para egresos y balance negativo.  (#F44336)
    static let expense = Color(red: 0xF4 / 255, green: 0x43 / 255, blue: 0x36 / 255)

    /// Gris de las líneas de rejilla del gráfico.  (#E0E0E0)
    static let grid = Color(red: 0xE0 / 255, green: 0xE0 / 255, blue: 0xE0 / 255)

    // MARK: Métricas

    /// Radio de esquina de las tarjetas (app:cardCornerRadius="12dp").
    static let cardCornerRadius: CGFloat = 12

    /// Padding interno estándar (android:padding="16dp").
    static let screenPadding: CGFloat = 16

    /// Altura del gráfico mensual (android:layout_height="220dp").
    static let chartHeight: CGFloat = 220
}

// MARK: - Formateo de moneda
//
// Reemplaza el patrón Java: String.format(Locale.getDefault(), "S/. %.2f", value)
// Se mantiene el prefijo "S/." (soles peruanos) tal como en el original.

enum CurrencyFormatter {

    /// Formatea un valor absoluto: "S/. 1,234.50".
    static func amount(_ value: Double) -> String {
        String(format: "S/. %.2f", value)
    }

    /// Formatea un monto con signo explícito: "+ S/. 10.00" / "- S/. 10.00".
    static func signed(_ value: Double) -> String {
        let prefix = value >= 0 ? "+ S/. " : "- S/. "
        return prefix + String(format: "%.2f", abs(value))
    }

    /// Formatea un monto según el tipo de movimiento (ingreso/egreso).
    static func signed(_ value: Double, isIncome: Bool) -> String {
        (isIncome ? "+ S/. " : "- S/. ") + String(format: "%.2f", value)
    }
}
