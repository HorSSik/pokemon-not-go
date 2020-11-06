//
//  PokemonDetailInfoViewModel.swift
//  Pokemon Not Go
//
//  Created by Dima Omelchenko on 30.10.2020.
//  Copyright © 2020 IDAP. All rights reserved.
//

import Foundation

import RxSwift
import RxCocoa

enum PokemonDetailInfoViewModelEvents {
    
    case back(pokemonData: PokemonData)
}

enum PokemonDetailInfoViewModelInputEvents {
    
    
}

class PokemonDetailInfoViewModel: BaseViewModel<PokemonDetailInfoViewModelEvents, PokemonDetailInfoViewModelInputEvents> {
    
    // MARK: -
    // MARK: Variables
    
    public var backDefaultUrl: URL {
        return self.pokemonDetailModel?.sprites.backDefault ?? URL(fileURLWithPath: "")
    }
    
    public var backUrl: URL {
        return self.pokemonDetailModel?.sprites.backShiny ?? URL(fileURLWithPath: "")
    }
    
    public var frontDefaultUrl: URL {
        return self.pokemonDetailModel?.sprites.frontDefault ?? URL(fileURLWithPath: "")
    }
    
    public var frontUrl: URL {
        return self.pokemonDetailModel?.sprites.frontShiny ?? URL(fileURLWithPath: "")
    }
    
    public var pokemonName: String {
        return "Pokemon name: " + (self.pokemonDetailModel?.name ?? "Not found").capitalizingFirstLetter()
    }
    
    public var pokemonOrder: String {
        return "Pokemon order: " + String(self.pokemonDetailModel?.order ?? 0)
    }
    
    public var pokemonWeight: String {
        return "Pokemon weight: " + String(self.pokemonDetailModel?.weight ?? 0)
    }
    
    public var pokemonHeight: String {
        return "Pokemon height: " + String(self.pokemonDetailModel?.height ?? 0)
    }
    
    public let didUpdate = PublishSubject<Void>()
    
    private(set) public var pokemonData: PokemonData
    
    private(set) public var pokemonDetailModel: PokemonDetailModel?
    
    private let networking: NetworkServiceType
    
    // MARK: -
    // MARK: Initialization
    
    public init(
        networking: NetworkServiceType,
        pokemonData: PokemonData,
        _ callBackHandler: @escaping (PokemonDetailInfoViewModelEvents) -> ()
    ) {
        self.networking = networking
        self.pokemonData = pokemonData
        
        super.init(callBackHandler)
    }
    
    // MARK: -
    // MARK: Private
    
    public func getDetailInfo() {
        self.lockHandler?()
        
        self.networking
            .pokemonsProvider
            .getDetailInfo(name: self.pokemonData.name)
            .subscribe(
                onSuccess: { [unowned self] model in
                    DispatchQueue
                        .main
                        .asyncAfter(
                            deadline: .now() + 1,
                            execute: {
                                dispatchOnMain {
                                    self.unlockHandler?()
                                    
                                    self.pokemonData = PokemonData(
                                        image: model.sprites.frontDefault,
                                        name: self.pokemonData.name,
                                        url: self.pokemonData.url
                                    )
                                    
                                    self.pokemonDetailModel = model
                                    
                                    self.didUpdate.onNext(())
                                }
                            }
                        )
                    print("getDetailInfo - \(model)")
                },
                onError: { error in
                    print("getDetailInfo error - \(error)")
                }
            )
            .disposed(by: self.disposeBag)
    }
}
