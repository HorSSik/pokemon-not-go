//
//  MainViewController.swift
//  Pokemon Not Go
//
//  Created by Dima Omelchenko on 28.10.2020.
//  Copyright © 2020 IDAP. All rights reserved.
//

import UIKit

class MainViewController: BaseViewController<MainView, MainViewModel> {
    
    // MARK: -
    // MARK: Private
    
    private func prepareBindings() {
        self.rootView?.startButton?
            .rx
            .tap
            .bind { [weak self] in
                self?.viewModel.callBackHandler?(.start)
            }
            .disposed(by: self.disposeBag)
    }
    
    // MARK: -
    // MARK: Overrided
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.prepareBindings()
    }
}
