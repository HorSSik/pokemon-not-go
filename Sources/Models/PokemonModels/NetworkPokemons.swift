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
    public typealias Service = CachedUrlSessionService
    
    public static var url: URL {
        get { return URL(string: "https://pokeapi.co/api/v2" + "/pokemon") ?? URL(fileURLWithPath: "") }
    }
}
