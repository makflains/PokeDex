//
//  PokemonList.swift
//  Pokemon
//
//  Created by сииас on 23/09/2023.
//

import Foundation

struct PokemonList: Decodable {
    let count: Int
    let next: URL?
    let previous: URL?
    let results: [PokemonResult]
}

struct PokemonResult: Decodable {
    let name: String
    let url: String
}
