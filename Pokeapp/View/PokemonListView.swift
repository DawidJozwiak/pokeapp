//
//  PokemonListView.swift
//  Pokeapp
//
//  Created by Dawid Jóźwiak on 13/07/2022.
//

import SwiftUI

struct PokemonListView: View {
    @StateObject var viewModel = PokemonListViewModel()
    
    var body: some View {
        NavigationView {
            ZStack{
                if #available(iOS 15.0, *) {
                    List {
                        ForEach(viewModel.searchResults.sorted { $0.isFavourite && $1.isFavourite }) { pokemon in
                            VStack(spacing: 0) {
                                Rectangle().frame(height: 10).foregroundColor(Color.white.opacity(0.1))
                                PokemonListViewCell(pokemon: pokemon)
                                Rectangle().frame(height: 10).foregroundColor(Color.white.opacity(0.1))
                            }
                        }
                        .listRowSeparator(.hidden)
                        .listRowInsets(EdgeInsets())
                    }
                    .buttonStyle(PlainButtonStyle())
                    .searchable(text: $viewModel.searchedText, placement: .navigationBarDrawer(displayMode: .always))
                    .onAppear {
                        viewModel.fetchListData()
                    }
                }
                if viewModel.isLoading {
                    ProgressView().scaleEffect(3.0)
                }
            }
        }.navigationBarBackButtonHidden(true).navigationTitle("My Pokemons")
    }
    
}

struct PokemonListView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonListView()
    }
}

struct PokemonListViewCell: View {
    @State var pokemon: Pokemon
    
    var body: some View {
        HStack {
            Image(uiImage: pokemon.image!).resizable().frame(width: 75, height: 75, alignment: .center)
            VStack(alignment: .leading) {
                Text("\(pokemon.name.capitalized)").fontWeight(.bold)
                Text("Pokemon of type \(pokemon.type)")
                    .foregroundColor(.gray).font(.footnote)
            }
            Spacer()
            Button(action: {
                self.pokemon.isFavourite.toggle()
            }) {
                Image(pokemon.isFavourite ? "star-solid" :"star-regular")
                    .resizable()
                    .frame(width: 40, height: 37.5, alignment: .center)
                    .foregroundColor(.yellow)
            }
        }.background(NavigationLink("", destination: PokemonDetailView(pokemon: pokemon)).opacity(0))
    }
}
