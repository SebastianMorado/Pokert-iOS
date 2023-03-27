//
//  InputNameView.swift
//  Pokert
//
//  Created by Sebastian Morado on 10/13/22.
//

import SwiftUI
import Peppermint

struct InputNameView: View {
    @State var name: String = ""
    @ObservedObject var gameManager: GameManager
    @State var isNameValid : Bool = false
    @State var goToNextView : Bool = false
    let textCriteria = RegexPredicate(expression: "^[\\p{L}]{3,12}$")
    
    func checkIfValidName(username: String) {
        if !username.containsBadWord() && textCriteria.evaluate(with: username){
            isNameValid = true
        } else {
            isNameValid = false
        }
    }

    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 20) {
                Spacer()
                Text("Before we start")
                    .font(.custom("HelveticaNeueHeavy", size: 22))
                    .foregroundColor(.black)
                    .padding(.trailing)
                Text("Please create a username")
                    .font(.custom("HelveticaNeue", size: 18))
                    .foregroundColor(.black)
                TextField("Username", text: $name)
                    .font(.custom("HelveticaNeue-Bold", size: 22))
                    .padding(.horizontal, 10)
                    .overlay(
                        Rectangle()
                            .frame(height: 2)
                            .padding(.top, 40)
                            .foregroundColor(.gray)
                    )
                    .onChange(of: name, perform: { newValue in
                        checkIfValidName(username: newValue)
                    })
                    .frame(width: 300)
                
                VStack(alignment: .leading, spacing: 5) {
                    Text("*Must be 3-12 characters long")
                    Text("*No special characters allowed")
                    Text("*No profanity allowed")
                    Text("*Will only be used for the global leaderboards")
                }
                .font(.custom("HelveticaNeue-Bold", size: 12))
                .foregroundColor(.gray)
                .multilineTextAlignment(.leading)
                
                NavigationLink(destination: InputCountryView(gameManager: gameManager), isActive: $goToNextView) { EmptyView() }
                Button {
                    gameManager.myName = name
                    goToNextView = true
                } label: {
                    Text("Confirm")
                        .font(.custom("HelveticaNeue-Bold", size: 18))
                        .foregroundColor(isNameValid ? .blue : .gray.opacity(0.5))
                }
                .disabled(!isNameValid)

                Spacer()
            }
            .padding(.trailing, 40)
            .cornerRadius(16)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct InputNameView_Previews: PreviewProvider {
    static var previews: some View {
        InputNameView(gameManager: GameManager())
    }
}
