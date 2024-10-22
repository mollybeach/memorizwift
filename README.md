# Memorizwift

Memorizwift is a memory card game app built with SwiftUI, based on Stanford's CS193p iOS Development course. This project demonstrates core iOS development concepts and SwiftUI best practices.

## Features

- Memory card game implementation
- SwiftUI-based user interface
- Responsive design for various iOS devices

## Requirements

- iOS 14.0+
- Xcode 12.0+
- Swift 5.3+

## Installation

1. Clone the repository:
   ```
   git clone https://github.com/yourusername/Memorizwift.git
   ```
2. Open `Memorizwift.xcodeproj` in Xcode.
3. Build and run the project on your iOS device or simulator.

## Usage

[Add brief instructions on how to play the game or use the app]

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

MIT License

## Acknowledgments

- Stanford CS193p - iOS Application Development
- [Any other resources or inspirations you'd like to credit]


# Overview of File Structure and Flow in Memorizwift

## AspectVGrid.swift (View)
**Purpose**: This is a custom view component responsible for creating a grid layout where items (such as cards) are displayed. It takes a list of `Item` objects and arranges them in a grid where each cell maintains a specific aspect ratio.

**Key Components**:
- **Item**: Generic type that must conform to `Identifiable`.
- **ItemView**: View type that represents how each `Item` is displayed.
- **GeometryReader**: Used to get the available size and compute the grid’s layout.
- **gridItemWidthThatFits**: Helper function that calculates the best possible width for each grid item based on the available space and the given aspect ratio.

**Relationship**: This view fits into the UI structure by controlling the grid layout for `CardView` items, creating a dynamic and responsive layout.

---

## Cardify.swift (ViewModifier)
**Purpose**: This is a `ViewModifier` that modifies the appearance of a card by applying specific styles like rounded corners, borders, and flipping animations.

**Key Components**:
- **isFaceUp**: Boolean property to determine the card's visibility.
- **RoundedRectangle**: A visual component that represents the card’s border.
- **ZStack**: Used to overlay content over the card background, showing the front or back of the card depending on `isFaceUp`.

**Relationship**: It is applied to `CardView` using the `.cardify()` extension, controlling how cards visually transition between face-up and face-down states.

---

## CardView.swift (View)
**Purpose**: Displays a single card using both content and the `Cardify` modifier. It manages how a card looks, whether it’s face-up or face-down, and its text content.

**Key Components**:
- **Pie**: A custom `Shape` that is used as part of the visual design.
- **cardify()**: Modifier applied to control the card’s appearance based on whether it's face-up.
- **Text(card.content)**: The content displayed on the face of the card.

**Relationship**: This is where individual cards are rendered and styled. It pulls in data from the `MemoryGame` model, then applies the `Cardify` modifier and displays the content.

---

## EmojiMemoryGame.swift (ObservableObject)
**Purpose**: The ViewModel of the app, connecting the `MemoryGame` model with the views (e.g., `CardView`, `EmojiMemoryGameView`). It holds the game state and provides methods to interact with the game.

**Key Components**:
- **MemoryGame**: This is the model the ViewModel manages.
- **shuffle()** and **choose()**: Functions that modify the game state.
- **@Published model**: This means that when the model changes, any views observing the `EmojiMemoryGame` will update automatically.

**Relationship**: This class mediates between the `MemoryGame` (model) and the SwiftUI views, handling all interactions such as shuffling or choosing cards. It is used in `EmojiMemoryGameView`.

---

## EmojiMemoryGameView.swift (View)
**Purpose**: The primary user interface for the memory game, showing the grid of cards and interacting with the ViewModel (`EmojiMemoryGame`).

**Key Components**:
- **AspectVGrid**: The custom grid component used to lay out the cards.
- **CardView**: Each card is displayed using this component.
- **viewModel.choose(card)**: Calls the ViewModel to update the game state when a card is tapped.
- **Shuffle Button**: Allows the user to shuffle the cards.

**Relationship**: This is the primary view that users interact with, connecting to the `EmojiMemoryGame` ViewModel. It uses the `AspectVGrid` and `CardView` to render the UI.

---

## MemorizwiftApp.swift (App)
**Purpose**: This is the entry point for the entire application. It sets up the SwiftUI app and defines the initial scene (window).

**Key Components**:
- **@StateObject game**: The ViewModel is initialized here and passed to the root view (`EmojiMemoryGameView`).
- **WindowGroup**: The container for the app’s UI.

**Relationship**: This file initializes the `EmojiMemoryGame` and provides it to the root view (`EmojiMemoryGameView`). It serves as the launching point for the entire SwiftUI app.

---

## MemoryGame.swift (Model)
**Purpose**: The core model of the game. It represents the game state, logic for matching cards, and shuffling the deck.

**Key Components**:
- **Card struct**: Represents an individual card with properties like `isFaceUp` and `isMatched`.
- **choose()**: Logic for handling what happens when a card is chosen.
- **shuffle()**: Shuffles the cards in the game.
- **indexOfTheOneAndOnlyFaceUpCard**: Tracks the currently selected card to check for matches.

**Relationship**: This is the data model used by the ViewModel (`EmojiMemoryGame`). It encapsulates all the business logic for the game and interacts with the view through the ViewModel.

---

## Pie.swift (Shape)
**Purpose**: A custom `Shape` that is used to display a pie chart or arc as part of the card’s UI.

**Key Components**:
- **startAngle / endAngle**: Control the portion of the circle that is drawn.
- **path(in rect: CGRect)**: Defines how the shape is drawn.

**Relationship**: This shape is used in `CardView` to visually represent something on the face of the card (in this case, a pie chart or arc). It’s purely for the visual design of the card.

---

## Flow Summary:
1. **MemoryGame.swift** (`Model`): Core game logic and card data are managed here.
2. **EmojiMemoryGame.swift** (`ViewModel`): Manages the game state and communicates between the model and the UI.
3. **MemorizwiftApp.swift** (`App`): Entry point, initializes the game and sets up the main window.
4. **EmojiMemoryGameView.swift** (`View`): Displays the main UI, including a grid of cards and interaction buttons. It relies on `AspectVGrid` for the layout and `CardView` for rendering each card.
5. **CardView.swift** (`View`): Displays individual cards, applying the `Cardify` modifier for styling.
6. **Cardify.swift** (`ViewModifier`): Modifies how cards appear and flip.
7. **AspectVGrid.swift** (`View`): Creates a flexible grid layout to display the cards.
8. **Pie.swift** (`Shape`): A custom shape used in the card design.

---

## Imports:
- **SwiftUI**: Used across all views (`EmojiMemoryGameView`, `CardView`, `AspectVGrid`) to build the UI.
- **Foundation**: Used in the `MemoryGame` for non-UI logic such as shuffling and managing data structures.
- **CoreGraphics**: Used in `Pie.swift` to work with the low-level drawing API for creating shapes.

---

This structure adheres to the **MVVM (Model-View-ViewModel)** design pattern common in SwiftUI apps, where:
- The **model** (`MemoryGame.swift`) manages data and game logic.
- The **ViewModel** (`EmojiMemoryGame.swift`) manages the state and logic for interacting between the UI and the model.
- The **Views** (`EmojiMemoryGameView.swift`, `CardView.swift`, `AspectVGrid.swift`) are responsible for presenting the data and capturing user input.

