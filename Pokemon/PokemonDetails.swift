//
//  PokemonDetails.swift
//  Pokemon
//
//  Created by сииас on 23/09/2023.
//

import Foundation

struct PokemonDetails: Decodable {
    let name: String
    let height: Int
    let weight: Int
    let sprites: Sprites
    let types: [PokemonType]

    struct Sprites: Decodable {
        let frontDefault: String

        enum CodingKeys: String, CodingKey {
            case frontDefault = "front_default"
        }
    }

    struct PokemonType: Decodable {
        let type: TypeName

        struct TypeName: Decodable {
            let name: String
        }
    }
}
