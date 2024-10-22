# Lecture Notes

# Table of Contents
- [Lecture 1: Lecture 1](#lecture-1)
- [Lecture 1: Lecture 2 ](#lecture-2)
- [Lecture 3: Architecture in Swift (MVVM)](#lecture-3-architecture-in-swift-mvvm)
- [Lecture 4: Memory Game in Swift](#lecture-4-memory-game-in-swift)
- [Lecture 5: Enums and Optionals](#lecture-5-enums-and-optionals)
- [Lecture 6: Layout in SwiftUI](#lecture-6-layout-in-swiftui)

## Lecture 01
* `some View` allows for any struct to be returned as long as it conforms to the View protocol.
* `@ViewBuilder` combines multiple views and returns a single View.
    * Expressions are forbidden.
```swift
@ViewBuilder
var myView: some View {
    Image(systemName: "globe")
    Text("some text")
}
```

## Lecture 02
* Trailing closures (last argument is a closure).
```swift
ZStack(alignment: .top) {
  Text("Hello")
}
```
* With a `@State` var, SwiftUI will keep note of changes and redraw the UI.
* In a `LazyVGrid` views are only created when SwiftUI needs to display them.

# Lecture 3: Architecture in Swift (MVVM)

## MVVM: Model-View-ViewModel

- MVVM is a design paradigm used to separate concerns between data (Model), the logic connecting data to the UI (ViewModel), and the UI itself (View).
- The **Model** is where the logic and data live. It could be a `struct`, an SQL database, machine learning code, a REST API, or any combination.
- The **UI** is a "parametizable" shell that the Model feeds and brings to life. The UI represents the Model visually.
- Swift ensures the UI is updated when the Model changes.

## Connecting the Model to the UI

- There are multiple ways to connect the Model to the UI:
    1. The Model could be a simple `@State` in a View (minimal separation).
    2. The Model might be accessed via a "ViewModel" class (full separation).
    3. The Model may still be accessible directly, but through a ViewModel (partial separation).

- In practice:
    - Simple data models with little logic may use approach 1.
    - Complex models combining various elements (e.g., SQL, structs) will likely use approach 2.
    - For now, always use approach 2: full separation via a ViewModel.

## MVVM Diagram

![MVVM Diagram](Memorizwift/Assets.xcassets/Image.imageset/MVVM.png)

---

# Swift Types

## Types in Swift

- **Struct**
- **Class**
- **Protocol**
- **Generics** ("don't care" types)
- **enum**
- **Functions**

## Struct & Class

### Common Features of Structs and Classes

- Both have stored variables (`vars`) and constants (`lets`), as well as computed properties.
    ```swift
    let defaultColor = Color.orange
    CardView().foregroundColor(defaultColor)
    ```
- Both can have functions.
    ```swift
    func multiply(operand: Int, by: Int) -> Int {
        return operand * by
    }
    multiply(operand: 5, by: 6)
    ```
- Both have initializers.
    ```swift
    struct RoundedRectangle {
        init(cornerRadius: CGFloat) { }
        init(cornerSize: CGSize) { }
    }
    ```
    - In the **MemoryGame** struct:
    ```swift
    struct MemoryGame {
        init(numberOfPairsOfCards: Int) {
            // Initialize game with that many pairs of cards
        }
    }
    ```

### Differences Between Structs and Classes

- **Structs**:
    - Value types (storage is right where it's used).
    - Copied when passed or assigned.
    - "Free" initializer initializes all variables.
    - No inheritance.
    - Stored on the stack.
    - Mutability is explicit (`var` or `let`).
    - The "go-to" data structure in Swift.

- **Classes**:
    - Reference types (multiple references to the same instance).
    - Passed by reference using pointers.
    - Support inheritance (single).
    - Always mutable (dangerous).
    - Stored on the heap.
    - Automatic reference counting (ARC) for memory management.
    - Used in special cases (e.g., ViewModels).

---

# Generics in Swift

- Generics allow for type-agnostic programming.
- Even though Swift is a strongly typed language, generics allow for flexibility while maintaining type safety.

### Example: Generic Array

```swift
struct Array<Element> {
    func append(_ element: Element) { }
}
```

- `Element` is a placeholder for any type, decided when using `Array`.
```swift
var names = Array<String>()
names.append("Molly")
names.append("Jake")
```

### Generic Functions

- Functions can also use generics.
    ```swift
    func printElement<T>(_ element: T) {
        print(element)
    }
    ```

---

# Protocols

- A protocol defines a set of required functions and properties, but no implementation.
- Any type (struct, class, enum) can conform to a protocol by implementing its requirements.

### Example Protocol

```swift
protocol Movable {
    func move(by: Int)
    var hasMoved: Bool { get }
    var distanceFromStart: Int { get }
}
```

- Types that conform to the protocol must provide an implementation.
    ```swift
    struct PortableThing: Movable {
        var hasMoved: Bool
        var distanceFromStart: Int
        func move(by: Int) { /* implementation */ }
    }
    ```

### Protocol Inheritance

- Protocols can inherit other protocols.
    ```swift
    protocol Vehicle: Movable {
        var passengerCount: Int { get set }
    }
    ```

### Protocol Usage

- Protocols can be used in place of types, especially with `some` and `any` keywords.
    ```swift
    struct ContentView: View {
        var body: some View { /* implementation */ }
    }
    ```

---

# Functions as Types

- Functions in Swift can be treated as types. You can declare variables, parameters, and return types as functions.

### Example Function Types

```swift
(Int, Int) -> Bool // Function takes two Ints and returns a Bool.
(Double) -> Void // Function takes a Double and returns nothing.
() -> Array<String> // Function takes no arguments, returns an Array of Strings.
```

### Example Usage

```swift
var operation: (Double) -> Double

func square(operand: Double) -> Double {
    return operand * operand
}

operation = square // Assigning the square function to the operation variable.
let result = operation(4) // result is 16
```

---

# Closures

- Closures are inline functions or lambdas, and are commonly used in Swift (e.g., `@ViewBuilder`).
- They allow passing functions around more easily.
    ```swift
    performOperation { nums in
        print(nums)
    }
    ```

---

# Memory Management: ARC vs Garbage Collection

- Swift uses **Automatic Reference Counting (ARC)** for memory management.
    - ARC keeps track of how many references point to an object and deallocates it when there are no more references.
- In contrast, **Garbage Collection** is used in languages like Java, where the system periodically deallocates unused objects based on reference checks.

# Lecture 4: Memory Game in Swift

## Model: MemoryGame Struct

The `MemoryGame` struct represents the model of our game.

```swift
struct MemoryGame<CardContent> {
    private(set) var cards: Array<Card>

    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = [] // Initialize the cards array
        // Add pairs of cards
        for pairIndex in 0 ..< max(2, numberOfPairsOfCards) {
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content: content))
            cards.append(Card(content: content))
        }
    }

    func choose(_ card: Card) { }
    
    // Shuffle the cards (needs to be marked 'mutating')
    mutating func shuffle() {
        cards.shuffle()
        print(cards)
    }

    struct Card {
        var isFaceUp = true
        var isMatched = false
        let content: CardContent
    }
}
```

### Explanation:

- The `MemoryGame` struct takes `CardContent` as a generic type.
- It initializes a list of card pairs using a content factory function.
- The `shuffle()` function shuffles the cards in place.

## Initialization in Swift

- Swift provides a free initializer for structs, but only if all properties are initialized.
- If a struct contains variables without default values, Swift does not provide a free initializer.

For example:

```swift
private var model: MemoryGame<String> = MemoryGame<String>(numberOfPairsOfCards: 4)
```

Here, we manually initialize the `model` with the correct number of card pairs.

## Trailing Closure Syntax

When the last argument of a function is a closure, Swift allows the closure to be written outside the parentheses.

Example:

```swift
performOperation(numbers: [1, 2, 3]) { nums in
    print(nums)
}
```

You can also use shorthand argument names like `$0`, which refers to the first argument.

## Static Variables

Static variables allow values to be global within a class or struct but scoped to the class itself. This is useful for values that don't need to change, such as an emoji set.

```swift
static let emojis = ["👻", "🐮", "🍓", "🫐", "👀", "🐶", "🐱", "🦊", "🐻", "🦁", "🐸", "🐧", "🐢", "🐙", "🐝", "🐼", "🦄"]
```

## Creating a Memory Game

A function can be used to create a memory game.

```swift
private static func createMemoryGame() -> MemoryGame<String> {
    return MemoryGame(numberOfPairsOfCards: 4) { pairIndex in
        return emojis[pairIndex]
    }
}

private var model = createMemoryGame()
```

## Property Initializers and Self

Property initializers run before `self` is available, meaning you cannot use instance members in initializers. This can be resolved by using `static` functions.

## Reactive Programming and ObservableObject

To make the view model reactive, we use the `ObservableObject` protocol and the `@Published` property wrapper.

```swift
class EmojiMemoryGame: ObservableObject {
    @Published private var model = createMemoryGame()
}
```

## Using @StateObject in SwiftUI

In a SwiftUI app, views that need to observe state changes use the `@StateObject` property wrapper.

```swift
import SwiftUI

@main
struct MemorizwiftApp: App {
    @StateObject var game = EmojiMemoryGame()
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: game)
        }
    }
}
```

### Summary:

- The `MemoryGame` struct models the game logic.
- We use closures for flexibility, static variables for global constants, and reactive programming patterns like `@Published` and `ObservableObject` for state management in SwiftUI.

# Lecture 5: Enums and Optionals

## Enum

- Enums are another variety of data structure in addition to `struct` and `class`. 
- Enums can only have discrete states.

```swift
enum FastFoodMenuItem {
    case hamburger
    case fries
    case drink
    case cookie
}
```

- An enum is a **value type** (like `struct`), so it is copied and passed around.

### Associated Data

- Each state of an enum can (but does not have to) have its own 'associated data'.

```swift
enum FastFoodMenuItem {
    case hamburger(numberOfPatties: Int)
    case fries(size: FryOrderSize)
    case drink(String, ounces: Int)
    case cookie
}
```

- The `drink` case has two pieces of associated data, one of them unnamed.
- In the example above, `FryOrderSize` would likely also be an enum:

```swift
enum FryOrderSize {
    case large
    case small
}
```

### Setting a Value of an Enum

- Use the type name and the case you want, separated by a dot.

```swift
let menuItem: FastFoodMenuItem = FastFoodMenuItem.hamburger(numberOfPatties: 2)
var otherItem: FastFoodMenuItem = FastFoodMenuItem.cookie
var yetAnotherItem = .cookie // Swift can infer this
```

### Checking an Enum's State

- Enum states are usually checked with a `switch` statement (an `if` statement is unusual, especially if there is associated data).

```swift
var menuItem = FastFoodMenuItem.hamburger(numberOfPatties: 2)

switch menuItem {
    case .hamburger: print("burger")
    case .fries: print("fries")
    case .drink: print("drink")
    case .cookie: print("cookie")
}
```

- It's not necessary to fully write out `FastFoodMenuItem.fries` inside the `switch` (since Swift can infer it).

### `break` in Switch

- If you don't want to do anything for a given case, use `break`.

```swift
switch menuItem {
    case .hamburger: break
    case .fries: print("fries")
    case .drink: print("drink")
    case .cookie: print("cookie")
}
```

- This code would print nothing to the console.

### `default` in Switch

- A `switch` must handle all possible cases, though you can use `default` to handle uninteresting cases.

```swift
switch menuItem {
    case .hamburger: break
    case .fries: print("fries")
    default: print("other")
}
```

- If `menuItem` is a `cookie`, the above would print "other".

### Multiple Lines in Switch Cases

- Each case in a `switch` can have multiple lines and does **not** fall through to the next case unless specified with `fallthrough`.

```swift
switch menuItem {
    case .hamburger: print("burger")
    case .fries:
        print("yummy")
        print("fries")
    case .drink: print("drink")
    case .cookie: print("cookie")
}
```

- The above code would print "yummy" and "fries" but not "drink".

### Accessing Associated Data

- Associated data can be accessed in a `switch` using the `let` syntax.

```swift
switch menuItem {
    case .hamburger(let pattyCount): print("a burger with \(pattyCount) patties!")
    case .fries(let size): print("a \(size) order of fries!")
    case .drink(let brand, let ounces): print("a \(ounces)oz \(brand)")
    case .cookie: print("a cookie!")
}
```

### Methods in Enums

- Enums can have methods and computed properties but no stored properties.

```swift
enum FastFoodMenuItem {
    case hamburger(numberOfPatties: Int)
    case fries(size: FryOrderSize)
    case drink(String, ounces: Int)
    case cookie

    func isIncludedInSpecialOrder(number: Int) -> Bool {
        switch self {
            case .hamburger(let pattyCount): return pattyCount == number
            case .fries, .cookie: return true
            case .drink(_, let ounces): return ounces == 16
        }
    }
}
```

- The above method checks if the item is included in a special order (e.g., a 16oz drink or a burger with a specific number of patties).

### Getting All Cases of an Enum

- Use the `CaseIterable` protocol to get all cases of an enum.

```swift
enum TeslaModel: CaseIterable {
    case X
    case S
    case Three
    case Y
}

for model in TeslaModel.allCases {
    reportSalesNumbers(for: model)
}
```

## Optionals

- An `Optional` is just an enum. It essentially looks like this:

```swift
enum Optional<T> {
    case none
    case some(T)
}
```

- Optionals can have two states: `.none` (nil) or `.some(T)` (with associated data of type `T`).

### Declaring Optionals

- Declaring an optional can be done with the syntax `T?`.

```swift
var hello: String? = "hello"
var goodbye: String? = nil
```

- You can also use the fully expressed `Optional<T>` form:

```swift
var hello: Optional<String> = .some("hello")
var goodbye: Optional<String> = .none
```

### Accessing the Value of an Optional

- Access the value of an optional either by force (`!`) or safely using `if let`.

```swift
if let safeHello = hello {
    print(safeHello)
} else {
    print("hello is nil")
}
```

### Nil-Coalescing Operator `??`

- The `??` operator provides a default value if the optional is nil.

```swift
let x: String? = nil
let y = x ?? "default value"
```

- In this case, `y` will be assigned "default value" if `x` is nil.

# Lecture 6: Layout in SwiftUI

## Layout: How is Space Apportioned to Views?

It's amazingly simple ...

- **Container Views** “offer” some or all of the space offered to them to the Views inside them.
- **Views** then choose what size they want to be (they are the only ones who can do so).
- **Container Views** then position the Views inside of them.

This describes the basic flow of layout in SwiftUI where container views manage space distribution, and views decide their own size preferences.

## Layout: HStack and VStack

### Stacks Dividing Space

- Stacks divide up the space offered to them and then offer that to the Views inside.
- The stack offers space to its “least flexible” subviews first.

**Examples**:
- **Inflexible View**: `Image` (it wants to be a fixed size).
- **Slightly more flexible View**: `Text` (always wants to size exactly to fit its text).
- **Very flexible View**: `RoundedRectangle` (always uses any space offered).

Once a View takes the space it wants, its size is removed from the available space, and the stack moves on to the next “least flexible” Views. Very flexible views share evenly.

### Spacer and Divider

- **Spacer(minLength: CGFloat)**
  - Takes all the space offered.
  - Draws nothing.
  - `minLength` defaults to platform-appropriate spacing.

- **Divider()**
  - Draws a dividing line crosswise to the stack direction.
  - Takes the minimum space to fit the line, and all crosswise space.

These views are essential for creating flexible, visually organized layouts in SwiftUI.

### layoutPriority(Double)

This can override which views get space first, regardless of their flexibility. By default, all views have a layout priority of 0.

```swift
HStack {
    Text("Important").layoutPriority(10)  // Higher priority
    Image(systemName: "arrow.up")  // Default priority (0)
    Text("Unimportant")
}
```

The `Text("Important")` will get the space it needs first due to its higher layout priority. Then, the `Image` will get its space because it is less flexible than the `Text("Unimportant")`. Finally, the `Text("Unimportant")` will fit into any remaining space, and if it doesn't get enough space, it may be truncated (e.g., "Swift is..." instead of "Swift is great!").

## Alignment in HStack and VStack

When stacking views with different widths, alignment determines their positioning (e.g., left-aligned, centered).

```swift
VStack(alignment: .leading) { 
    // Views go here
}
```

- **.leading** adjusts automatically for text flow direction (e.g., right-to-left languages like Arabic or Hebrew).
- Text baselines can also be used for alignment:

```swift
HStack(alignment: .firstTextBaseline) {
    Text("SwiftUI")    // Aligned by the first text baseline
    Text("Layouts")
}
```

You can also define your own alignment guides, though this is beyond the scope of this lecture.

## LazyHStack and LazyVStack

- **LazyHStack** and **LazyVStack**: These “lazy” stacks only build views that are currently visible.
  - They don’t take up all the space offered, even if they contain flexible views.
  - **Use case**: Ideal when the stack is within a `ScrollView`.

## LazyHGrid and LazyVGrid

- **LazyHGrid** and **LazyVGrid**: These grids size their views based on the configuration (e.g., number of columns in a grid).
  - The opposite direction (perpendicular to the grid’s axis) can grow or shrink as more views are added.
  - **Efficiency**: The grid does not take up all the space if it doesn’t need it.
  
## Grid

- **Grid**: A general-purpose grid that allocates space to its views both horizontally and vertically (hence no “H” or “V”).
  - Offers alignment options for both columns and rows using grid modifiers like `gridColumnAlignment()` and `gridRowAlignment()`.
  - **Use case**: Often used to create a "spreadsheet" or tabular display of data.

## ScrollView

- **ScrollView**: Takes up all the space offered to it and enables scrolling along a specified axis.
  - The views inside a `ScrollView` are sized to fit along the axis of scrolling (e.g., horizontally or vertically).

## ViewThatFits

- **ViewThatFits**: Chooses from a list of container views (e.g., `HStack`, `VStack`) and picks the one that best fits the available space.
  - Useful for handling different layouts in landscape vs. portrait mode, or accommodating dynamic type sizes (like larger fonts).

## Advanced Stacks: Form, List, OutlineGroup, and DisclosureGroup

- These views act like "smart" VStacks with additional functionality, such as scrolling, selection, and hierarchy.

  - **Form**: Used for building structured input forms.
  - **List**: Displays rows of data in a scrollable container.
  - **OutlineGroup**: Ideal for showing hierarchical data.
  - **DisclosureGroup**: Collapsible container for showing/hiding content.

## Custom Implementations of the Layout Protocol

- You can create custom views by implementing the **Layout** protocol.
  - This allows complete control over the "offer space, let views choose their size, then position them" process using methods like `sizeThatFits` and `placeSubviews`.

## ZStack

- **ZStack**: Stacks views on top of one another, with the last view being on top.
  - Sizes itself to fit its children, and if one child is flexible, the entire stack will be flexible as well.

### .background Modifier

```swift
Text("hello").background(Rectangle().foregroundColor(.red))
```

This works like a mini-ZStack, where the `Text` controls the layout. The `Rectangle` just adds background color without impacting the layout size.

### .overlay Modifier

```swift
Circle().overlay(Text("Hello"), alignment: .center)
```

In this example, the Circle is fully flexible and determines the overall size, with the `Text` stacked on top and centered.

## Modifiers in SwiftUI

### Modifiers and Layout

- Modifiers, such as `.padding`, return a modified view and can adjust how space is distributed.

```swift
Text("SwiftUI Layout").padding(10)
```

This applies 10 points of padding around the text, adjusting its total size.

### .aspectRatio Modifier

The `.aspectRatio` modifier controls how a view resizes to fit within its available space while maintaining a specified aspect ratio.

```swift
Image(systemName: "photo").aspectRatio(contentMode: .fit)
```

The view returned by `.aspectRatio` can choose to either:
- **.fit**: The content will resize to fit inside the available space while maintaining its aspect ratio.
- **.fill**: The content will expand to fill the entire available space while maintaining its aspect ratio, which may result in some content being cropped.

## GeometryReader

The `GeometryReader` view allows you to access information about the size and position of its parent container.

```swift
var body: some View {
    GeometryReader { geometry in
        Text("Width: \(geometry.size.width), Height: \(geometry.size.height)")
    }
}
```

The `geometry` parameter is a **GeometryProxy**, which provides:
- **size**: The total space offered by the parent container (`CGSize`).
- **frame(in:)**: The view's frame in a specific coordinate space (`CGRect`).
- **safeAreaInsets**: Insets around the safe area (`EdgeInsets`).

### Key Point:

`GeometryReader` itself always accepts all the space offered to it, meaning it will expand to fill the available space. It's particularly useful for adjusting the layout based on the view's size or position within the interface.

### Example of GeometryReader:

```swift
GeometryReader { geometry in
    Text("Available width: \(geometry.size.width), Available height: \(geometry.size.height)")
}
```

In this example, `GeometryReader` provides the width and height of the parent container, allowing the layout to adapt dynamically based on the available space.

## Safe Area

The **safe area** represents portions of the screen where views should not draw content, such as the area around the notch on iPhones or the home indicator.

By default, views are constrained to avoid drawing into the safe area, but this behavior can be overridden using the `.edgesIgnoringSafeArea` modifier.

```swift
ZStack {
    Text("Hello, World!")
}.edgesIgnoringSafeArea([.top])
```

In this example, the `ZStack` content is allowed to extend into the top safe area, overriding the default layout behavior. This can be useful for creating full-screen content or when you want the content to span the entire screen, including areas normally reserved for system elements.

By using `.edgesIgnoringSafeArea`, you can selectively allow content to be drawn into areas that are typically protected by the safe area.

# @ViewBuilder Notes

## Overview
- `@ViewBuilder` is a mechanism in Swift used to enhance a variable to have special functionality.
- It simplifies the syntax for creating **lists of views**.

### How it works:
- Developers can apply `@ViewBuilder` to any function that returns something conforming to `View`.
- The function still returns a `View`, but it interprets the contents as a **list of Views** and combines them into one.

### Example:
```swift
@ViewBuilder
func front(of card: Card) -> some View {
    let shape = RoundedRectangle(cornerRadius: 20)
    shape.fill(.white)
    shape.stroke()
    Text(card.content)
}
```

- The above would return a `TupleView` combining multiple views (e.g., a `RoundedRectangle` and `Text`).
- It would be valid to include simple conditionals (`if-else` or `if let`) to determine which views to include.

### Rules for @ViewBuilder:
- The contents of a `@ViewBuilder` are **just a list of views**. It does not allow arbitrary code.
- You can use **if-else**, **switch**, or **if let** statements to include or exclude views conditionally.
- Local `let` bindings are allowed within the `ViewBuilder`.
- No other types of code are allowed in the function marked with `@ViewBuilder`.

### Key points:
- Developers don't need to worry about how the views are combined, just that `@ViewBuilder` takes care of assembling the views into one.
