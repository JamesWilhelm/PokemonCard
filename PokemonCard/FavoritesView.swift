import SwiftUI
import SDWebImageSwiftUI

struct FavoritesView: View {
    @Binding var favoritedPokemon: [Pokemon]
    @State private var editMode: Bool = false

    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 200))], spacing: 20) {
                    ForEach(favoritedPokemon) { pokemon in
                        CardView {
                            VStack {
                                Text(pokemon.name.capitalized)
                                    .font(.title2)
                                    .fontWeight(.bold)
                                
                                WebImage(url: URL(string: pokemon.sprites.front_default))
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 100, height: 100)
                                
                                ForEach(pokemon.stats, id: \.stat.name) { stat in
                                    Text("\(stat.stat.name.capitalized): \(stat.base_stat)")
                                }
                            }
                            .padding()
                        }
                        .overlay(editMode ? deleteOverlay(pokemon: pokemon) : nil)
                        
                    }
                }
                .padding()
            }
            .navigationTitle("Favorites")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        editMode.toggle()
                    }) {
                        Text(editMode ? "Done" : "Edit")
                    }
                }
            }
        }
        .background(.blue)
        .ignoresSafeArea()
    }
    
    private func deleteOverlay(pokemon: Pokemon) -> some View {
        Button(action: {
            if let index = favoritedPokemon.firstIndex(where: { $0.id == pokemon.id }) {
                favoritedPokemon.remove(at: index)
            }
        }) {
            Circle()
                .foregroundColor(.red)
                .frame(width: 30, height: 30)
                .overlay(
                    Image(systemName: "minus")
                        .foregroundColor(.white)
                )
        }
        .offset(x: -90, y: -90)
    }
}

struct FavoritesView_Previews: PreviewProvider {
    @State static var favoritedPokemon: [Pokemon] = []

    static var previews: some View {
        FavoritesView(favoritedPokemon: $favoritedPokemon)
    }
}
