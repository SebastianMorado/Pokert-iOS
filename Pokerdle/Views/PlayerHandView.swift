//
//  PlayerHandView.swift
//  Pokert
//
//  Created by Sebastian Morado on 8/22/22.
//

import SwiftUI

struct PlayerHandView: View {
    @ObservedObject var gameManager : GameManager
    
    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            HStack(alignment: .center, spacing: 0) {
                Image(gameManager.currentGameState != .start ? gameManager.hands[gameManager.currentHandIndex].playerHand[0] : "Back1")
                    .resizable()
                    .modifier(CardbackModifier())
                Image(gameManager.currentGameState != .start ? gameManager.hands[gameManager.currentHandIndex].playerHand[1] : "Back1")
                    .resizable()
                    .modifier(CardbackModifier())
                
            }
            
            VStack(alignment: .center, spacing: 0) {
                Text("YOU")
                    .font(.custom("HelveticaNeue-Bold", size: 12))
                    .foregroundColor(.gray)
                Text("\(gameManager.playerHandRating)")
                    .font(.custom("HelveticaNeue-Bold", size: 12))
                    .foregroundColor(.gray)
                
            }
        }
    }
}

struct PlayerHandView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerHandView(gameManager: GameManager())
            .previewLayout(.sizeThatFits)
    }
}
