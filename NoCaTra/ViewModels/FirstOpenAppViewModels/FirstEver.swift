//
//  FirstEver.swift
//  NoCaTra
//
//  Created by Sam Hirth on 4/26/25.
//

import Foundation

struct FirstEver {
    
    static func setStartDate() {
        let defaults = UserDefaults.standard
        defaults.set(Date(), forKey: "StartDate")
    }
    
}
