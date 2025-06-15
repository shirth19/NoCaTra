//
//  ColorTheme.swift
//  NoCaTra
//
//  Created by Sam Hirth on 4/20/25.
//

import SwiftUI

struct ColorTheme {
    // Base Colors
    static let primaryGreen = Color(red: 144/255, green: 238/255, blue: 144/255) // Light, friendly green
    static let secondaryGreen = Color(red: 98/255, green: 187/255, blue: 98/255) // Slightly darker variant
    
    // UI Colors
    static let background = Color(red: 250/255, green: 250/255, blue: 250/255) // Almost white
    static let foreground = Color(red: 51/255, green: 51/255, blue: 51/255) // Soft black
    static let accent = primaryGreen
    
    // Status Colors
    static let success = Color(red: 76/255, green: 175/255, blue: 80/255)
    static let warning = Color(red: 255/255, green: 152/255, blue: 0/255)
    static let error = Color(red: 244/255, green: 67/255, blue: 54/255)
    
    // Text Colors
    static let primaryText = foreground
    static let secondaryText = Color(red: 117/255, green: 117/255, blue: 117/255)
    
    // Interactive Elements
    static let buttonBackground = primaryGreen
    static let buttonText = Color.white
    static let inputBorder = Color(red: 224/255, green: 224/255, blue: 224/255)
}
