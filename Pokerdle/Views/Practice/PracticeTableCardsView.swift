//
//  PracticeTableCardsView.swift
//  Pokert
//
//  Created by Sebastian Morado on 11/8/22.
//

import SwiftUI

struct PracticeTableCardsView: View {
    @ObservedObject var gameManager : PracticeGameManager
    var arrayGameStates : [GameState] = [.start, .preflop, .flop, .turn, .river, .end]
    
    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            HStack(alignment: .center, spacing: 10) {
                Image(arrayGameStates[2...5].contains(gameManager.currentGameState) ? gameManager.tableCards[0] : "Back1")
                    .resizable()
                    .modifier(CardbackModifier())
                Image(arrayGameStates[2...5].contains(gameManager.currentGameState) ? gameManager.tableCards[1] : "Back1")
                    .resizable()
                    .modifier(CardbackModifier())
                Image(arrayGameStates[2...5].contains(gameManager.currentGameState) ? gameManager.tableCards[2] : "Back1")
                    .resizable()
                    .modifier(CardbackModifier())
                Image(arrayGameStates[3...5].contains(gameManager.currentGameState) ? gameManager.tableCards[3] : "Back1")
                    .resizable()
                    .modifier(CardbackModifier())
                Image(arrayGameStates[4...5].contains(gameManager.currentGameState) ? gameManager.tableCards[4] : "Back1")
                    .resizable()
                    .modifier(CardbackModifier())
            }
        }
    }
}

struct PracticeTableCardsView_Previews: PreviewProvider {
    static var previews: some View {
        PracticeTableCardsView(gameManager: PracticeGameManager())
    }
}
