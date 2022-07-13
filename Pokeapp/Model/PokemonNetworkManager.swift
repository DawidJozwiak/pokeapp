//
//  PokemonNetworkManager.swift
//  Pokeapp
//
//  Created by Dawid Jóźwiak on 13/07/2022.
//

import Foundation
import Combine
import UIKit

class PokemonNetworkManager: ObservableObject{
    private var cancellable: AnyCancellable?
    
    func fetchPokemonList(_ completion: @escaping ([PokemonDataWithSprites]) -> Void) {
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon/?offset=0&limit=1154") else { fatalError("Invalid URL") }
        cancellable = URLSession.shared.dataTaskPublisher(for: url).map { $0.data }
        .decode(type: PokemonList.self, decoder: JSONDecoder())
        .flatMap { response in
            Publishers.MergeMany(response.results.map(self.fetchPokemon)).collect()
        }.receive(on: DispatchQueue.main)
            .sink (receiveCompletion: { _ in }, receiveValue: { pokemons in
                completion(pokemons)
            })
    }
    
    private func fetchPokemon(pokemonUrl: PokemonUrl) -> AnyPublisher<PokemonDataWithSprites, Error> {
        guard let url = URL(string: pokemonUrl.url) else { fatalError("Invalid Pokemon URL") }
        return URLSession.shared.dataTaskPublisher(for: url).map { $0.data }
        .decode(type: PokemonData.self, decoder: JSONDecoder())
        .flatMap { response in
            self.downloadImage(pokemonData: response)
        }.eraseToAnyPublisher()
    }
    
    func downloadImage(pokemonData: PokemonData) -> AnyPublisher<PokemonDataWithSprites, Error> {
       guard let url = URL(string:"https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(pokemonData.id).png") else { fatalError("Invalid image Url") }
        return URLSession.shared.dataTaskPublisher(for: url)
        .mapError { $0 as Error }
        .map { PokemonDataWithSprites(pokemonData: pokemonData, pokemonSprite: (UIImage(data: $0.data) ?? UIImage(named: "pokeball"))!) }
        .eraseToAnyPublisher()
    }
}
