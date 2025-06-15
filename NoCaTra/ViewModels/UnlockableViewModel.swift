//
//  UnlockableViewModel.swift
//  NoCaTra
//
//  Created by Sam Hirth on 4/20/25.
//

import SwiftUI
import Foundation

@MainActor
public class UnlockableViewModel: ObservableObject {
    @Published public private(set) var unlockStates: [Bool] = []
    
    private var unlockableModel: UnlockableModel
    
    init(unlockableModel: UnlockableModel = UnlockableModel()) {
        self.unlockableModel = unlockableModel
        self.refreshStates()
    }
    
    internal func refreshStates() {
        unlockStates = [
            unlockableModel.isEntry1Unlocked,
            unlockableModel.isEntry2Unlocked,
            unlockableModel.isEntry3Unlocked,
            unlockableModel.isEntry4Unlocked,
            unlockableModel.isEntry5Unlocked,
            unlockableModel.isEntry6Unlocked,
            unlockableModel.isEntry7Unlocked,
            unlockableModel.isEntry8Unlocked,
            unlockableModel.isEntry9Unlocked
        ]
    }
    
    private func postTrackerRefresh() {
        NotificationCenter.default.post(name: Notification.Name("UnlockStateChanged"), object: nil)
        NotificationCenter.default.post(name: Notification.Name("RefreshTrackerView"), object: nil)
    }
    
    private func postFullAppRefresh() {
        NotificationCenter.default.post(name: Notification.Name("FullAppRefresh"), object: nil)
    }
    
    public func toggleEntry(at index: Int) {
        guard index >= 0 && index < 9 else { return }
        
        // Update the model first
        switch index {
        case 0: unlockableModel.isEntry1Unlocked.toggle()
        case 1: unlockableModel.isEntry2Unlocked.toggle()
        case 2: unlockableModel.isEntry3Unlocked.toggle()
        case 3: unlockableModel.isEntry4Unlocked.toggle()
        case 4: unlockableModel.isEntry5Unlocked.toggle()
        case 5: unlockableModel.isEntry6Unlocked.toggle()
        case 6: unlockableModel.isEntry7Unlocked.toggle()
        case 7: unlockableModel.isEntry8Unlocked.toggle()
        case 8: unlockableModel.isEntry9Unlocked.toggle()
        default: break
        }
        
        // Refresh the published state
        refreshStates()
        
        // Post notification for observers
        postTrackerRefresh()
        
    }
    
    public func setEntry(at index: Int, to value: Bool) {
        guard index >= 0 && index < 9 else { return }
        
        unlockStates[index] = value
        
        switch index {
        case 0: unlockableModel.isEntry1Unlocked = value
        case 1: unlockableModel.isEntry2Unlocked = value
        case 2: unlockableModel.isEntry3Unlocked = value
        case 3: unlockableModel.isEntry4Unlocked = value
        case 4: unlockableModel.isEntry5Unlocked = value
        case 5: unlockableModel.isEntry6Unlocked = value
        case 6: unlockableModel.isEntry7Unlocked = value
        case 7: unlockableModel.isEntry8Unlocked = value
        case 8: unlockableModel.isEntry9Unlocked = value
        default: break
        }
        
        postTrackerRefresh()
    }
}
