# Lecture Notes
## Lecture 3

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

![MVVM Diagram](Memorizwift/Assets.xcassets/MVVM.png)

- Struct
- Class
- Protocol
- Generics "don't care type"
- enum
- functions 
