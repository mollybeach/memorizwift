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
            ForEach(0..<2) { _ in
                CardView()
                CardView(isFaceUp: false)
            }
        }
        .foregroundColor(.purple)
        .imageScale(.small)
        .padding()
    }
}

struct CardView: View{
    var isFaceUp: Bool = true
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius:12)
            if(isFaceUp) {
                base.fill(.white)
                base.strokeBorder(lineWidth: 5)
                Text("👻").font(.largeTitle)
            } else {
                base.fill()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
}


