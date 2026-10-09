//
//  Transaction.swift
//  ControlFinanzas
//
//  Portado desde: data/Transaction.java  (Android Room @Entity "transactions")
//
//  En Android era una entidad de Room con @PrimaryKey(autoGenerate = true).
//  En SwiftUI lo modelamos con SwiftData (@Model), que es el equivalente
//  moderno de persistencia declarativa. El identificador `id` pasa a ser
//  un UUID autogenerado por el framework.
//

import Foundation
import SwiftData

@Model
final class Transaction {

    /// Identificador único (equivalente a @PrimaryKey(autoGenerate = true)).
    @Attribute(.unique) var id: UUID

    /// Tipo de movimiento: "Ingreso" o "Egreso".
    var type: String

    /// Monto del movimiento.
    var amount: Double

    /// Categoría. Ej: "Comida", "Transporte", "Salario", etc.
    var category: String

    /// Forma de pago: "Efectivo", "Tarjeta", "Yape".
    var paymentMethod: String

    /// Fecha como timestamp (equivalente a `long date` de Android).
    var date: Date

    init(
        type: String,
        amount: Double,
        category: String,
        paymentMethod: String,
        date: Date = .now
    ) {
        self.id = UUID()
        self.type = type
        self.amount = amount
        self.category = category
        self.paymentMethod = paymentMethod
        self.date = date
    }
}

// MARK: - Helpers de dominio

extension Transaction {

    /// ¿Es un ingreso? (Antes: `"Ingreso".equals(t.getType())`)
    var isIncome: Bool { type == MovementType.income.rawValue }

    /// Importe con signo aplicado según el tipo.
    var signedAmount: Double { isIncome ? amount : -amount }
}

// MARK: - Constantes de dominio
//
// En Android venían de `res/values/strings.xml` (string-array movement_types
// y payment_methods). Aquí las exponemos como enums tipados.

enum MovementType: String, CaseIterable, Identifiable {
    case income = "Ingreso"
    case expense = "Egreso"

    var id: String { rawValue }
}

enum PaymentMethod: String, CaseIterable, Identifiable {
    case cash = "Efectivo"
    case card = "Tarjeta"
    case yape = "Yape"

    var id: String { rawValue }
}
