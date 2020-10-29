//
//  NetworkPokemons.swift
//  Pokemon Not Go
//
//  Created by Dima Omelchenko on 28.10.2020.
//  Copyright © 2020 IDAP. All rights reserved.
//

import Foundation

public struct NetworkPokemons: NetworkProcessable {
    
    //MARK: -
    //MARK: NetworkProcessable
    
    public typealias ReturnedType = PokemonsModel
    public typealias Service = UrlSessionService
    
    public static var url: URL {
        get { return URL(string: "https://pokeapi.co/api/v2" + "/pokemon") ?? URL(fileURLWithPath: "") }
    }
}

public struct PokemonsParams: QueryParamsType {
    
    // MARK: -
    // MARK: Variables
    
    public let limit: Int
    
    // MARK: -
    // MARK: Initialization
    
    public init(limit: Int) {
        self.limit = limit
    }
}
