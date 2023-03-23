//
//  Pokemon.swift
//  PokemonCard
//
//  Created by James Wilhelm on 3/23/23.
//

import Foundation

struct Pokemon: Codable, Identifiable {
    let id: Int
    let name: String
    let sprites: Sprites
    let stats: [Stat]
}

struct Sprites: Codable {
    let front_default: String
}

struct Stat: Codable {
    let base_stat: Int
    let stat: StatInfo
}

struct StatInfo: Codable {
    let name: String
}

