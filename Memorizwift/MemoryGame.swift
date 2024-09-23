//
//  MemoryGame.swift
//  Memorizwift
//
//  Created by Molly Beach on 9/21/24.
//

import Foundation

struct MemoryGame<CardContent> {
    private(set) var cards : Array<Card>
    
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent){
        // you job inside ur init is to initalize all ur vars
        cards = [] // this is a literal array we did it with our emojis
        // add numberOfPairsOfCards x 2 cards
        // remove pairIndex replace with _ cuz we dont use pair index in the for loop
        for pairIndex in 0..<numberOfPairsOfCards{
            let content = cardContentFactory(pairIndex)
            // free initalizer cuz im a struct
            cards.append(Card(content: content))
            cards.append(Card(content: content))
        }
    }
    
    func choose(_ card: Card){
        
    }
    struct Card {
        var isFaceUp = false
        var isMatched = false
        let content: CardContent
        
    }
    
}
