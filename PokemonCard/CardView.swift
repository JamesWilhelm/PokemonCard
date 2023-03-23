//
//  CardView.swift
//  PokemonCard
//
//  Created by James Wilhelm on 3/23/23.
//

import SwiftUI

struct CardView<Content: View>: View {
    var content: () -> Content

    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }

    var body: some View {
        content()
            .frame(minWidth: 0, maxWidth: .infinity)
            .background(Color.mint).opacity(50)
            .cornerRadius(10)
            .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 5)
            .padding([.top, .horizontal])

        
    }
}

