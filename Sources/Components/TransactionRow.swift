//
//  TransactionRow.swift
//  ControlFinanzas
//
//  Portado desde res/layout/item_transaction.xml + ui/TransactionAdapter.java
//
//  Cada fila mostraba: categoría (negrita), forma de pago (secundario) e
//  importe a la derecha coloreado en verde (ingreso) o rojo (egreso).
//

import SwiftUI

struct TransactionRow: View {

    let transaction: Transaction

    var body: some View {
        HStack(alignment: .center, spacing: 12) {

            // Icono según el tipo (mejora visual; el original no tenía icono).
            Image(systemName: transaction.isIncome ? "arrow.down.left.circle.fill" : "arrow.up.right.circle.fill")
                .font(.title2)
                .foregroundStyle(transaction.isIncome ? AppTheme.income : AppTheme.expense)

            VStack(alignment: .leading, spacing: 4) {
                Text(transaction.category)
                    .font(.body.weight(.bold))
                    .lineLimit(1)

                Text(transaction.paymentMethod)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }

            Spacer()

            Text(CurrencyFormatter.signed(transaction.amount, isIncome: transaction.isIncome))
                .font(.title3.weight(.bold))
                .foregroundStyle(transaction.isIncome ? AppTheme.income : AppTheme.expense)
        }
        .padding(.vertical, 12)
        .padding(.horizontal, 4)
        .contentShape(Rectangle())
    }
}

#Preview {
    VStack {
        TransactionRow(
            transaction: Transaction(type: "Ingreso", amount: 2500, category: "Salario", paymentMethod: "Tarjeta")
        )
        Divider()
        TransactionRow(
            transaction: Transaction(type: "Egreso", amount: 45.90, category: "Comida", paymentMethod: "Yape")
        )
    }
    .padding()
}
