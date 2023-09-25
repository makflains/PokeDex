//
//  PokemonAPI.swift
//  Pokemon
//
//  Created by сииас on 23/09/2023.
//

//
//  PokemonAPI.swift
//  Pokemon
//
//  Created by сииас on 23/09/2023.
//

import Foundation
import CoreData

class PokemonAPI {
    static let shared = PokemonAPI()

    private let baseURL = "https://pokeapi.co/api/v2"

    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Pokemon")
        container.loadPersistentStores { (_, error) in
            if let error = error {
                fatalError("Unable to load persistent stores: \(error)")
            }
        }
        return container
    }()

    private init() {}

    func fetchPokemonList(completion: @escaping ([Pokemon]?) -> Void) {
        guard let url = URL(string: "\(baseURL)/pokemon") else {
            completion(nil)
            return
        }

        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
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
                        if let id = self?.extractPokemonID(from: url) {
                            self?.fetchPokemonDetails(url: url) { pokemonDetails in
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
                    self?.savePokemonListToCoreData(pokemonArray)
                    completion(pokemonArray)
                }
            } catch {
                print("Error decoding PokemonList: \(error)")
                completion(nil)
            }
        }.resume()
    }

    private func fetchPokemonDetails(url: URL, completion: @escaping (PokemonDetails?) -> Void) {
        URLSession.shared.dataTask(with: url) { data, _, error in
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

    private func savePokemonListToCoreData(_ pokemonList: [Pokemon]) {
        let context = persistentContainer.viewContext
        for pokemonData in pokemonList {
            let entity = NSEntityDescription.entity(forEntityName: "Entity", in: context)!
            let newPokemon = NSManagedObject(entity: entity, insertInto: context) as! Entity
            newPokemon.id = pokemonData.id
            newPokemon.name = pokemonData.name
            newPokemon.elementType = pokemonData.types
            newPokemon.height = pokemonData.height
            newPokemon.weight = pokemonData.weight
            newPokemon.imageURL = pokemonData.imageUrl
            newPokemon.url = pokemonData.url
        }

        do {
            try context.save()
        } catch {
            print("Error saving Pokemon data to CoreData: \(error)")
        }
    }
}
