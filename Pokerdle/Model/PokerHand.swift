//
//  PokerHand.swift
//  Pokert
//
//  Created by Sebastian Morado on 1/18/23.
//

import Foundation

struct PokerHand: Codable {
    var playerHand : [String]
    var dealerHand : [String]
    var tableCards : [String]
    
    init(playerHand : [String], dealerHand : [String], tableCards : [String]) {
        self.playerHand = playerHand
        self.dealerHand = dealerHand
        self.tableCards = tableCards
    }
}
