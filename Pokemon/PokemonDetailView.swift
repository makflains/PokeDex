//
//  PokemonDetailView.swift
//  Pokemon
//
//  Created by сииас on 23/09/2023.
//

import SwiftUI

struct PokemonDetailView: View {
    let pokemon: Pokemon
    @State private var pokemonDetails: PokemonDetails? = nil
    @State private var isFetchingData = false
    
    // Создаем экземпляр DataManager
    let dataManager = DataManager.shared
    
    var body: some View {
        VStack {
            Text("Name: \(pokemon.name)")
                .font(.largeTitle)
            
            if let firstType = pokemonDetails?.pokemonTypes.first?.type.name {
                Text("Element Type: \(firstType)")
            }
            
            if let height = pokemonDetails?.height {
                Text("Height: \(height) dm")
            }
            
            if let weight = pokemonDetails?.weight {
                Text("Weight: \(weight) hg")
            }
            
            if let imageUrl = pokemonDetails?.sprites.front_default, let url = URL(string: imageUrl), let imageData = try? Data(contentsOf: url), let uiImage = UIImage(data: imageData) {
                Image(uiImage: uiImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100)
            }
            
            Spacer()
        }
        .navigationBarTitle("Pokemon Detail")
        .onAppear {
            fetchData()
        }
    }
    
    private func fetchData() {
        isFetchingData = true
        dataManager.fetchPokemonDetails(url: pokemon.url) { [self] pokemonDetails in
            if let pokemonDetails = pokemonDetails {
                self.pokemonDetails = pokemonDetails
            } else {
                // Обработка ошибки загрузки данных
            }
            isFetchingData = false
        }
    }
}
