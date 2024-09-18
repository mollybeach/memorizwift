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
            ForEach(0..<4) { index in
                CardView(initiallyFaceUp: index % 2 == 0)
            }
        }
        .foregroundColor(.purple)
        .imageScale(.small)
        .padding()
    }
}

struct CardView: View {
    @State private var isFaceUp: Bool

    init(initiallyFaceUp: Bool) {
        _isFaceUp = State(initialValue: initiallyFaceUp)
    }

    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)
            if isFaceUp {
                base.fill(.white)
                base.strokeBorder(lineWidth: 5)
                Text("👻").font(.largeTitle)
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



