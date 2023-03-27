//
//  PopupTextView.swift
//  Pokert
//
//  Created by Sebastian Morado on 10/31/22.
//

import SwiftUI

struct PopupTextView: View {
    var body: some View {
        HStack {
            Image(systemName: "doc.on.doc")
                .font(.system(size: 20, weight: .light))
                .foregroundColor(.gray)
            Text("Copied text to clipboard.")
                .font(.custom("HelveticaNeueLight", size: 14))
                .foregroundColor(.gray)
                .lineLimit(1)
        }
        .padding(.horizontal, 50)
        .padding(.vertical, 7)
        .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 10, style: .continuous))
        .cornerRadius(10)
        
    }
}

struct PopupTextView_Previews: PreviewProvider {
    static var previews: some View {
        PopupTextView()
            .previewLayout(.sizeThatFits)
            .padding()
            .background(.blue)
    }
}
