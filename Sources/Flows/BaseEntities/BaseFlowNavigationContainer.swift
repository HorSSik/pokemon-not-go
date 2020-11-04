//
//  BaseFlowNavigationContainer.swift
//  Pokemon Not Go
//
//  Created by Dima Omelchenko on 28.10.2020.
//  Copyright © 2020 IDAP. All rights reserved.
//

import UIKit

class BaseFlowNavigationContainer: UIViewController, UINavigationControllerDelegate {
    
    // MARK: -
    // MARK: Variables
    
    private(set) public var presenter: UINavigationController?
    private(set) public var contentController: UINavigationController?
    
    // MARK: -
    // MARK: Initialization
    
    public init(presenter: UINavigationController?) {
        self.presenter = presenter // add back swipe
        let contentController = UINavigationController()
        self.contentController = contentController
        
        super.init(nibName: nil, bundle: nil)
        
        contentController.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: -
    // MARK: Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.addChildController()
    }
    
    // MARK: -
    // MARK: Public
    
    public func push(viewController: UIViewController, animated: Bool) {
        self.contentController?.pushViewController(viewController, animated: animated)
    }
    
    public func pop(animated: Bool) {
        self.contentController?.popViewController(animated: animated)
    }
    
    // MARK: -
    // MARK: Private
    
    private func addChildController() {
        let controller = self.contentController
        controller?.setNavigationBarHidden(true, animated: false)
        
        if let contentController = controller {
            self.idp.addChild(childController: contentController)
        }
    }
}
