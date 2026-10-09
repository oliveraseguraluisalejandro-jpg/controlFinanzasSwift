//
//  MonthlySummaryCard.swift
//  ControlFinanzas
//
//  Portado desde res/layout/fragment_first.xml -> card_chart
//  ("Resumen Mensual" + navegador de mes + MonthlyChartView + totales).
//

import SwiftUI

struct MonthlySummaryCard: View {

    let monthTitle: String
    let income: Double
    let expense: Double
    let onPrevious: () -> Void
    let onNext: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {

            // Cabecera: título + navegación de mes
            HStack {
                Text("Resumen Mensual")
                    .font(.headline)

                Spacer()

                HStack(spacing: 8) {
                    // Antes: btn_prev_month (ic_media_previous)
                    Button(action: onPrevious) {
                        Image(systemName: "chevron.left")
                            .font(.body.weight(.semibold))
                    }
                    .accessibilityLabel("Mes anterior")

                    // Antes: tv_current_month ("Septiembre 2026")
                    Text(monthTitle)
                        .font(.subheadline.weight(.bold))
                        .frame(minWidth: 130)
                        .contentTransition(.numericText())

                    // Antes: btn_next_month (ic_media_next)
                    Button(action: onNext) {
                        Image(systemName: "chevron.right")
                            .font(.body.weight(.semibold))
                    }
                    .accessibilityLabel("Mes siguiente")
                }
                .buttonStyle(.plain)
            }

            // Antes: com.example.myapplication.ui.MonthlyChartView (220dp)
            MonthlyBarChart(income: income, expense: expense)
                .frame(height: AppTheme.chartHeight)
                .padding(.top, 4)

            // Totales del mes
            HStack {
                MonthlyTotalView(
                    title: "Ingresos del mes",
                    value: CurrencyFormatter.signed(income, isIncome: true),
                    color: AppTheme.income
                )

                Divider().frame(height: 32)

                MonthlyTotalView(
                    title: "Egresos del mes",
                    value: "- " + CurrencyFormatter.amount(expense),
                    color: AppTheme.expense
                )
            }
            .padding(.top, 4)
        }
        .padding(AppTheme.screenPadding)
        .background(Color(.secondarySystemGroupedBackground))
        .clipShape(RoundedRectangle(cornerRadius: AppTheme.cardCornerRadius, style: .continuous))
        .shadow(color: .black.opacity(0.08), radius: 3, x: 0, y: 2)
    }
}

/// Columna de total mensual (label + valor). Antes: los dos LinearLayout
/// internos con tv_monthly_income / tv_monthly_expense.
private struct MonthlyTotalView: View {
    let title: String
    let value: String
    let color: Color

    var body: some View {
        VStack(spacing: 4) {
            Text(title)
                .font(.caption)
                .foregroundStyle(.secondary)
            Text(value)
                .font(.headline)
                .foregroundStyle(color)
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    MonthlySummaryCard(
        monthTitle: "Septiembre 2026",
        income: 3200,
        expense: 1450.50,
        onPrevious: {},
        onNext: {}
    )
    .padding()
}
