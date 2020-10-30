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
    
    let baseExperience: Int
    let name: String
    let order: Int
    let weight: Int
    let sprites: Sprites
    
    enum CodingKeys: String, CodingKey {
        
        case baseExperience = "base_experience"
        case name
        case order
        case weight
        case sprites
    }
    
    public static var empty: PokemonDetailModel {
        return PokemonDetailModel(baseExperience: 0, name: "", order: 0, weight: 0, sprites: .empty)
    }
}

public struct Sprites: NetworkModel, Codable {
    
    // MARK: -
    // MARK: Variables
    
    let frontDefault: URL
    
    enum CodingKeys: String, CodingKey {
        
        case frontDefault = "front_default"
    }
    
    public static var empty: Sprites {
        return Sprites(frontDefault: URL(fileURLWithPath: ""))
    }
}
