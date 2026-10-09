//
//  AddMovementView.swift
//  ControlFinanzas
//
//  Portado desde SecondFragment.java + res/layout/fragment_second.xml
//
//  Formulario de nuevo movimiento:
//    - Spinner "Tipo de Movimiento"  (Ingreso / Egreso)
//    - Campo "Cantidad (S/.)"        (numérico decimal, obligatorio)
//    - Campo "Categoría"             (texto, por defecto "General")
//    - Spinner "Forma de Pago"       (Efectivo / Tarjeta / Yape)
//    - Botón "Guardar Movimiento"
//  Al guardar: inserta en la BD, muestra confirmación y vuelve atrás
//  (antes: Toast "Movimiento guardado con éxito" + navegación a FirstFragment).
//

import SwiftUI
import SwiftData

struct AddMovementView: View {

    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context

    @State private var viewModel = FinanceViewModel()

    // Estado del formulario
    @State private var type: MovementType = .income
    @State private var amountText: String = ""
    @State private var category: String = ""
    @State private var paymentMethod: PaymentMethod = .cash

    // Validación (antes: setError en los TextInputLayout)
    @State private var amountError: String?
    @State private var showSavedConfirmation = false

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    // Antes: Spinner spinner_type
                    Picker("Tipo de Movimiento", selection: $type) {
                        ForEach(MovementType.allCases) { movement in
                            Text(movement.rawValue).tag(movement)
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("Tipo de Movimiento")
                }

                Section {
                    // Antes: TextInputLayout til_amount + et_amount
                    HStack {
                        Text("S/.")
                            .foregroundStyle(.secondary)
                        TextField("0.00", text: $amountText)
                            .keyboardType(.decimalPad)
                    }

                    if let amountError {
                        Text(amountError)
                            .font(.caption)
                            .foregroundStyle(AppTheme.expense)
                    }
                } header: {
                    Text("Cantidad")
                }

                Section {
                    // Antes: TextInputLayout til_category + et_category
                    TextField("Ej. Comida, Salario", text: $category)
                        .textInputAutocapitalization(.sentences)
                } header: {
                    Text("Categoría")
                }

                Section {
                    // Antes: Spinner spinner_payment_method
                    Picker("Forma de Pago", selection: $paymentMethod) {
                        ForEach(PaymentMethod.allCases) { method in
                            Text(method.rawValue).tag(method)
                        }
                    }
                } header: {
                    Text("Forma de Pago")
                }
            }
            .navigationTitle("Nuevo Movimiento")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancelar") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Guardar") { save() }
                        .fontWeight(.semibold)
                }
            }
            .overlay(alignment: .bottom) {
                if showSavedConfirmation {
                    // Antes: Toast.makeText(... "Movimiento guardado con éxito")
                    Text("Movimiento guardado con éxito")
                        .font(.subheadline)
                        .foregroundStyle(.white)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 10)
                        .background(.black.opacity(0.8))
                        .clipShape(Capsule())
                        .padding(.bottom, 24)
                        .transition(.move(edge: .bottom).combined(with: .opacity))
                }
            }
        }
    }

    // MARK: Guardado (equivalente a saveTransaction())

    private func save() {
        amountError = nil

        // Validación: cantidad obligatoria (et_amount.setError("Ingresa una cantidad"))
        let trimmed = amountText.trimmingCharacters(in: .whitespaces)
        guard !trimmed.isEmpty else {
            amountError = "Ingresa una cantidad"
            return
        }

        // Validación: número válido (et_amount.setError("Cantidad inválida"))
        // Se admite coma o punto como separador decimal.
        let normalized = trimmed.replacingOccurrences(of: ",", with: ".")
        guard let amount = Double(normalized), amount > 0 else {
            amountError = "Cantidad inválida"
            return
        }

        // Categoría por defecto: "General" (if categoryStr.isEmpty() -> "General")
        let finalCategory = category.trimmingCharacters(in: .whitespaces).isEmpty
            ? "General"
            : category.trimmingCharacters(in: .whitespaces)

        let transaction = Transaction(
            type: type.rawValue,
            amount: amount,
            category: finalCategory,
            paymentMethod: paymentMethod.rawValue,
            date: .now
        )
        viewModel.insert(transaction, in: context)

        // Confirmación + cierre (antes: Toast + navigate to FirstFragment)
        withAnimation { showSavedConfirmation = true }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.9) {
            dismiss()
        }
    }
}

#Preview {
    AddMovementView()
        .modelContainer(for: Transaction.self, inMemory: true)
}
