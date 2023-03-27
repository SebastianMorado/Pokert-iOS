//
//  InputCountryView.swift
//  Pokert
//
//  Created by Sebastian Morado on 10/14/22.
//

import SwiftUI

struct InputCountryView: View {
  
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @State var country: String = ""
    @ObservedObject var gameManager: GameManager
    @State var isCountryValid : Bool = false
    @State var confirmAlert : Bool = false

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Spacer()
            Text("Almost there!")
                .font(.custom("HelveticaNeueHeavy", size: 22))
                .foregroundColor(.black)
                .padding(.trailing)
            HStack {
                Text("Name:")
                    .font(.custom("HelveticaNeue", size: 18))
                    .foregroundColor(.gray)
                Text("\(gameManager.myName)")
                    .font(.custom("HelveticaNeue-Bold", size: 18))
                    .foregroundColor(.gray)
            }
            Text("Scroll and choose your country")
                .font(.custom("HelveticaNeue", size: 18))
                .foregroundColor(.black)
            ScrollView(showsIndicators: true) {
                VStack(spacing: 10) {
                    ForEach(listOfCountries, id:\.self) { value in
                        Button {
                            country = value
                            confirmAlert.toggle()
                        } label: {
                            Text("\(value)")
                                .font(.custom("HelveticaNeue-Light", size: 18))
                                .foregroundColor(.blue)
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: 230)
            
            HStack(spacing: 30) {
                Button {
                    self.mode.wrappedValue.dismiss()
                } label: {
                    Text("Back")
                        .font(.custom("HelveticaNeue-Bold", size: 18))
                        .foregroundColor(.red.opacity(0.7))
                }
            }

            Spacer()
        }
        .padding(.horizontal, 40)
        .cornerRadius(16)
        .alert("Confirm details?", isPresented: $confirmAlert, actions: {
            Button("Cancel", role: .cancel) { }
            Button("Yes", role: .none) {
                gameManager.myCountry = dictOfCountries[country] ?? "PH"
                gameManager.submitUserInfo()
            }
        }, message: {
            Text("Name: \(gameManager.myName)\nCountry: \(country)")
        })

    }
}

struct InputCountryView_Previews: PreviewProvider {
    static var previews: some View {
        InputCountryView(gameManager: GameManager())
    }
}
