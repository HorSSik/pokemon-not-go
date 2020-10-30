//
//  Optional.swift
//  Pokemon Not Go
//
//  Created by Dima Omelchenko on 30.10.2020.
//  Copyright © 2020 IDAP. All rights reserved.
//

import Foundation

public extension Optional {
    
    func `do`(_ action: (Wrapped) -> ()) {
        self.map(action)
    }
    
    @discardableResult
    func apply<Result>(_ transform: ((Wrapped) -> Result)?) -> Result? {
        return self.flatMap {
            transform?($0)
        }
    }
    
    func or(_ action: () -> Wrapped) -> Wrapped {
        return self ?? action()
    }
}
