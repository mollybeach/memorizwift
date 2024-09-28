import Foundation

//
//  MemoryGame .swift
//  Memorizwift
//
//  Created by Molly Beach on 9/17/24.
//

struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards: Array<Card>
    
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = []
        // addNumberOfPairsCards x2 Cards
        for pairIndex in 0..<max(2, numberOfPairsOfCards) {
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content: content, id: "\(pairIndex+1)a"))
            cards.append(Card(content: content, id: "\(pairIndex+1)b"))
        }
    }
    
    mutating func choose(_ card: Card) {
        let chosenIndex = index(of: card)
        cards[chosenIndex].isFaceUp.toggle()
    }
    
    func index(of card: Card) -> Int {
        for index in cards.indices{
            if cards[index].id == card.id{
                return index
            }
        }
        return 0 //FIXME: bogus!
    }

    mutating func shuffle() {
        cards.shuffle()
        print(cards)
    }

    struct Card : Equatable, Identifiable , CustomDebugStringConvertible{

        var isFaceUp = true
        var isMatched = false
        let content: CardContent
        
        var id: String
        var debugDescription: String {
            "\(id): \(content) \(isFaceUp ? "up" : "down") \(isMatched ? "matched" : "")"
        }
    }
}

