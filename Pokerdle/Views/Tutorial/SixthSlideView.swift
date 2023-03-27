//
//  SixthSlideView.swift
//  Pokert
//
//  Created by Sebastian Morado on 9/16/22.
//

import SwiftUI

struct SixthSlideView: View {
    @Binding var currentPage : Int
    
    var body: some View {
        ZStack {
            VStack(alignment: .center, spacing: 10) {
                Spacer()
                Text("Tutorial 5 / 8")
                    .font(.custom("HelveticaNeue-Medium", size: 23))
                    .foregroundColor(.black)
                    .opacity(0.7)
                    .padding(.bottom)
                Text("FOLD")
                    .font(.custom("HelveticaNeue-BoldItalic", size: 28))
                    .foregroundColor(.black)
                    .opacity(0.7)
                Text("if you want to cut your losses and stop playing the current round. You will lose any bets you have already made")
                    .font(.custom("HelveticaNeue-Light", size: 18))
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                    .minimumScaleFactor(0.5)
                    .opacity(0.7)
                FullPokerFieldView(dealerHand: ["Back1", "Back1"], tableCards: ["AC", "JC", "KC", "9C", "Back1"], myHand: ["2H", "7D"], dealerSubtitle: nil, playerSubtitle: "(high card)")
                    .scaleEffect(0.9)
                Text("You may want to do this if you think you have a hand that will not win against the dealer")
                    .font(.custom("HelveticaNeue-Light", size: 18))
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                    .minimumScaleFactor(0.5)
                    .opacity(0.7)
                
//                HStack(alignment: .center, spacing: 20) {
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
//                    Button {
//                        currentPage += 1
//                        
//                    } label: {
//                        Text("NEXT")
//                            .font(.custom("HelveticaNeue-Bold", size: 20))
//                            .lineLimit(1)
//                            .minimumScaleFactor(0.5)
//                            .foregroundColor(Color.black)
//                            .padding(.horizontal, 20)
//                            .padding(.vertical, 10)
//                            .overlay(
//                                    RoundedRectangle(cornerRadius: 10)
//                                        .stroke(.black, lineWidth: 1)
//                                        
//                            )
//                    }
//                    .opacity(0.7)
//                    
//                }
//                .padding(.top)
                
                
                
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

struct SixthSlideView_Previews: PreviewProvider {
    static var previews: some View {
        SixthSlideView(currentPage: .constant(0))
    }
}
