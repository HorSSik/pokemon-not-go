//
//  BaseTableViewCell.swift
//  Pokemon Not Go
//
//  Created by Dima Omelchenko on 29.10.2020.
//  Copyright © 2020 IDAP. All rights reserved.
//

import UIKit

class BaseCell<Model, Event>: UITableViewCell {
    
    // MARK: -
    // MARK: Variables
    
    private(set) public var callBackHandler: ((Event) -> ())?
    
    // MARK: -
    // MARK: Life cycle
    
    // MARK: -
    // MARK: Cell Life Cycle
    
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
    
    public func fill(model: Model, _ callBackHandler: @escaping (Event) -> ()) {
        self.callBackHandler = callBackHandler
    }
    
    open func fill(with model: Model) {
        fatalError("Abstract method used for child classes")
    }
}
