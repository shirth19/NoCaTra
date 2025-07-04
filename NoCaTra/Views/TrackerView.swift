//
//  TrackerView.swift
//  NoCaTra
//
//  Created by Sam Hirth on 4/20/25.
//

//displays the current days EntryModules if they are unlocked

import SwiftUI
import SwiftData
import Foundation

// Import components
import SwiftUI

public struct TrackerView: View {
    @Query var allEntries: [EntryModule]
    @ObservedObject var unlockableViewModel: UnlockableViewModel

    // Store binding state for each entry by its ID
    @State private var openState: [UUID: Bool] = [:]
    @State private var contentState: [UUID: String] = [:]
    @State private var ratingOneState: [UUID: Int?] = [:]
    @State private var ratingTwoState: [UUID: Int?] = [:]
    @State private var refreshID = UUID()
    
    
    internal var todayEntries: [EntryModule] {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())

        let tomorrow = calendar.date(byAdding: .day, value: 1, to: today)!
        let yesterday = calendar.date(byAdding: .day, value: -1, to: today)!
        let twoDaysAgo = calendar.date(byAdding: .day, value: -2, to: today)!

        let filtered = allEntries.filter { entry in
            let dateRange: Range<Date>
            switch entry.contentType {
            case .plan:
                dateRange = today..<tomorrow
            case .diary:
                dateRange = yesterday..<today
            case .rating:
                dateRange = twoDaysAgo..<yesterday
            }

            guard dateRange.contains(entry.date) else { return false }

            switch (entry.category, entry.contentType) {
            case (.food, .diary): return unlockableViewModel.unlockStates[0]
            case (.food, .plan): return unlockableViewModel.unlockStates[1]
            case (.food, .rating): return unlockableViewModel.unlockStates[2]
            case (.exercise, .diary): return unlockableViewModel.unlockStates[3]
            case (.exercise, .plan): return unlockableViewModel.unlockStates[4]
            case (.exercise, .rating): return unlockableViewModel.unlockStates[5]
            case (.mindfulness, .diary): return unlockableViewModel.unlockStates[6]
            case (.mindfulness, .plan): return unlockableViewModel.unlockStates[7]
            case (.mindfulness, .rating): return unlockableViewModel.unlockStates[8]
            }
        }

        return filtered.sortedByCategoryAndContent()
    }

    /// Fetch the diary content from two days ago for the given category.
    internal func diaryFromTwoDaysAgo(for category: EntryCategory) -> String? {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        let start = calendar.date(byAdding: .day, value: -2, to: today)!
        let end = calendar.date(byAdding: .day, value: -1, to: today)!

        return allEntries.first(where: { entry in
            entry.category == category &&
            entry.contentType == .diary &&
            entry.date >= start && entry.date < end
        })?.content
    }

    public var body: some View {
        ScrollView {
            VStack(spacing: 12) {
                ForEach(todayEntries, id: \.id) { entry in
                    let (isOpenBinding, contentBinding, ratingOneBinding, ratingTwoBinding, isLockedBinding) = bindings(for: entry)
                    
                    EntryModuleView(
                        module: entry,
                        isOpen: isOpenBinding,
                        content: contentBinding,
                        ratingOne: ratingOneBinding,
                        ratingTwo: ratingTwoBinding,
                        isLocked: isLockedBinding,
                        previousContent: entry.contentType == .rating ? diaryFromTwoDaysAgo(for: entry.category) : nil,
                        streak: streak(for: entry)
                    )
                }
            }
            .padding()
        }
        .id(refreshID)
        .navigationTitle("Today's Entries")
        .onAppear {
            initializeState()
            print("TrackerView appeared — unlockStates: \(unlockableViewModel.unlockStates)")
        }
        .onReceive(NotificationCenter.default.publisher(for: Notification.Name("UnlockStateChanged"))) { _ in
            // Refresh the view when unlock states change
            initializeState()
        }
        .onReceive(NotificationCenter.default.publisher(for: Notification.Name("RefreshTrackerView"))) { _ in
            refreshID = UUID()
            print("RefreshTrackerView triggered — unlockStates: \(unlockableViewModel.unlockStates)")
        }
    }
    
    internal func bindings(for entry: EntryModule) -> (Binding<Bool>, Binding<String>, Binding<Int?>, Binding<Int?>, Binding<Bool>) {
        let isOpenBinding = Binding(
            get: { openState[entry.id] ?? false },
            set: { openState[entry.id] = $0 }
        )
        
        let contentBinding = Binding(
            get: { contentState[entry.id] ?? entry.content },
            set: { newValue in
                contentState[entry.id] = newValue
                entry.content = newValue
            }
        )
        
        let ratingOneBinding = Binding(
            get: { ratingOneState[entry.id] ?? entry.ratingOne },
            set: { newValue in
                ratingOneState[entry.id] = newValue
                entry.ratingOne = newValue
            }
        )
        
        let ratingTwoBinding = Binding(
            get: { ratingTwoState[entry.id] ?? entry.ratingTwo },
            set: { newValue in
                ratingTwoState[entry.id] = newValue
                entry.ratingTwo = newValue
            }
        )

        let isLockedBinding = Binding(
            get: { entry.isLocked },
            set: { _ in }
        )

        return (isOpenBinding, contentBinding, ratingOneBinding, ratingTwoBinding, isLockedBinding)
    }

    internal func initializeState() {
        // Initialize view state
        for entry in todayEntries {
            openState[entry.id] = openState[entry.id] ?? false
            contentState[entry.id] = contentState[entry.id] ?? entry.content
            ratingOneState[entry.id] = ratingOneState[entry.id] ?? entry.ratingOne
            ratingTwoState[entry.id] = ratingTwoState[entry.id] ?? entry.ratingTwo
        }
    }

    internal func streak(for module: EntryModule) -> Int {
        let calendar = Calendar.current
        var currentDate = calendar.startOfDay(for: module.date)
        var count = 0

        while true {
            guard let match = allEntries.first(where: { entry in
                entry.category == module.category &&
                entry.contentType == module.contentType &&
                calendar.isDate(entry.date, inSameDayAs: currentDate)
            }) else { break }

            guard match.isCompleted else { break }

            count += 1

            guard let previous = calendar.date(byAdding: .day, value: -1, to: currentDate) else { break }
            currentDate = previous
        }

        return count
    }
}
