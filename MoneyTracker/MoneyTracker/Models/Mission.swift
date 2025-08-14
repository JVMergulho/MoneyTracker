//
//  Mission.swift
//  MoneyTracker
//
//  Created by João Vitor Lima Mergulhão on 13/08/25.
//
import SwiftData

@Model
class Mission {
    var title: String
    var targetAmount: Double
    var category: Category
    // Você pode usar uma enum ou string para o período, ex: "monthly"
    var period: String
    
    init(title: String, targetAmount: Double, category: Category, period: String) {
        self.title = title
        self.targetAmount = targetAmount
        self.category = category
        self.period = period
    }
}
