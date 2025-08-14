//
//  MissionCardView.swift
//  MoneyTracker
//
//  Created by João Vitor Lima Mergulhão on 13/08/25.
//
import SwiftUI

struct MissionCardView: View {
    let mission: Mission
    let currentSpending: Double
    
    private var isFailed: Bool {
        currentSpending > mission.targetAmount
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(mission.title)
                .font(.headline)
            
            Text("Gasto: R$ \(currentSpending, specifier: "%.2f") / R$ \(mission.targetAmount, specifier: "%.2f")")
                .font(.subheadline)
                .foregroundColor(.secondary)

            // Mostra o progresso como uma barra.
            ProgressView(value: max(0, currentSpending), total: mission.targetAmount)
                .progressViewStyle(LinearProgressViewStyle(tint: isFailed ? .red : .blue))
        }
        .padding()
        .background(isFailed ? Color.red.opacity(0.2) : Color(.systemGray6))
        .cornerRadius(12)
        .shadow(radius: 2)
        .frame(width: 250)
    }
}
