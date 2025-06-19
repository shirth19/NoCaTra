//
//  CalendarDailyInfoView.swift
//  NoCaTra
//
//  Created by Sam Hirth on 4/20/25.
//

import SwiftUI
import SwiftData

struct CalendarDailyInfoView: View {
    let selectedDate: Date
    @ObservedObject var viewModel: CalendarViewModel
    @ObservedObject var unlockableViewModel: UnlockableViewModel
    @Environment(\.modelContext) private var context
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, MMMM d, yyyy"
        return formatter
    }()
    
    var body: some View {
            ScrollView {
                VStack(alignment: .leading, spacing: 12) {
                    Text(dateFormatter.string(from: selectedDate))
                        .font(.headline)
                        .padding(.horizontal)
                
                Divider()
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Today's Entries")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                    let entriesForDate = viewModel
                        .entries(for: selectedDate, context: context)
                        .filter(isUnlocked)
    
                    if entriesForDate.isEmpty {
                        Text("No entries for today")
                            .foregroundColor(.secondary)
                            .italic()
                    } else {
                        ForEach(entriesForDate) { entry in
                            GroupBox {
                                switch entry.contentType {
                                case .diary, .plan:
                                    TextField("Entry content", text: Binding(
                                        get: { entry.content },
                                        set: { viewModel.update(entry: entry, with: $0) }
                                    ))
                                    .textFieldStyle(.roundedBorder)

                                case .rating:
                                    HStack(spacing: 20) {
                                        VStack {
                                            Text("Healthiness")
                                                .font(.caption)
                                            Picker("Rating One", selection: Binding(
                                                get: { entry.ratingOne ?? 5 },
                                                set: { viewModel.update(entry: entry, ratingOne: $0) }
                                            )) {
                                                ForEach(1...10, id: \.self) { num in
                                                    Text("\(num)")
                                                }
                                            }
                                            .pickerStyle(.menu)
                                        }

                                        VStack {
                                            Text("Happiness")
                                                .font(.caption)
                                            Picker("Rating Two", selection: Binding(
                                                get: { entry.ratingTwo ?? 5 },
                                                set: { viewModel.update(entry: entry, ratingTwo: $0) }
                                            )) {
                                                ForEach(1...10, id: \.self) { num in
                                                    Text("\(num)")
                                                }
                                            }
                                            .pickerStyle(.menu)
                                        }
                                    }
                                }
                            } label: {
                                HStack {
                                    Image(systemName: entry.contentType.iconName)
                                    (
                                        Text(entry.category.rawValue + " ") +
                                        Text(entry.contentType.rawValue).bold()
                                    )
                                }
                                .foregroundColor(entry.category.color)
                            }
                            .padding(.vertical, 4)
                        }
                    }
                }
                .padding(.horizontal)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .background(Color(white: 0.95))
    }

    private func isUnlocked(_ entry: EntryModule) -> Bool {
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
}
