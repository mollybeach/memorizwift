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
            HStack {
                ForEach(0..<cardCount, id:\.self) { index in
                    CardView(content: emojis[index])
                }
            }
            .foregroundColor(.purple)
            HStack {
                Button(action: {
                    if cardCount < emojis.count {
                        cardCount+=1
                    }
                }, label: {
                    Image(systemName: "plus.rectangle.on.rectangle.fill")
                })
                Spacer()
                Button(action: {
                    if cardCount > 1 {
                        cardCount-=1
                    }

                }, label: {
                    Image(systemName: "rectangle.stack.badge.minus.fill")
                })
            }
            .imageScale(.large)
            .font(.largeTitle)
        }
        
        .imageScale(.small)
        .padding()
    }
}

struct CardView: View {
    let content: String
    @State var isFaceUp = true
    
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)
            if isFaceUp {
                base.fill(.white)
                base.strokeBorder(lineWidth: 5)
                Text(content).font(.largeTitle)
            } else {
                base.fill()
            }
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



