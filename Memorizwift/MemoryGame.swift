import Foundation

//
//  MemoryGame .swift
//  Memorizwift
//
//  Created by Molly Beach on 9/17/24.
//

struct MemoryGame<CardContent> {
    private(set) var cards: [Card]
    
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = []
        
        for pairIndex in 0..<max(2, numberOfPairsOfCards) {
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content: content))
            cards.append(Card(content: content))
        }
    }
    
    func choose(_ card: Card) {
        // TODO: Implement card choosing logic
    }

    mutating func shuffle() {
        cards.shuffle()    }
}

// MARK: - MemoryGame.Card

extension MemoryGame {
    struct Card {
        var isFaceUp = true
        var isMatched = false
        let content: CardContent
    }
}
