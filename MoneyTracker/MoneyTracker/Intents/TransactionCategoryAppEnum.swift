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
        .extra: "Ganho Extra",
        .salary: "Salário",
        .leisure: "Lazer",
        .food: "Alimentação",
        .transport: "Transporte",
        .bills: "Contas",
        .other: "Outros"
    ]
    
    case extra
    case salary
    case leisure
    case food
    case transport
    case bills
    case other
    
    // Converte de volta para a enumeração de categoria do modelo de dados.
    var toModelCategory: Category {
        switch self {
        case .extra: return .extra
        case .salary: return .salary
        case .leisure: return .leisure
        case .food: return .food
        case .transport: return .transport
        case .bills: return .bills
        case .other: return .other
        }
    }
}

enum GainCategoryAppEnum: String, AppEnum {
    static var typeDisplayRepresentation = TypeDisplayRepresentation(name: "Categoria de Ganho")
    static var caseDisplayRepresentations: [Self: DisplayRepresentation] = [
        .extra: "Ganho Extra",
        .salary: "Salário",
        .other: "Outros"
    ]
    
    case extra
    case salary
    case other
    
    var toModelCategory: Category {
        switch self {
        case .extra: return .extra
        case .salary: return .salary
        case .other: return .other
        }
    }
}

// Enum para categorias de despesa
enum ExpenseCategoryAppEnum: String, AppEnum {
    static var typeDisplayRepresentation = TypeDisplayRepresentation(name: "Categoria de Despesa")
    static var caseDisplayRepresentations: [Self: DisplayRepresentation] = [
        .leisure: "Lazer",
        .food: "Alimentação",
        .transport: "Transporte",
        .bills: "Contas",
        .other: "Outros"
    ]
    
    case leisure
    case food
    case transport
    case bills
    case other
    
    var toModelCategory: Category {
        switch self {
        case .leisure: return .leisure
        case .food: return .food
        case .transport: return .transport
        case .bills: return .bills
        case .other: return .other
        }
    }
}
