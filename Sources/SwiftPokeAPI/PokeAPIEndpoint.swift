//
//  PokeAPIEndpoint.swift
//  
//
//  Created by Tino on 1/10/2022.
//

import Foundation

/// The endpoints for [pokeapi](https://pokeapi.co).
public enum PokeAPIEndpoint: String {
    // berry
    case berry = "berry"
    case berryFirmness = "berry-firmness"
    case berryFlavor = "berry-flavor"
    // contest
    case contestType = "contest-type"
    case contestEffect = "contest-effect"
    case superContestEffect = "super-contest-effect"
    // encounter
    case encounterMethod = "encounter-method"
    case encounterContition = "encounter-condition"
    case encounterConditionValue = "encounter-condition-value"
    // evolution
    case evolutionChain = "evolution-chain"
    case evolutionTrigger = "evolution-trigger"
    // games
    case generation = "generation"
    case pokedex = "pokedex"
    case version = "version"
    case versionGroup = "version-group"
    // items
    case item = "item"
    case itemAttribute = "item-attribute"
    case itemCategory = "item-category"
    case itemFlingEffect = "item-fling-effect"
    case itemPocket = "item-pocket"
    // locations
    case location = "location"
    case locationArea = "location-area"
    case palParkArea = "pal-park-area"
    case region = "region"
    // machines
    case machine = "machine"
    // moves
    case move = "move"
    case moveAilment = "move-ailment"
    case moveBattleStyle = "move-battle-style"
    case moveCategory = "move-category"
    case moveDamageClass = "move-damage-class"
    case moveLearnMethod = "move-learn-method"
    case moveTarget = "move-target"
    // pokemon
    case abilities = "ability"
    case characteristic = "characteristic"
    case eggGroup = "egg-group"
    case gender = "gender"
    case growthRate = "growth-rate"
    case nature = "nature"
    case pokeathlonStat = "pokeathlon-stat"
    case pokemon = "pokemon"
    case pokemonColor = "pokemon-color"
    case pokemonForm = "pokemon-form"
    case pokemonHabitat = "pokemon-habitat"
    case pokemonShape = "pokemon-shape"
    case pokemonSpecies = "pokemon-species"
    case stat = "stat"
    case type = "type"
    // utility
    case language = "language"
}
