//
//  PracticeDealerHandView.swift
//  Pokert
//
//  Created by Sebastian Morado on 11/8/22.
//

import SwiftUI

struct PracticeDealerHandView: View {
    @ObservedObject var gameManager : PracticeGameManager
    
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
                Image(gameManager.currentGameState == .end ? gameManager.dealerCards[0] : "Back1")
                    .resizable()
                    .modifier(CardbackModifier())
                Image(gameManager.currentGameState == .end ? gameManager.dealerCards[1] : "Back1")
                    .resizable()
                    .modifier(CardbackModifier())
            }
        }
    }
}

struct PracticeDealerHandView_Previews: PreviewProvider {
    static var previews: some View {
        PracticeDealerHandView(gameManager: PracticeGameManager()
        )
    }
}
