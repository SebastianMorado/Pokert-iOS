//
//  FirstSlideView.swift
//  Pokert
//
//  Created by Sebastian Morado on 9/13/22.
//

import SwiftUI

struct FirstSlideView: View {
    @Binding var currentPage : Int
    
    var body: some View {
        ZStack {
            VStack(alignment: .center, spacing: 10) {
                Spacer()
                Text("Welcome to Pokert")
                    .font(.custom("HelveticaNeue-Medium", size: 23))
                    .foregroundColor(.black)
                    .opacity(0.7)
                Text("Your goal is to gain (or avoid losing) as much chips as possible against the dealer")
                    .font(.custom("HelveticaNeue-Light", size: 18))
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                    .minimumScaleFactor(0.5)
                    .padding(.vertical)
                    .opacity(0.7)
                Image("chip2")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 100, maxHeight: 100, alignment: .center)
                    .opacity(0.7)
                
                Text("You achieve this by making bets on whether you think you have a better five card combination than the dealer")
                    .font(.custom("HelveticaNeue-Light", size: 18))
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                    .minimumScaleFactor(0.5)
                    .opacity(0.7)
                    .padding(.bottom, 20)
                
//                Button {
//                    currentPage += 1
//                } label: {
//                    Text("NEXT")
//                        .font(.custom("HelveticaNeue-Bold", size: 20))
//                        .lineLimit(1)
//                        .minimumScaleFactor(0.5)
//                        .foregroundColor(Color.black)
//                        .padding(.horizontal, 20)
//                        .padding(.vertical, 10)
//                        .overlay(
//                                RoundedRectangle(cornerRadius: 10)
//                                    .stroke(.black, lineWidth: 1)
//                                    
//                        )
//                }
//                .opacity(0.7)
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

struct FirstSlideView_Previews: PreviewProvider {
    static var previews: some View {
        FirstSlideView(currentPage: .constant(0))
    }
}
