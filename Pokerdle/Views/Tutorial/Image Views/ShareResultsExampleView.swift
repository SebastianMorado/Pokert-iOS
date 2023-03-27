//
//  ShareResultsExampleView.swift
//  Pokert
//
//  Created by Sebastian Morado on 9/16/22.
//

import SwiftUI

struct ShareResultsExampleView: View {
    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            VStack(alignment: .center, spacing: 5) {
                Text("POKERT")
                    .font(.custom("HelveticaNeue-Bold", size: 20))
                    .foregroundColor(.gray)
                Text("150💰 / 10☀️")
                    .font(.custom("HelveticaNeue-Light", size: 20))
                    .foregroundColor(.black)
            }
            
            //Button
            HStack(alignment: .center, spacing: 5) {
                Text("Share")
                    .font(.custom("HelveticaNeue-Bold", size: 20))
                    .lineLimit(1)
                    .minimumScaleFactor(0.5)
                    
                    .foregroundColor(Color.white)
                    
                Image(systemName: "square.and.arrow.up")
                    .font(Font.system(size: 20, weight: .semibold))
                    .foregroundColor(Color.white)
            }
            .padding(.vertical, 10)
            .padding(.horizontal, 20)
            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.green, lineWidth: 2))
            .background(Color.green)
            .cornerRadius(10)
        }
        .padding(.horizontal, 50)
        .padding(.vertical)
        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
        
    }
}

struct ShareResultsExampleView_Previews: PreviewProvider {
    static var previews: some View {
        ShareResultsExampleView()
            .previewLayout(.sizeThatFits)
    }
}
