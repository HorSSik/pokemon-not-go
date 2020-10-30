//
//  IDP.swift
//  Pokemon Not Go
//
//  Created by Dima Omelchenko on 28.10.2020.
//  Copyright © 2020 IDAP. All rights reserved.
//

import UIKit

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

public extension IDP where Base: UITableView {
    func dequeueReusableCell(withCellClass cellClass: AnyClass) -> UITableViewCell? {
        return self.base.dequeueReusableCell(withIdentifier: toString(cellClass))
    }
    
    func dequeueReusableCell(withCellClass cellClass: AnyClass, for indexPath: IndexPath) -> UITableViewCell {
        return self.base.dequeueReusableCell(withIdentifier: toString(cellClass), for: indexPath)
    }
    
    func dequeueReusableCell<T: UITableViewCell>(with cellClass: T.Type, for indexPath: IndexPath) -> T {
        return self.base.dequeueReusableCell(withIdentifier: toString(cellClass), for: indexPath) as! T
    }
    
    func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T {
        return self.dequeueReusableCell(with: T.self, for: indexPath)
    }
}
