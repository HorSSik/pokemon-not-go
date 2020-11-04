//
//  F.swift
//  Pokemon Not Go
//
//  Created by Dima Omelchenko on 28.10.2020.
//  Copyright © 2020 IDAP. All rights reserved.
//

import Foundation

typealias EmptyAction = () -> ()

func toString(_ cls: AnyClass) -> String {
    return String(describing: cls)
}

func dispatchOnMain(_ completion: @escaping () -> ()) {
    DispatchQueue.main.async {
        completion()
    }
}

public func cast<Type, Result>(_ value: Type) -> Result? {
    return value as? Result
}
