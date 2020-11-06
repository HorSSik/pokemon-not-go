//
//  PokemonModels.swift
//  Pokemon Not Go
//
//  Created by Dima Omelchenko on 28.10.2020.
//  Copyright © 2020 IDAP. All rights reserved.
//

import Foundation

public struct PokemonsModel: NetworkModel {
    
    // MARK: -
    // MARK: Variables
    
    public let count: Int
    public var results: [PokemonData]
    
    public static var empty: PokemonsModel {
        return PokemonsModel(count: 0, results: [])
    }
}

public struct PokemonData: NetworkModel {
    
    // MARK: -
    // MARK: Variables
    
    public var image: URL?
    public let name: String
    public let url: URL
    
    public static var empty: PokemonData {
        return PokemonData(image: URL(fileURLWithPath: ""), name: "", url: URL(fileURLWithPath: ""))
    }
    
    // MARK: -
    // MARK: Initialization
    
    public init(image: URL?, name: String, url: URL) {
        self.image = image
        self.name = name
        self.url = url
    }
}

