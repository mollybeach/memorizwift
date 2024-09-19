//
//  MemorizwiftApp.swift
//  Memorizwift
//
//  Created by Molly Beach on 9/17/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        HStack {
            let emojis : [String] = ["👻", "🐮", "🍓", "🫐"];
            ForEach(0..<4) { index in
                CardView(content: emojis[index], initiallyFaceUp: index % 2 == 0)
            }
        }
        .foregroundColor(.purple)
        .imageScale(.small)
        .padding()
    }
}

struct CardView: View {
    let content: String
    @State private var isFaceUp: Bool
    
    init(content: String, initiallyFaceUp: Bool) {
        self.content = content
        _isFaceUp = State(initialValue: initiallyFaceUp)
    }

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



