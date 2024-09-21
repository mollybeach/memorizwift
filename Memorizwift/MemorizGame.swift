//
//  MemorizGame.swift
//  Memorizwift
//
//  Created by Molly Beach on 9/21/24.
//

import Foundation

struct MemoryGame<CardContent> {
    var cards : Array<Card>
    
    func choose(card: Card){
        
    }
    struct Card {
        var isFaceUp: Bool
        var isMatched: Bool
        var content: CardContent
        
    }
    
}
