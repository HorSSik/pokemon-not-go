//
//  BaseView.swift
//  Pokemon Not Go
//
//  Created by Dima Omelchenko on 28.10.2020.
//  Copyright © 2020 IDAP. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa

class BaseView<ViewModel: BaseViewModelType>: UIView {
    
    // MARK: -
    // MARK: Variables
    
    private var indicatorView: UIActivityIndicatorView?
    
    private(set) public var disposeBag = DisposeBag()
    
    // MARK: -
    // MARK: Public
    
    public func fill(with viewModel: ViewModel) {
        viewModel.lockHandler = { [weak self] in self?.lock() }
        viewModel.unlockHandler = { [weak self] in self?.unlock() }
    }
    
    func lock(on view: UIView? = nil, color: UIColor = .black) {
        let indicatorView = UIActivityIndicatorView()
        indicatorView.style = .large
        indicatorView.color = color
        indicatorView.startAnimating()
        let view = view ?? self
        
        view.addSubview(indicatorView)
        indicatorView.center = view.center
        view.bringSubviewToFront(indicatorView)
        
        self.unlock()
        self.indicatorView = indicatorView
    }
    
    func unlock() {
        self.indicatorView?.stopAnimating()
        self.indicatorView?.removeFromSuperview()
        self.indicatorView = nil
    }
}
