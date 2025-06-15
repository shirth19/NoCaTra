//
//  NoCaTraApp.swift
//  NoCaTra
//
//  Created by Sam Hirth on 4/20/25.
//

import SwiftUI
import SwiftData

@main
struct NoCaTraApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: EntryModule.self)
                .onAppear {
                    if checkFirstEver() {
                        FirstEver.setStartDate()
                    }

                    DispatchQueue.main.async {
                        do {
                            let container = try ModelContainer(for: EntryModule.self)
                            let context = ModelContext(container)
                            generateMissingModulesIfNeeded(context: context)
                        } catch {
                            print("Failed to create ModelContainer: \(error)")
                        }
                    }
                }
        }
    }
}
