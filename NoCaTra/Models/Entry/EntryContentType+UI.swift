import SwiftUI

extension EntryContentType {
    /// Icon associated with the entry type.
    var iconName: String {
        switch self {
        case .diary:  return "pencil"
        case .plan:   return "list.bullet"
        case .rating: return "star"
        }
    }

    /// Color used to highlight this entry type.
    var color: Color {
        switch self {
        case .diary:  return .blue
        case .plan:   return .teal
        case .rating: return .orange
        }
    }
}
