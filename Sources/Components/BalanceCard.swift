//
//  BalanceCard.swift
//  ControlFinanzas
//
//  Portado desde res/layout/fragment_first.xml -> card_balance
//  ("Balance Total" + tv_balance_amount).
//

import SwiftUI

struct BalanceCard: View {

    let balance: Double

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Balance Total")
                .font(.subheadline)
                .foregroundStyle(.secondary)

            Text(CurrencyFormatter.amount(balance))
                .font(.system(size: 28, weight: .bold))
                .foregroundStyle(balance < 0 ? AppTheme.expense : .primary)
                .contentTransition(.numericText())
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(AppTheme.screenPadding)
        .background(Color(.secondarySystemGroupedBackground))
        .clipShape(RoundedRectangle(cornerRadius: AppTheme.cardCornerRadius, style: .continuous))
        .shadow(color: .black.opacity(0.08), radius: 3, x: 0, y: 2)
    }
}

#Preview {
    BalanceCard(balance: 1250.75)
        .padding()
}
