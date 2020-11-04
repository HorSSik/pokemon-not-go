//
//  PokemonsViewModel.swift
//  Pokemon Not Go
//
//  Created by Dima Omelchenko on 28.10.2020.
//  Copyright © 2020 IDAP. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa

enum PokemonsViewModelEvents {
    
    case back
    case showPokemonInfo(pokemonData: PokemonData)
}

class PokemonsViewModel: BaseViewModel<PokemonsViewModelEvents> {
    
    // MARK: -
    // MARK: Variables
    
    public var pokemonsValues: [PokemonData] {
        return self.pokemonsModel?.results ?? []
    }
    
    public let updateTable = PublishSubject<Void>()
    
    private var pokemonsModel: PokemonsModel?
    
    private let networking: NetworkServiceType
    
    // MARK: -
    // MARK: Initialization
    
    public init(
        networking: NetworkServiceType,
        _ callBackHandler: @escaping (PokemonsViewModelEvents) -> ()
    ) {
        self.networking = networking
        
        super.init(callBackHandler)
    }
    
    // MARK: -
    // MARK: Public
    
    public func getPokemons() {
        self.lockHandler?()
        
        self.networking
            .pokemonsProvider
            .getPokemons(limit: 50)
            .subscribe(
                onSuccess: { [weak self] model in
                    DispatchQueue
                        .main
                        .asyncAfter(
                            deadline: .now() + 1,
                            execute: {
                                dispatchOnMain {
                                    self?.unlockHandler?()
                                    
                                    self?.pokemonsModel = model
                                    
                                    self?.updateTable.onNext(())
                                }
                            }
                        )
                },
                onError: { error in
                    print("error - \(error)")
                }
            )
            .disposed(by: self.disposeBag)
    }
}
