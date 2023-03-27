//
//  TutorialView.swift
//  Pokert
//
//  Created by Sebastian Morado on 9/13/22.
//

import SwiftUI

struct TutorialView: View {
    @ObservedObject var gameManager: GameManager
    
    var body: some View {
        SliderTabView(gameManager: gameManager)
    }
}

struct SliderTabView: View {
    @State var currentPage : Int = 0
    @ObservedObject var gameManager: GameManager
    
    init(gameManager: GameManager) {
        UIPageControl.appearance().currentPageIndicatorTintColor = .black
        UIPageControl.appearance().pageIndicatorTintColor = UIColor.black.withAlphaComponent(0.2)
        UIPageControl.appearance().tintColor = UIColor.black.withAlphaComponent(0.2)
        self.gameManager = gameManager
    }
    
    var body: some View {
        TabView(selection: $currentPage){
            FirstSlideView(currentPage: $currentPage)
                .tag(0)
            SecondSlideView(currentPage: $currentPage)
                .tag(1)
            ThirdSlideView(currentPage: $currentPage)
                .tag(2)
            FourthSlideView(currentPage: $currentPage)
                .tag(3)
            FifthSlideView(currentPage: $currentPage)
                .tag(4)
            SixthSlideView(currentPage: $currentPage)
                .tag(5)
            SeventhSlideView(currentPage: $currentPage)
                .tag(6)
            EighthSlideView(currentPage: $currentPage)
                .tag(7)
            NinthSlideView(currentPage: $currentPage, gameManager: gameManager)
                .tag(8)
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
        .padding(.vertical, 20)
        .animation(.easeOut(duration: 0.2), value: currentPage)
    }
}

struct TutorialView_Previews: PreviewProvider {
    static var previews: some View {
        TutorialView(gameManager: GameManager())
    }
}
