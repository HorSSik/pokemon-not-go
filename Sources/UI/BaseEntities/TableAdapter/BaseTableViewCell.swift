//
//  BaseTableViewCell.swift
//  Pokemon Not Go
//
//  Created by Dima Omelchenko on 29.10.2020.
//  Copyright © 2020 IDAP. All rights reserved.
//

import UIKit

protocol BaseCellType {
    
    func fill(model: Any, _ callBackHandler: @escaping (Any) -> ())
}

class BaseCell<Model, Event>: UITableViewCell, BaseCellType {
    
    // MARK: -
    // MARK: Variables
    
    private(set) public var callBackHandler: ((Event) -> ())?
    
    // MARK: -
    // MARK: Life cycle
    
    override open func awakeFromNib() {
        super.awakeFromNib()
        
        self.selectionStyle = .none
    }

    override open func prepareForReuse() {
        self.callBackHandler = nil
        
        super.prepareForReuse()
    }
    
    // MARK: -
    // MARK: Public
    
    public func fill(model: Any, _ callBackHandler: @escaping (Any) -> ()) {
        if let value = model as? Model {
            self.callBackHandler = callBackHandler
            
            self.fill(with: value)
        }
    }
    
    open func fill(with model: Model) {
        fatalError("Abstract method used for child classes")
    }
}
