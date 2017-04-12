//
//  PopoverViewController.swift
//  PokeFinder
//
//  Created by Mark Rabins on 3/26/17.
//  Copyright © 2017 self.edu. All rights reserved.
//

import UIKit

class PopoverViewController: UIViewController {
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    let searchController = UISearchController(searchResultsController: nil)
    
    var searchActive = false
    
    var filteredPokemon = [String]()
    let pokeAnno = [PokeAnnotation]()
    
    //    var geoFire: GeoFire!
    var thePokemon = [String]()
    
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
        
        cellAttributes.backgroundColor = UIColor(red: 221/255, green: 233/255, blue: 241/255, alpha: 0.25)
        
        
        cellAttributes = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CustomCollectionViewCell
        cellAttributes.pokemonNameLabel.text = pokemon[indexPath.row].uppercased()
//        cellAttributes.pokemonImageLabel.image = UIImage(named: imageName)
        
        
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
    
    func filterContentForSearchText(_ searchText: String, scope: String = "Pokemon") {
        searchActive = true
        
        
//        
//        //        let filteredFlatPokemon = thePokemon.flatMap { $0 }
//        //
//                filteredPokemon = pokemon.filter ({(pokemon) -> Bool in
//                    let matchedPokemon = (scope == searchText)
//                    return matchedPokemon
//                })
//                collectionView.reloadData()
    }
    
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        let scope = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
        filterContentForSearchText(searchController.searchBar.text!, scope: scope)
    }
}



