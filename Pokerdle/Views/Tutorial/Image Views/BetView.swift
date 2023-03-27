//
//  BetView.swift
//  Pokert
//
//  Created by Sebastian Morado on 9/16/22.
//

import SwiftUI

struct BetView: View {
    @State var currentBet: Int
    @State var raise: Int
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            Text("\(currentBet)")
                .font(.custom("HelveticaNeue-Medium", size: 25))
                .foregroundColor(.gray)
                
            
            Text("CURRENT BET")
                .font(.custom("HelveticaNeue-Medium", size: 12))
                .foregroundColor(.gray)
        }
        .padding(.bottom, 10)
        .overlay(
            Text("+\(raise)")
                .font(.custom("HelveticaNeue-Medium", size: 15))
                .foregroundColor(raise == 10 ? .green : raise == 20 ? .yellow : .red)
                .offset(x: 30, y: -23)
            
        )
    }
}

struct BetView_Previews: PreviewProvider {
    static var previews: some View {
        BetView(currentBet: 10, raise: 20)
            .previewLayout(.sizeThatFits)
    }
}
