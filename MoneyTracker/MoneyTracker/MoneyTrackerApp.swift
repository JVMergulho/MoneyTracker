//
//  MoneyTrackerApp.swift
//  MoneyTracker
//
//  Created by João Vitor Lima Mergulhão on 13/08/25.
//

import SwiftUI
import SwiftData
import AppIntents

@main
struct MoneyTrackerApp:  App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [Transaction.self, Mission.self])
    }
}
