//
//  EntryModule.swift
//  NoCaTra
//
//  Created by Sam Hirth on 4/22/25.
//

// Variables needed to make an entry module:
// - date
// - Title
// - Button caption
// - Module caption
// - is module open
// - is module completed
// - Entry Category - from the entry category already definied
// - diary, log, or rating

import Foundation
import SwiftUI
import SwiftData

@Model
class EntryModule {
    // MARK: - Properties
    @Attribute(.unique) var id: UUID
    var date: Date
    var category: EntryCategory    // What it's about (food/exercise/mindfulness)
    var contentType: EntryContentType  // How it's recorded (diary/plan/rating)
    
    // State
    var isOpen: Bool
    var isCompleted: Bool
    var isLocked: Bool
    
    // Content (only one will be used based on contentType)
    var content: String  // Used for diary and plan
    var ratingOne: Int?  // Used for rating (nil means not rated)
    var ratingTwo: Int?  // Used for rating (nil means not rated)
    
    // MARK: - Initialization
    init(
        date: Date,
        category: EntryCategory,
        contentType: EntryContentType,
        isOpen: Bool = false,
        isCompleted: Bool = false,
        isLocked: Bool = false,
        content: String = "",
        ratingOne: Int? = nil,
        ratingTwo: Int? = nil
    ) {
        self.id = UUID()
        self.date = date
        self.category = category
        self.contentType = contentType
        self.isOpen = isOpen
        self.isCompleted = isCompleted
        self.isLocked = isLocked
        self.content = content
        self.ratingOne = ratingOne
        self.ratingTwo = ratingTwo
    }
}
