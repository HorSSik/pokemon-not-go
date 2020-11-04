//
//  UINavigationController+Extensions.swift
//  Pokemon Not Go
//
//  Created by Dima Omelchenko on 04.11.2020.
//  Copyright © 2020 IDAP. All rights reserved.
//

import UIKit

public extension UINavigationController {
    
    // MARK: -
    // MARK: Public
    
    func fadeTo(_ viewController: UIViewController, _ completion: (() -> ())? = nil) {
        self.view.layer.add(self.transition(), forKey: nil)
        self.pushViewController(viewController, animated: false)
        completion?()
    }
    
    func fadePop() {
        self.view.layer.add(self.transition(), forKey: nil)
        self.popViewController(animated: false)
    }
    
    func fadePopToRoot() {
        self.view.layer.add(self.transition(), forKey: nil)
        self.popToRootViewController(animated: false)
    }
    
    func pushWithHideTabBar(_ viewController: UIViewController, animated: Bool, tabBarIsHidden: Bool) {
        self.tabBarController?.tabBar.isHidden = tabBarIsHidden
        self.pushViewController(viewController, animated: animated)
    }
    
    func popWithHideTabBar(animated: Bool, tabBarIsHidden: Bool) {
        self.tabBarController?.tabBar.isHidden = tabBarIsHidden
        self.popViewController(animated: animated)
    }
    
    func popToRootWithHideTabBar(animated: Bool, tabBarIsHidden: Bool) {
        self.tabBarController?.tabBar.isHidden = tabBarIsHidden
        self.popToRootViewController(animated: animated)
    }
    
    // MARK: -
    // MARK: Private
    
    private func transition() -> CATransition {
        let transition = CATransition()
        transition.duration = 0.25
        transition.type = .fade
        
        return transition
    }
}
