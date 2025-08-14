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
    // O SwiftUI irá manter esta view sempre atualizada com os dados.
    @Query(sort: \Transaction.date, order: .reverse) private var transactions: [Transaction]
    
    @State private var isShowingAddTransaction = false

    var body: some View {
        NavigationView {
            VStack {
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
                .navigationTitle("Minhas Finanças")

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
    }
}
