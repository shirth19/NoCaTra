//
//  CalendarHeaderView.swift
//  NoCaTra
//
//  Created by Sam Hirth on 4/20/25.
//

import SwiftUI

struct CalendarHeaderView: View {
    var body: some View {
        Text("Tracker Calendar")
            .font(.title2)
            .fontWeight(.bold)
            .foregroundColor(ColorTheme.accent)
            .padding(.vertical, 8)
    }
}

#Preview {
    CalendarHeaderView()
}
