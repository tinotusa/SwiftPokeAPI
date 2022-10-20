# SwiftPokeAPI

A wrapper for [pokeapi](https://pokeapi.co).

# Usage
Getting a specific resource.
```swift
import SwiftPokeAPI

// in some async context
do {
    let pokemon = try await Pokemon("ditto")
    print(pokemon.id)
    
    let berry = try await Berry("cheri")
    print(berry.name)
    
    let stat = try await Stat("1")
    print(stat.name)
    
    let nature = try await Nature("bold")
    print(nature.id)
} catch {
    print(error.localizedDescription)
}
```

# Getting a list of resources
```swift
import SwiftPokeAPI

// in some async context
do {
    let resource = try await Resource<Pokemon>(limit: 20)
    let pokemonSet = resource.items
    let nextURL = resource.next
    if let nextURL {
        print("The next url is \(nextURL)")
    }

    for pokemon in pokemonSet {
        print(pokemon.name)
    }
} catch {
    print(error.localizedDescription)
}
```

