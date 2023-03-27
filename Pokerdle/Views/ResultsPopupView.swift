//
//  ResultsPopupView.swift
//  Pokert
//
//  Created by Sebastian Morado on 8/30/22.
//

import SwiftUI

struct ResultsPopupView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var gameManager : GameManager
    
    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    VStack(alignment: .center, spacing: 20) {
                        if gameManager.currentStreak <= 0 {
                            Spacer()
                            Text("Finish a round to get your statistics")
                                .font(.custom("HelveticaNeue-Medium", size: 18))
                                .foregroundColor(.gray)
                                .multilineTextAlignment(.center)
                                .opacity(0.5)
                            Spacer()
                        } else {
                            StatisticsView(gameManager: gameManager)
                            HistoryChartView(lastFiveRounds: gameManager.lastFiveRounds)
                            HighscoreView(gameManager: gameManager)
                            
                        }
                        
                        
                        
                    }
                }
                .navigationTitle("Statistics")
                .navigationBarTitleDisplayMode(.large)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            Haptics.shared.play(.light)
                            dismiss()
                        } label: {
                            Image(systemName: "xmark")
                                .foregroundColor(.gray)
                        }

                    }
                }
                VStack(alignment: .center, spacing: 0) {
                    Divider()
                    ShareButtonView(gameManager: gameManager)
                }
                .padding(.horizontal, 30)
            }
            .padding(.bottom)
            
        }
    }
}

struct ResultsPopupView_Previews: PreviewProvider {
    static var previews: some View {
        ResultsPopupView(gameManager: GameManager())
            .previewLayout(.sizeThatFits)
    }
}
