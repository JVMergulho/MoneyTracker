//
//  AddTransactionView.swift
//  MoneyTracker
//
//  Created by João Vitor Lima Mergulhão on 13/08/25.
//


import SwiftUI
import SwiftData

struct AddTransactionView: View {
    @Environment(\.dismiss) var dismiss
    // Obtém o ModelContext do ambiente para salvar os dados.
    @Environment(\.modelContext) private var modelContext

    // O nome da variável de estado foi alterado para 'title'.
    @State private var title = ""
    @State private var amount = ""
    @State private var selectedCategory = Category.other
    @State private var isExpense = true // Para controlar se o valor é positivo ou negativo.

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Detalhes da Movimentação")) {
                    // O binding do TextField foi alterado para 'title'.
                    TextField("Descrição", text: $title)
                    TextField("Valor", text: $amount)
                        .keyboardType(.decimalPad)

                    // Seletor de categoria
                    Picker("Categoria", selection: $selectedCategory) {
                        ForEach(Category.allCases, id: \.self) { category in
                            Text(category.rawValue).tag(category)
                        }
                    }
                }

                Section(header: Text("Tipo")) {
                    // Alterna entre receita e despesa.
                    Toggle(isOn: $isExpense) {
                        Text(isExpense ? "Despesa" : "Receita")
                    }
                    .tint(.blue)
                }
            }
            .navigationTitle("Nova Movimentação")
            .navigationBarItems(
                leading: Button("Cancelar") { dismiss() },
                trailing: Button("Salvar") {
                    saveTransaction()
                    dismiss()
                }.disabled(title.isEmpty || amount.isEmpty)
            )
        }
    }

    private func saveTransaction() {
        guard let value = Double(amount.replacingOccurrences(of: ",", with: ".")) else { return }
        let finalAmount = isExpense ? -value : value
        
        // Cria uma nova instância de Transaction e a insere no ModelContext.
        // O nome do parâmetro foi alterado para 'title'.
        let newTransaction = Transaction(title: title, amount: finalAmount, category: selectedCategory, date: Date())
        modelContext.insert(newTransaction)
    }
}