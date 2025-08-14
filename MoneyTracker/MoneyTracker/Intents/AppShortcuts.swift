//
//  AppShortcuts.swift
//  MoneyTracker
//
//  Created by João Vitor Lima Mergulhão on 13/08/25.
//
import AppIntents

// Esta estrutura faz com que a intenção fique disponível para a Siri e para o app Atalhos.
struct AppShortcuts: AppShortcutsProvider {
    @AppShortcutsBuilder
    static var appShortcuts: [AppShortcut] {
        // Atalho para registrar uma despesa.
        AppShortcut(
            intent: AddExpenseIntent(),
            phrases: [
                "Registrar despesa com \(.applicationName)",
                "Adicionar despesa com \(.applicationName)",
                "Adicionar gasto com \(.applicationName)",
                "Registrar gasto com \(.applicationName)"
            ],
            shortTitle: "Registrar Despesa",
            systemImageName: "minus.circle.fill"
        )
        // Atalho para registrar um ganho.
        AppShortcut(
            intent: AddGainIntent(),
            phrases: [
                "Registrar ganho com \(.applicationName)",
                "Adicionar ganho com \(.applicationName)"
            ],
            shortTitle: "Registrar Ganho",
            systemImageName: "plus.circle.fill"
        )
    }
}
