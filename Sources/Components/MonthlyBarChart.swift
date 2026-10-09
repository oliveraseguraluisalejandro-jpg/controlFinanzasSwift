//
//  MonthlyBarChart.swift
//  ControlFinanzas
//
//  Portado desde ui/MonthlyChartView.java (View personalizada con Canvas).
//
//  Replica fielmente el dibujo original:
//    - 3 líneas de rejilla discontinuas (100% / 50% / 0%).
//    - Barra de ingresos (verde) y barra de egresos (rojo) con esquinas redondeadas.
//    - Importes por encima de cada barra.
//    - Etiquetas "Ingresos (xx%)" / "Egresos (xx%)" debajo.
//    - Animación de entrada (ValueAnimator -> withAnimation).
//    - Mensaje "Sin movimientos en este mes" cuando ambas son 0.
//

import SwiftUI

struct MonthlyBarChart: View {

    let income: Double
    let expense: Double

    /// Progreso de la animación (antes: `animationProgress` del ValueAnimator).
    @State private var progress: CGFloat = 0

    var body: some View {
        GeometryReader { geo in
            if income == 0 && expense == 0 {
                // Antes: canvas.drawText("Sin movimientos en este mes", ...)
                Text("Sin movimientos en este mes")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .frame(width: geo.size.width, height: geo.size.height)
            } else {
                Canvas { context, size in
                    draw(in: &context, size: size)
                }
            }
        }
        .onAppear {
            progress = 0
            withAnimation(.easeOut(duration: 0.5)) {
                progress = 1
            }
        }
        .onChange(of: income) { _, _ in animate() }
        .onChange(of: expense) { _, _ in animate() }
    }

    private func animate() {
        progress = 0
        withAnimation(.easeOut(duration: 0.5)) {
            progress = 1
        }
    }

    // MARK: Dibujo (equivalente a onDraw de MonthlyChartView)

    private func draw(in context: inout GraphicsContext, size: CGSize) {
        let paddingLeft: CGFloat = 16
        let paddingRight: CGFloat = 16
        let paddingTop: CGFloat = 32
        let paddingBottom: CGFloat = 48

        let chartRight = size.width - paddingRight
        let chartBottom = size.height - paddingBottom
        let chartHeight = chartBottom - paddingTop
        let chartWidth = chartRight - paddingLeft

        guard chartWidth > 0, chartHeight > 0 else { return }

        // --- Rejilla (3 líneas discontinuas) ---
        let gridStyle = StrokeStyle(lineWidth: 2, dash: [10, 10])
        let gridColor = AppTheme.grid

        for y in [paddingTop, paddingTop + chartHeight / 2, chartBottom] {
            var path = Path()
            path.move(to: CGPoint(x: paddingLeft, y: y))
            path.addLine(to: CGPoint(x: chartRight, y: y))
            context.stroke(path, with: .color(gridColor), style: gridStyle)
        }

        let maxVal = max(income, expense) == 0 ? 1 : max(income, expense)

        let barWidth = min(60, chartWidth / 4)
        let bar1CenterX = paddingLeft + chartWidth * 0.3
        let bar2CenterX = paddingLeft + chartWidth * 0.7

        // --- Barra de ingresos ---
        let incomeHeight = CGFloat(income / maxVal) * chartHeight * progress
        let incomeRect = CGRect(
            x: bar1CenterX - barWidth / 2,
            y: chartBottom - incomeHeight,
            width: barWidth,
            height: incomeHeight
        )
        context.fill(
            Path(roundedRect: incomeRect, cornerRadius: 8),
            with: .color(AppTheme.income)
        )

        // --- Barra de egresos ---
        let expenseHeight = CGFloat(expense / maxVal) * chartHeight * progress
        let expenseRect = CGRect(
            x: bar2CenterX - barWidth / 2,
            y: chartBottom - expenseHeight,
            width: barWidth,
            height: expenseHeight
        )
        context.fill(
            Path(roundedRect: expenseRect, cornerRadius: 8),
            with: .color(AppTheme.expense)
        )

        // --- Importes encima de las barras ---
        if income > 0 {
            drawCenteredText(
                CurrencyFormatter.amount(income),
                at: CGPoint(x: bar1CenterX, y: chartBottom - incomeHeight - 8),
                color: .primary,
                bold: true,
                in: &context
            )
        }
        if expense > 0 {
            drawCenteredText(
                CurrencyFormatter.amount(expense),
                at: CGPoint(x: bar2CenterX, y: chartBottom - expenseHeight - 8),
                color: .primary,
                bold: true,
                in: &context
            )
        }

        // --- Etiquetas debajo de las barras ---
        let total = income + expense
        let incomePercent = total > 0 ? String(format: " (%.0f%%)", (income / total) * 100) : ""
        let expensePercent = total > 0 ? String(format: " (%.0f%%)", (expense / total) * 100) : ""

        drawCenteredText(
            "Ingresos" + incomePercent,
            at: CGPoint(x: bar1CenterX, y: chartBottom + 20),
            color: .secondary,
            bold: false,
            in: &context
        )
        drawCenteredText(
            "Egresos" + expensePercent,
            at: CGPoint(x: bar2CenterX, y: chartBottom + 20),
            color: .secondary,
            bold: false,
            in: &context
        )
    }

    private func drawCenteredText(
        _ string: String,
        at point: CGPoint,
        color: Color,
        bold: Bool,
        in context: inout GraphicsContext
    ) {
        let text = Text(string)
            .font(.system(size: 12, weight: bold ? .bold : .regular))
            .foregroundStyle(color)

        // Centrar horizontalmente (Paint.Align.CENTER) y verticalmente sobre el punto.
        let resolved = context.resolve(text)
        let size = resolved.measure(
            in: CGSize(width: .greatestFiniteMagnitude, height: .greatestFiniteMagnitude)
        )
        context.draw(
            resolved,
            at: CGPoint(x: point.x - size.width / 2, y: point.y - size.height / 2),
            anchor: .topLeading
        )
    }
}

#Preview {
    VStack(spacing: 24) {
        MonthlyBarChart(income: 3200, expense: 1450.50)
            .frame(height: 220)
        MonthlyBarChart(income: 0, expense: 0)
            .frame(height: 220)
    }
    .padding()
}
