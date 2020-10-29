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

protocol NetworkServiceType {
    
    var pokemonsProvider: PokemonsProviderType { get }
}

class NetworkServices: NetworkServiceType {
    
    // MARK: -
    // MARK: Variables
    
    public let pokemonsProvider: PokemonsProviderType = PokemonsProvider<NetworkPokemons>()
}
