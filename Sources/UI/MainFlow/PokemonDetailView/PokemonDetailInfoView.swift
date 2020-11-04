//
//  PokemonDetailInfoView.swift
//  Pokemon Not Go
//
//  Created by Dima Omelchenko on 30.10.2020.
//  Copyright © 2020 IDAP. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa

import Kingfisher

class PokemonDetailInfoView: BaseView<PokemonDetailInfoViewModel> {
    
    // MARK: -
    // MARK: Outleties
    
    @IBOutlet internal var backButton: UIButton?
    
    @IBOutlet internal var contentView: UIView?
    
    @IBOutlet internal var pokemonBackDefaultImageView: UIImageView?
    @IBOutlet internal var pokemonBackImageView: UIImageView?
    @IBOutlet internal var pokemonFrontDefaultImageView: UIImageView?
    @IBOutlet internal var pokemonFrontImageView: UIImageView?
    
    @IBOutlet internal var nameLabel: UILabel?
    @IBOutlet internal var orderLabel: UILabel?
    @IBOutlet internal var weightLabel: UILabel?
    @IBOutlet internal var heightLabel: UILabel?
    
    // MARK: -
    // MARK: Private
    
    private func showView(isHidden: Bool) {
        self.contentView?.isHidden = isHidden
        self.contentView?.alpha = 0
        
        UIView
            .animate(
                withDuration: 0.5,
                animations: {
                    self.contentView?.alpha = 1
                },
                completion: { _ in }
            )
    }
    
    // MARK: -
    // MARK: Overrided
    
    override func fill(with viewModel: PokemonDetailInfoViewModel) {
        super.fill(with: viewModel)
        
        viewModel.pokemonDetailModel.do { pokemonDetailModel in
            self.showView(isHidden: false)
            
            self.pokemonBackDefaultImageView?.kf.setImage(with: viewModel.backDefaultUrl)
            self.pokemonBackImageView?.kf.setImage(with: viewModel.backUrl)
            self.pokemonFrontDefaultImageView?.kf.setImage(with: viewModel.frontDefaultUrl)
            self.pokemonFrontImageView?.kf.setImage(with: viewModel.frontUrl)
            
            self.nameLabel?.text = viewModel.pokemonName
            self.orderLabel?.text = viewModel.pokemonOrder
            self.weightLabel?.text = viewModel.pokemonWeight
            self.heightLabel?.text = viewModel.pokemonHeight
        }
    }
}
