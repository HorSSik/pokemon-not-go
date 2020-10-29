//
//  MainFlowController.swift
//  Pokemon Not Go
//
//  Created by Dima Omelchenko on 28.10.2020.
//  Copyright © 2020 IDAP. All rights reserved.
//

import UIKit

class MainFlowController: BaseFlowNavigationContainer {
    
    // MARK: -
    // MARK: Variables
    
    private var networking: NetworkServiceType
    
    // MARK: -
    // MARK: Initialization
    
    required init(presenter: UINavigationController?, networking: NetworkServiceType) {
        self.networking = networking
        
        super.init(presenter: presenter)
        
        self.showMainViewController()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: -
    // MARK: Private
    
    private func showMainViewController() {
        let mainViewModel = MainViewModel(networking: self.networking) { [weak self] events in
            self?.handle(events: events)
        }
        
        let mainViewController = MainViewController(viewModel: mainViewModel)
        
        self.push(viewController: mainViewController, animated: true)
    }
    
    private func handle(events: MainViewModelEvents) {
        switch events {
        case .start:
            dispatchOnMain { self.showPokemonsController() }
        }
    }
    
    private func showPokemonsController() {
        let pokemonsViewModel = PokemonsViewModel(networking: self.networking) { [weak self] events in
            self?.handle(events: events)
        }
        
        let pokemonsViewController = PokemonsViewController(viewModel: pokemonsViewModel)
        
        self.push(viewController: pokemonsViewController, animated: true)
    }
    
    private func handle(events: PokemonsViewModelEvents) {
        switch events {
        case .showPokemonInfo:
            print("showPokemonInfo")
        }
    }
}
