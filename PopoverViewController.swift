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
    
    var filteredPokemon: [String] = []
    
    //    var geoFire: GeoFire!
    var thePokemon = [pokemon]
    
    var cellAttributes = CustomCollectionViewCell()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
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
        if searchActive {
            print("Filtered poks \(filteredPokemon.count)")

            return filteredPokemon.count
        }
        print("ThePokemon \(thePokemon.count)")
        return thePokemon.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        cellAttributes = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CustomCollectionViewCell
        if searchActive == true {
            let filteredFlatPokemon = filteredPokemon.flatMap { $0 }
            for filteredItems in filteredFlatPokemon {
                cellAttributes.pokemonNameLabel.text = filteredItems
            }
        } else {
            let flatPokemon = thePokemon.flatMap { $0 }
            for items in flatPokemon {
                cellAttributes.pokemonNameLabel.text = items
                print("ITEMS \(items)")
            }
        }
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
        
        let filteredFlatPokemon = thePokemon.flatMap { $0 }

        filteredPokemon = filteredFlatPokemon.filter ({(PokeAnnotation) -> Bool in
            let matchedPokemon = (scope == searchText)
            return matchedPokemon
        })
        collectionView.reloadData()
    }
    
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        let scope = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
        filterContentForSearchText(searchController.searchBar.text!, scope: scope)
    }
}



