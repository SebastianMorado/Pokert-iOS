//
//  PracticePlayerHandView.swift
//  Pokert
//
//  Created by Sebastian Morado on 11/8/22.
//

import SwiftUI

struct PracticePlayerHandView: View {
    @ObservedObject var gameManager : PracticeGameManager
    
    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            HStack(alignment: .center, spacing: 0) {
                Image(gameManager.currentGameState != .start ? gameManager.myCards[0] : "Back1")
                    .resizable()
                    .modifier(CardbackModifier())
                Image(gameManager.currentGameState != .start ? gameManager.myCards[1] : "Back1")
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

struct PracticePlayerHandView_Previews: PreviewProvider {
    static var previews: some View {
        PracticePlayerHandView(gameManager: PracticeGameManager())
    }
}
