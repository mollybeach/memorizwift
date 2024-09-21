//
//  MemorizwiftApp.swift
//  Memorizwift
//
//  Created by Molly Beach on 9/17/24.
//

import SwiftUI

struct ContentView: View {
    let emojis : [String] = ["👻", "🐮", "🍓", "🫐", "👀", "🐶", "🐱", "🦊", "🐻", "🦁", "🐸", "🐧", "🐢", "🐙", "🐝", "🐼", "🦄"];
    @State var cardCount : Int = 4;
    
    var body: some View {
        VStack{
            ScrollView{
                Image("Image")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                cards
            }
            Spacer()
            cardCountAdjusters
        }
        .padding()
    }
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 120))]){
            ForEach(0..<cardCount, id:\.self) { index in
                CardView(content: emojis[index])
                    .aspectRatio(5/6, contentMode: .fit)
            }
        }
        .foregroundColor(.purple)
    }
    
    var cardCountAdjusters: some View {
        HStack {
            cardAdder
            Spacer()
            cardRemover
        }
        .imageScale(.large)
        .font(.largeTitle)
    }
    
    func cardCountAdjuster(by offset: Int, symbol: String) -> some View {
        Button(action: {
            cardCount += offset
        }, label: {
            Image(systemName: symbol)
        })
        .disabled(cardCount + offset < 1 || cardCount + offset > emojis.count)
        .foregroundColor(.gray)

    }
    var cardAdder: some View {
        cardCountAdjuster(by: +1, symbol: "plus.rectangle.on.rectangle.fill")
    }
    var cardRemover: some View {
        cardCountAdjuster(by: -1, symbol: "rectangle.stack.badge.minus.fill")
    }
    
}

struct CardView: View {
    let content: String
    @State var isFaceUp = true
    
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)
            Group {
                base.fill(.white)
                base.strokeBorder(lineWidth: 5)
                Text(content).font(.largeTitle)
            }.opacity(isFaceUp ? 1 : 0)
                base.fill().opacity(isFaceUp ? 0 : 1)
        }
        .onTapGesture {
            isFaceUp.toggle()
            print("Card tapped, isFaceUp: \(isFaceUp)")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}



