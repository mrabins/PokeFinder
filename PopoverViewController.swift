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
import CoreLocation

class PopoverViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    let searchController = UISearchController(searchResultsController: nil)
    
    var filteredPokemon = [Pokemon]()
    var pokemon = [Pokemon]()
    var inSearchMode = false
    var theViewController = ViewController()
    let locationManager = CLLocationManager()
    var locationValue = CLLocationCoordinate2D()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isHidden = true
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        self.searchBar.delegate = self
        
        loadPokemonList()
        
        // Requests Authorization from the User
        self.locationManager.requestAlwaysAuthorization()
        
        // For use in the foreground
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }
    
    
    func loadPokemonList() {
        for i in 1..<152 {
            let pokes = Pokemon(number: i)
            pokemon.append(pokes)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locationValue = manager.location!.coordinate
    }
    
    func filterContentForSearchText(_ searchText: String) {
        inSearchMode = true
        filteredPokemon = pokemon.filter({( pokemon: Pokemon) -> Bool in
            return pokemon.pokemonName.lowercased().contains(searchText.lowercased())
        })
        collectionView.reloadData()
    }
}

extension PopoverViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        var pokeyToShow: Pokemon
        
        let latitude = locationValue.latitude
        let longitude = locationValue.longitude
        let cLLocationFromLatAndLong = CLLocation(latitude: latitude, longitude: longitude)
        
        if filteredPokemon.count >= 1 {
            pokeyToShow = filteredPokemon[indexPath.row]
        }
            pokeyToShow = pokemon[indexPath.row]
        
        _ = dismiss(animated: false, completion: nil)

//        theViewController.createSighting(forLocation: cLLocationFromLatAndLong, withPokemon: pokeyToShow.pokemonNumber)
//        
  
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if inSearchMode {
            return filteredPokemon.count
        }
        return pokemon.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cellAttributes = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? PokemonCollectionViewCell {
            
            cellAttributes.backgroundColor = UIColor(red: 221/255, green: 233/255, blue: 241/255, alpha: 0.25)
            
            let poke: Pokemon!
            
            if inSearchMode {
                poke = filteredPokemon[indexPath.row]
                cellAttributes.configureCell(poke)
            } else {
                poke = pokemon[indexPath.row]
                cellAttributes.configureCell(poke)
            }
            cellAttributes.configureCell(poke)
            return cellAttributes
        } else {
            return UICollectionViewCell()
        }
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
