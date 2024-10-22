//
//  MemorizwiftApp.swift
//  Memorizwift
//
//  Created by Molly Beach on 9/17/24.
//

import SwiftUI

@main
struct MemorizwiftApp: App {
    @StateObject var game = EmojiMemoryGame()
    
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(viewModel: game)
        }
    }
}

