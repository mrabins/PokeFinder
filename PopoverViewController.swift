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
    
    var searchActive = false
    
    var filteredPokemon = [Pokemon]()
    var pokemon = [Pokemon]()

    
    
    //    var geoFire: GeoFire!
    
    var cellAttributes = CustomCollectionViewCell()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isHidden = true
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = true
        definesPresentationContext = true
        searchController.searchBar.delegate = self
        
        loadPokemonList()
        
    }
    
    //    func createSighting(forLocation location: CLLocation, withPokemon pokeId: Int) {
    //        geoFire.setLocation(location, forKey: "\(pokeId)")
    //    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    func loadPokemonList() {
        for i in 1..<152 {
            let poke = Pokemon(number: i)
            pokemon.append(poke)
        }
    }
}


extension PopoverViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        // What to do when selected
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if searchActive == true {
            return filteredPokemon.count
        } else {
            return pokemon.count
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        cellAttributes = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CustomCollectionViewCell
        
        let poke: Pokemon!
        
        if searchController.isActive && searchController.searchBar.text != "" {
            poke = filteredPokemon[indexPath.row]
        } else {
            poke = pokemon[indexPath.row]
        }
        

        cellAttributes.backgroundColor = UIColor(red: 221/255, green: 233/255, blue: 241/255, alpha: 0.25)
  
        cellAttributes.pokemonNameLabel.text = poke.pokemonName.capitalized
        cellAttributes.pokemonImageView.image = UIImage(named: "\(poke.pokemonNumber)")
        
        
        return cellAttributes

        }
    
    
}

extension PopoverViewController: UISearchBarDelegate, UISearchResultsUpdating {
    
    // Handles the search feature
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchActive = true
    }
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchActive = false
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false
    }
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        filterContentForSearchText(searchBar.text!)
    }
    
    
    func filterContentForSearchText(_ searchText: String, scope: String = "Pokemon") {
        searchActive = true
        
        filteredPokemon = pokemon.filter({( pokemon : Pokemon) -> Bool in
        return pokemon.pokemonName.lowercased().contains(searchText.lowercased())
        })
        collectionView.reloadData()
        
    }
    
    
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
}



