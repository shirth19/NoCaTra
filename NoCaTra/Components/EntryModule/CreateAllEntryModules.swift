//
//  CreateAllEntryModules.swift
//  NoCaTra
//
//  Created by Sam Hirth on 4/22/25.
//

import Foundation
import SwiftUI

func createAllEntryModules(for date: Date) -> [EntryModule] {
    let unlockableModel = UnlockableModel()
    
    return [
        // Food
        EntryModule(date: date, category: .food, contentType: .diary, isLocked: !unlockableModel.isEntry1Unlocked),
        EntryModule(date: date, category: .food, contentType: .plan, isLocked: !unlockableModel.isEntry2Unlocked),
        EntryModule(date: date, category: .food, contentType: .rating, isLocked: !unlockableModel.isEntry3Unlocked),
        
        // Exercise
        EntryModule(date: date, category: .exercise, contentType: .diary, isLocked: !unlockableModel.isEntry4Unlocked),
        EntryModule(date: date, category: .exercise, contentType: .plan, isLocked: !unlockableModel.isEntry5Unlocked),
        EntryModule(date: date, category: .exercise, contentType: .rating, isLocked: !unlockableModel.isEntry6Unlocked),
        
        // Mindfulness
        EntryModule(date: date, category: .mindfulness, contentType: .diary, isLocked: !unlockableModel.isEntry7Unlocked),
        EntryModule(date: date, category: .mindfulness, contentType: .plan, isLocked: !unlockableModel.isEntry8Unlocked),
        EntryModule(date: date, category: .mindfulness, contentType: .rating, isLocked: !unlockableModel.isEntry9Unlocked),
    ]
}
