//
//  CoreDataService.swift
//  Pokemon Not Go
//
//  Created by Dima Omelchenko on 05.11.2020.
//  Copyright © 2020 IDAP. All rights reserved.
//

import Foundation

protocol CoreDataServiceType {
    
    associatedtype Model = AnyObject
    
    func save(object: Model)
    
    func read(key: String) -> Model?
    
//    func read() -> [Model]?
}

class CoreDataService<StorageType: NSObject>: CoreDataServiceType where StorageType: NetworkModel {
    
    // MARK: -
    // MARK: Typealies
    
    typealias Model = StorageType
    
    // MARK: -
    // MARK: Variables
    
    public let provider: CoreDataProvider<Model>
    
    // MARK: -
    // MARK: Initialization
    
    public init(provider: CoreDataProvider<Model>) {
        self.provider = provider
    }
    
    // MARK: -
    // MARK: Public
    
    func save(object: Model) {
        self.provider.save(object: object)
    }
    
    func read(key: String) -> Model? {
        return self.provider.read(key: key)
    }
}
