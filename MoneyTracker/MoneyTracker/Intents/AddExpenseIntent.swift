//
//  AddExpenseIntent.swift
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
    
    @Parameter(title: "Categoria da despesa", description: "A categoria da despesa.")
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
