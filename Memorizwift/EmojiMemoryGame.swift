//
//  EmojiMemoryGame.swift
//  Memorizwift
//
//  Created by Molly Beach on 9/21/24.
//

import SwiftUI // ViewModel Does Import Swift UI

//class EmojiMemoryGame: MySuperClass, SomethingWeBehaveLike

func createCardContent(forPairAtIndex index:Int) -> String{
    return ["👻", "🐮", "🍓", "🫐", "👀", "🐶", "🐱", "🦊", "🐻", "🦁", "🐸", "🐧", "🐢", "🐙", "🐝", "🐼", "🦄"][index]
    
}
class EmojiMemoryGame {
    // We never had any init intializer for our CardView. Classes did the same thing but
    // their initializers have no arguments so they only work if all of your variables
    // have no arguments it only works all your variables have default values and we have a
    // variable right here model that has no value so that's why it's saying
    // "i cant give you the free initializer here because you have some unitialized value
    //since you have some unitialized variables so u have no intitalizers plesae "give me one" it's saying
    // so i could give it an init and we're going to see init her ein a second here in our model but instead im going
    // to try to give this
    //private var model: MemoryGame<String> as value
    //private var model: MemoryGame<String> = MemoryGame<String> () with no arguments possibly
    // can i do that no because there's  a missing argument cards okay MemoryGame<String> is a struct
    //it's free initalizer lets me initialize all of the variables and if i go back here and look at
    // at my model it's going an unitialized variable which the cards the cards of array
    // from MemoryGame.swift :   private(set) var cards : Array<Card> <-
    // You've got to provide those cards:
    //  private var model: MemoryGame<String>(cards: <- this makes no sense for cards to be the argument
    // so this is where intializers come in what does make sense is numberOfPairsOfCards: 4)
    // ->   private var model: MemoryGame<String> = MemoryGame<String>(numberOfPairsOfCards: 4)
    // we're going to have to create an init in MemoryGame.swift
    
    // closure
    
    private var model = MemoryGame(
        numberOfPairsOfCards: 4,
        cardContentFactory: { index in
        return ["👻", "🐮", "🍓", "🫐", "👀", "🐶", "🐱", "🦊", "🐻", "🦁", "🐸", "🐧", "🐢", "🐙", "🐝", "🐼", "🦄"][index]
        }
    )
    
    var cards: Array<MemoryGame<String>.Card>{
        return model.cards
    }
    func choose(_ card: MemoryGame<String>.Card){
        model.choose(card)
    }
}
