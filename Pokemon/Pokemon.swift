//
//  Pokemon.swift
//  Pokemon
//
//  Created by сииас on 23/09/2023.
//

struct Pokemon: Identifiable, Codable {
    let id: Int
    let name: String
    let url: String
    let elementType: String? // Стихия
    let height: Double? // Рост
    let weight: Double? // Вес
    let imageUrl: String? // URL изображения
    
    // Другие свойства, если необходимо
}
