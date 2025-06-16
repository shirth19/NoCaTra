//
//  CalendarViewModel.swift
//  NoCaTra
//
//  Created by Sam Hirth on 4/20/25.
//
import SwiftUI
import Foundation
import SwiftData

class CalendarViewModel: ObservableObject {

    /// Fetch entries for a specific date from `ModelContext`.
    func entries(for date: Date, context: ModelContext) -> [EntryModule] {
        let calendar = Calendar.current
        let startOfDay = calendar.startOfDay(for: date)
        let endOfDay = calendar.date(byAdding: .day, value: 1, to: startOfDay)!

        let descriptor = FetchDescriptor<EntryModule>(
            predicate: #Predicate { entry in
                entry.date >= startOfDay && entry.date < endOfDay
            }
        )

        return (try? context.fetch(descriptor)) ?? []
    }

    /// Update an entry's content directly in the model.
    func update(entry: EntryModule, with newContent: String) {
        if entry.content != newContent {
            entry.content = newContent
        }
    }
}
