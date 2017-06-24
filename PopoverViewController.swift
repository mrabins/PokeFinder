//
//  PopoverViewController.swift
//  PokeFinder
//
//  Created by Mark Rabins on 3/26/17.
//  Copyright © 2017 self.edu. All rights reserved.
//

import UIKit
import FirebaseDatabase
import MapKit

class PopoverViewController: UIViewController {
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    let searchController = UISearchController(searchResultsController: nil)
    
    var filteredPokemon = [Pokemon]()
    var pokemon = [Pokemon]()
    var inSearchMode = false
    
    
    //    var geoFire: GeoFire!
    
    var cellAttributes = PokemonCollectionViewCell()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isHidden = true
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        self.searchBar.delegate = self
        
        print("the searchBar \(searchController)")
        
        
        loadPokemonList()
    }
    
    
    func loadPokemonList() {
        for i in 1..<152 {
            let pokes = Pokemon(number: i)
            pokemon.append(pokes)
        }
    }
    
    func filterContentForSearchText(_ searchText: String) {
        inSearchMode = true
        filteredPokemon = pokemon.filter({( pokemon: Pokemon) -> Bool in
            return pokemon.pokemonName.lowercased().contains(searchText.lowercased())
        })
        
        collectionView.reloadData()
        print("collectionView.reloadData")
        
    }
    
}

extension PopoverViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        // What to do when selected
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if inSearchMode {
            return filteredPokemon.count
        }
        return pokemon.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        cellAttributes = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! PokemonCollectionViewCell
        
        cellAttributes.backgroundColor = UIColor(red: 221/255, green: 233/255, blue: 241/255, alpha: 0.25)
        
        var poke: Pokemon
        
        if inSearchMode {
            poke = filteredPokemon[indexPath.row]
            print("the poke is \(poke.pokemonName)")
        }
        poke = pokemon[indexPath.row]
        
        cellAttributes.pokemonNameLabel.text = poke.pokemonName.capitalized
        cellAttributes.pokemonImageView.image = UIImage(named: "\(poke.pokemonNumber)")
    
        return cellAttributes
        
    }
}

extension PopoverViewController: UISearchResultsUpdating, UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = nil
        searchBar.showsCancelButton = false
        searchBar.endEditing(true)
        inSearchMode = false
        collectionView.reloadData()
    }
    
    
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchBar.text!)
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        inSearchMode = true
        self.searchBar.showsCancelButton = true
        filterContentForSearchText(searchBar.text!)
        
    }
}
