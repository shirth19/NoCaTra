//
//  CalendarTabView.swift
//  NoCaTra
//
//  Created by Sam Hirth on 4/20/25.
//

import SwiftUI

struct CalendarTabView: View {
    @State private var selectedDate = Date()
    @StateObject private var calendarViewModel = CalendarViewModel()
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                CalendarHeaderView()
                CalendarView(selectedDate: $selectedDate, calendarViewModel: calendarViewModel)
                CalendarDailyInfoView(selectedDate: selectedDate, viewModel: calendarViewModel)
            }
        }
    }
}

#Preview {
    CalendarTabView()
}
