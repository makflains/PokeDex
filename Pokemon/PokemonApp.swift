//
//  PokemonApp.swift
//  Pokemon
//
//  Created by сииас on 23/09/2023.
//

import SwiftUI

@main
struct PokemonApp: App {
    @StateObject var dataManager = DataManager.shared
    @ObservedObject var pokemonAPI = PokemonAPI.shared

    var body: some Scene {
        WindowGroup {
            PokemonListView()
                .environmentObject(dataManager)
                .environmentObject(pokemonAPI)
        }
    }
}
