//
//  TutorialButtonView.swift
//  Pokert
//
//  Created by Sebastian Morado on 9/13/22.
//

import SwiftUI

struct TutorialButtonView: View {
    @ObservedObject var gameManager: GameManager
    
    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            Button {
                Haptics.shared.play(.heavy)
                gameManager.isFinishedOnboarding = false
            } label: {
                HStack(alignment: .center, spacing: 5) {
                    Text("Tutorial".uppercased())
                        .font(.custom("HelveticaNeue-Bold", size: 16))
                        .lineLimit(1)
                        .minimumScaleFactor(0.5)
                        
                        .foregroundColor(Color.blue)
                }
                .padding(.vertical, 10)
                .padding(.horizontal, 20)
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.blue, lineWidth: 4))
                .background(Color.clear)
                
                    
            }
            .cornerRadius(10)
        }
        .padding(.vertical, 10)
        .padding(.horizontal)
    }
}

struct TutorialButtonView_Previews: PreviewProvider {
    static var previews: some View {
        TutorialButtonView(gameManager: GameManager())
            .previewLayout(.sizeThatFits)
    }
}
