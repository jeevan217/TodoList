//
//  ToDoListAppApp.swift
//  ToDoListApp
//
//  Created by Jeevan Kaderiya on 7/10/2024.
//

import SwiftUI

@main
struct ToDoListAppApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

extension Color {
    init(_ hex: String) {
        // Remove '#' if present
        let hex = hex.replacingOccurrences(of: "#", with: "")
        
        // Ensure the hex string is valid and has a length of 6
        guard hex.count == 6, let rgb = UInt32(hex, radix: 16) else {
            self = .clear // Fallback color if hex is invalid
            return
        }
        
        let r = Double((rgb >> 16) & 0xFF) / 255.0
        let g = Double((rgb >> 8) & 0xFF) / 255.0
        let b = Double(rgb & 0xFF) / 255.0
        
        self.init(red: r, green: g, blue: b)
    }
}
