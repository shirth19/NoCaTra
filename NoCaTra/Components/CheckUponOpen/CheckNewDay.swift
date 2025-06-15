//
//  CheckNewDay.swift
//  NoCaTra
//
//  Created by Sam Hirth on 4/22/25.
//

// Will check if it a new day and if new entries need to be added to the celendar

import SwiftData
import Foundation

func generateMissingModulesIfNeeded(context: ModelContext) {
    let defaults = UserDefaults.standard
    guard let startDate = defaults.object(forKey: "StartDate") as? Date else {
        print("No start date found.")
        return
    }

    let calendar = Calendar.current
    let today = calendar.startOfDay(for: Date())
    var currentDate = calendar.startOfDay(for: startDate)

    while currentDate <= today {
        if !entryModulesExist(for: currentDate, context: context) {
            let newModules = createAllEntryModules(for: currentDate)
            for module in newModules {
                context.insert(module)
            }
        }
        currentDate = calendar.date(byAdding: .day, value: 1, to: currentDate)!
    }
}

func entryModulesExist(for date: Date, context: ModelContext) -> Bool {
    let calendar = Calendar.current
    let startOfDay = calendar.startOfDay(for: date)
    let endOfDay = calendar.date(byAdding: .day, value: 1, to: startOfDay)!

    let fetchDescriptor = FetchDescriptor<EntryModule>(
        predicate: #Predicate { entry in
            entry.date >= startOfDay && entry.date < endOfDay
        }
    )

    if let results = try? context.fetch(fetchDescriptor) {
        return !results.isEmpty
    }

    return false
}
