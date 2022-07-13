//
//  PokemonDetailView.swift
//  Pokeapp
//
//  Created by Dawid Jóźwiak on 13/07/2022.
//

import SwiftUI

struct PokemonDetailView: View {
    var pokemon: Pokemon?
    
    var body: some View {
        VStack{
            Image(uiImage: (pokemon?.image ?? UIImage(named: "pokeball"))!)
                .resizable()
                .frame(width: 300, height: 300, alignment: .center)
                .scaledToFit()
                .clipShape(Circle())
            HStack {
                Image(pokemon?.isFavourite ?? false ? "star-solid" :"star-regular")
                    .resizable()
                    .frame(width: 40, height: 37.5, alignment: .center)
                    .foregroundColor(.yellow)
                Text(pokemon?.name.capitalized ?? "Unknown").fontWeight(.bold)
            }
            
        }
    }
}

struct PokemonDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonDetailView()
    }
}
