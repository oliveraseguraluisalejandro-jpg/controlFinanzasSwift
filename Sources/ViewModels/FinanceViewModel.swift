//
//  FinanceViewModel.swift
//  ControlFinanzas
//
//  Portado desde la capa MVVM de Android:
//    - data/TransactionRepository.java
//    - ui/TransactionViewModel.java
//
//  Android usaba LiveData<List<Transaction>> + ExecutorService para escribir en
//  Room en segundo plano. Aquí usamos @Observable (Observation framework, iOS 17)
//  y el ModelContext de SwiftData. La reactividad de la lista la aporta
//  @Query en la vista, mientras el ViewModel calcula balance, totales
//  mensuales y expone las operaciones de escritura (insert / delete).
//

import Foundation
import Observation
import SwiftData

@Observable
final class FinanceViewModel {

    // MARK: Estado de selección de mes (equivalente a `selectedCalendar`)

    /// Mes actualmente seleccionado para el resumen mensual.
    var selectedMonth: Date = .now

    // MARK: Operaciones de escritura (Repository)

    /// Inserta un movimiento. Antes: `repository.insert(transaction)`.
    func insert(_ transaction: Transaction, in context: ModelContext) {
        context.insert(transaction)
        try? context.save()
    }

    /// Elimina un movimiento. Antes: `repository.delete(transaction)`.
    func delete(_ transaction: Transaction, in context: ModelContext) {
        context.delete(transaction)
        try? context.save()
    }

    // MARK: Navegación de meses (btnPrevMonth / btnNextMonth)

    func previousMonth() {
        selectedMonth = Calendar.current.date(byAdding: .month, value: -1, to: selectedMonth) ?? selectedMonth
    }

    func nextMonth() {
        selectedMonth = Calendar.current.date(byAdding: .month, value: 1, to: selectedMonth) ?? selectedMonth
    }

    // MARK: Cálculos (antes en FirstFragment.updateUI())

    /// Balance total de TODOS los movimientos (Ingresos - Egresos).
    /// Antes: `overallBalance` en FirstFragment.
    func overallBalance(from transactions: [Transaction]) -> Double {
        transactions.reduce(0) { $0 + $1.signedAmount }
    }

    /// Suma de ingresos del mes seleccionado.
    func monthlyIncome(from transactions: [Transaction]) -> Double {
        transactions
            .filter { $0.isIncome && isInSelectedMonth($0.date) }
            .reduce(0) { $0 + $1.amount }
    }

    /// Suma de egresos del mes seleccionado.
    func monthlyExpense(from transactions: [Transaction]) -> Double {
        transactions
            .filter { !$0.isIncome && isInSelectedMonth($0.date) }
            .reduce(0) { $0 + $1.amount }
    }

    /// ¿La fecha pertenece al mes/año seleccionado?
    /// Antes: comparación de Calendar.YEAR y Calendar.MONTH en el bucle de FirstFragment.
    private func isInSelectedMonth(_ date: Date) -> Bool {
        let calendar = Calendar.current
        return calendar.component(.year, from: date) == calendar.component(.year, from: selectedMonth)
            && calendar.component(.month, from: date) == calendar.component(.month, from: selectedMonth)
    }

    /// Título del mes con la primera letra en mayúscula: "Septiembre 2026".
    /// Antes: SimpleDateFormat("MMMM yyyy", Locale("es-ES")) + capitalización manual.
    var formattedMonth: String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "es_ES")
        formatter.dateFormat = "MMMM yyyy"
        let raw = formatter.string(from: selectedMonth)
        guard let first = raw.first else { return raw }
        return first.uppercased() + raw.dropFirst()
    }
}
