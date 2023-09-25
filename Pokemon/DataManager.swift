//
//  DataManager.swift
//  Pokemon
//
//  Created by сииас on 23/09/2023.
//

import CoreData
import Combine
import SwiftUI

class DataManager: ObservableObject {
    static let shared = DataManager()
    private let baseURL = "https://pokeapi.co/api/v2"
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Pokemon")
        container.loadPersistentStores { (description, error) in
            if let error = error {
                fatalError("Unable to load persistent stores: \(error)")
            }
        }
        return container
    }()
    
    func savePokemon(_ pokemon: Pokemon) {
        let context = persistentContainer.viewContext
        let entity = Entity(context: context)
        
        entity.id = pokemon.id
        entity.name = pokemon.name
        entity.elementType = pokemon.types
        entity.height = pokemon.height
        entity.weight = pokemon.weight
        entity.imageURL = pokemon.imageUrl
        entity.url = pokemon.url
        
        do {
            try context.save()
        } catch {
            print("Error saving Pokemon data: \(error)")
        }
    }
    
    func fetchPokemonList(completion: @escaping ([Pokemon]?) -> Void) {
        guard let url = URL(string: "\(baseURL)/pokemon") else {
            completion(nil)
            return
        }

        URLSession.shared.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }

            do {
                let decoder = JSONDecoder()
                let pokemonList = try decoder.decode(PokemonList.self, from: data)

                let dispatchGroup = DispatchGroup()
                var pokemonArray: [Pokemon] = []

                for result in pokemonList.results {
                    dispatchGroup.enter()

                    if let url = result.url {
                        if let id = self?.extractPokemonID(from: url.absoluteString) {
                            self.fetchPokemonDetails(url: url) { pokemonDetails in
                                if let pokemonDetails = pokemonDetails {
                                    let pokemon = Pokemon(
                                        id: id,
                                        name: result.name,
                                        height: pokemonDetails.height,
                                        weight: pokemonDetails.weight,
                                        imageUrl: pokemonDetails.sprites.frontDefault
                                    )
                                    pokemonArray.append(pokemon)
                                }

                                dispatchGroup.leave()
                            }
                        } else {
                            dispatchGroup.leave()
                            print("Invalid Pokemon ID")
                        }
                    } else {
                        dispatchGroup.leave()
                        print("Invalid Pokemon URL")
                    }
                }

                dispatchGroup.notify(queue: .main) {
                    completion(pokemonArray)
                }
            } catch {
                print("Error decoding PokemonList: \(error)")
                completion(nil)
            }
        }.resume()
    }

    func fetchPokemonDetails(url: URL, completion: @escaping (PokemonDetails?) -> Void) {
        URLSession.shared.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }

            do {
                let decoder = JSONDecoder()
                let pokemonDetails = try decoder.decode(PokemonDetails.self, from: data)
                completion(pokemonDetails)
            } catch {
                print("Error decoding PokemonDetails: \(error)")
                completion(nil)
            }
        }.resume()
    }

    private func extractPokemonID(from url: URL) -> Int? {
        if let idString = url.lastPathComponent, let id = Int(idString) {
            return id
        }
        return nil
    }
}
