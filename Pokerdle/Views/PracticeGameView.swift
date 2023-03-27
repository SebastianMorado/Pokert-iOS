//
//  PracticeGameView.swift
//  Pokert
//
//  Created by Sebastian Morado on 11/8/22.
//

import SwiftUI

struct PracticeGameView: View {
    @StateObject var gameManager = PracticeGameManager()
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            Spacer()
            VStack(alignment: .center, spacing: 30) {
                PracticeDealerHandView(gameManager: gameManager)
                PracticeTableCardsView(gameManager: gameManager)
                PracticePlayerHandView(gameManager: gameManager)
            }
            .padding(.bottom)
            .padding(.horizontal, 20)
            
            
            Text("\(gameManager.resultText)")
                .font(.custom("HelveticaNeue-Bold", size: 18))
                .foregroundColor(.white)
                .padding(.horizontal, 10)
                .padding(.vertical, 5)
                .background(gameManager.roundResult == 0 ? .gray : gameManager.roundResult == 1 ? .yellow : .red)
                .cornerRadius(10)
                .multilineTextAlignment(.center)
                .lineLimit(1)
                .minimumScaleFactor(0.5)
                .opacity(gameManager.isResultTextShowing ? 1 : 0)
            
            if UIDevice.isIPad {
                Spacer()
            }
            PracticeButtons(gameManager: gameManager)
        }
        .overlay(
            VStack(alignment: .leading, spacing: 0, content: {
                HStack(alignment: .center, spacing: 0) {
                    Image("chipstack1")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 30, alignment: .center)
                        .offset(x: 0, y: 4)
                    Text("\(gameManager.currentChips)")
                        .font(.custom("HelveticaNeue", size: 18))
                }
                HStack(alignment: .center, spacing: 0) {
                    Image("sun")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 30, alignment: .center)
                        .offset(x: 0, y: 3)
                    Text("\(gameManager.currentStreak)")
                        .font(.custom("HelveticaNeue", size: 18))
                }
            })
            .padding(5)
            .offset(x: UIScreen.screenWidth < 400 ? 35 : UIScreen.screenWidth < 600 ? 20 : -10)
            , alignment: .topLeading
        )
        .padding()
        .navigationTitle("Practice Mode")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarHidden(false)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    self.presentationMode.wrappedValue.dismiss()
                } label: {
                    HStack(spacing: 5) {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 18, weight: .medium))
                        Text("Back")
                            .font(.custom("HelveticaNeue-Medium", size: 18))
                            
                    }
                    .foregroundColor(.gray)
                }

                
            }
            
        }
        .background(Color.green.opacity(0.1))
    }
        
}

struct PracticeGameView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            PracticeGameView()
        }
        .navigationViewStyle(StackNavigationViewStyle())
        
    }
}

struct PracticeButtons: View {
    @ObservedObject var gameManager: PracticeGameManager
    
    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            VStack(alignment: .center, spacing: 0) {
                Text("\(gameManager.currentBet)")
                    .font(.custom("HelveticaNeue-Medium", size: 25))
                    .foregroundColor(.gray)
                
                
                Text("CURRENT BET")
                    .font(.custom("HelveticaNeue-Medium", size: 12))
                    .foregroundColor(.gray)
            }
            .padding(.bottom, 10)
            .overlay(
                Text("+\(gameManager.currentRaise * gameManager.raiseMultipler + gameManager.mandatoryBet)")
                    .font(.custom("HelveticaNeue-Medium", size: 15))
                    .foregroundColor(gameManager.currentRaise == 0 ? .green : gameManager.currentRaise == 1 ? .yellow : .red)
                    .offset(x: 30, y: -23)
                    .opacity(gameManager.currentGameState == .end || gameManager.currentGameState == .start || gameManager.isPlayerAllIn || gameManager.justFolded ? 0 : 1)
                
            )
            HStack(alignment: .center, spacing: 10) {
                Spacer()
                Button {
                    Haptics.shared.play(.heavy)
                    gameManager.buttonPressed(button: .fold)
                } label: {
                    Text("FOLD")
                        .font(.custom("HelveticaNeueMedium", size: 20))
                        .lineLimit(1)
                        .minimumScaleFactor(0.5)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 10)
                        .frame(width: 120)
                        .background(gameManager.isFoldPressed ? Color.accentColor : Color.clear)
                        .foregroundColor(gameManager.isFoldPressed ? Color.white : Color.accentColor)
                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.accentColor, lineWidth: 2))
                    
                }
                
                .cornerRadius(10)
                .disabled(gameManager.isFoldButtonDisabled)
                
                
                Button {
                    Haptics.shared.play(.heavy)
                    gameManager.buttonPressed(button: .call)
                } label: {
                    Text("CALL")
                        .font(.custom("HelveticaNeueMedium", size: 20))
                        .lineLimit(1)
                        .minimumScaleFactor(0.5)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 10)
                        .frame(width: 120)
                        .background(gameManager.isCheckPressed ? Color.accentColor : Color.clear)
                        .foregroundColor(gameManager.isCheckPressed ? Color.white : Color.accentColor)
                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.accentColor, lineWidth: 2))
                }
                .cornerRadius(10)
                .disabled(gameManager.isCheckButtonDisabled)
                
                Button {
                    Haptics.shared.play(.rigid)
                    gameManager.buttonPressed(button: .raise)
                } label: {
                    Text("RAISE")
                        .font(.custom("HelveticaNeueMedium", size: 20))
                        .lineLimit(1)
                        .minimumScaleFactor(0.5)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 10)
                        .frame(width: 120)
                        .background(gameManager.isRaisePressed ? (gameManager.currentRaise == 1 ? Color.yellow : Color.red) : Color.clear)
                        .foregroundColor(gameManager.isRaisePressed ? Color.white : Color.accentColor)
                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(gameManager.isRaisePressed ? (gameManager.currentRaise == 1 ? Color.yellow : Color.red) : Color.accentColor, lineWidth: 2))
                }
                .cornerRadius(10)
                .disabled(gameManager.isRaiseButtonDisabled)
                Spacer()
            }
            .padding(.horizontal)
            Button {
                Haptics.shared.play(.heavy)
                gameManager.buttonPressed(button: .confirm)
            } label: {
                Text(gameManager.confirmButtonText)
                    .font(.custom("HelveticaNeueBold", size: 20))
                    .padding(.horizontal, 20)
                    .padding(.vertical, 10)
                    .background(gameManager.isConfirmButtonDisabled ? Color.gray : Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .disabled(gameManager.isConfirmButtonDisabled)
            
        }
        .padding(.top)
    }
}
