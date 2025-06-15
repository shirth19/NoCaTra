//
//  unlockableModel.swift
//  NoCaTra
//
//  Created by Sam Hirth on 4/23/25.
//

//This is a class, it needs to be changed

import SwiftUI

public struct UnlockableModel {
    @AppStorage("isEntry1Unlocked") public var isEntry1Unlocked: Bool = false
    @AppStorage("isEntry2Unlocked") public var isEntry2Unlocked: Bool = false
    @AppStorage("isEntry3Unlocked") public var isEntry3Unlocked: Bool = false
    @AppStorage("isEntry4Unlocked") public var isEntry4Unlocked: Bool = false
    @AppStorage("isEntry5Unlocked") public var isEntry5Unlocked: Bool = false
    @AppStorage("isEntry6Unlocked") public var isEntry6Unlocked: Bool = false
    @AppStorage("isEntry7Unlocked") public var isEntry7Unlocked: Bool = false
    @AppStorage("isEntry8Unlocked") public var isEntry8Unlocked: Bool = false
    @AppStorage("isEntry9Unlocked") public var isEntry9Unlocked: Bool = false
    
    public init() {}
}
