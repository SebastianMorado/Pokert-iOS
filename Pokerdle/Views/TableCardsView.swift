//
//  TableCardsView.swift
//  Pokert
//
//  Created by Sebastian Morado on 8/22/22.
//

import SwiftUI

struct TableCardsView: View {
    @ObservedObject var gameManager : GameManager
    var arrayGameStates : [GameState] = [.start, .preflop, .flop, .turn, .river, .end]
    
    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            HStack(alignment: .center, spacing: 10) {
                Image(arrayGameStates[2...5].contains(gameManager.currentGameState) ? gameManager.hands[gameManager.currentHandIndex].tableCards[0] : "Back1")
                    .resizable()
                    .modifier(CardbackModifier())
                Image(arrayGameStates[2...5].contains(gameManager.currentGameState) ? gameManager.hands[gameManager.currentHandIndex].tableCards[1]  : "Back1")
                    .resizable()
                    .modifier(CardbackModifier())
                Image(arrayGameStates[2...5].contains(gameManager.currentGameState) ? gameManager.hands[gameManager.currentHandIndex].tableCards[2]  : "Back1")
                    .resizable()
                    .modifier(CardbackModifier())
                Image(arrayGameStates[3...5].contains(gameManager.currentGameState) ? gameManager.hands[gameManager.currentHandIndex].tableCards[3]  : "Back1")
                    .resizable()
                    .modifier(CardbackModifier())
                Image(arrayGameStates[4...5].contains(gameManager.currentGameState) ? gameManager.hands[gameManager.currentHandIndex].tableCards[4]  : "Back1")
                    .resizable()
                    .modifier(CardbackModifier())
            }
        }
    }
}

struct TableCardsView_Previews: PreviewProvider {
    static var previews: some View {
        TableCardsView(gameManager: GameManager())
            .previewLayout(.sizeThatFits)
    }
}
