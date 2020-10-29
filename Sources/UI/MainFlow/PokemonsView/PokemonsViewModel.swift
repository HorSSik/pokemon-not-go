//
//  PokemonsViewModel.swift
//  Pokemon Not Go
//
//  Created by Dima Omelchenko on 28.10.2020.
//  Copyright © 2020 IDAP. All rights reserved.
//

import Foundation

enum PokemonsViewModelEvents {
    
    case showPokemonInfo
}

class PokemonsViewModel: BaseViewModel<PokemonsViewModelEvents> {
    
    // MARK: -
    // MARK: Variables
    
    private let networking: NetworkServiceType
    
    private var pokemonsModel: PokemonsModel?
    
    // MARK: -
    // MARK: Public
    
    public init(
        networking: NetworkServiceType,
        _ callBackHandler: @escaping (PokemonsViewModelEvents) -> ()
    ) {
        self.networking = networking
        
        super.init(callBackHandler)
        
        self.getPokemons()
    }
    
    // MARK: -
    // MARK: Private
    
    private func getPokemons() {
        self.networking.pokemonsProvider.getPokemons(limit: 50)
    }
}
