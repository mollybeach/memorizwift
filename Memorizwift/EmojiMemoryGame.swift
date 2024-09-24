//
//  EmojiMemoryGame.swift
//  Memorizwift
//
//  Created by Molly Beach on 9/21/24.
//

import SwiftUI

// MARK: - EmojiMemoryGame

class EmojiMemoryGame: ObservableObject {
    
    // MARK: - Static Properties
    
    static let emojis = [
        "👻", "🐮", "🍓", "🫐", "👀", "🐶", "🐱", "🦊", "🐻", "🦁",
        "🐸", "🐧", "🐢", "🐙", "🐝", "🐼", "🦄"
    ]
    
    // MARK: - Private Properties
    
    @Published private var model = createMemoryGame()
    
    // MARK: - Initializer
    
    init() {}
    
    // MARK: - Public Properties
    
    var cards: [MemoryGame<String>.Card] {
        model.cards
    }
    
    // MARK: - Private Methods
    
    private static func createMemoryGame() -> MemoryGame<String> {
        MemoryGame(numberOfPairsOfCards: 6) { pairIndex in
            emojis.indices.contains(pairIndex) ? emojis[pairIndex] : "⁉️"
        }
    }
    
    // MARK: - Intent(s)
    
    func shuffle() {
        model.shuffle()
    }
    
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
}
