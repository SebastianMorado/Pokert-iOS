//
//  Extensions.swift
//  Pokert
//
//  Created by Sebastian Morado on 10/13/22.
//

import SwiftUI

extension View {
    
    func sync<T:Equatable>(_ published:Binding<T>, with binding:Binding<T>)-> some View{
        self
            .onChange(of: published.wrappedValue) { published in
                binding.wrappedValue = published
            }
            .onChange(of: binding.wrappedValue) { binding in
                published.wrappedValue = binding
            }
    }
    

}

extension String {
    func containsBadWord() -> Bool {
        //Sorry for bad words
        for word in bannedWords {
            if lowercased().contains(word) {
                return true
            }
        }
        return false
    }
}

extension UIScreen{
   static let screenWidth = UIScreen.main.bounds.size.width
   static let screenHeight = UIScreen.main.bounds.size.height
   static let screenSize = UIScreen.main.bounds.size
}

extension UIDevice {
    static var isIPad: Bool {
        UIDevice.current.userInterfaceIdiom == .pad
    }
    
    static var isIPhone: Bool {
        UIDevice.current.userInterfaceIdiom == .phone
    }
}
