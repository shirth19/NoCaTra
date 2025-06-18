//
//  CalendarView.swift
//  NoCaTra
//
//  Created by Sam Hirth on 4/20/25.
//

import SwiftUI

struct CalendarView: View {
    @Binding var selectedDate: Date
    @State private var displayedMonth = Date()
    @ObservedObject var calendarViewModel: CalendarViewModel
    private let calendar = Calendar.current
    private let weekdaySymbols = Calendar.current.veryShortWeekdaySymbols
    
    var body: some View {
        VStack(spacing: 20) {
            // Month navigation
            HStack {
                Button(action: previousMonth) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(ColorTheme.accent)
                }
                
                Text(monthYearString)
                    .font(.title2)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity)
                
                Button(action: nextMonth) {
                    Image(systemName: "chevron.right")
                        .foregroundColor(ColorTheme.accent)
                }
            }
            .padding(.horizontal)
            
            // Weekday headers
            HStack {
                ForEach(weekdaySymbols, id: \.self) { symbol in
                    Text(symbol)
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.gray)
                }
            }
            
            // Days grid
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7), spacing: 8) {
                ForEach(daysInMonth, id: \.self) { date in
                    if let date = date {
                        DayView(date: date,
                               isSelected: calendar.isDate(date, inSameDayAs: selectedDate),
                               isToday: calendar.isDateInToday(date))
                            .onTapGesture {
                                selectedDate = date
                            }
                    } else {
                        Color.clear
                            .aspectRatio(1, contentMode: .fill)
                    }
                }
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(ColorTheme.background)
                .shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 1)
        )
        .padding(.horizontal)
    }
    
    private var monthYearString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter.string(from: displayedMonth)
    }
    
    private var daysInMonth: [Date?] {
        guard let monthInterval = calendar.dateInterval(of: .month, for: displayedMonth),
              let monthFirstWeek = calendar.dateInterval(of: .weekOfMonth, for: monthInterval.start),
              let monthLastWeek = calendar.dateInterval(of: .weekOfMonth, for: monthInterval.end - 1) else {
            return []
        }
        
        let dateInterval = DateInterval(start: monthFirstWeek.start, end: monthLastWeek.end)
        var dates = [Date?]()
        calendar.enumerateDates(startingAfter: dateInterval.start - 1,
                              matching: DateComponents(hour: 0, minute: 0, second: 0),
                              matchingPolicy: .nextTime) { date, _, stop in
            if let date = date {
                if date <= dateInterval.end {
                    if calendar.isDate(date, equalTo: monthInterval.start, toGranularity: .month) ||
                        calendar.isDate(date, equalTo: monthInterval.end - 1, toGranularity: .month) {
                        dates.append(date)
                    } else {
                        dates.append(nil)
                    }
                } else {
                    stop = true
                }
            }
        }
        return dates
    }
    
    private func previousMonth() {
        if let newDate = calendar.date(byAdding: .month, value: -1, to: displayedMonth) {
            displayedMonth = newDate
        }
    }
    
    private func nextMonth() {
        if let newDate = calendar.date(byAdding: .month, value: 1, to: displayedMonth) {
            displayedMonth = newDate
        }
    }
}

struct DayView: View {
    let date: Date
    let isSelected: Bool
    let isToday: Bool
    private let calendar = Calendar.current

    var body: some View {
        Text("\(calendar.component(.day, from: date))")
            .frame(maxWidth: .infinity)
            .aspectRatio(1, contentMode: .fill)
            .background(background)
            .foregroundColor(textColor)
            .clipShape(Circle())
    }

    private var background: some View {
        Group {
            if isSelected {
                Circle()
                    .fill(ColorTheme.accent)
            } else if isToday {
                Circle()
                    .stroke(ColorTheme.accent, lineWidth: 1)
            }
        }
    }

    private var textColor: Color {
        if isSelected { return .white }
        if calendar.isDateInWeekend(date) { return .secondary }
        return .primary
    }
}

#Preview {
    CalendarView(selectedDate: .constant(Date()), calendarViewModel: CalendarViewModel())
}
