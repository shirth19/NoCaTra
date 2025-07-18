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

        let fetched = (try? context.fetch(descriptor)) ?? []

        return fetched.sortedByCategoryAndContent()
    }

    /// Update an entry's content directly in the model.
    func update(entry: EntryModule, with newContent: String) {
        if entry.content != newContent {
            entry.content = newContent
        }
    }

    /// Update an entry's first rating value.
    func update(entry: EntryModule, ratingOne: Int) {
        if entry.ratingOne != ratingOne {
            entry.ratingOne = ratingOne
        }
    }

    /// Update an entry's second rating value.
    func update(entry: EntryModule, ratingTwo: Int) {
        if entry.ratingTwo != ratingTwo {
            entry.ratingTwo = ratingTwo
        }
    }
}
