//
//  LeaderboardRowView.swift
//  Pokert
//
//  Created by Sebastian Morado on 10/7/22.
//

import SwiftUI
import FlagKit

struct LeaderboardRowView: View {
    @State var user: UserInfo
    
    var body: some View {
        HStack {
            Text("\(user.position).")
                .font(.custom("Courier New Bold", size: 14))
                .frame(maxWidth: 30)
            
            Image(uiImage: Flag(countryCode: user.country)!.image(style: .roundedRect))
                .frame(maxWidth: 30)
            
            Spacer()
            
            Text(user.name)
                .font(.custom("Courier New Bold", size: 14))
                .minimumScaleFactor(0.5)
                .lineLimit(1)
                .frame(maxWidth: 300)
            
            Spacer()
            
            VStack(alignment: .center, spacing: 0) {
                VStack {
                    Text("\(user.chips)")
                        .font(.custom("HelveticaNeue-Bold", size: 13))
                        .lineLimit(1)
                        .foregroundColor(.orange)
//                    Text("CHIPS")
//                        .font(.custom("HelveticaNeue-Bold", size: 8))
                }
                RoundedRectangle(cornerRadius: 1)
                    .frame(width: 15, height: 1, alignment: .center)
                    .foregroundColor(.orange)
                VStack {
                    Text("\(user.rounds)")
                        .font(.custom("HelveticaNeue-Bold", size: 13))
                        .lineLimit(1)
                        .foregroundColor(.orange)
//                    Text("ROUNDS")
//                        .font(.custom("HelveticaNeue-Bold", size: 6))
                }
            }
            .foregroundColor(.gray)
            .frame(maxWidth: 50)
            .minimumScaleFactor(0.6)
            
        }
    }
}

struct LeaderboardRowView_Previews: PreviewProvider {
    static var previews: some View {
        Form {
            Section {
                LeaderboardRowView(user: UserInfo(id: "jfdas0NSJD", name: "noobmaster69", country: "PE", rounds: 9, chips: 300, date: Date.now, position: 2))
                    .previewLayout(.sizeThatFits)
            }
        }
        
    }
}
