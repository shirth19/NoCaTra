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
}
