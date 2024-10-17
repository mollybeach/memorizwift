# Lecture Notes
## Lecture 3 Architecture

# MVVM
- Design Paradigm

# Model and UI
## Seperating "Logic and Data" from "UI"
- SwiftUI is very serious about the seperation of application logic & data from UI
- We call this logic and data our "Model"
- It could be a struct or an sql database or some machine learning code or REST API from the internet or many other things Or any combination of these things
- The UI is basically just a "parametizable" shell that the Model feeds and brings to life Think of the UI as a visual representation of the Model
- The model is where things like isFaceUp and cardCount would live (not in @State in the UI)
- Swift takes care of making sure the UI gets rebuilt when a Model change affects the UI

## Connecting the Model to the UI
- There are some choices about how to connect the Model to the UI...
    1. Rarely, the Model could just be a @State in a View (this is minimal to no seperation)
    2. The Model might only be accessible via a gatekeeper "ViewModel" class (full seperation)
    3. There is a View Model class, but the Model is still directly accessible (partial seperation)
- Mostly the choice depends on the complexity of the Model...
- A Model that is made up of SQL + struct(s) + something else will likely opt for #2
- A Model that is just a simple piece of data and little to no logic will likely opt for #1
- Something in-between might opt for #3
- Just always do #2 for now, it's the best choice for most things
- We're going to talk about now #2 (full seperation)
- We call this architecture that connects the Model to the UI in this way "MVVM"
- MVVM stands for Model-View-ViewModel
- This is the primary architecture for any reasonably complex SwiftUI application
- You'll also quickly see how #3 (partial seperation) is just a minor tweak to MVVM

## MVVM Diagram

![MVVM Diagram](Memorizwift/Assets.xcassets/Image.imageset/MVVM.png)

# Varieties of Types

- Struct
- Class
- Protocol
- Generics "don't care type"
- enum
- functions 

## Struct & Class 
### Both Struct & Class are have:
... pretty much the same syntax

### Stored vars:
    - computed vars (i.e. those whose value is the result of evaluating some code)
    - constant lets (i.e., vars whos values never change)
``` swift
let defaultColor = Color.orange
CardView().foregroundColor(defaultColor)
```

### Functions:
``` swift
func multiply(operand: Int, by: Int) -> Int {
    return operand * by
}
multiply(operand: 5, by: 6)

//Functions can an external and internal name:

func multiply(_ operand: Int, by otherOperand: Int) -> Int {
    return operand * otherOperand
}
multiply(5, by: 6)

//"_" is the external name, "by" is the external name
// "operand" and "otherOperand" are the internal name
// Callers use the external name
```

### Initializers
    - Special functions that are called when creating a struct or class

``` swift
struct RoundedRectangle {
    init(cornerRadius: CGFloat) {
        // initialize this rectangle with a corner radius
    }
    init(cornerSize: CGSize) {
        // initialize this rectangle with a corner size
    }
}

// In the Demo

struct MemoryGame {
    init(numberOfPairsOfCards: Int) {
        // Create a Game with that many pairs of cards
    }
}
```

- 99% of the time, you'll use structs
- The Only time we will use classes is that ViewModel 

## Difference between Struct & Class

### Struct
- Value Type (Storage for value is right there)
- Copied when passed or assigned
- Copied on write ( When someone modifies it, it makes a copy of it )
- Stored in memory on the stack
- Functional Programming (Functionality Encapsulation how it behaves)
- No Inheritance
- "Free" init initializes ALL vars
- Mutability is explicit (var or let)
- Your "go to" data structure
- Everything you've seen so far is a struct (Except View which is a protocol)

### Class
- Reference Type (20 pieces of code all point to the same thing)
- Passed around via pointers 
- Automatically reference counting (In alot of languges you do garbage collection what is garbage collection, but in Swift it's reference counting it keeps track of how many things are pointing to a chunk of memory and when it gets down to zero it frees it)
- Object Oriented Programming (Data Encapsulation)
- Inheritance (single)
- "Free" init initializes NO vars 
- Always mutatable (Dangerous)
- Used in special circumstances
- ViewModel is MVVM is always a class (also, UIKit (old style iOS) is class-based)


# Generics
- Sometimes we just don't care 
- We may want to manipulate data structures in a generic way that are "type agnostic"
In other words we don't know what type something is and we don't care
- But Swift is a strongly typed language so we don't use variables and such that are "untyped"
- The Wider of a Scope you put the generic the better 
## Array
- An array is a bunch of things and it doesn't care what type they are
- But inside Array's code it has to have variables for the things it contains 
- They need types for the arguments to Array functions that do things like adding items to it 

``` swift
struct Array<Element> {
    func append(_ element: Element)
}
// The type of the arugment to append is Element a Generic Type 
```
- Array's implementation of append knows nothing about that argument and does not care 
- Element is a not any known struct or or class or protocol it's just a placeholder for a type 

### The Code for using an Array looks like this
``` swift
var names = Array<String>()
names.append("Molly")
names.append("Jake")
```
-When someone uses Array that's when Element gets determined (by Array<String> or Array<Int> etc).

### Type Parameter 
- A generic type parameter is a placeholder for a type
- Element is a generic type parameter
- Array<Element> is a generic type
- Array<String> is a generic type
- Array<Int> is a generic type
- Array<Array<Int>> is a generic type
- Array<Array<Array<Int>>> is a generic type
- Array<Array<Array<Array<Int>>>> is a generic type

### Generic Functions
- A generic function is a function that takes generic type parameters
- Example:
``` swift
func printElement(_ element: Element) {
    print(element)
}
```
# Protocol
- A protocol is sort of a "stripped down" struct or class
- It hsa functions and vars but no implementation

- A type that a value must have
- A protocol is a set of requirements
- Example:
``` swift
protocol Movable {
    func move(by: Int)
    var hasMoved: Bool { get }
    var distanceFromStart: Int { get }
}
```

- See? No implementation
- The {} on the vars just say whether is a read only var or a var that can be set
- Any typ can now claim to implement Moveable 
``` swift
struct PortableThing: Movable {
    // Must implement move(by:), hasMoved, and distanceFromStart here
    var hasMoved: Bool
    var distanceFromStart: Int
    func move(by: Int) {
        // implementation
    }
}
// Portable thing now conforms to (aka "behaves like a") Movable
// ... it's also legal (this is called "protocol inheritance") 

protocol Vehicle: Movable {
    var passengerCount: Int { get set }
}
class Car: Vehicle {
    //must implement move(by:), hasMoved, distanceFromStart, and passengerCount here
}
// implements Multiple Protocols
class Car: Vehicle, Impoundable, Leaseable {
    //must implement move(by:), hasMoved, distanceFromStart, passengerCount
    // must implement any func/vars in Impoundable and Leaseable here too
}
```
## What do we use Protocols for?
- Protocol is a type
- It can be used in the normal places you might see a type with certain restrictions 
- especially with the addition with some and any
- For Example it can be the type of a var or a return type (like a var body's return type)
- Specifying a protocol the behavior of a struct, class or enum
struct ContentView: View 
- just by doing this ContentView becomes a very powerful struct!
- Of course ContentView did have to implement var body to particpate in being a View, but still
- We call this process "constrains and gain"
- A protocol can constrain another type (ex: a View has to implement var body)
- We're going to see a Variety of protocols in the coming weeks 
- Ex: Identifiable, Hashable, Equatable, CustomStringConvertible
- And more specialized ones like: Animatable
- Protocols turning "don't cares" into "somewhat cares"
``` swift
struct Array<Element> where Element: Equatable 
// This means you could only put things into the array that u could do == on
```
- If Array was declared like this, then the only things that are Equatable can be in the array
- This is the heart of "protocol oriented programming"
- A protocol becomes massively more powerful via something called an extension 
- Using protocols as types some and any keywords help us do that 

## Functions as Types 
- You can declares a variable ( or parameter to a func or whatever) to be a function type
- This syntax for this includes the type of the argument and the type of the return value
- You can do this anywhere any other type is allowed
- Example:
``` swift
(Int, Int) -> Bool // takes two Ints and returns a Bool
(Double) -> Void // takes a Double and returns nothing
() -> Array<String> // takes no arguments returns an Array of Strings
// All of the above are just types 
// No different than Bool or View or Array<Int>. All are types 

var foo: (Double) -> Void // foo's types: "Function that takes a Double and returns nothing"
func doSomething(what: () -> Bool) // what's type: "Function that takes no arguments and returns a Bool"

```
### Functions are Types 
``` swift
var operations: (Double) -> Double 
// This is a var called operation: It's type is a function that takes a Double and returns a Double

// Here's Simple function that takes a double and returns a double
func square(operand: Double) -> Double {
    return operand * operand
}
// This is a function that takes a double and returns a double
// So it matches the type of operations
// Therefore we can do this:
operations = square // just assigning a value to the operation var, nothing more
let result1 = operation(4) // result1 is 16
// Note that we don't use argument labels (eg. operand) when executing function types
operation = sqrt // sqrt is a built in function that takes a double and returns a double
let result2 = operation(4) // result2 is 2
```

## Closues 
- We also call them inline functions or lambdas
- It's so common to pass functions around that we are very often "inlining" them
- We've already used this alot (@ViewBuilders are closures, so is on onTapGesture's action)
- We'll peel back the layers on this in the demo and again in the quarter 


Garbage collection is basically when you have a reference to a class that say you have variable X equals this class let's say nothing else is pointing to that class right just that variable nothing is using. Nothing is you know nothing is like a sign to it other than the class. At random, the system will decide it's time to look at all of the references in the entire in the entire project and anything that's not being used get rid of it. Get rid of any class that doesn't have something pointing to it. Get rid of any thing that's not in use however the difference between garbage collection and like automatic reference counting or manual memory management is that this happens at random the system will randomly go. OK there's not a lot of work happening. It's time to clear out the memory or there is a lot of work happening we need this memory. Let's go kill a reference to everything that isn't in active use. So that's basically what garbage collection is it just a computer sign deciding OK we need to now free up this memory and we do so by looking at all of the references to all the classes and all the variables and if no one's using it, kill it and get rid of it and then we have more memory

So it's actually a language specific feature so like in Java there's something called the Java virtual machine that executes Java it's a feature of basically the compiler so The compiler for swift is called LLDB low-level shit LLDB but that's the thing that you can type commands in and get like specific output in the console of Xcode, but It's a specific feature it's not like I guess I mean it is a program but don't it's not like an app you know what I mean like it's it's the compiler like how V8 is that whatever the engine for JavaScript do you know what I mean for web stuff

Swift uses a different method of memory management called ARC automatic reference counting basically if you have a pointer pointing to something then it will stay in memory and then when the pointers no longer pointing to it then everything is then it's it's killed the memory that hold it is killed And that's a very efficient form of memory


# Lecture 4 
import Foundation

// Model
struct MemoryGame<CardContent> {
    private(set) var cards : Array<Card>
    
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent){
        // you job inside ur init is to initalize all ur vars
        cards = [] // this is a literal array we did it with our emojis
        // add numberOfPairsOfCards x 2 cards
        // remove pairIndex replace with _ cuz we dont use pair index in the for loop
        for pairIndex in 0 ..< max(2, numberOfPairsOfCards) {
            let content = cardContentFactory(pairIndex)
            // free initalizer cuz im a struct
            cards.append(Card(content: content))
            cards.append(Card(content: content))
        }
    }
    
    func choose(_ card: Card){
        
    }
    //Cannot use mutating member on immutable value: 'self' is immutable
    // Any function that modifies the model has to be marked mutating
    mutating func shuffle(){
        cards.shuffle()
        print(cards)
        
    }
    
    struct Card {
        var isFaceUp = true
        var isMatched = false
        let content: CardContent
        
    }
    
}
    // We never had any init intializer for our CardView. Classes did the same thing but
    // their initializers have no arguments so they only work if all of your variables
    // have no arguments it only works all your variables have default values and we have a
    // variable right here model that has no value so that's why it's saying
    // "i cant give you the free initializer here because you have some unitialized value
    //since you have some unitialized variables so u have no intitalizers plesae "give me one" it's saying
    // so i could give it an init and we're going to see init her ein a second here in our model but instead im going
    // to try to give this
    //private var model: MemoryGame<String> as value
    //private var model: MemoryGame<String> = MemoryGame<String> () with no arguments possibly
    // can i do that no because there's  a missing argument cards okay MemoryGame<String> is a struct
    //it's free initalizer lets me initialize all of the variables and if i go back here and look at
    // at my model it's going an unitialized variable which the cards the cards of array
    // from MemoryGame.swift :   private(set) var cards : Array<Card> <-
    // You've got to provide those cards:
    //  private var model: MemoryGame<String>(cards: <- this makes no sense for cards to be the argument
    // so this is where intializers come in what does make sense is numberOfPairsOfCards: 4)
    // ->   private var model: MemoryGame<String> = MemoryGame<String>(numberOfPairsOfCards: 4)
    // we're going to have to create an init in MemoryGame.swift
    
    // closure
    // if the last argument is to a function or a creation what can we do with it ? throw it on the outside closure syntax
    // trailing closure take closure out of parenthessis
    /*
     for example :
     performOperation(numbers: [1, 2, 3], operation: { (nums) in
         print(nums)
     })
     to this :
     performOperation(numbers: [1, 2, 3]) { (nums) in
         print(nums)
     }
     explaination: { (nums) in print(nums) } is not longer surrounded by ()
     
     if i were to replace index with $0 $0 is a special name okay $0 means first argument i could have $1
         let emojis =  ["👻", "🐮", "🍓", "🫐", "👀", "🐶", "🐱", "🦊", "🐻", "🦁", "🐸", "🐧", "🐢", "🐙", "🐝", "🐼", "🦄"]

     you cant put variables before intializers in a class because you ont know whether emojis will be read yet to be able call it in the initializer 
     
     you could make it global but everyone in this class knows we dont use gloabl variables
     
     the solution is to add it back in to the class but add the word static to the front what it means is make emojis global
     but namespace it inside of my class
     
     static let emojis =  ["👻", "🐮", "🍓", "🫐", "👀", "🐶", "🐱", "🦊", "🐻", "🦁", "🐸", "🐧", "🐢", "🐙", "🐝", "🐼", "🦄"]
     to call this you say EmojiMemoryGame.emojis[pairIndex]
     
     and you can also add the word private now it's a private global variable only for us to use 
     but another cool feature not really type inference but swift if youre doing a property intializer like these and you use one of these namespace globals you dont have to put the extra thing EmojiMemoryGame.emojis[pairIndex]
     
    it will figure it out you can just put emojis[pairIndex]
    
        // what if i want to make a lil function to create my model
    private var model = createMemoryGame()
    func createMemoryGame(){
        
        return MemoryGame(numberOfPairsOfCards: 4 ) { pairIndex in
            return EmojiMemoryGame[pairIndex]
        }
    }
 
    Cannot use instance member 'createMemoryGame' within property initializer; property initializers run before 'self' is available
        cant use a function before i can intialize my class 
        how do we fix that also with static
            func createMemoryGame(){
        
        static return MemoryGame(numberOfPairsOfCards: 4 ) { pairIndex in
            return EmojiMemoryGame[pairIndex]
        }
    }
    
    return types can never be infered in swift
    
        static let emojis =  ["👻", "🐮", "🍓", "🫐", "👀", "🐶", "🐱", "🦊", "🐻", "🦁", "🐸", "🐧", "🐢", "🐙", "🐝", "🐼", "🦄"]
    
    // what if i want to make a lil function to create my model
   // i would like to put my statics at the top they're global to my entire thing so i want them to be listed first 
    
    private static func createMemoryGame() -> MemoryGame<String>{
        return MemoryGame(numberOfPairsOfCards: 4 ) { pairIndex in
            return  emojis[pairIndex]
        }
    }
    
    private var model = createMemoryGame()
    
    var cards: Array<MemoryGame<String>.Card>{
        return model.cards
    }
    func choose(_ card: MemoryGame<String>.Card){
        model.choose(card)
    }
}
    When we say "some View" for the Var body it's not inferrring its actually looking in there and setting it to be that 
             // .purple is actually Color.purple this is type color it's a truct and .purple is just a non private
        // static var
        // option click thats how u can see the documentation
        .foregroundColor(Color.purple)
        
            //Cannot use mutating member on immutable value: 'self' is immutable
    // Any function that modifies the model has to be marked mutating
    mutating func shuffle(){
        cards.shuffle()
    }
        // We have to get our view model reactive so that the cards shuffle so that something changes we do that by implementing
// the protocol: Observable object
class EmojiMemoryGame : ObservableObject {
    static let emojis =  ["👻", "🐮", "🍓", "🫐", "👀", "🐶", "🐱", "🦊", "🐻", "🦁", "🐸", "🐧", "🐢", "🐙", "🐝", "🐼", "🦄"]
        // if you put published @Published on a var that if this var changes it will say something changed
    @Published private var model = createMemoryGame()
    
    
    
    // instead of the equal sign at the bottom in the preview pass the view model to content view 
    struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: EmojiMemoryGame())
    }
}
also change it in your app : //
// so apps like views can have @StateObjects
// somewhere there needs to be @State
import SwiftUI

@main
struct MemorizwiftApp: App {
    @StateObject var game = EmojiMemoryGame
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: game)
        }
    }
}



     */


# Lecture 5

## enum

- another variety of data structure in addition to struct and class 
- it can only have discrete status 
```
enum FastFoodMenuItem {
    case hamburger
    case fries
    case drink
    case cookie
}
```
- an enum is a value type (like struct), so its is copied and passed around

### Associated Data
- Each state can (but does not have to have it's own 'associated data')
```
enum FastFoodMenuItem {
    case hamburger(numberOfPatties: Int)
    case fries (size: FryOrderSize)
    case drink (String, ounces: Int)
    case cookie
}
```
- Note that the drink case has 2 pieces of associated data (one of them "unnamed)
- In the example above, FryOrderSize would also probably be an enum for example...
```
enum FryOrderSize {
    case large
    case small
}
```
### Setting a value of enum 
- Just use the name of the type along with the case you want seperated by a dot...
```
let menuItem: FastFooMenuItem = FastFoodMenuItem.hamburger(patties:2)
var otherItem: FastFooMenuItem = FastFoodMenuItem.cookie
var yetAnotherItem = .cookie // swift can't figure this out

### Checking an enum's state
An enum's state is usually checked with a switch statement ...
(although we could use an if statement, but this is unusual if there is associated data)

```
var menuItem = FastFoodMenuItem.hamburger(patties: 2)

switch menuItem {
case FastFoodMenuItem.hamburger: print ("burger")
case FastFoodMenuItem.fries: print("fries")
case FastFoodMenuItem.drink: print ("drink")
case FastFoodMenuItem.cookie: print ("cookie")
}
```
Note that we are ignoring the "associated data" above ... so far ...

It is not necessary to use the fully-expressed FastFoodMenuItem.fries inside the switch
(since Swift can infer the FastFoodMenuItem part of that) 

### break

If you don't want to do something with a given case use break

```
var menuItem = FastFoodMenuItem.hamburger(patties: 2)

switch menuItem {
case .hamburger break
case .fries: print("fries")
case .drink: print ("drink")
case .cookie: print ("cookie")
}
```
This code would print nothing to the console

### default
A switch must handle all possible cases (although you can default uninteresting cases) ...

```
var menuItem = FastFoodMenuItem.cookie

switch menuItem {
case .hamburger: break 
case .fries: print ("fries")
default: print ("other")
}

If the menuItem was a cookie, the above item would print "other" on the console

You can switch on any type (not just enum), by the way, for example ...
```
let s: String = "hello"

switch {
case "goodbye": ... 
case "hello": ...
default: ... // gotta have this for String because switch has to cover ALL cases
｝
```

### Multiple lines allowed
Each case in a switch can be multiple lines and does NOT fall through to the next case ...

```
var menuItem = FastFoodMenuItem.fries(size: FryOrderSize.large)

switch menuItem {
    case .hamburger: print("burger")
    case .fries:
        print ("yummy") 
        print ("fries")
    case .drink:
        print ("drink")
    case .cookie: print ("cookie")
}
```
The above code would print "yummy" and "fries" on the console, but not "drink" 
If you put the keyword fallthrough as the last line of a case, it will fall through.

What about the associated data? Associated data is accessed through a switch statement using this let syntax …

```
var menuItem = FastFoodMenuItem.drink("Coke", ounces: 32)

switch menuItem {
    case .hamburger(let pattyCount): print("a burger with \(pattyCount) patties!")
    case .fries(let size): print("a \(size) order of fries!")
    case .drink(let brand, let ounces): print("a \(ounces)oz \(brand)")
    case .cookie: print("a cookie!")
}

```

The above code would print a "a 32oz Coke on the console"
Note that the local vairables retrieves the associate data that can have a different name 
(e.g. pattyCount above versus not even having a name in the enum declaration)

### Methods yes, (stored) Properties no
An enum can have methods (and computed properties) but no stored properties …

```
enum FastFoodMenuItem {
    case hamburger(numberOfPatties: Int)
    case fries(size: FryOrderSize)
    case drink(String, ounces: Int)
    case cookie

    func isIncludedInSpecialOrder(number: Int) -> Bool { }
    var calories: Int { 
        // switch on self and calculate caloric value here
    }
}
```
An enum's state is entirely which case it is in and that case’s associated data, nothing more.


### Methods yes, (stored) Properties no
An enum can have methods (and computed properties) but no stored properties …

```
enum FastFoodMenuItem {
    case hamburger(numberOfPatties: Int)
    case fries(size: FryOrderSize)
    case drink(String, ounces: Int)
    case cookie

    func isIncludedInSpecialOrder(number: Int) -> Bool { }
    var calories: Int { 
        // switch on self and calculate caloric value here
    }
}
```

An enum's state is entirely which case it is in and that case’s associated data, nothing more.

Metho ds yes, (stored) Properties no
In an enum's own methods, you can test the enum's state (and get associated data) using self ...

```
enum FastFoodMenuItem {
...
    func isIncludedInSpecialOrder(number: Int) → Bool {
        switch self {
            case .hamburger(let pattyCount): return pattyCount == number
            case .fries, .cookie: return true // a drink and cookie in every special order
            case .drink(_, let ounces): return ounces = 16 // & 16oz drink of any kind
        }
    }
}

```

Special order 1 is a single patty burger, 2 is double patty (3 is a triple etc)  

Geting all the cases of an enumeration
```
enum TeslaModel: CaseIterable {
    case X
    case S
    case Three
    case Y
}
```
Now this enum will have a static var allCases that you can iterate over.

for model in TeslaModel.allCases {
    reportSalesNumbers(for: model)
}

func reportSalesNumbers(for model: TeslaModel){
    switch model { 
        //...
    }
}

# Optionals

An Optional is just an enum. Period, nothing more.

It essentially looks like this …
```
enum Optional<T> { // a generic type, like Array<Element> or MemoryGame<CardContent>
    case none
    case some(T) // the some case has associated value of type T
}
```
You can see that it can only have two values: is set (some) or not set (none).
In the is set case, it can have some associated value tagging along (of "don’t care type" T).

Where do we use Optional?
Any time we have a value that can sometimes be "not set" or "unspecified" or "undetermined."
This happens surprisingly often.

That’s why Swift introduces a lot of "syntactic sugar" to make it easy to use Optionals …

Declaring something of type Optional<T> can be done with the syntax T?
```
enum Optional<T> {
    case none
    case some(<T>)
}
```
var hello: String?
var hello: String? = "hello"
var hello: String? = nil

var hello: Optional<String> = .none
var hello: Optional<String> = .some("hello")
var hello: Optional<String> = .none


Declaring something of type Optional<T> can be done with the syntax T?

You can then assign it the value nil (Optional.none).

Or you can assign it something of the type T (Optional.some with associated value = that value).

Note that Optionals always start out with an implicit = nil.

```
enum Optional<T> {
    case none
    case some(<T>)
}

var hello: String?
var hello: String? = "hello"
var hello: String? = nil

var hello: Optional<String> = .none
var hello: Optional<String> = .some("hello")
var hello: Optional<String> = .none
```
Optionals

You can access the associated value either by force (with !)...

```
enum Optional<T> {
    case none
    case some(<T>)
}

let hello: String? = ...
print(hello!)

switch hello {
    case .none: // raise an exception (crash)
    case .some(let data): print(data)
}
```
Optionals

You can access the associated value either by force (with !) ...
Or "safely" using if let and then using the safely-gotten associated value in { } (else allowed too).

```
enum Optional<T> {
    case none
    case some(<T>)
}

let hello: String? = ...
print(hello!)

switch hello {
    case .none: // raise an exception (crash)
    case .some(let data): print(data)
}

if let safehello = hello {
    print(safehello)
} else {
    // do something else
}

switch hello {
    case .none: { // do something else }
    case .some(let safehello): print(safehello)
}
```
Optionals

There's also ?? which does "Optional defaulting". It's called the "nil-coalescing operator".

enum Optional<T> {
    case none
    case some(<T>)
}

let x: String? = ...
let y = x ?? "foo"

switch x {
    case .none: y = "foo"
    case .some(let data): y = data
}


The slide explains how the space on-screen is apportioned to the views in SwiftUI. Here's the information presented:

Layout
How is the space on-screen apportioned to the Views?

It's amazingly simple ...

Container Views “offer” some or all of the space offered to them to the Views inside them.
Views then choose what size they want to be (they are the only ones who can do so).
Container Views then position the Views inside of them.
This describes the basic flow of layout in SwiftUI where container views manage space distribution and views decide their own size preferences. Let me know if you'd like more details on this topic!

Layout: HStack and VStack
Stacks divide up the space that is offered to them and then offer that to the Views inside.
The stack offers space to its “least flexible” (with respect to sizing) subviews first.
Examples:
Inflexible View: Image (it wants to be a fixed size).

Slightly more flexible View: Text (always wants to size exactly to fit its text).

Very flexible View: RoundedRectangle (always uses any space offered).

Once an offered View(s) takes what it wants, its size is removed from the space available.

The stack then moves on to the next “least flexible” Views.

Very flexible views (i.e., those that will take all offered space) will share evenly (mostly).

Rinse and repeat.

After the Views inside the stack choose their own sizes, the stack sizes itself to fit them.
If any of the Views in the stack are “very flexible,” then the stack will also be “very flexible.”
This provides a detailed explanation of how SwiftUI stacks allocate space, prioritize subviews based on flexibility, and adapt their own size accordingly. Let me know if you need further details or examples!


The slide provides details about some useful views (Spacer and Divider) in SwiftUI that are commonly used in HStack and VStack. Here's the information:

Layout: HStack and VStack
There are a couple of really valuable Views for layout that are commonly put in stacks:

Spacer(minLength: CGFloat)

Always takes all the space offered to it.
Draws nothing.
The minLength defaults to the most likely spacing you’d want on a given platform.
Divider()

Draws a dividing line cross-wise to the way the stack is laying out.
For example, in an HStack, Divider draws a vertical line.
Takes the minimum space needed to fit the line in the direction the stack is going.
Takes all the space offered to it in the other (cross-wise) direction.
These views are essential for creating flexible and visually organized layouts in SwiftUI. Let me know if you have any more questions!
Layout: HStack and VStack
layoutPriority(Double) can override which views get space first, regardless of their flexibility. By default, all views have a layout priority of 0.
Example:
```
HStack {
    Text("Important").layoutPriority(10)  // Higher priority
    Image(systemName: "arrow.up")  // Default priority (0)
    Text("Unimportant")
}
```
The Text("Important") will get the space it needs first, due to its higher layout priority.
Then, the Image will get its space because it is less flexible than the Text("Unimportant").
Finally, the Text("Unimportant") will fit into any remaining space, and if it doesn't get enough space, it may get truncated (e.g., "Swift is..." instead of "Swift is great!").
This shows how layoutPriority gives control over space distribution when laying out views in SwiftUI.

Layout: HStack and VStack
Another crucial aspect of how stacks arrange the views they contain is alignment.

When a VStack lays out views in a column, how are the views aligned if they have different widths? Are they left-aligned, centered, or something else?

Alignment is specified through an argument to the stack, for example:

```
VStack(alignment: .leading) { ... }
```
Why .leading instead of .left?
Stacks adjust automatically for environments where text is laid out from right to left (such as Arabic or Hebrew).

The .leading alignment positions the views relative to the start of the text flow.

Text baselines can also be used for alignment:

```
HStack(alignment: .firstTextBaseline) { ... }
```

You can even define your own alignment guides, but this is beyond the scope of this course.

SwiftUI provides built-in alignment options like text baselines, center, top, trailing, etc., for positioning views flexibly.
LazyHStack and LazyVStack
These "lazy" stacks don’t build any of their views that are not currently visible.
They do not take up all the space offered, even if they have flexible views inside.
Use case: Ideal when the stack is within a ScrollView.
LazyHGrid and LazyVGrid
These grids size their views based on the configuration (e.g., the columns argument in a grid).
The other direction (opposite to the grid’s axis) can grow and shrink as more views are added.
Efficiency: The grid does not take all the space if it doesn’t need it.
Grid
A general grid that allocates space to its views both horizontally and vertically (no "H" or "V" in its name).
Offers various alignment options for columns and rows via grid*() modifiers.
Use case: Often used as a "spreadsheet" view or for displaying tabular data.

ScrollView
ScrollView takes all the space offered to it.
The views inside are sized to fit along the axis of scrolling.
ViewThatFits
Takes a list of container views (e.g., HStack and VStack) and picks the one that best fits the available space.
Useful for handling different layouts in landscape vs. portrait mode or when accommodating dynamic type sizes (like large fonts that may not fit horizontally).
Form, List, OutlineGroup, and DisclosureGroup
These act like “really smart VStacks” with additional features like scrolling, selection, and hierarchy.
They are more advanced than basic stacks and offer a structured layout.
Custom Implementations of the Layout Protocol
You can create custom views by implementing the Layout protocol.
This allows control over the "offer space, let views choose their size, then position them" process using methods like sizeThatFits and placeSubviews.

ZStack
ZStack sizes itself to fit its children.
If even one child is fully flexible in size, the ZStack will also be flexible.
.background Modifier
swift
Copy code
Text("hello").background(Rectangle().foregroundColor(.red))
This is similar to making a ZStack with a Text and Rectangle (with the Text in front).
However, in this case, the resulting view will be sized to the Text, and the Rectangle is not involved in the layout sizing.
The layout is determined solely by the Text, effectively making a "mini-ZStack" of two elements.
.overlay Modifier
swift
Copy code
Circle().overlay(Text("Hello"), alignment: .center)
This follows the same layout rules as .background, but stacks the views in the opposite order.
Here, the view is sized to the Circle (which is fully flexible), and the Text is stacked on top of it.
The Text will be positioned based on the alignment specified inside the Circle (in this case, centered).
This explanation demonstrates how these modifiers control the layout of overlapping views in SwiftUI.

This slide explains how modifiers work in SwiftUI, especially in relation to layout and sizing.

Modifiers
View modifiers (such as .padding) return a modified view. Conceptually, the modifier "contains" the view it is modifying.
Many modifiers simply pass the size offered to them along (like .font or .foregroundColor), but some modifiers actively participate in the layout process.
Example: .padding
The view returned by .padding(10) offers the view it is modifying a space that is the same size as it was originally offered, but reduced by 10 points on each side.
The modified view then chooses a size for itself that is 10 points larger on all sides than the size chosen by the original view.
Example: .aspectRatio
The view returned by the .aspectRatio modifier takes the space offered and chooses a size for itself that either:
.fit: Fits within the offered space while maintaining the aspect ratio.
.fill: Uses all the available space (or more) while maintaining the aspect ratio.
A view can choose a size larger than the space originally offered if necessary.
This explains how layout-related modifiers adjust the space and size of views they modify in SwiftUI, providing flexibility in how views are rendered.
This slide explains the use of GeometryReader in SwiftUI.

GeometryReader
You wrap a GeometryReader view around what would normally appear in your view’s body to get access to the size and position information of the container that is offering the space.
Example:
swift
Copy code
var body: View {
    GeometryReader { geometry in
        // Use geometry information here
    }
}
The geometry parameter is a GeometryProxy, which provides:

size: The amount of space offered by the container (CGSize).
frame(in:): The view's frame in a specific coordinate space (CGRect).
safeAreaInsets: The insets that define the safe area (EdgeInsets).
Key Point: The size provided by GeometryReader is the total space offered to the view by its parent container.

GeometryReader itself accepts all the space offered to it, which means it will expand to fill the available space.

This layout tool is useful when you need to adjust your view’s content based on its size or position within the overall interface.

This slide explains the concept of the Safe Area in SwiftUI and how to manage drawing inside or outside of it.

Safe Area
Safe areas represent portions of the screen where views should not draw content. For example, the notch on iPhones (like iPhone X and later) is considered part of the safe area.

Surrounding views or elements may introduce their own safe areas to ensure important content isn’t obscured.

Normally, views are constrained to avoid drawing in safe areas, but you can choose to override this behavior and draw into those areas using the .edgesIgnoringSafeArea modifier.

Example:
swift
Copy code
ZStack {
    ...
}.edgesIgnoringSafeArea([.top])  // Allows drawing into the top safe area
In this example, the content inside the ZStack is allowed to extend into the top edge's safe area, overriding the default behavior.
This is useful for cases where you want full-screen content or where drawing into the safe area enhances the user experience.

