//
//  TableSection.swift
//  Pokemon Not Go
//
//  Created by Dima Omelchenko on 30.10.2020.
//  Copyright © 2020 IDAP. All rights reserved.
//

import UIKit

protocol SectionType {
    
    var model: [Any] { get }
    var cell: UITableViewCell.Type { get }
    var callBackHandler: ((Any) -> ())? { get }
}

class TableSection: SectionType {
    
    // MARK: -
    // MARK: Variables
    
    private(set) public var model: [Any]
    private(set) public var cell: UITableViewCell.Type
    private(set) public var callBackHandler: ((Any) -> ())?
    
    // MARK: -
    // MARK: Initialization
    
    public init<Model, Cell, Event>(
        model: [Model],
        cell: Cell.Type,
        callBackHandler: @escaping (Any) -> ()
    )
        where Cell: BaseCell<Model, Event>
    {
        self.model = model
        self.cell = cell
        self.callBackHandler = callBackHandler
    }
}
