//
//  PokemonListView.swift
//  Pokemon
//
//  Created by сииас on 23/09/2023.
//

import SwiftUI

struct PokemonListView: View {
    @State private var pokemonList: [Pokemon] = []
    @State private var isFetchingData = false
    
    // Создаем экземпляр DataManager
    let dataManager = DataManager.shared
    
    var body: some View {
        NavigationView {
            List(pokemonList) { pokemon in
                NavigationLink(destination: PokemonDetailView(pokemon: pokemon)) {
                    Text(pokemon.name)
                }
            }
            .navigationBarTitle("Pokemon List")
            .onAppear {
                fetchData()
            }
        }
    }
    
    private func fetchData() {
        isFetchingData = true
        dataManager.fetchPokemonList { [self] pokemonList in
            if let pokemonList = pokemonList {
                self.pokemonList = pokemonList
            } else {
                // Обработка ошибки загрузки данных
            }
            isFetchingData = false
        }
    }
}
