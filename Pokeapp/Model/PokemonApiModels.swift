//
//  PokemonModels.swift
//  Pokeapp
//
//  Created by Dawid Jóźwiak on 13/07/2022.
//

import Foundation
import UIKit

struct PokemonUrl: Decodable {
    let name: String
    let url: String
}

struct PokemonList: Decodable {
    let results: [PokemonUrl]
}

struct PokemonData: Decodable, Identifiable {
    let id: Int
    let name: String
    let types: [TypeElement]
}

struct PokemonDataWithSprites {
    let pokemonData: PokemonData
    let pokemonSprite: UIImage
}

struct TypeElement: Codable {
    let slot: Int
    let type: Species
}

struct Species: Codable {
    let name: String
    let url: String
}
