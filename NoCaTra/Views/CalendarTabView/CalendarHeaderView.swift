//
//  CalendarHeaderView.swift
//  NoCaTra
//
//  Created by Sam Hirth on 4/20/25.
//

import SwiftUI

/// Displays the heading for the calendar page.
/// A rounded border is applied so it matches the module style.

struct CalendarHeaderView: View {
    var body: some View {
        Text("Tracker Calendar")
            .font(.title2)
            .fontWeight(.bold)
            .padding(8)
            .frame(maxWidth: .infinity)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(ColorTheme.accent, lineWidth: 2)
            )
            .padding(.horizontal)
    }
}

#Preview {
    CalendarHeaderView()
}
