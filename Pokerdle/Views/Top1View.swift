//
//  Top1View.swift
//  Pokert
//
//  Created by Sebastian Morado on 10/6/22.
//

import SwiftUI
import FlagKit

struct Top1View: View {
    @State var user: UserInfo
    
    var body: some View {
        HStack {
            Text("\(user.position).")
                .font(.custom("Courier New Bold", size: 14))
                .frame(maxWidth: 30)
            
            
            
            Image(uiImage: Flag(countryCode: user.country)!.image(style: .roundedRect))
                .frame(maxWidth: 30)
            
            Spacer()
            
            VStack(alignment: .center, spacing: 10) {
                Image("medal1")
                    .resizable()
                    .scaledToFit()
                    .frame(maxHeight: 40)
                Text(user.name)
                    .font(.custom("Courier New Bold", size: 18))
                    .minimumScaleFactor(0.5)
                    .lineLimit(1)
            }
            
            Spacer()
            
            VStack(alignment: .center, spacing: 5) {
                VStack {
                    Text("\(user.chips)")
                        .font(.custom("HelveticaNeue-Bold", size: 13))
                        .foregroundColor(.orange)
                        .lineLimit(1)
                    Text("CHIPS")
                        .font(.custom("HelveticaNeue-Bold", size: 10))
                }
                Rectangle()
                    .frame(width: 30, height: 1, alignment: .center)
                    .foregroundColor(.orange)
                VStack {
                    Text("\(user.rounds)")
                        .font(.custom("HelveticaNeue-Bold", size: 13))
                        .foregroundColor(.orange)
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

struct Top1View_Previews: PreviewProvider {
    static var previews: some View {
        Form {
            Section {
                Top1View(user: UserInfo(id: "mdsmnWJUR", name: "shmorado", country: "PH", rounds: 10, chips: 300, date: Date.now, position: 1))
                    .previewLayout(.sizeThatFits)
            }
        }
        
    }
}
