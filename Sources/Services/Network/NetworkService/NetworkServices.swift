//
//  NetworkServices.swift
//  Pokemon Not Go
//
//  Created by Dima Omelchenko on 28.10.2020.
//  Copyright © 2020 IDAP. All rights reserved.
//

import Foundation

import RxSwift
import RxCocoa

import CoreData

protocol NetworkServiceType {
    
    var pokemonsProvider: PokemonsProviderType { get }
}

class NetworkServices: NetworkServiceType {
    
    // MARK: -
    // MARK: Variables
    
    public let pokemonsProvider: PokemonsProviderType
    
    // MARK: -
    // MARK: Initialization
    
    public init() {
        let pokemonProvider = CoreDataProvider<PokemonDetailModel>()
        let pokemonDataService = PokemonDetailDataBaseServise(provider: pokemonProvider)
        
        self.pokemonsProvider = PokemonsProvider<NetworkPokemons, NetworkDetailPokemon, PokemonDetailDataBaseServise>(coreDataService: pokemonDataService)
    }
}
