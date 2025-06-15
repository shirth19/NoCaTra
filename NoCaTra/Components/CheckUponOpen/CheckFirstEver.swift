//
//  CheckFirstEver.swift
//  NoCaTra
//
//  Created by Sam Hirth on 4/22/25.
//

//Check if first time ever opening the app

import Foundation

func checkFirstEver() -> Bool {
    let defaults = UserDefaults.standard
    let hasLaunchedBefore = defaults.bool(forKey: "HasLaunchedBefore")
    
    if !hasLaunchedBefore {
        // Set the flag so next time it returns false
        defaults.set(true, forKey: "HasLaunchedBefore")
        return true
    }
    
    return false
}
