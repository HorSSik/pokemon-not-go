//
//  BaseViewController.swift
//  Pokemon Not Go
//
//  Created by Dima Omelchenko on 28.10.2020.
//  Copyright © 2020 IDAP. All rights reserved.
//

import UIKit

import RxCocoa
import RxSwift

class BaseViewController<RootView: BaseView<ViewModel>, ViewModel>: UIViewController {
    
    // MARK: -
    // MARK: Variables
    
    public var rootView: RootView? {
        return cast(self.viewIfLoaded)
    }
    
    private(set) public var viewModel: ViewModel
    
    private(set) public var disposeBag = DisposeBag()
    
    // MARK: -
    // MARK: Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.rootView?.fill(with: self.viewModel)
    }
    
    // MARK: -
    // MARK: Initialization
    
    public init(viewModel: ViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: toString(type(of: self)), bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
