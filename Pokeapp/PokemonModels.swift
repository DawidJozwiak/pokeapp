//
//  PokemonModels.swift
//  Pokeapp
//
//  Created by Dawid Jóźwiak on 13/07/2022.
//

import Foundation

struct PokemonUrl: Decodable {
    let name: String
    let url: String
}

struct PokemonList: Decodable {
    let results: [PokemonUrl]
}

struct Pokemon: Decodable, Identifiable {
    let id: Int
    let name: String
}
