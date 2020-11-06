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
    func getDetailInfo(name: String) -> Single<PokemonDetailModel>
}

class PokemonsProvider<
    AllPokemonsProvider: NetworkProcessable,
    DetailPokemonModel: NetworkProcessable,
    CoreDataService: CoreDataServiceType>: PokemonsProviderType
where AllPokemonsProvider.ReturnedType == PokemonsModel,
      DetailPokemonModel.ReturnedType == PokemonDetailModel,
      CoreDataService.Model == PokemonDetailModel  {
    
    // MARK: -
    // MARK: Variables
    
    public let coreDataService: CoreDataService
    
    // MARK: -
    // MARK: Initialization
    
    public init(coreDataService: CoreDataService) {
        self.coreDataService = coreDataService
    }
    
    // MARK: -
    // MARK: Public
    
    public func getPokemons(limit: Int) -> Single<PokemonsModel> {
        let params = PokemonsParams(limit: limit)
        
        return get(with: AllPokemonsProvider.self +| params)
    }
    
    public func getDetailInfo(name: String) -> Single<PokemonDetailModel> {
        let params = DetailPokemonParams()
        
        return get(with: multipleParamRequest(model: DetailPokemonModel.self, pathParam: name, queryParams: params))
    }
}
