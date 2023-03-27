//
//  LeaderboardView.swift
//  Pokert
//
//  Created by Sebastian Morado on 10/3/22.
//

import SwiftUI

struct LeaderboardView: View {
    @ObservedObject var gameManager : GameManager
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    VStack(alignment: .center, spacing: 0) {
                        GroupBox {
                            ForEach(gameManager.topUsersInLeaderboard, id: \.id) { user in
                                Divider()
                                if user.position == 1 {
                                    Top1View(user: user)
                                } else {
                                    LeaderboardRowView(user: user)
                                }
                            }
                        } label: {
                            GroupBoxLabelView(title: "Global Leaderboard", image: "trophy")
                        }
                        .padding(.horizontal)

                    }
                }
                .navigationTitle("Ranking")
                .navigationBarTitleDisplayMode(.large)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            Haptics.shared.play(.light)
                            gameManager.refreshLeaderboards()
                        }, label: {
                            Image(systemName: "arrow.clockwise")
                                .foregroundColor(.gray)
                            
                        })

                    }
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
                Divider()
                VStack {
                    GroupBoxLabelView(title: "My Highscore")
                    MyScoreView(gameManager: gameManager)
                }
                .padding(.horizontal)
            }
            .padding(.bottom)
            
        }
        
    }
}

struct LeaderboardView_Previews: PreviewProvider {
    static var previews: some View {
        LeaderboardView(gameManager: GameManager())
    }
}
