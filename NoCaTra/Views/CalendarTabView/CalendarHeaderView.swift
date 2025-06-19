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
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.black, lineWidth: 1)
            )
            .frame(maxWidth: .infinity)
            .padding(.horizontal)
    }
}

#Preview {
    CalendarHeaderView()
}
