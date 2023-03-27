//
//  MyScoreView.swift
//  Pokert
//
//  Created by Sebastian Morado on 10/13/22.
//

import SwiftUI
import FlagKit

struct MyScoreView: View {
    @ObservedObject var gameManager : GameManager
    
    var body: some View {
        HStack {
            Image(systemName: "star.fill")
                .font(.system(size: 14))
                .foregroundColor(.yellow)
                .frame(maxWidth: 30)
            Image(uiImage: Flag(countryCode: gameManager.myCountry)!.image(style: .roundedRect))
                .frame(maxWidth: 30)
            Spacer()
            VStack(alignment: .center, spacing: 5) {
                Image(systemName: "person.fill")
                    .font(.system(size: 40))
                    .foregroundColor(.gray)
                Text(gameManager.myName)
                    .font(.custom("Courier New Bold", size: 18))
                    .minimumScaleFactor(0.5)
                    .lineLimit(1)
            }
            Spacer()
            VStack(alignment: .center, spacing: 5) {
                VStack {
                    Text("\(gameManager.highScore["chips"]!)")
                        .font(.custom("HelveticaNeue-Bold", size: 13))
                        .lineLimit(1)
                    Text("CHIPS")
                        .font(.custom("HelveticaNeue-Bold", size: 10))
                }
                Rectangle()
                    .frame(width: 30, height: 1, alignment: .center)
                VStack {
                    Text("\(gameManager.highScore["streak"]!)")
                        .font(.custom("HelveticaNeue-Bold", size: 13))
                        .lineLimit(1)
                    Text("ROUNDS")
                        .font(.custom("HelveticaNeue-Bold", size: 8))
                }
            }
            .foregroundColor(.gray)
            .frame(maxWidth: 50)
            .minimumScaleFactor(0.5)
            
        }
    }
}

struct MyScoreView_Previews: PreviewProvider {
    static var previews: some View {
        MyScoreView(gameManager: GameManager())
    }
}
