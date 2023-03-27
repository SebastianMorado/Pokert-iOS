//
//  PokerRoundModel.swift
//  Pokert
//
//  Created by Sebastian Morado on 9/21/22.
//

import Foundation

struct PokerRound {
    var count : Int
    var hands : [PokerHand]
    
    init(count: Int, hands: [PokerHand]) {
        self.count = count
        self.hands = hands
    }
    
}
