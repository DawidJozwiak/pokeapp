//
//  ContentView.swift
//  Pokeapp
//
//  Created by Dawid Jóźwiak on 13/07/2022.
//

import SwiftUI

struct ContentView: View {
    @State var isAnimating = false
    @State var shouldMoveToListView = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Image("landscape").resizable().aspectRatio(contentMode: .fill).edgesIgnoringSafeArea(.all)
                VStack {
                    Image("pokemon-logo")
                        .resizable()
                        .frame(width: 325.0, height: 200.0, alignment: .top)
                        .scaleEffect(isAnimating ? 1 : 0)
                        .animation(Animation.easeOut(duration: 2), value: isAnimating)
                        .onAppear {
                            self.isAnimating = true
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                                shouldMoveToListView = true
                            }
                        }
                    NavigationLink(destination: PokemonListView(), isActive: $shouldMoveToListView, label: {
                        EmptyView()
                    })
                    Spacer()
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
