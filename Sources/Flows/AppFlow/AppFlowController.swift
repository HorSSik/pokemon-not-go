//
//  AppFlowController.swift
//  Pokemon Not Go
//
//  Created by Dima Omelchenko on 28.10.2020.
//  Copyright © 2020 IDAP. All rights reserved.
//

import UIKit

class AppFlowController: BaseFlowController {
    
    // MARK: -
    // MARK: Variables
    
    private var networking: NetworkServiceType
    
    // MARK: -
    // MARK: Initialization
    
    public init(navigationController: UINavigationController?, network: NetworkServiceType) {
        self.networking = network
        
        super.init(navigationController: navigationController)
        
        self.presentMainFlow()
    }
    
    // MARK: -
    // MARK: Public
    
    public func presentMainFlow() {
        let mainFlowController = MainFlowController(presenter: self.navigationController, networking: self.networking)

        self.push(viewController: mainFlowController, animated: true)
    }
}
