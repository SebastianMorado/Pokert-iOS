//
//  UserInfo.swift
//  Pokert
//
//  Created by Sebastian Morado on 10/4/22.
//

import Foundation

class UserInfo {
    var id: String
    var name: String
    var country: String
    var rounds: Int
    var chips: Int
    var date: Date
    var position: Int
    
    init(id: String, name: String, country: String, rounds: Int, chips: Int, date: Date, position: Int) {
        self.id = id
        self.name = name
        self.country = country
        self.rounds = rounds
        self.chips = chips
        self.date = date
        self.position = position
    }
}
