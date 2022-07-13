//
//  PokemonListViewModel.swift
//  Pokeapp
//
//  Created by Dawid Jóźwiak on 13/07/2022.
//

import Foundation
extension PokemonListView {
    @MainActor class PokemonListViewModel: ObservableObject {
        @Published var searchedText: String = ""
        @Published var pokemonArray = [Pokemon]()
        @Published var isLoading = true
        private var pokemonNetworkManager = PokemonNetworkManager()
        
        var searchResults: [Pokemon] {
            if searchedText.isEmpty {
                return pokemonArray
            } else {
                return pokemonArray.filter { $0.name.lowercased().contains(searchedText.lowercased())}
            }
        }
        
        func fetchListData() {
            pokemonNetworkManager.fetchPokemonList { pokemonDataArray in
                self.pokemonArray = pokemonDataArray
                    .map { Pokemon(id: $0.pokemonData.id, name: $0.pokemonData.name, type: ($0.pokemonData.types.map { $0.type.name.capitalized }).joined(separator: "/"), image: $0.pokemonSprite) }
                    .sorted{ $0.id < $1.id }
                self.isLoading = false
            }
        }
    }
}
