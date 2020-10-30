//
//  PokemonsProvider.swift
//  Pokemon Not Go
//
//  Created by Dima Omelchenko on 29.10.2020.
//  Copyright © 2020 IDAP. All rights reserved.
//

import Foundation

import RxSwift
import RxCocoa

public protocol PokemonsProviderType {
    
    func getPokemons(limit: Int) -> Single<PokemonsModel>
}

class PokemonsProvider<AllPokemonsProvider: NetworkProcessable>: PokemonsProviderType
    where AllPokemonsProvider.ReturnedType == PokemonsModel {
    
    // MARK: -
    // MARK: Public
    
    public func getPokemons(limit: Int) -> Single<PokemonsModel> {
        let params = PokemonsParams(limit: limit)
        
        return get(with: AllPokemonsProvider.self +| params)
    }
}
