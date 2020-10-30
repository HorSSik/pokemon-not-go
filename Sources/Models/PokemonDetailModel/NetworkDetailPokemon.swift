//
//  NetworkDetailPokemon.swift
//  Pokemon Not Go
//
//  Created by Dima Omelchenko on 30.10.2020.
//  Copyright © 2020 IDAP. All rights reserved.
//

import Foundation

public struct NetworkDetailPokemon: NetworkProcessable {

    //MARK: -
    //MARK: NetworkProcessable

    public typealias ReturnedType = PokemonDetailModel
    public typealias Service = UrlSessionService

    public static var url: URL {
        get { return URL(string: "https://pokeapi.co/api/v2" + "/pokemon/") ?? URL(fileURLWithPath: "") }
    }
}

public struct DetailPokemonParams: QueryParamsType {
    
    // MARK: -
    // MARK: Variables

    public let name: String

    // MARK: -
    // MARK: Initialization

    public init(name: String) {
        self.name = name
    }
}
