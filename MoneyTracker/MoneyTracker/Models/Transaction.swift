//
//  Category.swift
//  MoneyTracker
//
//  Created by João Vitor Lima Mergulhão on 13/08/25.
//


import Foundation
import SwiftData

// A 'enum' para definir as categorias das movimentações.
// 'CaseIterable' nos permite iterar sobre todos os casos para o seletor na interface.
enum Category: String, CaseIterable, Codable {
    case salary = "Salário"
    case leisure = "Lazer"
    case food = "Alimentação"
    case transport = "Transporte"
    case bills = "Contas"
    case other = "Outros"
}

// @Model transforma a classe em um tipo persistível gerenciado pelo SwiftData.
@Model
class Transaction {
    // Propriedades do modelo. A id é gerenciada automaticamente pelo SwiftData.
    var title: String // Nome da propriedade alterado para 'title'.
    var amount: Double
    var category: Category
    var date: Date
    
    // Inicializador necessário para criar novas instâncias.
    init(title: String, amount: Double, category: Category, date: Date) {
        self.title = title
        self.amount = amount
        self.category = category
        self.date = date
    }
}