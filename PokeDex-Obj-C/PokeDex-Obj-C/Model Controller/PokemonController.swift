//
//  PokemonController.swift
//  PokeDex-Obj-C
//
//  Created by Seschwan on 11/22/19.
//  Copyright © 2019 Seschwan. All rights reserved.
//

import Foundation
import UIKit

class PokemonController: NSObject {
    
    let pokemonBaseURL = URL(string: "https://pokeapi.co/api/v2/pokemon?limit=20")!
    
    @objc (sharedController) static let shared = PokemonController()
    
    @objc var pokemonArray = [Pokemon]()
    
    @objc func fetchPokemon(completion: @escaping ([Pokemon]?, Error?) -> Void) {
        let request = URLRequest(url: pokemonBaseURL)
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                NSLog("There was an error in the dataTask: \(error)")
                return
            }
            
            guard let data = data else {
                NSLog("Error returning data in dataTask: \(String(describing: error))")
                return
            }
            
            do {
                guard let dictionary = try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any],
                    let pokemonDictionaries = dictionary["results"] as? [[String : Any]] else {
                        completion(nil, error)
                        return
                }
                self.pokemonArray = pokemonDictionaries.map { Pokemon(dictionary: $0)}
                completion(self.pokemonArray, nil)
                print(pokemonDictionaries)
            } catch {
                completion(nil, error)
                return
            }
        }.resume()
    }
    
    @objc func fillInDetails(pokemon: Pokemon) {
        let url = URL(string: pokemon.pokemonURL!)!
        print(url.absoluteString)
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                NSLog("There was an error in fillInDetails: \(error)")
                return
            }
            
            guard let data = data else {
                NSLog("Error returning data in FillInDetails: \(String(describing: error))")
                return
            }
            
            do {
                guard let dictionary = try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any] else { return }
                var abilityNames = [String]()
                
                guard let identifier = dictionary["id"] as? Int else { return }
                pokemon.id = String(identifier)
                
                if let abilities = dictionary["abilities"] as? [[String: Any]] {
                    for ability in abilities {
                        let innerAbility = ability["ability"] as! [String: Any]
                        let name = innerAbility["name"] as! String
                        abilityNames.append(name)
                    }
                    pokemon.pokemonAbilites = abilityNames
                    print(abilityNames)
                }
                
                if let sprites = dictionary["sprites"] as? [String: Any] {
                    let spriteStringUrl: String = sprites["front_default"] as! String
                    let url = URL(string: spriteStringUrl)!
                    self.getImage(url: url, completion: { (image, _) in
                        pokemon.pokemonImage = image!
                    })
                }
                
            } catch {
                return
            }
        }.resume()
    }
    
    
    func getImage(url: URL, completion: @escaping (UIImage?, Error?) -> Void) {
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                NSLog("Error \(error)")
                completion(nil, error)
                return
            }
            
            guard let data = data else {
                NSLog("Error returning image: \(error)")
                completion(nil, error)
                return
            }
            let image = UIImage(data: data);
            completion(image, error);
        }.resume()
    }
    
}
