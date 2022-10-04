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
    let pokemonList = try await NamedAPIResourceList(.pokemon, limit: 20)

    // getting pokemon in resource list
    var pokemonArray = await withTaskGroup(of: Pokemon?.self) { group in
        for result in pokemonList.results {
            group.addTask {
                do {
                    guard let name = result.name {
                        print("Result has no name. Use the url instead.")
                        return nil
                    }
                    let pokemon = try await Pokemon(name)
                    return pokemon
                } catch {
                    print(error.localizedDescription)
                }
                return nil
            }
        }
        var tempPokemon = [Pokemon]()
        for await pokemon in group {
            guard let pokemon else { continue }
            tempPokemon.append(pokemon)
        }
        return tempPokemon
    }
    
    for pokemon in pokemonArray {
        print(pokemon.species.name)
    }
} catch {
    print(error.localizedDescription)
}
```

