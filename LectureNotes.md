# Lecture Notes

# Table of Contents
- [Lecture 1: Introduction to SwiftUI and View Basics](#lecture-1-introduction-to-swiftui-and-view-basics)
- [Lecture 2: MVVM and SwiftUI Essentials](#lecture-2-mvvm-and-swiftui-essentials)
- [Lecture 3: Architecture in Swift (MVVM)](#lecture-3-architecture-in-swift-mvvm)
- [Lecture 4: Memory Game in Swift](#lecture-4-memory-game-in-swift)
- [Lecture 5: Enums and Optionals](#lecture-5-enums-and-optionals)
- [Lecture 6: Layout in SwiftUI](#lecture-6-layout-in-swiftui)
- [Lecture 7: Drawing, Animating, and View Modifiers in SwiftUI](#lecture-7-drawing-animating-and-view-modifiers-in-swiftui)
- [Lecture 8: Property Observers and Animation in Swift](#lecture-8-property-observers-and-animation-in-swift)


# Lecture 1: Introduction to SwiftUI and View Basics
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

# Lecture 2: MVVM and SwiftUI Essentials
* Trailing closures (last argument is a closure).
```swift
ZStack(alignment: .top) {
  Text("Hello")
}
```
* With a `@State` var, SwiftUI will keep note of changes and redraw the UI.
* In a `LazyVGrid` views are only created when SwiftUI needs to display them.

# Lecture 3: Architecture in Swift (MVVM)

## Table of Contents
1. [MVVM: Model-View-ViewModel](#mvvm-model-view-viewmodel)
2. [Connecting the Model to the UI](#connecting-the-model-to-the-ui)
3. [Swift Types](#types-in-swift)
4. [Struct & Class](#struct--class)
   - [Common Features](#common-features-of-structs-and-classes)
   - [Differences](#differences-between-structs-and-classes)
5. [Generics in Swift](#generics-in-swift)
6. [Protocols](#protocols)
7. [Functions as Types](#functions-as-types)
8. [Closures](#closures)
9. [Memory Management: ARC vs Garbage Collection](#memory-management-arc-vs-garbage-collection)

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

## Table of Contents
1. [Model: MemoryGame Struct](#model-memorygame-struct)
2. [Initialization in Swift](#initialization-in-swift)
3. [Trailing Closure Syntax](#trailing-closure-syntax)
4. [Static Variables](#static-variables)
5. [Creating a Memory Game](#creating-a-memory-game)
6. [Property Initializers and Self](#property-initializers-and-self)
7. [Reactive Programming and ObservableObject](#reactive-programming-and-observableobject)
8. [Using @StateObject in SwiftUI](#using-stateobject-in-swiftui)

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

## Table of Contents
1. [Enum](#enum)
   - [Associated Data](#associated-data)
   - [Setting a Value of an Enum](#setting-a-value-of-an-enum)
   - [Checking an Enum's State](#checking-an-enums-state)
   - [break in Switch](#break-in-switch)
   - [default in Switch](#default-in-switch)
   - [Multiple Lines in Switch Cases](#multiple-lines-in-switch-cases)
   - [Accessing Associated Data](#accessing-associated-data)
   - [Methods in Enums](#methods-in-enums)
   - [Getting All Cases of an Enum](#getting-all-cases-of-an-enum)
2. [Optionals](#optionals)
   - [Declaring Optionals](#declaring-optionals)
   - [Accessing the Value of an Optional](#accessing-the-value-of-an-optional)
   - [Nil-Coalescing Operator](#nil-coalescing-operator-)

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

## Table of Contents
1. [Basic Layout Principles](#layout-how-is-space-apportioned-to-views)
2. [HStack and VStack](#layout-hstack-and-vstack)
   - [Stacks Dividing Space](#stacks-dividing-space)
   - [Spacer and Divider](#spacer-and-divider)
   - [layoutPriority](#layoutprioritydouble)
3. [Alignment in Stacks](#alignment-in-hstack-and-vstack)
4. [Lazy Stacks](#lazyhstack-and-lazyvstack)
5. [Grids](#lazyhgrid-and-lazyvgrid)
6. [ScrollView](#scrollview)
7. [ViewThatFits](#viewthatfits)
8. [Advanced Stacks](#advanced-stacks-form-list-outlinegroup-and-disclosuregroup)
9. [Custom Layout Protocol](#custom-implementations-of-the-layout-protocol)
10. [ZStack](#zstack)
11. [Modifiers in SwiftUI](#modifiers-in-swiftui)
    - [Background and Overlay](#background-modifier)
    - [Aspect Ratio](#aspectratio-modifier)
12. [GeometryReader](#geometryreader)
13. [Safe Area](#safe-area)
14. [@ViewBuilder](#viewbuilder-notes)

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

# Lecture 7: Drawing, Animating, and View Modifiers in SwiftUI

## Today’s Agenda

## Table of Contents
1. [Shape in SwiftUI](#shape-in-swiftui)
   - [What is a Shape?](#what-is-a-shape)
   - [Drawing Shapes](#drawing-shapes)
   - [Modifying Shapes](#modifying-shapes)
2. [Creating Custom Shapes](#creating-custom-shapes)
3. [ViewModifier](#viewmodifier)
   - [What is a ViewModifier?](#what-is-a-viewmodifier)
   - [The ViewModifier Protocol](#the-viewmodifier-protocol)
4. [Animation in SwiftUI](#animation-in-swiftui)
5. [Cardify ViewModifier Example](#cardify-viewmodifier)
6. [Protocols in SwiftUI](#protocols-in-swiftui)
7. [Generics and Protocols](#generics--protocols)
8. [The `some` Keyword](#some-keyword)
9. [The `any` Keyword](#any)

---

## Shape in SwiftUI

### What is a Shape?

- **Shape** is a protocol that inherits from `View`.
- In other words, all shapes are also views in SwiftUI.
- Examples of shapes already in SwiftUI include:
  - `RoundedRectangle`
  - `Circle`
  - `Capsule`

### Drawing Shapes

- By default, shapes draw themselves by filling with the current foreground color.
- You can modify this by using `.stroke()` and `.fill()` to change the way the shape is drawn.
- These modifiers return a `View` that draws the shape in the specified way (by stroking or filling).

### Modifying Shapes

- The arguments to `.stroke()` and `.fill()` are quite interesting.
- Initially, it might seem that the argument to `.fill()` is a color (e.g., `Color.white`), but this isn’t always the case.

```swift
func fill<S>(_ whatToFillWith: S) -> View where S: ShapeStyle
```

- This is a **generic function**, and `S` is a placeholder for a type that conforms to the `ShapeStyle` protocol.
- `ShapeStyle` turns a `Shape` into a `View` by applying some styling to it.
- Examples of `ShapeStyle` include:
  - `Color`
  - `ImagePaint`
  - `AngularGradient`
  - `LinearGradient`

---

## Creating Custom Shapes

### How to Create Your Own Shape

- The `Shape` protocol (by extension) implements the `View`'s body var for you.
- However, it introduces its own function that you are required to implement:

```swift
func path(in rect: CGRect) -> Path {
    return Path()
}
```

- In this function, you will create and return a `Path` that draws anything you want.
- The `Path` struct has many functions to support drawing, such as:
  - Lines
  - Arcs
  - Bezier curves
  - etc.

### Example: Timer Countdown Pie

- In our demo, we will add a "timer countdown pie" to our `CardView` (currently without animation).

---

## ViewModifier

- View modifiers in SwiftUI are essentially functions that modify the appearance or behavior of a view.
- Examples include:
  - `foregroundColor`
  - `font`
  - `padding`
  - `frame`
- These modifiers return a modified `View`, allowing you to chain multiple modifiers together in a declarative manner.

---

## Animation in SwiftUI

- Animations in SwiftUI are built by simply adding the `.animation()` modifier to views.
- This tells SwiftUI to animate any changes to the view’s state in a smooth, coordinated fashion.
- **Animation** is crucial for a mobile UI, and SwiftUI makes it very easy to implement.
- One way to perform animations is by animating a **Shape**.
- Another way is by animating **Views** via their **ViewModifiers**.
  
### Animating Shapes

- In the upcoming demo, we will show how to animate a pie-shaped countdown timer by animating a Shape.

---

## ViewModifier in SwiftUI

### What is a ViewModifier?

- You’ve used many functions that modify views (like `aspectRatio` and `padding`).
- These functions likely turn around and call the `.modifier()` function in the View.

Example:

```swift
.aspectRatio(2/3) is likely something like .modifier(AspectModifier(2/3))
```

- **AspectModifier** can be anything that conforms to the **ViewModifier** protocol.

### The ViewModifier Protocol

- The **ViewModifier** protocol has a single function that creates a new View based on the thing passed to it.
  
```swift
protocol ViewModifier {
    func body(content: Content) -> some View {
        return some View that likely contains content
    }
}
```

- When we call `.modifier` on a view, the `content` passed to this function is the view itself.

Example:

```swift
aView.modifier(MyViewModifier(arguments: …))
```

- `MyViewModifier` implements `ViewModifier`, and `aView` will be passed to its body function via the `content`.

---

## Example: Creating a ViewModifier

### Learning by Example

- Let’s say we want to create a modifier that "card-ifies" a view.
- This would take the view and put it on a card-like interface, as seen in the Memorize game.
- This modifier should work with any view, not just our `Text("👻")`.

What would such a ViewModifier look like?

```swift
// Example ViewModifier code
```

In this example, we will create a custom modifier to "card-ify" any view, adding functionality and visual customization to the view in SwiftUI.

---

## Cardify ViewModifier

### Cardify Modifier Example

```swift
Text("👻").modifier(Cardify(isFaceUp: true)) // eventually .cardify(isFaceUp: true)
```

- Here, we apply a custom **Cardify** modifier to a `Text` view.

### Implementing Cardify Modifier

```swift
struct Cardify: ViewModifier {
    var isFaceUp: Bool
    func body(content: Content) -> some View {
        ZStack {
            if isFaceUp {
                RoundedRectangle(cornerRadius: 10).fill(Color.white)
                RoundedRectangle(cornerRadius: 10).stroke()
                content
            } else {
                RoundedRectangle(cornerRadius: 10)
            }
        }
    }
}
```

- **Cardify** is a `ViewModifier` that checks if a card is face-up and then uses a `ZStack` to display either the card content or just a rounded rectangle for the card's back.
- The `ZStack` allows us to layer the views, such as the `RoundedRectangle` for the card shape and the actual content (like the emoji or text).
  
---

## Transitioning to a Custom ViewModifier

### Converting to a Simplified Cardify

```swift
Text("👻").modifier(Cardify(isFaceUp: true))
```

- This can be shortened to:

```swift
Text("👻").cardify(isFaceUp: true)
```

### Implementing as an Extension

```swift
extension View {
    func cardify(isFaceUp: Bool) -> some View {
        return self.modifier(Cardify(isFaceUp: isFaceUp))
    }
}
```

- By using an extension on `View`, we can easily add the `cardify` function to any view without having to manually call `.modifier()` every time.
  
---

## Protocols in SwiftUI

### What is a Protocol Used For?

- One of the most powerful uses of protocols is to facilitate **code sharing**.
- Implementation can be added to a protocol by creating an extension to it.

### Code Example:

```swift
extension ProtocolName {
    // Default implementation for protocol methods
}
```

- This is how Views get modifiers like `foregroundColor` and `font`.
- Functions like `filter` and `firstIndex(where:)` are implemented using protocol extensions.
- Extensions can also add a **default implementation** for functions or properties in the protocol.

### Key Takeaways:

- Adding extensions to protocols is essential for **protocol-oriented programming** in Swift.
- This is how Swift enables code reuse and sharing across multiple types and modules.

---

### What is a Protocol Used For?

- Protocols facilitate **code sharing** by allowing extensions to add implementation.
- Examples:
  - **filter** was added to Array, String, and Range as an extension to the **Sequence** protocol.

```swift
filter(_ isIncluded: (Element) -> Bool) -> Array<Element>
```

- The `filter` function was written once by Apple but works on many types like Array, Range, and more.


---

## View in SwiftUI and Protocols

- In SwiftUI, there’s a protocol similar to the following:

```swift
protocol View {
    var body: some View { get }
}
```

- There’s also an extension that provides various modifiers:

```swift
extension View {
    func foregroundColor(_ color: Color) -> some View { /* implementation */ }
    func font(_ font: Font?) -> some View { /* implementation */ }
    func blur(radius: CGFloat, opaque: Bool) -> some View { /* implementation */ }
    // ...and many more...
}
```

- The first part **constrains** views (e.g., CardView) to provide the required body.
- The second part **adds many modifiers** as benefits for conforming to the protocol.

---

## Generics + Protocols

### Identifiable Protocol

```swift
protocol Identifiable {
    var id: ID { get }
}
```

- Here, `ID` is a **"don't care" type**, meaning any type can be used for `id`.
- Protocols in Swift can be **generic** and declare associated types.

```swift
protocol Identifiable {
    associatedtype ID
    var id: ID { get }
}
```

- This allows any conforming type to provide its own specific type for `id`.

### Example of Generics in Identifiable

- For example, `String` is used as the `ID` type in `MemoryGame.Card`, which conforms to `Identifiable`.
- Since `String` is **Hashable**, we can look up `id`s in hash tables.
- This is why **Hashable** is often combined with **Identifiable**.

```swift
protocol Identifiable {
    associatedtype ID: Hashable
    var id: ID { get }
}
```

---

### Generics + Protocols

- Consider the `Identifiable` protocol:

```swift
protocol Identifiable {
    var id: ID { get }
}
```

- The type `ID` is a "don't care" for `Identifiable`.
- We can enforce that `ID` is `Hashable`:

```swift
protocol Identifiable {
    associatedtype ID: Hashable
    var id: ID { get }
}
```

---

### `some` Keyword

- The `some` keyword is used to pass things opaquely in or out of a function or variable.
- It means that you know the thing conforms to the protocol, but nothing more.

### Example

```swift
var body: some View {
    if viewModel.rounded {
        RoundedRectangle(cornerRadius: 12)
    } else {
        Rectangle()
    }
}
```

- All paths through the curly braces `{ }` must return something of the same type.

---

## `some`

### In (i.e., as a parameter to a function)

We saw a generic function in `Shape`:

```swift
func fill<S>(_ whatToFillWith: S) -> View where S: ShapeStyle
```

This could be simplified as:

```swift
func fill(_ whatToFillWith: some ShapeStyle) -> some View
```

The actual (underlying) type is determined by the caller:

```swift
Circle().fill(ImagePaint(image: Image(systemName: "globe")))
```

#### Example Usage:

```swift
func fillAndStroke(shape: some Shape) -> some View {
    ZStack {
        shape.fill(.white)
        shape.stroke()
    }
}
```

---

## `any`

For simple protocols, you can use the `protocol` keyword like any other type.

Example: `Array<Foo>` for a simple protocol like:

```swift
protocol Foo {
    func bar()
}
```

If you iterate through an `Array<Foo>`, the only thing you can call is `bar()`.

However, for protocols that involve generics (like `Identifiable`), or are self-referential (like `Equatable`), you can’t do this easily.

Swift’s solution to create a heterogeneous array of such things is to use the keyword `any`.

### Example:

```swift
let ids = [any Identifiable]()
```

### To do anything with these ids:

```swift
func printId(of identifiable: some Identifiable) {
    print(identifiable.id)
}
```

---

## Generics and Protocols

### Help!

Some of you might be feeling overwhelmed.

- "How am I going to design systems using generics/protocols?"

#### Good News:

- SwiftUI does a lot of the work for you.
- The more you use it, the more you’ll grasp the concepts.
- Eventually, you’ll master extensions and generics.

You don’t need to be an expert in functional programming to use SwiftUI effectively. Start with the basics, and mastery will come with experience.


### Summary

- Protocols are a powerful way to enable code sharing in SwiftUI.
- `ViewModifier` allows for flexible customization of views.
- Animations are easy to implement and customize.
- Custom shapes allow you to create unique UI elements.



# Lecture 8: Property Observers and Animation in Swift

## Table of Contents
1. [Property Observers](#property-observers)
   - [.onChange(of:)](#onchangeof)
2. [Animation](#animation)
   - [Important Takeaways](#important-takeaways-about-animation)
   - [Implicit Animation](#implicit-animation)
   - [Animation Curve](#animation-curve)
   - [Explicit Animation](#explicit-animation)
   - [Transitions](#transitions)
   - [Matched Geometry Effect](#matched-geometry-effect)
   - [.onAppear](#onappear)
   - [Shape and ViewModifier Animation](#shape-and-viewmodifier-animation)
3. [Demo Examples](#demo-examples)


---

## 1. Property Observers

### Property Observers

Swift is able to detect when a struct changes. Property Observers allow us to take action when this happens. Essentially, they "watch" a variable and execute code when it changes.

The syntax can look a lot like a computed variable, but it's completely unrelated to that:

```swift
var isFaceUp: Bool {
    willSet {
        if newValue {
            startUsingBonusTime()
        } else {
            stopUsingBonusTime()
        }
    }
}
```

- `newValue`: This is a special variable representing the value that is going to be set.
- `didSet`: Another property observer that uses `oldValue`, representing the previous value.

### .onChange(of:) {}

Instead of using a property observer on an `@State` variable, we can use the `.onChange(of:)` view modifier. This detects a change to an `@State` or ViewModel variable:

```swift
@State private var taps = 0

Text("\(taps) taps")
    .onChange(of: viewModel.cards) { newCards in
        taps += 1
    }
```

- `newCards`: This represents the value it is going to be set to.

---

## 2. Animation

### Important Takeaways about Animation

- Only **changes** can be animated.
  - Changes to ViewModifier arguments (including `GeometryEffect` modifiers).
  - Changes to shapes.
  - Transitioning a view from "existing" to "not existing" in the UI.

- **ViewModifiers** are the primary "change agents" in the UI.
  - Changes to a ViewModifier's arguments must happen **after** the view is initially in the UI.
  - Not all ViewModifier arguments are animatable, but most are.
  
- When a view **arrives** or **departs**, the entire thing is animated as a unit.

### Implicit Animation

Implicit animation in Swift allows us to automatically animate views. To enable this, we simply add a `.animation()` modifier to the view:

```swift
Text("💀")
    .opacity(card.scary ? 1 : 0)
    .rotationEffect(Angle.degrees(card.upsideDown ? 180 : 0))
    .animation(Animation.easeInOut, value: card)
```

- **Warning**: The `.animation` modifier does not work like a container. It propagates the `.animation` modifier to all the views it contains.

### Animation Curve

The kind of animation curve we use controls how the animation "plays out":

- `.linear`: Consistent rate throughout.
- `.easeInOut`: Starts slow, speeds up, and then slows down again.
- `.spring`: Provides a "soft landing" or "bounce" effect at the end of the animation.

### Explicit Animation

Explicit animations allow us to create animation transactions where changes are animated together by executing a block of code:

```swift
withAnimation(.linear(duration: 2)) {
    // Do something that will cause view to change
}
```

Explicit animations are often wrapped around calls to **ViewModel Intent Functions**, like:

- Entering or exiting editing mode.

**Note**: Explicit animations do not override implicit animations.

---

## Transitions

**Purpose:** Transitions specify how to animate the **arrival/departure** of Views.
- They work for Views **already on-screen** (containers that are inside CTAOOS - "Containers That Are Already On-Screen").
- Transitions are composed of pairs of ViewModifiers (before and after changes occur).

Example:
- A view fades in on appearance but flies out when it disappears.

### Types of Built-in Transitions
- **`.opacity`:** Uses `.opacity` to fade the `View` in/out.
- **`.scale`:** Uses `.frame` to expand/shrink the `View`.
- **`.offset`:** Moves the `View` using an offset.
- **`.modifier(active:identity:)`:** You provide the two ViewModifiers to use.

---

### Specifying Transitions
Use `.transition()` to specify which kind of transition to use when a View arrives/departs.

Example:
```swift
ZStack {
  if isFaceUp {
    RoundedRectangle(cornerRadius: 10)
      .stroke()
    Text("💀")
      .transition(AnyTransition.scale)
  } else {
    RoundedRectangle(cornerRadius: 10)
      .transition(AnyTransition.identity)
  }
}
```

In this example:
- If `isFaceUp` changes, the front RoundedRectangle fades in and the text grows in.
- Unlike `.animation()`, `.transition()` only works for the **entire ZStack** (or its content).
- It **does not** get redistributed to a container’s content Views.
- **Group** and **ForEach** distribute `.transition()` to their child views.

### Setting Animation Details for a Transition
To set an animation (curve/duration/etc.) for a transition, use the `.animation` method of `AnyTransition` structs.

Example:
```swift
.transition(AnyTransition.opacity.animation(.linear(duration: 20)))
```

---

## Important Takeaways About Animation
- Only **changes** can be animated:
  - **ViewModifier arguments**
  - **Shapes**
  - **View transition from existing to non-existing** (or vice versa).
  
- **Animation** shows the user changes that have already happened.
  
**ViewModifiers** are the primary "change agents" in the UI.
- Changes to a ViewModifier’s arguments can only happen **after** the `View` is added to the UI.
- Only changes since a View joined the UI can be animated.

## Matched Geometry Effect

- Sometimes you want a `View` to move from one place on the screen to another, and possibly resize along the way.
- If the `View` is moving to a new place in its same container, this is no problem (like shuffle).
- "Moving" like this is just animating the `.position` `ViewModifier` arguments.
  - `.position` is what `HStack`, `LazyVGrid`, etc., use to position the Views inside them.
  - This kind of thing happens automatically when you explicitly animate.

- But what if the `View` is "moving" from **one container to a different container**?
  - This is not really possible.
  
- Instead, you need a `View` in the **source** position and a different one in the **destination** position.
  - Then you must "match" their geometries up as one leaves the UI and the other arrives.

- So, this is similar to `.transition` in that it is animating `Views` coming and going in the UI. 
  - It's just that it's particular to the case where a **pair** of `Views` arrivals/departures are synced.

## Example - Dealing Cards off of a Deck

- A great example of this would be "dealing cards off of a deck".
  - The "deck" might well be its own `View` off to the side.
  - When a card is "dealt" from the deck, it needs to fly from there to the game.
  - But the deck and game's main `View` are not in the same `LazyVGrid` or anything.

- How do we handle this?

### Marking Views

- We mark both `Views` using this `ViewModifier`:
```swift
.matchedGeometryEffect(id: ID, in: Namespace) // ID type is a "don't care": Hashable
```

- Declare the Namespace as a private var in your `View` like this:
```swift
@Namespace private var myNamespace
```

### Controlling Views

- Now write code so that **only one** of the 2 `Views` is ever included in the UI at the same time.
  - You can do this with `if-else` in a `ViewBuilder` or maybe via `ForEach`.
  
- Now, when one of the pair leaves and the other arrives at the same time, their size and position will be synced up and animated.

- It's possible to match geometries when both `Views` are on screen too.

---

## .onAppear

- Remember that animations only work on `Views` that are in `CTAAOS` (Containers That Are Already On-Screen).
  
### Kicking Off Animation on Appear

- How can you kick off an animation as soon as a `View's` Container arrives on-screen?
  - `View` has a nice function called `.onAppear {}`.
    - It executes a closure anytime a `View` appears on screen.

- Since, by definition, a `View` is on-screen when its own `.onAppear {}` is happening, it is in a `CTAAOS`, so any animations for it or its children that are appearing can fire.

### Using withAnimation Inside onAppear

- We'll use `.onAppear {}` to kick off a couple of animations in the demo this week, especially ones that only make sense when a certain `View` is visible (e.g., our flying score).

---

## Shape and ViewModifier Animation

- The communication with the animation system happens (both ways) with a single var.
  - This var is the only thing in the `Animatable` protocol.

### Implementing the Protocol

- Shapes and `ViewModifiers` that want to be animatable must implement this protocol:
```swift
var animatableData: Type
```

- `Type` is a "don't care". Well... it's a "care a little bit".
  - `Type` has to implement the protocol `VectorArithmetic`.
    - That's because it has to be able to be broken up into little pieces on an animation curve.

- `Type` is very often a floating point number (`Float`, `Double`, `CGFloat`).

- But there's another struct that implements `VectorArithmetic` called `AnimatablePair`.
  - `AnimatablePair` combines two `VectorArithmetics` into one `VectorArithmetic`.

- Of course, you can have `AnimatablePairs` of `AnimatablePairs`, so you can animate all you want.

---

## Shape and ViewModifier Animation

The communication with the animation system happens (both ways) with a single variable. 
This var is the only thing in the `Animatable` protocol.

- Shapes and ViewModifiers that want to be animatable must implement this protocol.

```swift
var animatableData: Type
```

- `Type` is a don’t care. Well… it’s a “care a little bit.”
- `Type` has to implement the protocol `VectorArithmetic` because it has to be broken up into little pieces on an animation curve.

### Example of `Type`
- Type is often a floating point number (Float, Double, CGFloat).
- Another struct that implements `VectorArithmetic` is `AnimatablePair`.
- `AnimatablePair` combines two `VectorArithmetic` into one `VectorArithmetic`.

With `AnimatablePairs`, you can animate as much as you want!

## Animation Communication

Because it’s communicating both ways, this `animatableData` is a **read-write** variable.

- The **setting** of this var is the animation system telling the Shape/VM which "piece" to draw.
- The **getting** of this var is the animation system getting the start/end points of an animation.

This is often a computed var (but doesn’t have to be).

- We might not want to use the name `animatableData` in our Shape/VM code, instead using more descriptive variable names.
- The `get/set` often just gets/sets other variables, essentially exposing them to the animation system with a different name.

---

## 3. Demo Examples

### Demo 1: Explicit Animation (Shuffling and Choosing Cards)
- Demonstrates shuffling and selecting cards with explicit animations.

### Demo 2: Implicit Animation (Celebrating a Match!)
- An example of celebrating a match with implicit animations.

### Demo 3: Animatable ViewModifier (Flipping Cards)
- Shows how to create custom view modifiers for flipping cards.

### Demo 4: Suppressing Unwanted Animation
- How to suppress unwanted animations using `.animation(nil)`.

### Demo 5: onAppear Animation (Score Indications)
- Demonstrates animating score changes with property observers and tuples.

---
