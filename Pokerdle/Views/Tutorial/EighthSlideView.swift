//
//  EigthSlideView.swift
//  Pokert
//
//  Created by Sebastian Morado on 9/16/22.
//

import SwiftUI

struct EighthSlideView: View {
    @Binding var currentPage : Int
    
    var body: some View {
        ZStack {
            VStack(alignment: .center, spacing: 40) {
                Spacer()
                Text("Tutorial 7 / 8")
                    .font(.custom("HelveticaNeue-Medium", size: 23))
                    .foregroundColor(.black)
                    .opacity(0.7)
                    .padding(.bottom)
                Text("Survive each round daily and show your friends that you are a poker prodigy by sharing your results")
                    .font(.custom("HelveticaNeue-Light", size: 18))
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                    .minimumScaleFactor(0.5)
                    .opacity(0.7)
                
                ShareResultsExampleView()
                
                Text("Everybody receives the same challenge each day so prove to them that you played your cards better")
                    .font(.custom("HelveticaNeue-Light", size: 18))
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                    .minimumScaleFactor(0.5)
                    .opacity(0.7)
                

                
                
                
                Spacer()
            }
            .padding()
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
        
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(.black, lineWidth: 1)
                    
        )
        .padding(.horizontal, 20)
        
    }
}

struct EigthSlideView_Previews: PreviewProvider {
    static var previews: some View {
        EighthSlideView(currentPage: .constant(0))
    }
}
