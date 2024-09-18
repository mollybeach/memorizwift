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
                CardView(isFaceUp: true)
                CardView(isFaceUp: false)
            }
        }

        .foregroundColor(.purple)
        .imageScale(.small)
        .padding()
    }
}

struct CardView: View{
    var isFaceUp: Bool = false
    var body: some View {
        ZStack(){
            if(isFaceUp) {
                RoundedRectangle(cornerRadius:12)
                    .foregroundColor(.white)
                RoundedRectangle(cornerRadius: 12)
                    .strokeBorder(lineWidth: 5)
                Text("👻").font(.largeTitle)
            } else {
                RoundedRectangle(cornerRadius:12)
                RoundedRectangle(cornerRadius: 12)
                    .strokeBorder(lineWidth: 5)
                Text("👻").font(.largeTitle)
            }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
}


