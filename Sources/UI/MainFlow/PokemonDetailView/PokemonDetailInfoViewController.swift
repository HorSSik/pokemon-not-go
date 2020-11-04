//
//  PokemonDetailInfoViewController.swift
//  Pokemon Not Go
//
//  Created by Dima Omelchenko on 30.10.2020.
//  Copyright © 2020 IDAP. All rights reserved.
//

import UIKit

class PokemonDetailInfoViewController: BaseViewController<PokemonDetailInfoView, PokemonDetailInfoViewModel> {
    
    // MARK: -
    // MARK: Private
    
    private func prepareBindings() {
        let disposeBag = self.disposeBag
        
        self.rootView?.backButton?
            .rx
            .tap
            .bind { [weak self] in
                self?.viewModel.callBackHandler?(.back)
            }
            .disposed(by: disposeBag)
        
        self.viewModel
            .didUpdate
            .bind { [weak self] in
                self.do {
                    $0.rootView?.fill(with: $0.viewModel)
                }
            }
            .disposed(by: disposeBag)
    }
    
    // MARK: -
    // MARK: Overrided

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.prepareBindings()
        
        self.viewModel.getDetailInfo()
    }
}
