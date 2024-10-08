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

### Type Parameeter 
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

