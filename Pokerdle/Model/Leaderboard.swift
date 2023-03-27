//
//  Leaderboard.swift
//  Pokert
//
//  Created by Sebastian Morado on 11/1/22.
//

import Foundation

struct Leaderboard {
    var topTen : [UserInfo]
    
    init(topTen: [UserInfo]) {
        self.topTen = topTen
    }
}
