//
//  DataManager.swift
//  Pokemon
//
//  Created by сииас on 23/09/2023.
//

import Foundation

class DataManager {
    static let shared = DataManager()
    
    func fetchPokemonList(completion: @escaping ([Pokemon]?) -> Void) {
        // Ваш код для загрузки списка покемонов
    }
    
    func fetchPokemonDetails(url: String, completion: @escaping (PokemonDetails?) -> Void) {
        guard let url = URL(string: url) else {
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let pokemonDetails = try decoder.decode(PokemonDetails.self, from: data)
                    completion(pokemonDetails)
                } catch {
                    print("Ошибка при декодировании данных: \(error)")
                    completion(nil)
                }
            } else {
                print("Ошибка при загрузке данных: \(error?.localizedDescription ?? "Неизвестная ошибка")")
                completion(nil)
            }
        }.resume()
    }
    
    // Другие функции для работы с данными о покемонах, если необходимо
}
