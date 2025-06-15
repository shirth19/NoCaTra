//
//  CalendarViewModel.swift
//  NoCaTra
//
//  Created by Sam Hirth on 4/20/25.
//
import SwiftUI
import Foundation

class CalendarViewModel: ObservableObject {
    @Published var allEntries: [EntryModule] = []

    // Load or generate entries
    func entries(for date: Date) -> [EntryModule] {
        let calendar = Calendar.current
        return allEntries.filter {
            calendar.isDate($0.date, inSameDayAs: date)
        }
    }

    func update(entry: EntryModule, with newContent: String) {
        if let index = allEntries.firstIndex(where: { $0.id == entry.id }) {
            if allEntries[index].content != newContent {
                allEntries[index].content = newContent
            }
        }
    }
}
