import Foundation

// What the entry is about
enum EntryCategory: String, Codable, CaseIterable, Identifiable {
    case food       = "Food"
    case exercise   = "Exercise"
    case mindfulness = "Mindfulness"
    
    var id: String { rawValue }
}

// What type of content the entry contains
enum EntryContentType: String, Codable, CaseIterable, Identifiable {
    case diary  = "Diary"
    case plan   = "Plan"
    case rating = "Rating"
    
    var id: String { rawValue }
}
