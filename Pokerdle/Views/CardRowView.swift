//
//  CardRowView.swift
//  Pokert
//
//  Created by Sebastian Morado on 9/13/22.
//

import SwiftUI

struct CardRowView: View {
    @State var hand : [String]
    @State var handName : String
    @State var handDescription : String
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            Text("\(handName)")
                .font(.custom("HelveticaNeue-Bold", size: 14))
                .foregroundColor(.black.opacity(0.7))
            Text("\(handDescription)")
                .font(.custom("HelveticaNeue-Light", size: 12))
                .foregroundColor(.black.opacity(0.87))
                .multilineTextAlignment(.center)
                .lineLimit(2)
                .minimumScaleFactor(0.5)
                .padding(.bottom, 10)
            HStack(alignment: .center, spacing: 10) {
                ForEach(0..<hand.count, id: \.self) { i in
                    Image(hand[i])
                        .resizable()
                        .modifier(CardbackModifier())
                }
            }
        }
        .padding(.vertical, 10)
    }
}

struct CardRowView_Previews: PreviewProvider {
    static var previews: some View {
        CardRowView(hand: ["TH", "JH", "QH", "KH", "AH"], handName: "ROYAL FLUSH", handDescription: "A, K, Q, J, 10, all the same suit.")
            .previewLayout(.sizeThatFits)
    }
}
