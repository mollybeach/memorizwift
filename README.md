# Memorizwift

Memorizwift is a memory card game app built with SwiftUI, based on Stanford's CS193p iOS Development course. This project demonstrates core iOS development concepts and SwiftUI best practices.

# Project Structure
```
Memorizwift/
├── .git/
├── Memorizwift/
│   ├── Assets.xcassets/
│   │   ├── AccentColor.colorset/
│   │   │   └── Contents.json
│   │   ├── AppIcon.appiconset/
│   │   │   └── Contents.json
│   │   ├── Image.imageset/
│   │   │   ├── Contents.json
│   │   │   └── MVVM.png
│   │   └── Contents.json
│   ├── Preview Content/
│   │   └── Preview Assets.xcassets/
│   │   │   └── Contents.json
│   ├── .DS_Store
│   ├── AspectVGrid.swift
│   ├── Cardify.swift
│   ├── CardView.swift
│   ├── EmojiMemoryGame.swift
│   ├── EmojiMemoryGameView.swift
│   ├── FlyingNumber.swift
│   ├── MemorizwiftApp.swift
│   ├── MemoryGame.swift
│   └── Pie.swift
├── Memorizwift.xcodeproj/
│   ├── project.xcworkspace/
│   │   ├── xcshareddata/
│   │   │   ├── swiftpm/
│   │   │   │   └── configuration/
│   │   │   └── IDEWorkspaceChecks.plist
│   │   ├── xcuserdata/
│   │   │   └── mollybeach.xcuserdatad/
│   │   │   │   └── UserInterfaceState.xcuserstate
│   │   └── contents.xcworkspacedata
│   ├── xcshareddata/
│   │   └── xcschemes/
│   │   │   └── Memorizwift.xcscheme
│   ├── xcuserdata/
│   │   └── mollybeach.xcuserdatad/
│   │   │   ├── xcdebugger/
│   │   │   │   └── Breakpoints_v2.xcbkptlist
│   │   │   └── xcschemes/
│   │   │   │   └── xcschememanagement.plist
│   └── project.pbxproj
├── MemorizwiftTests/
│   └── MemorizwiftTests.swift
├── MemorizwiftUITests/
│   ├── MemorizwiftUITests.swift
│   └── MemorizwiftUITestsLaunchTests.swift
├── MemorizwiftWeb/
├── .DS_Store
├── LectureNotes.md
└── README.md
```


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

## MemorizwiftApp.swift (App)

**Type:** `@main` App (Entry point)

**Purpose:** This is the entry point for the entire app. It initializes the EmojiMemoryGame ViewModel and provides it to the root view EmojiMemoryGameView.

**Key Components:**

- `@StateObject var game:` The ViewModel instance that manages the game's state and behavior.
- `WindowGroup:` Provides the root EmojiMemoryGameView with the game data to display.

**Imports:**

- `SwiftUI:` Required to define the app’s UI and manage the lifecycle of views.

---

## EmojiMemoryGame.swift (ViewModel)

**Type:** ObservableObject

**Purpose:** This class is the ViewModel in the MVVM architecture. It manages the game logic and communicates between the UI (Views) and the model (MemoryGame.swift).

**Key Components:**

- `@Published private var model:` The MemoryGame model that stores the game's current state.

**Functions:**
- `choose(_ card: Card):` Updates the game when a card is chosen.
- `shuffle():` Shuffles the deck of cards.
- `cards:` Exposes the current state of the cards to the view.
- `score:` Exposes the score of the game to the view.
- `color:` Returns a constant color for use in the view.

**Relationship:**
The ViewModel (EmojiMemoryGame) connects the UI (e.g., EmojiMemoryGameView) with the business logic/model (MemoryGame.swift). Whenever changes occur to the model (cards or game state), the views observing the ViewModel (like EmojiMemoryGameView) are updated.

---

## EmojiMemoryGameView.swift (View)

**Type:** SwiftUI View

**Purpose:** This is the main view that displays the memory game grid and buttons. It interacts with the EmojiMemoryGame ViewModel to get the game’s data and update the UI when actions occur.

**Key Components:**

- `@ObservedObject var viewModel:` The ViewModel that the view observes for updates.
- `AspectVGrid:` A custom grid layout for rendering cards, using the AspectVGrid struct.

**Interactions:**
- Tapping a card calls `viewModel.choose(card)` to update the game.
- The "Shuffle" button shuffles the cards by calling `viewModel.shuffle()`.

**Relationship:**
This view observes the EmojiMemoryGame ViewModel for changes and renders the card grid using CardView for individual cards. This view relies on AspectVGrid for layout and CardView to display individual card content.

---

## MemoryGame.swift (Model)

**Type:** Generic Struct

**Purpose:** This is the core model of the game, responsible for holding the game state and logic. It manages the cards, matching logic, and scoring.

**Key Components:**

- `cards:` An array of Card structs representing the game cards.

**Functions:**
- `choose(_ card: Card):` Contains the logic for selecting cards and matching them.
- `shuffle():` Shuffles the deck of cards.

**Card:** Nested struct representing a single card, containing properties like `isFaceUp, isMatched,` and `content.`

**Relationship:**
The MemoryGame struct provides the underlying game logic, which is used by the EmojiMemoryGame ViewModel to manage the game's state. CardView displays the Card data from this model, while the ViewModel handles interactions.

---

## AspectVGrid.swift (View)

**Type:** Generic View

**Purpose:** This view creates a dynamic grid layout where items (like cards) are displayed in a grid with a consistent aspect ratio.

**Key Components:**

- `GeometryReader:` Provides the size of the available container, used to calculate the grid layout.
- `LazyVGrid:` Lays out the items in a vertical scrolling grid with adaptive columns based on the available space.
- `gridItemWidthThatFits:` Helper function to calculate the width of the grid items.

**Relationship:**
This view dynamically calculates and displays items in a grid. It works alongside CardView to arrange cards in the game’s layout. EmojiMemoryGameView uses this view to lay out cards.

---

## Cardify.swift (ViewModifier)

**Type:** ViewModifier and Animatable

**Purpose:** This is a custom view modifier that animates and styles a card, flipping it between face-up and face-down. It also handles the 3D rotation for flipping.

**Key Components:**

- `rotation:` Tracks the card's rotation, controlling whether it’s face-up or face-down.
- `animatableData:` A property for animating the rotation.
- `ZStack:` Layering different views to show the card’s face and back.

**Animations:**
- Rotates the card in 3D using `.rotation3DEffect()` to animate between face-up and face-down.

**Relationship:**
This modifier is applied to CardView using the `.cardify()` extension to animate the flipping of the cards. It enhances the visual appeal by using 3D animations and custom styling for the cards.

---

## CardView.swift (View)

**Type:** SwiftUI View

**Purpose:** This view represents a single card. It renders the card's content and applies the Cardify modifier to handle the visual transition between face-up and face-down states.

**Key Components:**

- `Pie:` A custom Shape used to display part of the card's content (e.g., a pie chart or progress indicator).
- `cardify():` Applies the Cardify modifier to animate the card flip.
- `Text(card.content):` Displays the card’s content.

**Relationship:**
Each card in the memory game is represented by this view. It uses Cardify to handle animations and Pie for additional visual content. EmojiMemoryGameView uses this view inside the AspectVGrid to display each card in the grid.

---

## Pie.swift (Shape)

**Type:** Shape

**Purpose:** A custom shape that draws a pie slice or arc. This can be used as part of the card’s design, such as representing progress.

**Key Components:**

- `startAngle` and `endAngle:` Define the arc’s angles.
- `path(in rect: CGRect):` Builds the path for the shape to draw.

**Relationship:**
This shape is used inside CardView to enhance the card's visual appearance. It contributes to the graphical display of the card's content.

---

## FlyingNumber.swift (View)

**Type:** SwiftUI View

**Purpose:** Displays a number that "flies" onto the screen, potentially as part of a score indicator or other dynamic visual element.

**Key Components:**

- Displays a number using `Text(number)` when number != 0.

**Relationship:**
This view can be integrated into various parts of the UI to display dynamic numerical values, such as scores.

---

## Overall Flow:

1. **MemorizwiftApp.swift** initializes the app and provides the EmojiMemoryGame ViewModel to the root view.
2. **EmojiMemoryGame.swift** (ViewModel) manages the game’s logic and state using the MemoryGame model and provides data to the UI via EmojiMemoryGameView.
3. **EmojiMemoryGameView.swift** displays the grid of cards using AspectVGrid and updates the UI based on interactions.
4. **AspectVGrid.swift** dynamically arranges CardView items in a grid with a fixed aspect ratio.
5. **CardView.swift** renders individual cards, applying the Cardify modifier for visual transitions and using the Pie shape for additional content.
6. **Cardify.swift** handles the visual appearance and animations of cards (e.g., flipping).
7. **MemoryGame.swift** provides the underlying game logic and data structures (cards, matching, and scoring).
8. **Pie.swift** enhances the visual design of cards with custom shapes.
9. **FlyingNumber.swift** can be used for displaying dynamic numeric content such as scores.

---

## Imports:

- `SwiftUI:` Required for building the app’s user interface, handling views, layouts, animations, and modifiers.
- `Foundation:` Used for non-UI logic in the MemoryGame (e.g., arrays, shuffling).
- `CoreGraphics:` Imported in Pie.swift for low-level graphics drawing, needed for creating the custom shape.

---

### This setup follows the MVVM (Model-View-ViewModel) pattern:

1. **Model:** MemoryGame.swift manages the game's state and logic.
2. **ViewModel:** EmojiMemoryGame.swift acts as the mediator between the model and the views.
3. **View:** The SwiftUI views (e.g., EmojiMemoryGameView, CardView) render the UI and interact with the ViewModel.
