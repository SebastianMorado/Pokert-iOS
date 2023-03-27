//
//  StatisticsView.swift
//  Pokert
//
//  Created by Sebastian Morado on 9/12/22.
//

import SwiftUI

struct StatisticsView: View {
    @ObservedObject var gameManager : GameManager
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            GroupBox {
                HStack(alignment: .center, spacing: 15) {
                    VStack(alignment: .center, spacing: 0) {
                        Text("\(gameManager.currentChips)")
                            .font(.custom("HelveticaNeue-Medium", size: 25))
                            .foregroundColor(.green)
                            
                        
                        Text("Chips")
                            .font(.custom("HelveticaNeue-Medium", size: 16))
                            .foregroundColor(.gray)
                    }
                    
                    Text("after")
                        .font(.custom("HelveticaNeue-Medium", size: 16))
                        .foregroundColor(.gray)
                    
                    VStack(alignment: .center, spacing: 0) {
                        Text("\(gameManager.currentStreak)")
                            .font(.custom("HelveticaNeue-Medium", size: 25))
                            .foregroundColor(.green)
                            
                        
                        Text("Rounds")
                            .font(.custom("HelveticaNeue-Medium", size: 16))
                            .foregroundColor(.gray)
                    }
                }
                .padding(.vertical, 5)
                CreditsRowView(label: "Big Wins", info: "\(gameManager.numberOfBigWins)")
                CreditsRowView(label: "Good Laydowns", info: "\(gameManager.numberOfGoodLaydowns)")
                CreditsRowView(label: "Bad Beats", info: "\(gameManager.numberOfBadBeats)")
            } label: {
                GroupBoxLabelView(title: "Current Game", image: "gamecontroller.fill")
            }
            .padding(.horizontal)

        }
    }
}

struct StatisticsView_Previews: PreviewProvider {
    static var previews: some View {
        StatisticsView(gameManager: GameManager())
            .previewLayout(.sizeThatFits)
    }
}
