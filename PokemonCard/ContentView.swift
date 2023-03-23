import SwiftUI
import SDWebImageSwiftUI

struct ContentView: View {
    @StateObject private var viewModel = PokemonViewModel()
    @State private var showBack = false
    @State private var rotation: Double = 0
    @State private var showFavorites = false

    var body: some View {
        
        
        NavigationView {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [.red, .black]), startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)

                VStack {
    

                    if let pokemon = viewModel.pokemon {
                        CardView {
                            Group {
                                if showBack {
                                    VStack {
                                        
                                        Text(pokemon.name.capitalized)
                                            .font(.largeTitle)
                                        
                                        ForEach(pokemon.stats, id: \.stat.name) { stat in
                                            Text("\(stat.stat.name.capitalized): \(stat.base_stat)")
                                        }
                                    }
                                    .padding()
                                    .rotation3DEffect(.degrees(180), axis: (x: 0.0, y: 1.0, z: 0.0))
                                } else {
                                    VStack{
                                        WebImage(url: URL(string: pokemon.sprites.front_default))
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 200, height: 200)
                                        Text("Click Card to view more info")
                                            .foregroundColor(.gray)
                                    }
                                }
                            }
                            .rotation3DEffect(.degrees(rotation), axis: (x: 0.0, y: 1.0, z: 0.0))
                        }
                        .onTapGesture {
                            withAnimation(.spring()) {
                                rotation += 180
                                showBack.toggle()
                            }
                        }
                    } else {
                        Text("Click Random to begin")
                            .foregroundColor(.white)
                            .frame(width: 200, height: 220) 
                        
                    }
                    
                    Button(action: {
                        let randomId = Int.random(in: 1...898) // Generate a random Pokémon ID between 1 and 898
                        viewModel.fetchPokemonData(pokemonId: randomId)
                        showBack = false
                        rotation = 0
                    }) {
                        Text("Random")
                            .font(.title)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                        
                    }

                    HStack {
                        Button(action: {
                            if let pokemon = viewModel.pokemon {
                                viewModel.addToFavorites(pokemon: pokemon)
                            }
                        }) {
                            Text("Favorite")
                                .padding()
                                .background(Color.purple)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }

                        Button(action: {
                            showFavorites.toggle()
                        }) {
                            Text("Favorites")
                                .padding()
                                .background(Color.green)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                    }
                }
            }
            .sheet(isPresented: $showFavorites) {
                FavoritesView(favoritedPokemon: $viewModel.favoritedPokemon)
            }
            .navigationTitle("Pokémon Randomizer")
            .accentColor(.white)
        }
    }
}
   
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

