//
//  SecondSlideView.swift
//  Pokert
//
//  Created by Sebastian Morado on 9/15/22.
//

import SwiftUI

struct SecondSlideView: View {
    @Binding var currentPage : Int
    
    var body: some View {
        ZStack {
            VStack(alignment: .center, spacing: 10) {
                Spacer()
                Text("Tutorial 1 / 8")
                    .font(.custom("HelveticaNeue-Medium", size: 23))
                    .foregroundColor(.black)
                    .opacity(0.7)
                    .padding(.bottom)
                Text("Try to get the best five card poker hand out of the seven cards available (your hand + five table cards)")
                    .font(.custom("HelveticaNeue-Light", size: 18))
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                    .minimumScaleFactor(0.5)
                    .opacity(0.7)
                FullPokerFieldView(dealerHand: ["Back1", "Back1"], tableCards: ["Back1", "Back1", "Back1", "Back1", "Back1"], myHand: ["TH", "JS"], dealerSubtitle: nil, playerSubtitle: nil)
                    .scaleEffect(0.9)
                Text("Two cards will be given to you and the dealer each, while the remaining five will be revealed later on")
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

struct SecondSlideView_Previews: PreviewProvider {
    static var previews: some View {
        SecondSlideView(currentPage: .constant(0))
    }
}
