//
//  ControlFinanzasApp.swift
//  ControlFinanzas
//
//  Punto de entrada. En Android esto equivalía a:
//    - MainActivity.java (Activity principal)
//    - AppDatabase.java  (configuración de Room)
//
//  Aquí la app se define con el App protocol y el contenedor de SwiftData
//  reemplaza a Room (AppDatabase.getDatabase(context)).
//

import SwiftUI
import SwiftData

@main
struct ControlFinanzasApp: App {

    /// Contenedor de persistencia (equivalente a Room "finance_database").
    let modelContainer: ModelContainer

    init() {
        do {
            modelContainer = try ModelContainer(for: Transaction.self)
        } catch {
            fatalError("No se pudo crear el ModelContainer: \(error)")
        }
    }

    var body: some Scene {
        WindowGroup {
            RootView()
        }
        .modelContainer(modelContainer)
    }
}

/// Vista raíz: contiene el NavigationStack, la barra de navegación y el FAB.
/// Equivale a activity_main.xml (CoordinatorLayout + Toolbar + FloatingActionButton
/// + FragmentContainerView con el nav_graph).
struct RootView: View {

    @State private var showNewMovement = false

    var body: some View {
        NavigationStack {
            HomeView()
                .navigationTitle("Control de Finanzas")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    // Antes: menu/menu_main.xml (action_settings)
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            // Espacio reservado para configuración (igual que el original).
                        } label: {
                            Image(systemName: "gearshape")
                        }
                        .accessibilityLabel("Configuración")
                    }
                }
                .overlay(alignment: .bottomTrailing) {
                    // Antes: FloatingActionButton (fab) en activity_main.xml.
                    FloatingActionButton {
                        showNewMovement = true
                    }
                    .padding(.trailing, AppTheme.screenPadding)
                    .padding(.bottom, AppTheme.screenPadding)
                }
                .sheet(isPresented: $showNewMovement) {
                    // Antes: navegación action_FirstFragment_to_SecondFragment.
                    AddMovementView()
                }
        }
    }
}
