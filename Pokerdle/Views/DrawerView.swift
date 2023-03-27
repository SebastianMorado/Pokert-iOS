//
//  DrawerView.swift
//  Pokert
//
//  Created by Sebastian Morado on 10/27/22.
//

import SwiftUI

struct DrawerView: View {
    @State private var isDrawerOpen : Bool = false
    @State private var isDrawerOpenNotAnimated : Bool = false
    @ObservedObject var gameManager : GameManager
    @State var isShowingResultsScreen : Bool = false
    @State var isShowingInfoScreen : Bool = false
    @State var isShowingLeaderboards : Bool = false
    @Binding var isAnimating : Bool
    
    
    var body: some View {
        HStack(spacing: 12) {
            //MARK: - Drawer handle
            Image(systemName: isDrawerOpenNotAnimated ? "chevron.compact.right" : "chevron.compact.left")
                .resizable()
                .scaledToFit()
                .frame(width: 25, height: 40)
                .padding(.leading, 8)
                .foregroundStyle(.secondary)
                .onTapGesture {
                    withAnimation {
                        isDrawerOpen.toggle()
                    }
                    isDrawerOpenNotAnimated.toggle()
                    Haptics.shared.play(.medium)
                }
            
            //MARK: - Thumbnails
            VStack(spacing: 10) {
                Button {
                    Haptics.shared.play(.medium)
                    isShowingInfoScreen.toggle()
                } label: {
                    VStack {
                        Image(systemName: "info.circle")
                            .font(.system(size: 40))
                            .foregroundColor(.gray)
                            .padding(.horizontal, 0)
                        .frame(width: 40, height: 40)
                        Text("Help")
                            .font(.custom("HelveticaNeue-Bold", size: 12))
                            .foregroundColor(.gray)
                            .lineLimit(1)
                    }
                }
                .frame(width: 40)
               
                Button {
                    Haptics.shared.play(.medium)
                    isShowingResultsScreen.toggle()
                } label: {
                    VStack {
                        Image(systemName: "chart.xyaxis.line")
                            .font(.system(size: 40))
                            .foregroundColor(.gray)
                            .padding(.horizontal, 0)
                        .frame(width: 40, height: 40)
                        Text("Stats")
                            .font(.custom("HelveticaNeue-Bold", size: 12))
                            .foregroundColor(.gray)
                            .lineLimit(1)
                    }
                    
                }
                .frame(width: 40)
                Button {
                    Haptics.shared.play(.medium)
                    isShowingLeaderboards.toggle()
                } label: {
                    VStack {
                        Image("leaderboard2")
                            .resizable()
                            .padding(.horizontal, 0)
                            .frame(width: 40, height: 40)
                            .offset(y: -1)
                        .opacity(0.4)
                        Text("Rank")
                            .font(.custom("HelveticaNeue-Bold", size: 12))
                            .foregroundColor(.gray)
                            .lineLimit(1)
                    }
                }
                .frame(width: 40)
            }
            

            
            Spacer()
        }
        .padding(.vertical, 8)
        .background(.ultraThinMaterial)
        .cornerRadius(12)
        .opacity(isAnimating ? 1 : 0)
        .animation(.linear(duration: 1), value: isAnimating)
        .frame(width: 120)
        .offset(x: isDrawerOpen ? 0 : 80)
        .sheet(isPresented: $isShowingResultsScreen) {
            ResultsPopupView(gameManager: gameManager)
        }
        .sync($gameManager.isShowingResultsScreen, with: $isShowingResultsScreen)
        .sheet(isPresented: $isShowingInfoScreen) {
            InfoView(gameManager: gameManager)
        }
        .sync($gameManager.isShowingInfoScreen, with: $isShowingInfoScreen)
        .sheet(isPresented: $isShowingLeaderboards) {
            LeaderboardView(gameManager: gameManager)
        }
        .sync($gameManager.isShowingLeaderboards, with: $isShowingLeaderboards)
    }
}

struct DrawerView_Previews: PreviewProvider {
    static var previews: some View {
        DrawerView(gameManager: GameManager(), isAnimating: .constant(true))
            .preferredColorScheme(.light)
            .padding()
    }
}
