//
//  MainViewModel.swift
//  Pokemon Not Go
//
//  Created by Dima Omelchenko on 28.10.2020.
//  Copyright © 2020 IDAP. All rights reserved.
//

import Foundation

enum MainViewModelEvents {
    
    case start
}

class MainViewModel: BaseViewModel<MainViewModelEvents> {
    
    // MARK: -
    // MARK: Variables
    
    private let networking: NetworkServiceType
    
    // MARK: -
    // MARK: Initialization
    
    public init(
        networking: NetworkServiceType,
        _ callBackHandler: @escaping (MainViewModelEvents) -> ()
    ) {
        self.networking = networking
        
        super.init(callBackHandler)
    }
}
