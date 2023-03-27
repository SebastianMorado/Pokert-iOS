//
//  FourthSlideView.swift
//  Pokert
//
//  Created by Sebastian Morado on 9/16/22.
//

import SwiftUI

struct FourthSlideView: View {
    @Binding var currentPage : Int
    
    var body: some View {
        ZStack {
            VStack(alignment: .center, spacing: 10) {
                Spacer()
                Text("Tutorial 3 / 8")
                    .font(.custom("HelveticaNeue-Medium", size: 23))
                    .foregroundColor(.black)
                    .opacity(0.7)
                    .padding(.bottom)
                Text("CALL")
                    .font(.custom("HelveticaNeue-BoldItalic", size: 28))
                    .foregroundColor(.black)
                    .opacity(0.7)
                Text("if you want the next card to be revealed while only placing the minimum bet")
                    .font(.custom("HelveticaNeue-Light", size: 18))
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                    .minimumScaleFactor(0.5)
                    .opacity(0.7)
                FullPokerFieldView(dealerHand: ["Back1", "Back1"], tableCards: ["9H", "7C", "5H", "Back1", "Back1"], myHand: ["5D", "JS"], dealerSubtitle: nil, playerSubtitle: "(one pair)")
                    .scaleEffect(0.9)
                Text("You may want to do this if you are unsure about the strength of your hand")
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

struct FourthSlideView_Previews: PreviewProvider {
    static var previews: some View {
        FourthSlideView(currentPage: .constant(0))
    }
}
