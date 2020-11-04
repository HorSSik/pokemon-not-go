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
    
    @IBOutlet internal var startButtonView: UIView?
    @IBOutlet internal var startButton: UIButton?
    
    // MARK: -
    // MARK: Private
    
    private func showStartButtonView() {
        self.startButtonView?.alpha = 0
        
        UIView
            .animate(
                withDuration: 1,
                animations: { [weak self] in
                    self?.startButtonView?.alpha = 1
                }
            )
    }
    
    // MARK: -
    // MARK: Overrided
    
    override func fill(with viewModel: MainViewModel) {
        self.showStartButtonView()
    }
}
