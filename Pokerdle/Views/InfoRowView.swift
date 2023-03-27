//
//  InfoRowView.swift
//  Pokert
//
//  Created by Sebastian Morado on 11/5/22.
//

import SwiftUI

struct InfoRowView: View {
    var label: String
    var info: String? = nil
    var linkInfo: String? = nil
    var linkDestination: String? = nil
    
    var body: some View {
        VStack {
            Divider()
            HStack {
                Text(label).foregroundColor(.secondary)
                Spacer()
                if let info = info {
                    Text(info)
                } else if let linkInfo = linkInfo, let linkDestination = linkDestination {
                    Link(linkInfo, destination: URL(string: linkDestination)!)
                    Image(systemName: "arrow.up.right.square").foregroundColor(.pink)
                } else {
                    EmptyView()
                }
            }
        }
        .padding(.vertical, 5)
    }
}

struct InfoRowView_Previews: PreviewProvider {
    static var previews: some View {
        InfoRowView(label: "Developer")
    }
}
