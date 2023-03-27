//
//  FullPokerFieldView.swift
//  Pokert
//
//  Created by Sebastian Morado on 9/15/22.
//

import SwiftUI

struct FullPokerFieldView: View {
    @State var dealerHand : [String]
    @State var tableCards : [String]
    @State var myHand : [String]
    @State var dealerSubtitle: String?
    @State var playerSubtitle : String?
    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            VStack(alignment: .center, spacing: 0) {
                Text("DEALER'S HAND")
                    .font(.custom("HelveticaNeue-Bold", size: 12))
                    .foregroundColor(.gray)
                if let sub = dealerSubtitle {
                    Text(sub)
                        .font(.custom("HelveticaNeue-Bold", size: 12))
                        .foregroundColor(.gray)
                }
            }
            HStack(alignment: .center, spacing: 10) {
                
                Image(dealerHand[0])
                    .resizable()
                    .modifier(CardbackModifier())
                Image(dealerHand[1])
                    .resizable()
                    .modifier(CardbackModifier())
            }
            HStack(alignment: .center, spacing: 10) {
                Image(tableCards[0])
                    .resizable()
                    .modifier(CardbackModifier())
                Image(tableCards[1])
                    .resizable()
                    .modifier(CardbackModifier())
                Image(tableCards[2])
                    .resizable()
                    .modifier(CardbackModifier())
                Image(tableCards[3])
                    .resizable()
                    .modifier(CardbackModifier())
                Image(tableCards[4])
                    .resizable()
                    .modifier(CardbackModifier())
                
            }
            HStack(alignment: .center, spacing: 10) {
                Image(myHand[0])
                    .resizable()
                    .modifier(CardbackModifier())
                Image(myHand[1])
                    .resizable()
                    .modifier(CardbackModifier())
            }
            VStack(alignment: .center, spacing: 0) {
                Text("YOUR HAND")
                    .font(.custom("HelveticaNeue-Bold", size: 12))
                    .foregroundColor(.gray)
                if let sub = playerSubtitle {
                    Text(sub)
                        .font(.custom("HelveticaNeue-Bold", size: 12))
                        .foregroundColor(.gray)
                }
            }
            
        }
    }
}

struct FullPokerFieldView_Previews: PreviewProvider {
    static var previews: some View {
        FullPokerFieldView(dealerHand: ["Back1", "Back1"], tableCards: ["Back1", "Back1", "Back1", "Back1", "Back1"], myHand: ["TH", "JS"], dealerSubtitle: nil, playerSubtitle: "(one pair)")
            .previewLayout(.sizeThatFits)
    }
}
