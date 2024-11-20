import TokamakDOM

@main
struct MemorizwiftWebApp: App {
    @StateObject var game = EmojiMemoryGame()
    
    var body: some Scene {
        WindowGroup {
            VStack {
                Text("Memorizwift Web")
                    .font(.largeTitle)
                    .padding()
                EmojiMemoryGameView(viewModel: game)
            }
        }
    }
}