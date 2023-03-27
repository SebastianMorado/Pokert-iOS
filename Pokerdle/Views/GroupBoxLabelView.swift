//
//  GroupBoxLabelView.swift
//  Pokert
//
//  Created by Sebastian Morado on 11/5/22.
//

import SwiftUI

struct GroupBoxLabelView: View {
    var title: String
    var subtitle: String?
    var image: String? = nil
    var customImage: String? = nil
    var body: some View {
        HStack {
            Text(title)
                .fontWeight(.bold)
            + Text(subtitle ?? "")
                .fontWeight(.light)
            Spacer()
            if let customImage = customImage {
                Image(customImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
            } else if let image = image {
                Image(systemName: image)
            }
            
            
        }
    }
}

struct GroupBoxLabelView_Previews: PreviewProvider {
    static var previews: some View {
        GroupBoxLabelView(title: "Pokert", customImage: "leaderboard2")
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
