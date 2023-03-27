//
//  ErrorView.swift
//  Pokert
//
//  Created by Sebastian Morado on 9/29/22.
//

import SwiftUI

struct ErrorView: View {
    @ObservedObject var gameManager: GameManager
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            Spacer()
            
            //No Wifi Image
            VStack(spacing: 0) {
                Image(systemName: "wifi.exclamationmark")
                    .font(.system(size: 100))
                    .padding()
                .foregroundColor(.gray)
                Text("\(gameManager.errorText)")
                    .font(.custom("HelveticaNeue-Light", size: 20))
                    .lineLimit(2)
                    .minimumScaleFactor(0.5)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.gray)
            }
            .padding(.bottom, 40)
            //Retry Button
            Button {
                if gameManager.currentError == .offlineError {
                    gameManager.reconnectToInternet()
                } else if gameManager.currentError == .outdatedVersion {
                    gameManager.openAppStore()
                }
                
            } label: {
                Text("RETRY")
                    .font(.custom("HelveticaNeue-Bold", size: 20))
                    .lineLimit(1)
                    .minimumScaleFactor(0.5)
                    .foregroundColor(Color.gray)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 10)
                    .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.gray, lineWidth: 2)
                    )
            }

            Spacer()
        }
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView(gameManager: GameManager())
    }
}
