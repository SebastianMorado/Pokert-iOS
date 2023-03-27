//
//  ResetButtonView.swift
//  Pokert
//
//  Created by Sebastian Morado on 10/7/22.
//

import SwiftUI

struct ResetButtonView: View {
    @ObservedObject var gameManager: GameManager
    @State private var isAlertShowing: Bool = false
    
    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            Button {
                Haptics.shared.play(.heavy)
                isAlertShowing = true
            } label: {
                HStack(alignment: .center, spacing: 5) {
                    Text("Reset Data".uppercased())
                        .font(.custom("HelveticaNeue-Bold", size: 16))
                        .lineLimit(1)
                        .minimumScaleFactor(0.5)
                        
                        .foregroundColor(Color.white)
                }
                .padding(.vertical, 8)
                .padding(.horizontal, 15)
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.red, lineWidth: 2))
                .background(Color.red.opacity(0.7))
                
                    
            }
            .cornerRadius(10)
            .alert("Are you sure you want to reset your game data?", isPresented: $isAlertShowing) {
                Button("Cancel", role: .cancel) { }
                Button("Delete", role: .destructive) {
                    gameManager.fullReset()
                }
                
            }
        }
        .padding(.vertical, 10)
        .padding(.horizontal)
    }
}

struct ResetButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ResetButtonView(gameManager: GameManager())
    }
}
