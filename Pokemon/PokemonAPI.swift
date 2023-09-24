//
//  PokemonAPI.swift
//  Pokemon
//
//  Created by сииас on 23/09/2023.
//

import Foundation

class PokemonAPI {
    static let baseURL = "https://pokeapi.co/api/v2"
    
    static func fetchPokemonList(completion: @escaping (PokemonList?) -> Void) {
        guard let url = URL(string: "\(baseURL)/pokemon") else {
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let pokemonList = try decoder.decode(PokemonList.self, from: data)
                    completion(pokemonList)
                } catch {
                    print("Error decoding PokemonList: \(error)")
                    completion(nil)
                }
            } else if let error = error {
                print("Error fetching PokemonList: \(error)")
                completion(nil)
            }
        }.resume()
    }
}
