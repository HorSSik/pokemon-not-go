//
//  PokemonsProvider.swift
//  Pokemon Not Go
//
//  Created by Dima Omelchenko on 29.10.2020.
//  Copyright © 2020 IDAP. All rights reserved.
//

import Foundation

public protocol PokemonsProviderType {
    
    func getPokemons(limit: Int)
}

class PokemonsProvider<AllPokemonsProvider: NetworkProcessable>: PokemonsProviderType
    where AllPokemonsProvider.ReturnedType == PokemonsModel {
    
    // MARK: -
    // MARK: Public
    
    public func getPokemons(limit: Int) {
        let params = PokemonsParams(limit: limit)
        
        (AllPokemonsProvider.self +| params) <=| { result in
            switch result {
            case let .success(model):
                print("model count - \(model.results.count)")
            case .failure(_):
                break
            }
        }
    }
}
