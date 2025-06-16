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
    @Environment(\.modelContext) private var context
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, MMMM d, yyyy"
        return formatter
    }()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(dateFormatter.string(from: selectedDate))
                .font(.headline)
                .padding(.horizontal)
            
            Divider()
            
            VStack(alignment: .leading, spacing: 8) {
                Text("Today's Entries")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                let entriesForDate = viewModel.entries(for: selectedDate, context: context)

                if entriesForDate.isEmpty {
                    Text("No entries for today")
                        .foregroundColor(.secondary)
                        .italic()
                } else {
                    ForEach(entriesForDate) { entry in
                        VStack(alignment: .leading, spacing: 4) {
                            Text(entry.category.rawValue.capitalized)
                                .font(.caption)
                                .foregroundColor(.gray)
                            TextField("Entry content", text: Binding(
                                get: { entry.content },
                                set: { newValue in
                                    viewModel.update(entry: entry, with: newValue)
                                }
                            ))
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        }
                        .padding(.vertical, 4)
                    }
                }
            }
            .padding(.horizontal)
            
            Spacer()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(white: 0.95))
    }
}

#Preview {
    CalendarDailyInfoView(selectedDate: Date(), viewModel: CalendarViewModel())
}
