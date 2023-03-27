//
//  ContentView.swift
//  Pokert
//
//  Created by Sebastian Morado on 7/27/22.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var gameManager : GameManager
    
    
    var body: some View {
        ZStack {
            if !gameManager.isFinishedOnboarding {
                TutorialView(gameManager: gameManager)
            } else if !gameManager.hasGivenUserInformation {
                InputNameView(gameManager: gameManager)
            } else {
                if gameManager.isShowingErrorScreen {
                    ErrorView(gameManager: gameManager)
                } else {
                    MainGameView(gameManager: gameManager)
                }
            }
            
        }
        .transition(.slide)
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(gameManager: GameManager())
    }
}
