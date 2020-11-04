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
    // MARK: Overrided
    
    override func fill(with viewModel: PokemonsViewModel) {
        super.fill(with: viewModel)
        
        self.backButton?.setTitle("Go back", for: .normal)
    }
}
