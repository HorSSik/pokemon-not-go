//
//  UIViewController+Extensions.swift
//  Pokemon Not Go
//
//  Created by Dima Omelchenko on 28.10.2020.
//  Copyright © 2020 IDAP. All rights reserved.
//

import UIKit

public extension IDP where Base: UIViewController {
    
    func addChild(childController: UIViewController,
                  atView view: UIView,
                  atFrame frame:CGRect? = nil,
                  autoLayout: Bool = true) {
        let `self` = self.base
        
        self.addChild(childController)
        let rect = frame ?? view.bounds
        childController.view.frame = rect
        view.addSubview(childController.view)
        if autoLayout {
            let childView = childController.view
            childView?.translatesAutoresizingMaskIntoConstraints = false
            childView?.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            childView?.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
            childView?.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
            childView?.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        }
        childController.didMove(toParent: self)
    }
    
    func addChild(childController: UIViewController,
                  atFrame frame:CGRect? = nil,
                  autoLayout: Bool = true) {
        self.addChild(childController: childController,
                      atView: self.base.view,
                      atFrame: frame,
                      autoLayout: autoLayout)
    }
    
    func removeChild(childController: UIViewController) {
        childController.willMove(toParent: nil)
        childController.view.removeFromSuperview()
        childController.removeFromParent()
    }
}

extension UIViewController: IDPExtensionsProvider {}
