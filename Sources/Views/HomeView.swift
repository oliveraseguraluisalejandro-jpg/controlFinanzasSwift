//
//  HomeView.swift
//  ControlFinanzas
//
//  Portado desde FirstFragment.java + res/layout/fragment_first.xml
//
//  Estructura original (NestedScrollView > ConstraintLayout):
//    1. Card "Balance Total"          -> BalanceCard
//    2. Card "Resumen Mensual"        -> MonthlySummaryCard (título + navegador
//                                        de mes + gráfico + totales)
//    3. Título "Movimientos Recientes"
//    4. RecyclerView de movimientos   -> lista con TransactionRow
//

import SwiftUI
import SwiftData

struct HomeView: View {

    @Environment(\.modelContext) private var context

    /// Equivalente a `LiveData<List<Transaction>> getAllTransactions()`
    /// con la consulta SQL "ORDER BY date DESC".
    @Query(sort: \Transaction.date, order: .reverse)
    private var transactions: [Transaction]

    @State private var viewModel = FinanceViewModel()

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {

                // 1. Balance total
                BalanceCard(balance: viewModel.overallBalance(from: transactions))

                // 2. Resumen mensual (gráfico + totales)
                MonthlySummaryCard(
                    monthTitle: viewModel.formattedMonth,
                    income: viewModel.monthlyIncome(from: transactions),
                    expense: viewModel.monthlyExpense(from: transactions),
                    onPrevious: { viewModel.previousMonth() },
                    onNext: { viewModel.nextMonth() }
                )

                // 3. Título de movimientos recientes
                Text("Movimientos Recientes")
                    .font(.headline)
                    .padding(.top, 8)

                // 4. Lista de movimientos
                if transactions.isEmpty {
                    EmptyTransactionsView()
                } else {
                    VStack(spacing: 0) {
                        ForEach(transactions, id: \.id) { transaction in
                            TransactionRow(transaction: transaction)
                            if transaction.id != transactions.last?.id {
                                Divider().padding(.leading, 16)
                            }
                        }
                    }
                    .padding(.horizontal, 8)
                    .background(Color(.secondarySystemGroupedBackground))
                    .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                }
            }
            .padding(AppTheme.screenPadding)
            .padding(.bottom, 80) // espacio para el FAB flotante
        }
        .background(Color(.systemGroupedBackground))
    }
}

/// Estado vacío (no existía en el original, pero mejora la UX cuando
/// la lista de Room está vacía).
struct EmptyTransactionsView: View {
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: "tray")
                .font(.largeTitle)
                .foregroundStyle(.secondary)
            Text("Aún no hay movimientos registrados")
                .font(.subheadline)
                .foregroundStyle(.secondary)
            Text("Toca el botón + para agregar tu primer movimiento")
                .font(.caption)
                .foregroundStyle(.tertiary)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 32)
    }
}

#Preview {
    RootView()
        .modelContainer(for: Transaction.self, inMemory: true)
}
