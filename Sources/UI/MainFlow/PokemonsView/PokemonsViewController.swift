//
//  PokemonsViewController.swift
//  Pokemon Not Go
//
//  Created by Dima Omelchenko on 28.10.2020.
//  Copyright © 2020 IDAP. All rights reserved.
//

import UIKit

class PokemonsViewController: BaseViewController<PokemonsView, PokemonsViewModel> {
    
    // MARK: -
    // MARK: Variables
    
    private var tableAdapter: TableAdapter?
    
    // MARK: -
    // MARK: Private
    
    private func prepareBindings() {
        let disposeBag = self.disposeBag
        let pokemonView = self.rootView
        
        self.viewModel
            .updateTable
            .bind { [weak self] in
                self?.configureTableView()
            }
            .disposed(by: disposeBag)
        
        pokemonView?.backButton?
            .rx
            .tap
            .bind { [weak self] in
                self?.viewModel.callBackHandler?(.back)
            }
            .disposed(by: disposeBag)
    }
    
    private func configureTableView() {
        let section = TableSection(model: self.viewModel.pokemonsValues, cell: PokemonTableViewCell.self) { _ in }
        self.tableAdapter = TableAdapter(
            tableView: self.rootView?.pokemonsTableView,
            cellType: [PokemonTableViewCell.self]
        ) { [weak self] event in
            self?.handle(event: event)
        }
        
        self.tableAdapter?.sections = [section]
    }
    
    private func handle(event: TableAdapterEvents) {
        switch event {
        case let .didSelect(indexPath):
            self.viewModel.callBackHandler?(.showPokemonInfo(pokemonData: self.viewModel.pokemonsValues[indexPath.row]))
        }
    }

    
    // MARK: -
    // MARK: Overrided

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.prepareBindings()
        
        self.viewModel.getPokemons()
    }
}
