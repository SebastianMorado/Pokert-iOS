//
//  ShareButtonView.swift
//  Pokert
//
//  Created by Sebastian Morado on 8/31/22.
//

import SwiftUI

struct ShareButtonView: View {
    @ObservedObject var gameManager : GameManager
    @State private var isShowingPopup : Bool = false
    
    var body: some View {
        HStack(alignment: .center, spacing: 0) {
            VStack(alignment: .leading, spacing: 0) {
                Text("Next Pokert")
                    .font(.custom("HelveticaNeue-Bold", size: 15))
                    .foregroundColor(.gray)
                Text("\(gameManager.timeBeforeNextPuzzle)")
                    .font(.custom("HelveticaNeue-Bold", size: 15))
                    .foregroundColor(.gray)
            }
            Spacer()
            Button {
                gameManager.pressShareButton()
                Haptics.shared.play(.heavy)
                playSound(sound: "click", type: "mp3")
                withAnimation(.spring()) {
                    isShowingPopup.toggle()
                }
            } label: {
                HStack(alignment: .center, spacing: 5) {
                    Text("Share")
                        .font(.custom("HelveticaNeue-Bold", size: 20))
                        .lineLimit(1)
                        .minimumScaleFactor(0.5)
                        
                        .foregroundColor(Color.white)
                        
                    Image(systemName: "square.and.arrow.up")
                        .font(Font.system(size: 20, weight: .semibold))
                        .foregroundColor(Color.white)
                }
                .padding(.vertical, 10)
                .padding(.horizontal, 20)
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.green, lineWidth: 2))
                .background(Color.green)
                
                    
            }
            .cornerRadius(10)
        }
        .padding(.top, 10)
        .overlay(
            ZStack {
                if isShowingPopup {
                    PopupTextView()
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                withAnimation(.spring()) {
                                    self.isShowingPopup.toggle()
                                }
                            }
                        }
                }
            }
            
        )
    }
}

struct ShareButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ShareButtonView(gameManager: GameManager())
            .previewLayout(.sizeThatFits)
    }
}
