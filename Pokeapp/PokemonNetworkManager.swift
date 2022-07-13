//
//  PokemonNetworkManager.swift
//  Pokeapp
//
//  Created by Dawid Jóźwiak on 13/07/2022.
//

import Foundation
import Combine

class PokemonNetworkManager: ObservableObject{
    @Published var pokemonArray = [Pokemon]()
    @Published var isLoading = true
    private var cancellable: AnyCancellable?
    
    func fetchPokemonList() {
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon/?offset=0&limit=1154") else { fatalError("Invalid URL") }
        cancellable = URLSession.shared.dataTaskPublisher(for: url).map { $0.data }
        .decode(type: PokemonList.self, decoder: JSONDecoder())
        .flatMap { response in
            Publishers.MergeMany(response.results.map(self.fetchPokemon)).collect()
        }.receive(on: DispatchQueue.main)
            .sink (receiveCompletion: { _ in }, receiveValue: { pokemons in
                self.pokemonArray = pokemons.sorted { $0.id < $1.id }
                self.isLoading = false
            })
    }
    
    private func fetchPokemon(pokemonUrl: PokemonUrl) -> AnyPublisher<Pokemon, Error> {
        guard let url = URL(string: pokemonUrl.url) else { fatalError("Invalid Pokemon URL") }
        return URLSession.shared.dataTaskPublisher(for: url).map { $0.data }
        .decode(type: Pokemon.self, decoder: JSONDecoder())
        .eraseToAnyPublisher()
    }
}
