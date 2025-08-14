//
//  ContentView.swift
//  MoneyTracker
//
//  Created by João Vitor Lima Mergulhão on 13/08/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    // Usa @Query para buscar todas as movimentações do banco de dados.
    @Query(sort: \Transaction.date, order: .reverse) private var transactions: [Transaction]
    // Novo: busca todas as missões do banco de dados.
    @Query private var missions: [Mission]

    @State private var isShowingAddTransaction = false
    // NOVO: Variável de estado para controlar a exibição da tela de adicionar missão.
    @State private var isShowingAddMission = false
    
    // Calcula o gasto total para uma missão específica em um período.
    private func calculateCurrentSpending(for mission: Mission) -> Double {
        let calendar = Calendar.current
        let today = Date()
        guard let startOfPeriod = calendar.date(byAdding: .month, value: -1, to: today) else { return 0.0 }
        
        let filteredTransactions = transactions.filter {
            // Filtra as transações pela categoria e dentro do período da missão.
            $0.category == mission.category && $0.date >= startOfPeriod
        }
        
        // Soma apenas os valores negativos (despesas) da categoria.
        let total = filteredTransactions.reduce(0.0) { result, transaction in
            if transaction.amount < 0 {
                return result + abs(transaction.amount)
            }
            return result
        }
        
        return total
    }

    var body: some View {
        NavigationView {
            VStack {
                // Novo: Exibe as missões na tela principal.
                if !missions.isEmpty {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Suas Missões")
                            .font(.title2)
                            .fontWeight(.bold)
                            .padding(.horizontal)

                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 20) {
                                // CORREÇÃO: Adicionado 'id: \.id' para resolver o erro de compilação
                                ForEach(missions, id: \.id) { mission in
                                    let currentSpending = calculateCurrentSpending(for: mission)
                                    MissionCardView(mission: mission, currentSpending: currentSpending)
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                    .padding(.vertical)
                }

                // Tabela de Movimentações
                List {
                    // Se não houver movimentações, mostramos uma mensagem.
                    if transactions.isEmpty {
                        Text("Nenhuma movimentação registrada. Adicione uma para começar!")
                            .foregroundColor(.secondary)
                    } else {
                        // Exibe cada movimentação da lista.
                        ForEach(transactions) { transaction in
                            TransactionRow(transaction: transaction)
                        }
                    }
                }
                .listStyle(InsetGroupedListStyle())
                .navigationTitle("Money Tracker")
                // NOVO: Adiciona um botão na barra de navegação para adicionar missões.
                .navigationBarItems(trailing: Button(action: {
                    isShowingAddMission = true
                }) {
                    Image(systemName: "dot.scope")
                        .font(.title2)
                })

                // Botão para adicionar nova movimentação
                Button("Adicionar Movimentação") {
                    isShowingAddTransaction = true
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
                .padding(.horizontal)
            }
        }
        // Exibe a tela de adicionar movimentação como uma folha modal.
        .sheet(isPresented: $isShowingAddTransaction) {
            AddTransactionView()
        }
        // NOVO: Exibe a tela de adicionar missão como uma folha modal.
        .sheet(isPresented: $isShowingAddMission) {
            AddMissionView()
        }
    }
}
