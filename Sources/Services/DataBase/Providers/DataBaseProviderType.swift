//
//  DataBaseProviderType.swift
//  Pokemon Not Go
//
//  Created by Dima Omelchenko on 05.11.2020.
//  Copyright © 2020 IDAP. All rights reserved.
//

import Foundation

protocol DataBaseProviderType {
    
    associatedtype DataBaseObject: AnyObject
    
    func read(key: String) -> DataBaseObject?
    
    func save(object: DataBaseObject)
    
//    func read() -> [DataBaseObject]?
}
