import SwiftUI

extension EntryCategory {
    /// Color used to highlight entry labels based on category.
    var color: Color {
        switch self {
        case .food:
            return .orange
        case .exercise:
            return .green
        case .mindfulness:
            return .purple
        }
    }

    /// A lighter background color derived from the base category color.
    var lightColor: Color {
        color.opacity(0.15)
    }
}
