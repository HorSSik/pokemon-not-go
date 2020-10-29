//
//  PokemonTableViewCell.swift
//  Pokemon Not Go
//
//  Created by Dima Omelchenko on 29.10.2020.
//  Copyright © 2020 IDAP. All rights reserved.
//

import UIKit

enum PokemonTableViewCellEvents { }

class PokemonTableViewCell: BaseCell<PokemonData, PokemonTableViewCellEvents> {
    
    // MARK: -
    // MARK: Outleties
    
    @IBOutlet internal var titleLabel: UILabel?
    @IBOutlet internal var pokemonNameLabel: UILabel?
    
    // MARK: -
    // MARK: Overrided
    
    override func fill(with model: PokemonData) {
        let name = model.name
        
        self.titleLabel?.text = "Who's that pokemon?"
        self.pokemonNameLabel?.text = name.dropFirst().uppercased() + name
    }
}
