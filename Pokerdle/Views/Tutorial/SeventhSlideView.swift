//
//  SeventhSlideView.swift
//  Pokert
//
//  Created by Sebastian Morado on 9/16/22.
//

import SwiftUI

struct SeventhSlideView: View {
    @Binding var currentPage : Int
    
    var body: some View {
        ZStack {
            VStack(alignment: .center, spacing: 10) {
                Spacer()
                Text("Tutorial 6 / 8")
                    .font(.custom("HelveticaNeue-Medium", size: 23))
                    .foregroundColor(.black)
                    .opacity(0.7)
                    .padding(.bottom)
                Text("After all five community cards are revealed, you can make one final bet before the dealer reveals their hand")
                    .font(.custom("HelveticaNeue-Light", size: 18))
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                    .minimumScaleFactor(0.5)
                    .opacity(0.7)
                FullPokerFieldView(dealerHand: ["JH", "QD"], tableCards: ["7H", "6C", "JD", "2S", "KH"], myHand: ["KC", "7D"], dealerSubtitle: "(one pair)", playerSubtitle: "(two pair)")
                    .scaleEffect(0.9)
                    .overlay(
                        Text("YOU WIN!")
                            .font(.custom("HelveticaNeue-Bold", size: 14))
                            .foregroundColor(.white)
                            .padding(6)
                            .background(.gray)
                            .cornerRadius(10)
                            .offset(x: 0, y: 0)
                    )
                Text("Whoever makes the better five card combination using their hand and the five cards available wins all the bets")
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
//                        //currentPage += 1
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

struct SeventhSlideView_Previews: PreviewProvider {
    static var previews: some View {
        SeventhSlideView(currentPage: .constant(0))
    }
}
