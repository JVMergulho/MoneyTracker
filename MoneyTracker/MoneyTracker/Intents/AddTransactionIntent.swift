//
//  AddTransactionIntent.swift
//  MoneyTracker
//
//  Created by João Vitor Lima Mergulhão on 13/08/25.
//
import AppIntents
import Foundation
import SwiftData

struct AddExpenseIntent: AppIntent {
    static var title: LocalizedStringResource = "Registrar Despesa"
    static var description: IntentDescription = "Adiciona uma despesa ao seu histórico financeiro."
    static var openAppWhenRun: Bool = false
    
    @Parameter(title: "Descrição", description: "O que você gastou.")
    var transactionTitle: String
    
    @Parameter(title: "Valor", description: "O valor da despesa.")
    var transactionAmount: Double
    
    @Parameter(title: "Categoria", description: "A categoria da despesa.")
    var transactionCategory: ExpenseCategoryAppEnum

    func perform() async throws -> some IntentResult & ProvidesDialog {
        let modelCategory = transactionCategory.toModelCategory
        let finalAmount = -transactionAmount // Despesa, então o valor é negativo.
        
        do {
            let container = try ModelContainer(for: Transaction.self)
            let context = ModelContext(container)
            
            let newTransaction = Transaction(title: transactionTitle, amount: finalAmount, category: modelCategory, date: Date())
            context.insert(newTransaction)
            
            try context.save()
            
            let formattedAmount = String(format: "R$ %.2f", abs(finalAmount))
            let dialog = "Despesa registrada com sucesso! Adicionado \(transactionTitle) de \(formattedAmount) na categoria \(modelCategory.rawValue)."
            
            return .result(dialog: IntentDialog(stringLiteral: dialog))
        } catch {
            return .result(dialog: "Ocorreu um erro ao registrar a despesa.")
        }
    }
}

// Intenção para adicionar um ganho.
struct AddGainIntent: AppIntent {
    static var title: LocalizedStringResource = "Registrar Ganho"
    static var description: IntentDescription = "Adiciona um ganho ao seu histórico financeiro."
    static var openAppWhenRun: Bool = false
    
    @Parameter(title: "Descrição", description: "O que você recebeu.")
    var transactionTitle: String
    
    @Parameter(title: "Valor", description: "O valor do ganho.")
    var transactionAmount: Double
    
    @Parameter(title: "Categoria", description: "A categoria do ganho.")
    var transactionCategory: GainCategoryAppEnum

    func perform() async throws -> some IntentResult & ProvidesDialog {
        let modelCategory = transactionCategory.toModelCategory
        let finalAmount = transactionAmount // Ganho, então o valor é positivo.
        
        do {
            let container = try ModelContainer(for: Transaction.self)
            let context = ModelContext(container)
            
            let newTransaction = Transaction(title: transactionTitle, amount: finalAmount, category: modelCategory, date: Date())
            context.insert(newTransaction)
            
            try context.save()
            
            let formattedAmount = String(format: "R$ %.2f", abs(finalAmount))
            let dialog = "Ganho registrado com sucesso! Adicionado \(transactionTitle) de \(formattedAmount) na categoria \(modelCategory.rawValue)."
            
            return .result(dialog: IntentDialog(stringLiteral: dialog))
        } catch {
            return .result(dialog: "Ocorreu um erro ao registrar o ganho.")
        }
    }
}

// Esta estrutura faz com que a intenção fique disponível para a Siri e para o app Atalhos.
struct AppShortcuts: AppShortcutsProvider {
    @AppShortcutsBuilder
    static var appShortcuts: [AppShortcut] {
        // Atalho para registrar uma despesa.
        AppShortcut(
            intent: AddExpenseIntent(),
            phrases: [
                "Registrar despesa com \(.applicationName)",
                "Adicionar despesa com \(.applicationName)"
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
