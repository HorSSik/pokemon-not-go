//
//  MainView.swift
//  Pokemon Not Go
//
//  Created by Dima Omelchenko on 28.10.2020.
//  Copyright © 2020 IDAP. All rights reserved.
//

import UIKit

class MainView: BaseView<MainViewModel> {
    
    // MARK: -
    // MARK: Outleties
    
    @IBOutlet internal var startButton: UIButton?
    
    // MARK: -
    // MARK: Private
    
    private func prepareBindings(viewModel: MainViewModel) {
        self.startButton?
            .rx
            .tap
            .bind { [weak viewModel] in
                viewModel?.callBackHandler?(.start)
            }
            .disposed(by: self.disposeBag)
    }
    
    // MARK: -
    // MARK: Overrided
    
    override func fill(with viewModel: MainViewModel) {
        self.prepareBindings(viewModel: viewModel)
    }
}
