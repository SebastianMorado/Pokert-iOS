//
//  NinthSlideView.swift
//  Pokert
//
//  Created by Sebastian Morado on 9/16/22.
//

import SwiftUI

struct NinthSlideView: View {
    @Binding var currentPage : Int
    @ObservedObject var gameManager : GameManager
    
    var body: some View {
        ZStack {
            VStack(alignment: .center, spacing: 40) {
                Spacer()
                Text("Tutorial 8 / 8")
                    .font(.custom("HelveticaNeue-Medium", size: 23))
                    .foregroundColor(.black)
                    .opacity(0.7)
                    .padding(.bottom)
                Text("To learn more about the different poker hands or to see this tutorial again, just press the info button")
                    .font(.custom("HelveticaNeue-Light", size: 18))
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                    .minimumScaleFactor(0.5)
                    .opacity(0.7)
                
                Image(systemName: "info.circle")
                    .font(.system(size: 50, weight: .bold))
                    .foregroundColor(.black)
                
                Text("The best way to learn is by doing so jump right into your first round!")
                    .font(.custom("HelveticaNeue-Medium", size: 18))
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                    .minimumScaleFactor(0.5)
                    .opacity(0.7)
                
                HStack(alignment: .center, spacing: 20) {
//                    Button {
//                        currentPage -= 1
//                    } label: {
//                        Text("BACK")
//                            .font(.custom("HelveticaNeue-Bold", size: 20))
//                            .lineLimit(1)
//                            .minimumScaleFactor(0.5)
//                            .foregroundColor(.white)
//                            .padding(.horizontal, 20)
//                            .padding(.vertical, 10)
//
//                            .background(.gray)
//                    }
//                    .cornerRadius(10)
                    Button {
                        Haptics.shared.play(.heavy)
                        withAnimation {
                            gameManager.finishTutorial()
                        }
                        

                    } label: {
                        Text("I'M READY")
                            .font(.custom("HelveticaNeue-Bold", size: 20))
                            .lineLimit(1)
                            .minimumScaleFactor(0.5)
                            .foregroundColor(Color.black)
                            .padding(.horizontal, 20)
                            .padding(.vertical, 10)
                            .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(.black, lineWidth: 1)

                            )
                    }
                    .opacity(0.7)

                }
                
                
                
                Spacer()
            }
            .padding()
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
        
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(.black, lineWidth: 1)
                    
        )
        .padding(.horizontal, 20)
        
    }
}

struct NinthSlideView_Previews: PreviewProvider {
    static var previews: some View {
        NinthSlideView(currentPage: .constant(0), gameManager: GameManager())
    }
}
