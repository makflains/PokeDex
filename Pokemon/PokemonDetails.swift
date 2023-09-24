//
//  PokemonDetails.swift
//  Pokemon
//
//  Created by сииас on 23/09/2023.
//

import Foundation

struct PokemonDetails: Codable {
    let id: Int
    let name: String
    let pokemonTypes: [PokemonType] // Изменим имя типа на `pokemonTypes`
    let height: Int
    let weight: Int
    let sprites: Sprites
    
    struct PokemonType: Codable { // Переименуем тип в `PokemonType`
        let type: TypeName
        struct TypeName: Codable {
            let name: String
        }
    }
    
    struct Sprites: Codable {
        let front_default: String
    }
}
