//
//  TransactionRow.swift
//  MoneyTracker
//
//  Created by João Vitor Lima Mergulhão on 13/08/25.
//


import SwiftUI

struct TransactionRow: View {
    let transaction: Transaction

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(transaction.title)
                    .font(.headline)
                Text(transaction.date, style: .date)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            Spacer()
            VStack(alignment: .trailing) {
                Text("R$ \(transaction.amount, specifier: "%.2f")")
                    .font(.subheadline)
                    .foregroundColor(transaction.amount < 0 ? .red : .green)
                Text(transaction.category.rawValue)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
        .padding(.vertical, 5)
    }
    
    
}
