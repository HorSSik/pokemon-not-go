//
//  BaseViewModel.swift
//  Pokemon Not Go
//
//  Created by Dima Omelchenko on 28.10.2020.
//  Copyright © 2020 IDAP. All rights reserved.
//

import Foundation

protocol BaseViewModelType { }

class BaseViewModel<Events>: NSObject, BaseViewModelType {
    
    // MARK: -
    // MARK: Variables
    
    private(set) public var callBackHandler: ((Events) -> ())?
    
    // MARK: -
    // MARK: Initialization
    
    public init(networking: NetworkServiceType, _ callBackHandler: @escaping (Events) -> ()) {
        self.callBackHandler = callBackHandler
    }
}
