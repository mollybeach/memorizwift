import TokamakShim

struct ContentView: View {
    var body: some View {
        Text("Hello, Memorizwift!")
    }
}

@main
struct MemorizwiftWebApp: App {
    var body: some Scene {
        WindowGroup("Memorizwift") {
            ContentView()
        }
    }
} 