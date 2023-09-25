//
//  PokemonListView.swift
//  Pokemon
//
//  Created by сииас on 23/09/2023.
//

import SwiftUI

struct PokemonListView: View {
    @EnvironmentObject var dataManager: DataManager
    @State private var pokemonList: [Pokemon] = []

    var body: some View {
        NavigationView {
            List {
                ForEach(pokemonList, id: \.id) { pokemon in
                    NavigationLink(destination: PokemonDetailView(pokemon: .constant(pokemon))) {
                        Text(pokemon.name)
                    }
                }
            }
            .navigationTitle("Pokemon List")
            .onAppear {
                loadData()
            }
        }
    }

    func loadData() {
        dataManager.fetchPokemonList { fetchedPokemonList in
            DispatchQueue.main.async {
                if let fetchedPokemonList = fetchedPokemonList {
                    self.pokemonList = fetchedPokemonList
                }
            }
        }
    }
}


struct PokemonListView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonListView()
    }
}
