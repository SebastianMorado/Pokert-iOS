//
//  HighscoreView.swift
//  Pokert
//
//  Created by Sebastian Morado on 9/12/22.
//

import SwiftUI

struct HighscoreView: View {
    @ObservedObject var gameManager : GameManager
    
    var body: some View {
        GroupBox {
            HStack(alignment: .center, spacing: 15) {
                VStack(alignment: .center, spacing: 0) {
                    Text("\(gameManager.highScore["chips"] ?? 0)")
                        .font(.custom("HelveticaNeue-Medium", size: 25))
                        .foregroundColor(.yellow)
                        
                    
                    Text("Chips")
                        .font(.custom("HelveticaNeue-Medium", size: 16))
                        .foregroundColor(.gray)
                }
                
                Text("after")
                    .font(.custom("HelveticaNeue-Medium", size: 16))
                    .foregroundColor(.gray)
                
                VStack(alignment: .center, spacing: 0) {
                    Text("\(gameManager.highScore["streak"] ?? 0)")
                        .font(.custom("HelveticaNeue-Medium", size: 25))
                        .foregroundColor(.yellow)
                        
                    
                    Text("Rounds")
                        .font(.custom("HelveticaNeue-Medium", size: 16))
                        .foregroundColor(.gray)
                }
            }
            .padding(.top, 1)
            
        } label: {
            GroupBoxLabelView(title: "Highscore", image: "trophy.fill")
        }
        .padding(.horizontal)
    }
}

struct HighscoreView_Previews: PreviewProvider {
    static var previews: some View {
        HighscoreView(gameManager: GameManager())
            .previewLayout(.sizeThatFits)
    }
}
