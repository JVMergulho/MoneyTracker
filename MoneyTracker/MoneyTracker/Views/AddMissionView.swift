//
//  AddMissionView.swift
//  MoneyTracker
//
//  Created by João Vitor Lima Mergulhão on 13/08/25.
//


import SwiftUI
import SwiftData

struct AddMissionView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) private var modelContext

    @State private var title = ""
    @State private var targetAmount = ""
    @State private var selectedCategory = Category.leisure

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Detalhes da Missão")) {
                    TextField("Título da Missão", text: $title)
                    TextField("Valor Limite", text: $targetAmount)
                        .keyboardType(.decimalPad)
                
                    // O seletor de categoria para a missão.
                    Picker("Categoria", selection: $selectedCategory) {
                        ForEach(Category.allCases.filter { $0 != .salary && $0 != .extra }, id: \.self) { category in
                            Text(category.rawValue).tag(category)
                        }
                    }
                }
            }
            .navigationTitle("Nova Missão")
            .navigationBarItems(
                leading: Button("Cancelar") { dismiss() },
                trailing: Button("Salvar") {
                    saveMission()
                    dismiss()
                }.disabled(title.isEmpty || targetAmount.isEmpty)
            )
        }
    }

    private func saveMission() {
        guard let value = Double(targetAmount.replacingOccurrences(of: ",", with: ".")) else { return }
        
        let newMission = Mission(title: title, targetAmount: value, category: selectedCategory, period: "monthly")
        modelContext.insert(newMission)
    }
}
