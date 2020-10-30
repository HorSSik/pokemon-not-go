//
//  PokemonDetailModel.swift
//  Pokemon Not Go
//
//  Created by Dima Omelchenko on 30.10.2020.
//  Copyright © 2020 IDAP. All rights reserved.
//

import Foundation

public struct PokemonDetailModel: NetworkModel, Codable {
    
    // MARK: -
    // MARK: Variables
    
    let baseExperience: Int?
    let name: String
    let order: Int
    let weight: Int
    let height: Int
    let sprites: Sprites
    
    enum CodingKeys: String, CodingKey {
        
        case baseExperience = "base_experience"
        case name
        case order
        case weight
        case height
        case sprites
    }
    
    public static var empty: PokemonDetailModel {
        return PokemonDetailModel(baseExperience: 0, name: "", order: 0, weight: 0, height: 0, sprites: .empty)
    }
}

public struct Sprites: NetworkModel, Codable {
    
    // MARK: -
    // MARK: Variables
    let backDefault: URL
    let backShiny: URL
    let frontDefault: URL
    let frontShiny: URL
    
    enum CodingKeys: String, CodingKey {
        
        case backDefault = "back_default"
        case backShiny = "back_shiny"
        case frontDefault = "front_default"
        case frontShiny = "front_shiny"
    }
    
    public static var empty: Sprites {
        return Sprites(
            backDefault: URL(fileURLWithPath: ""),
            backShiny: URL(fileURLWithPath: ""),
            frontDefault: URL(fileURLWithPath: ""),
            frontShiny: URL(fileURLWithPath: "")
        )
    }
}
