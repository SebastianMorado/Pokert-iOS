//
//  DealerHandView.swift
//  Pokert
//
//  Created by Sebastian Morado on 8/21/22.
//

import SwiftUI

struct DealerHandView: View {
    @ObservedObject var gameManager : GameManager
    
    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            VStack(alignment: .center, spacing: 0) {
                Text("DEALER")
                    .font(.custom("HelveticaNeue-Bold", size: 12))
                .foregroundColor(.gray)
                Text("\(gameManager.dealerHandRating)")
                    .font(.custom("HelveticaNeue-Bold", size: 12))
                    .foregroundColor(.gray)
            }
            
            HStack(alignment: .center, spacing: 0) {
                Image(gameManager.currentGameState == .end ? gameManager.hands[gameManager.currentHandIndex].dealerHand[0]  : "Back1")
                    .resizable()
                    .modifier(CardbackModifier())
                Image(gameManager.currentGameState == .end ? gameManager.hands[gameManager.currentHandIndex].dealerHand[1]  : "Back1")
                    .resizable()
                    .modifier(CardbackModifier())
            }
        }
    }
}

struct DealerHandView_Previews: PreviewProvider {
    static var previews: some View {
        DealerHandView(gameManager: GameManager())
            .previewLayout(.sizeThatFits)
    }
}
