//
//  IDP.swift
//  Pokemon Not Go
//
//  Created by Dima Omelchenko on 28.10.2020.
//  Copyright © 2020 IDAP. All rights reserved.
//

import Foundation

public protocol IDPExtensionsProvider: class {}

public extension IDPExtensionsProvider {
    /// A proxy which hosts extensions for `self`.
    var idp: IDP<Self> {
        get {
            return IDP(self)
        }
        set {
            
        }
    }
    
    /// A proxy which hosts static extensions for the type of `self`.
    static var idp: IDP<Self>.Type {
        return IDP<Self>.self
    }
}

/// A proxy which hosts extensions of `Base`.
public struct IDP<Base> {
    /// The `Base` instance the extensions would be invoked with.
    public let base: Base
    
    public static var base: Base.Type {
        return Base.self
    }
    
    /// Construct a proxy
    ///
    /// - parameters:
    ///   - base: The object to be proxied.
    fileprivate init(_ base: Base) {
        self.base = base
    }
}
