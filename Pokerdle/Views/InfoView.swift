//
//  InfoView.swift
//  Pokert
//
//  Created by Sebastian Morado on 9/13/22.
//

import SwiftUI

struct InfoView: View {
    @ObservedObject var gameManager: GameManager
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .center, spacing: 20) {
                    GroupBox {
                        VStack(alignment: .center, spacing: 10) {
                            Divider()
                            HStack(alignment: .center, spacing: 10) {
                                Image("logo")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 80, height: 80)
                                    .cornerRadius(9)
                                Text("Go big or go home.")
                                    .font(.custom("HelveticaNeueHeavy", size: 14)) +
                                Text(" Try to survive as many rounds as you can while winning the most chips. Be the best in the world (or among your friends)")
                                    .font(.custom("HelveticaNeue", size: 14))

                            }
                            HStack {
                                TutorialButtonView(gameManager: gameManager)
                                ResetButtonView(gameManager: gameManager)
                            }
                        }
                    } label: {
                        GroupBoxLabelView(title: "Pokert", image: "info.circle")
                    }
                    .padding(.horizontal)
                    
                    GroupBox {
                        VStack(alignment: .center, spacing: 0) {
                            CardRowView(hand: ["TH", "JH", "QH", "KH", "AH"], handName: "ROYAL FLUSH", handDescription: "A, K, Q, J, 10, all of the same suit")
                            CardRowView(hand: ["3S", "4S", "5S", "6S", "7S"], handName: "STRAIGHT FLUSH", handDescription: "Five sequential cards of the same suit")
                            CardRowView(hand: ["TH", "TD", "TS", "TC", "Back1"], handName: "FOUR OF A KIND", handDescription: "Four cards of the same rank")
                            CardRowView(hand: ["2C", "2D", "7H", "7C", "7S"], handName: "FULL HOUSE", handDescription: "Three of a kind + a pair")
                            CardRowView(hand: ["AC", "3C", "7C", "8C", "QC"], handName: "FLUSH", handDescription: "Any five cards of the same suit")
                            CardRowView(hand: ["3H", "4C", "5S", "6H", "7D"], handName: "STRAIGHT", handDescription: "Five sequential cards not of the same suit")
                            CardRowView(hand: ["QS", "QH", "QD", "Back1", "Back1"], handName: "THREE OF A KIND", handDescription: "Three cards of the same rank")
                            CardRowView(hand: ["5D", "5S", "KC", "KD", "Back1"], handName: "TWO PAIR", handDescription: "Two different pairs of cards of the same rank")
                            CardRowView(hand: ["JH", "JC", "Back1", "Back1", "Back1"], handName: "ONE PAIR", handDescription: "Two cards of the same rank")
                            CardRowView(hand: ["2C", "KD", "5H", "6H", "TS"], handName: "HIGH CARD", handDescription: "If you have no other of the above hands, you play your highest rank card — in this case the king of diamonds")
                        }
                    } label: {
                        GroupBoxLabelView(title: "Hand Rankings", subtitle: " (best to worst)" , image: "chart.bar.xaxis")
                        Divider()
                    }
                    .padding(.horizontal)
                    
                    GroupBox {
                        CreditsRowView(label: "Development & Design", info: "Sebastian Morado")
                        CreditsRowView(label: "Twitter", linkInfo: "@shmorado", linkDestination: "https://twitter.com/shmorado")
                        CreditsRowView(label: "Version", info: gameManager.version)
                        CreditsRowView(label: "Assets", info: "Screaming Brain Studios\nRoyyan Wijaya\nVectors Market\nRich Paul, \nClaire Jones\nghufronagustian\niconixar")
                        CreditsRowView(label: "Privacy Policy", linkInfo: "Read", linkDestination: "https://www.freeprivacypolicy.com/live/36556e94-a244-4a82-a19d-15ac9714fc7e")
                        CreditsRowView(label: "Email", info: "sabby.morado@gmail.com")
                        
                    } label: {
                        GroupBoxLabelView(title: "Credits", image: "square.and.pencil")
                    }
                    .padding(.horizontal)
                    .padding(.bottom)

                    
                }
                .navigationBarTitleDisplayMode(.large)
                .navigationTitle("Information")
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
            }
        }
        
    }
}

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView(gameManager: GameManager())
    }
}
