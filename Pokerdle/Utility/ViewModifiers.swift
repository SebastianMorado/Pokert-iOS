//
//  ViewModifiers.swift
//  Pokert
//
//  Created by Sebastian Morado on 8/22/22.
//

import SwiftUI

struct CardbackModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .scaledToFit()
            .frame(minWidth: 20, maxWidth: 100, minHeight: 20, maxHeight: 100)
            .brightness(0.6)
            .contrast(0.6)
    }
}

struct CardbackModifier2: ViewModifier {
    func body(content: Content) -> some View {
        content
            .scaledToFit()
            .frame(minWidth: 20, maxWidth: 90, minHeight: 20, maxHeight: 90)
    }
}
