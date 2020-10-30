//
//  TableAdapter.swift
//  Pokemon Not Go
//
//  Created by Dima Omelchenko on 30.10.2020.
//  Copyright © 2020 IDAP. All rights reserved.
//

import UIKit

enum TableAdapterEvents {
    
    case didSelect(IndexPath)
}

class TableAdapter: NSObject, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: -
    // MARK: Variables
    
    public var sections = [SectionType]() {
        didSet {
            self.tableView?.reloadData()
        }
    }
    
    private(set) public weak var tableView: UITableView?
    private(set) public var callBackHandler: ((TableAdapterEvents) -> ())?
    
    // MARK: -
    // MARK: Initialization
    
    public init(
        tableView: UITableView?,
        cellType: [UITableViewCell.Type],
        _ callBackHandler: @escaping (TableAdapterEvents) -> ()
    ) {
        self.tableView = tableView
        self.callBackHandler = callBackHandler
        
        super.init()
        
        tableView?.delegate = self
        tableView?.dataSource = self
        
        cellType.forEach {
            self.tableView?.register($0)
        }
    }
    
    // MARK: -
    // MARK: UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.sections[section].model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = self.sections[indexPath.section]
        let cell = tableView.dequeueReusableCell(withIdentifier: toString(section.cell), for: indexPath)
        
        let tableCell = cell as? BaseCellType
        let model = section.model[indexPath.row]
        
        tableCell?.fill(model: model) { _ in
            
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.callBackHandler?(.didSelect(indexPath))
    }
}
