//
//  Pokemon.swift
//  Pokemon
//
//  Created by сииас on 23/09/2023.
//

import Foundation

struct Pokemon: Decodable, Identifiable {
    var id: UUID
    var name: String
    var height: Float
    var weight: Float
    var imageUrl: String
    var url: String
    var types: String

    struct PokemonType: Decodable {
        var type: TypeName

        struct TypeName: Decodable {
            var name: String
        }
    }

    init(id: UUID, name: String, height: Float, weight: Float, imageUrl: String, url: String, types: String) {
        self.id = id
        self.name = name
        self.height = height
        self.weight = weight
        self.imageUrl = imageUrl
        self.url = url
        self.types = types
    }
}
