//
//  PokemonListView.swift
//  Pokeapp
//
//  Created by Dawid Jóźwiak on 13/07/2022.
//

import SwiftUI

struct PokemonListView: View {
    @ObservedObject var pokemonNetworkManager = PokemonNetworkManager()
    @State var searchedText: String = ""
    var body: some View {
        ZStack{
            if #available(iOS 15.0, *) {
                List {
                    ForEach(searchResults) { pokemon in
                        PokemonListViewCell(pokemon: pokemon)
                    }
                }.searchable(text: $searchedText, placement: .navigationBarDrawer(displayMode: .always))
                    .onAppear {
                        pokemonNetworkManager.fetchPokemonList()
                    }
            }
            if pokemonNetworkManager.isLoading {
                ProgressView().scaleEffect(3.0)
            }
        }
    }
    
    var searchResults: [Pokemon] {
        if searchedText.isEmpty {
            return pokemonNetworkManager.pokemonArray
        } else if Int(searchedText) != nil {
            return pokemonNetworkManager.pokemonArray.filter { String($0.id).prefix(searchedText.count).contains(searchedText) }
        } else {
            return pokemonNetworkManager.pokemonArray.filter { $0.name.lowercased().contains(searchedText.lowercased())}
        }
    }
}

struct PokemonListView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonListView()
    }
}

struct PokemonListViewCell: View {
    var pokemon: Pokemon
    @State private var isPressed = false
    
    var body: some View {
            HStack {
                VStack(alignment: .leading) {
                Text("\(pokemon.id). \(pokemon.name.capitalized)")
                    Text("Pokemon of type").foregroundColor(.gray)
                }
                Spacer()
                Button(action: {
                    isPressed.toggle()
                }) {
                    Image(isPressed ? "star-solid" :"star-regular").resizable().frame(width: 22.5, height: 20, alignment: .center)
                }
            }
    }
}
