//
//  BaseViewModel.swift
//  Pokemon Not Go
//
//  Created by Dima Omelchenko on 28.10.2020.
//  Copyright © 2020 IDAP. All rights reserved.
//

import Foundation

import RxSwift
import RxCocoa

protocol BaseViewModelType: class {
    
    var lockHandler: EmptyAction? { get set }
    var unlockHandler: EmptyAction? { get set }
}

class BaseViewModel<Events>: NSObject, BaseViewModelType {
    
    // MARK: -
    // MARK: Variables
    
    public var lockHandler: EmptyAction?
    public var unlockHandler: EmptyAction?
    
    private(set) public var disposeBag = DisposeBag()
    
    private(set) public var callBackHandler: ((Events) -> ())?
    
    // MARK: -
    // MARK: Initialization
    
    public init(_ callBackHandler: @escaping (Events) -> ()) {
        self.callBackHandler = callBackHandler
        
        super.init()
        
        self.prepareBindings(disposeBag: self.disposeBag)
    }
    
    // MARK: -
    // MARK: Public
    
    func prepareBindings(disposeBag: DisposeBag) {
        
    }
}
