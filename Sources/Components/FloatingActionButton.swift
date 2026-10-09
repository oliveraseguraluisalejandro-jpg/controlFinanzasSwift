//
//  FloatingActionButton.swift
//  ControlFinanzas
//
//  Portado desde el FloatingActionButton de activity_main.xml
//  (app:srcCompat="@android:drawable/ic_dialog_email", esquina inferior derecha).
//

import SwiftUI

struct FloatingActionButton: View {

    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Image(systemName: "plus")
                .font(.title2.weight(.semibold))
                .foregroundStyle(.white)
                .frame(width: 56, height: 56)
                .background(AppTheme.income)
                .clipShape(Circle())
                .shadow(color: .black.opacity(0.2), radius: 4, x: 0, y: 2)
        }
        .accessibilityLabel("Nuevo movimiento")
    }
}

#Preview {
    FloatingActionButton {}
        .padding()
}
