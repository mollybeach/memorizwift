//
//  ContentView.swift
//  Memorizwift
//
//  Created by Molly Beach on 9/17/24.
// Functional Programming : Behavior
// Object Oriented : Data Encapulation

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]
    // Variables are Structs
    // storage
    var i : Int
    var s : String
    
    // View is a Protocol
    // The Value of inside View {} <- is computed
    // properties of struct
    //Computed is not stored somewher Everytime someone asks for the value of the body it runs this code
    // it's like a read only variable cuz u can only run it not store it
    // some View <- type has to be any struct in the world as long as it behaves like a view execute this code see what it returns
    var body: some View {
        NavigationSplitView {
            List {
                ForEach(items) { item in
                    NavigationLink {
                        Text("Item at \(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))")
                    } label: {
                        Text(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: addItem) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
        } detail: {
            Text("Select an item")
        }
    }

    private func addItem() {
        withAnimation {
            let newItem = Item(timestamp: Date())
            modelContext.insert(newItem)
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(items[index])
            }
        }
    }
}

#Preview {
    ContentView(i: 0, s: "")
        .modelContainer(for: Item.self, inMemory: true)
}

