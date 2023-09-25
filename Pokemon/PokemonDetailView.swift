//
//  PokemonDetailView.swift
//  Pokemon
//
//  Created by сииас on 23/09/2023.
//

import SwiftUI
import CoreData

public struct PokemonDetailView: View {
    @Binding var pokemon: Pokemon
    @State private var pokemonDetails: PokemonDetails?
    private var dataManager = DataManager.shared

    public init(pokemon: Binding<Pokemon>) {
        self._pokemon = pokemon
    }

    public var body: some View {
        VStack {
            if let pokemonDetails = pokemonDetails {
                Text(pokemonDetails.name)
                    .font(.title)
                Text("Type: \(pokemonDetails.types[0].type.name)")
                Text("Height: \(pokemonDetails.height)")
                Text("Weight: \(pokemonDetails.weight)")

                AsyncImage(url: URL(string: pokemon.imageUrl)) { phase in
                    if let image = phase.image {
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    } else if phase.error != nil {
                        Text("Error loading image")
                    } else {
                        ProgressView()
                    }
                }
                .frame(width: 100, height: 100)
            } else {
                Text("Loading...")
                    .onAppear {
                        loadDetails()
                    }
            }
        }
    }

    func loadDetails() {
        if let url = URL(string: pokemon.url) {
            dataManager.fetchPokemonDetails(url: url) { fetchedPokemonDetails in
                DispatchQueue.main.async {
                    self.pokemonDetails = fetchedPokemonDetails
                }
            }
        } else {
            print("Invalid URL: \(pokemon.url)")
        }
    }

}

struct PokemonDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let previewPokemon = Pokemon(
            id: UUID(),
            name: "Bulbasaur",
            height: 7.0,
            weight: 69.0,
            imageUrl: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png",
            url: "https://pokeapi.co/api/v2/pokemon/1/",
            types: "Grass"
        )
        return PokemonDetailView(pokemon: .constant(previewPokemon))
    }
}
