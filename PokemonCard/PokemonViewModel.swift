import Foundation
import Combine

class PokemonViewModel: ObservableObject {
    @Published var pokemon: Pokemon?
    @Published var favoritedPokemon: [Pokemon] = []

    private var cancellable: AnyCancellable?

    func fetchPokemonData(pokemonId: Int) {
        let url = URL(string: "https://pokeapi.co/api/v2/pokemon/\(pokemonId)")!

        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: Pokemon.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in }, receiveValue: { [weak self] pokemon in
                self?.pokemon = pokemon
            })
    }

    func addToFavorites(pokemon: Pokemon) {
        if !favoritedPokemon.contains(where: { $0.id == pokemon.id }) {
            favoritedPokemon.append(pokemon)
        }
    }
}

