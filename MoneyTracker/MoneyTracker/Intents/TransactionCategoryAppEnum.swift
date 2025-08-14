//
//  TransactionCategoryAppEnum.swift
//  MoneyTracker
//
//  Created by João Vitor Lima Mergulhão on 13/08/25.
//


import AppIntents
import Foundation
import SwiftData

// A enumeração para as categorias do App Intent.
// O App Intent usa um tipo 'AppEnum' para categorizar as opções.
enum TransactionCategoryAppEnum: String, AppEnum {
    static var typeDisplayRepresentation = TypeDisplayRepresentation(name: "Categoria")
    static var caseDisplayRepresentations: [Self: DisplayRepresentation] = [
        .salary: "Salário",
        .leisure: "Lazer",
        .food: "Alimentação",
        .transport: "Transporte",
        .bills: "Contas",
        .other: "Outros"
    ]
    
    case salary
    case leisure
    case food
    case transport
    case bills
    case other
    
    // Converte de volta para a enumeração de categoria do modelo de dados.
    var toModelCategory: Category {
        switch self {
        case .salary: return .salary
        case .leisure: return .leisure
        case .food: return .food
        case .transport: return .transport
        case .bills: return .bills
        case .other: return .other
        }
    }
}