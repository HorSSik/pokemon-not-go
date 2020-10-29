//
//  BaseFlowController.swift
//  Pokemon Not Go
//
//  Created by Dima Omelchenko on 28.10.2020.
//  Copyright © 2020 IDAP. All rights reserved.
//

import UIKit

class BaseFlowController {
    
    // MARK: -
    // MARK: Variables
    
    private(set) public var navigationController: UINavigationController?
    
    // MARK: -
    // MARK: Initialization
    
    public init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
        
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    // MARK: -
    // MARK: Public
    
    public func push(viewController: UIViewController, animated: Bool) {
        self.navigationController?.pushViewController(viewController, animated: animated)
    }
    
    public func pop(animated: Bool) {
        self.navigationController?.popViewController(animated: animated)
    }
}
