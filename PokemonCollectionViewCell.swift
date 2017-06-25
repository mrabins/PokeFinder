//
//  PokemonCollectionViewCell.swift
//  PokeFinder
//
//  Created by Mark Rabins on 3/26/17.
//  Copyright © 2017 self.edu. All rights reserved.
//

import UIKit

class PokemonCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var pokemonImageView: UIImageView!
    @IBOutlet weak var pokemonNameLabel: UILabel!
    
    var pokemon: Pokemon!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        layer.cornerRadius = 5.0
        
    }
    
    func configureCell(_ pokemon: Pokemon) {
        self.pokemon = pokemon
        pokemonImageView.image = UIImage(named: "\(self.pokemon.pokemonNumber)")
        pokemonNameLabel.text = self.pokemon.pokemonName.capitalized
    }
    
}
