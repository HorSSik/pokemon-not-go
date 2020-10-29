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
    
    private(set) public var disposeBag = DisposeBag()
    
    // MARK: -
    // MARK: Public
    
    public func fill(with viewModel: ViewModel) {
        
    }
}
