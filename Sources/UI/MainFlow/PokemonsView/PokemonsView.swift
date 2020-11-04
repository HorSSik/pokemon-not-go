//
//  PokemonsView.swift
//  Pokemon Not Go
//
//  Created by Dima Omelchenko on 28.10.2020.
//  Copyright © 2020 IDAP. All rights reserved.
//

import UIKit

import RxCocoa
import RxSwift

class PokemonsView: BaseView<PokemonsViewModel> {
    
    // MARK: -
    // MARK: Outleties
    
    @IBOutlet internal var backButton: UIButton?
    
    @IBOutlet internal var pokemonsTableView: UITableView?
    
    @IBOutlet internal var contentView: UIView?
    
    // MARK: -
    // MARK: Private
    
    private func prepareBindings(viewModel: PokemonsViewModel) {
        let disposeBag = self.disposeBag
        
        viewModel
            .updateTable
            .bind { [weak self, weak viewModel] in
                viewModel?.configureTableView(tableView: self?.pokemonsTableView)
            }
            .disposed(by: disposeBag)
        
        self.backButton?
            .rx
            .tap
            .bind { [weak viewModel] in
                viewModel?.callBackHandler?(.back)
            }
            .disposed(by: disposeBag)
    }
    
    // MARK: -
    // MARK: Overrided
    
    override func fill(with viewModel: PokemonsViewModel) {
        super.fill(with: viewModel)
        
        self.prepareBindings(viewModel: viewModel)
        
        viewModel.configureTableView(tableView: self.pokemonsTableView)
    }
}
