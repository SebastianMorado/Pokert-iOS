//
//  PokerFunctions.swift
//  Pokert
//
//  Created by Sebastian Morado on 8/4/22.
//

import Foundation



class PokerFunctions {
    
    static let shared = PokerFunctions()
    
    init () {}
    
    func getSuit(card: String) -> String {
        return String(card.suffix(1))
    }

    func getRank(card: String) -> Int {
        let rank = String(card.first!)
        if rank == "A" {
            return 14
        } else if rank == "K" {
            return 13
        } else if rank == "Q" {
            return 12
        } else if rank == "J" {
            return 11
        } else if rank == "T" {
            return 10
        } else {
            return Int(rank) ?? 0
        }
    }

    func isFlush(hand: [String]) -> Int? {
        var dict = [
            "D" : [0, 0],
            "S" : [0, 0],
            "H" : [0, 0],
            "C" : [0, 0]
        ]
        var suitThatHasFlush : String? = nil
        for card in hand {
            let suit = getSuit(card: card)
            dict[suit]![0] += 1
            if getRank(card: card) > dict[suit]![1] {
                dict[suit]![1] = getRank(card: card)
            }
            if dict[suit]![0] >= 5 {
                suitThatHasFlush = suit
            }
        }
        
        return suitThatHasFlush != nil ? dict[suitThatHasFlush!]![1] : nil
        
    }

    func checkHighCard(hand: [String]) -> Int {
        var handRanks = [Int]()
        for card in hand {
            handRanks.append(getRank(card: card))
        }
        return handRanks.max() ?? 0
        
    }

    let testHands = [
        ["AC", "5C", "TC", "7C", "3C", "KS", "QS"],
        ["2C", "3D", "4S", "5H", "2D", "7C", "8D"],
        ["2C", "3D", "4S", "3H", "2D", "5H", "5D"],
        ["5S", "4C", "AD", "4S", "4H", "AS", "5H"],
        ["AS", "KS", "JS", "QS", "TS", "9S", "8S"]
    ]

    func handDist(hand: [String]) -> [Int: Int] {
        var dist = [Int: Int]()
        for i in 1...14 {
            dist[i] = 0
        }
        for card in hand {
            dist[getRank(card: card)]! += 1
        }
        dist[1] = dist[14]
        //print("Dist: \(dist)")
        return dist
    }

    func straightHighCard(hand: [String]) -> [Int]? {
        let dist = handDist(hand: hand)
        var results : [Int] = []
        for i in (4...14).reversed() {
            for k in 0...4 {
                if dist[i - k] ?? 0 < 1 {
                    break
                } else if k == 4 {
                    results.append(i)
                }
            }
        }
        if results.count > 0 {
            return results
        } else {return nil}
    }

    func cardCount(hand: [String], num: Int) -> [Int]? {
        let dist = handDist(hand: hand)
        var resultList = [Int]()
        for i in 2...14 {
            if dist[i] == num {
                resultList.append(i)
            }
        }
        return resultList.count == 0 ? nil : resultList
        
    }
    
    //(Int, Int) returns (Power of hand, high card)
    func handRating(hand: [String]) -> (Int, Int) {
        //cache some results
        let arrayOfHighestRankCardInStraights = straightHighCard(hand: hand)
        let highCardFlush = isFlush(hand: hand)
        let highCard = checkHighCard(hand: hand)
        let pairs = cardCount(hand: hand, num: 2)
        
        if let arrayOfHighestRankCardInStraights, let highCardFlush, arrayOfHighestRankCardInStraights.contains(highCardFlush) {
            return (8, highCardFlush)
        } else if let highCardQuad = cardCount(hand: hand, num: 4)?.max() {
            return (7, highCardQuad)
        } else if let highCardFullHouse = cardCount(hand: hand, num: 3)?.max(), let _ = pairs {
            return (6, highCardFullHouse)
        } else if let high = highCardFlush {
            return (5, high)
        } else if let highCardStraightInArray = arrayOfHighestRankCardInStraights?.max() {
            return (4, highCardStraightInArray)
        } else if let highCardTrips = cardCount(hand: hand, num: 3)?.max() {
            return (3, highCardTrips)
        } else if let highCardTwoPair = pairs, highCardTwoPair.count >= 2 {
            return (2, highCardTwoPair.max()!)
        } else if let highCardPair = pairs, highCardPair.count == 1 {
            return (1, highCardPair[0])
        } else {
            return (0, highCard)
        }
    }
    
    func getHandRatingString(handRating : (Int, Int)) -> String {
        switch handRating.0 {
        case 0:
            return "(high card)"
        case 1:
            return "(one pair)"
        case 2:
            return "(two pair)"
        case 3:
            return "(three of a kind)"
        case 4:
            return "(straight)"
        case 5:
            return "(flush)"
        case 6:
            return "(full house)"
        case 7:
            return "(four of a kind)"
        case 8:
            if handRating.1 == 14 {
                return "(royal flush)"
            } else {
                return "(straight flush)"
            }
        default:
            return ""
        }
    }
    
    func generateCardString(rank: Int, suit: Int) -> String {
        var suitString = ""
        var rankString = ""
        
        if suit == 0 { suitString = "D" }
        else if suit == 1 { suitString = "H" }
        else if suit == 2 { suitString = "S" }
        else if suit == 3 { suitString = "C" }
        
        if rank == 14 { rankString = "A"}
        else if rank == 13 { rankString = "K"}
        else if rank == 12 { rankString = "Q"}
        else if rank == 11 { rankString = "J"}
        else if rank == 10 { rankString = "T"}
        else { rankString = String(rank)}
        
        return rankString + suitString
    }

    func compareHands(myHand: [String], dealerHand: [String], bet: Int, didFold: Bool) -> HandResults {
        let myHandRating = handRating(hand: myHand)
        //print("My hand: \(myHandRating)")
        let dealerHandRating = handRating(hand: dealerHand)
        //print("Dealers hand: \(dealerHandRating)")
        
        var result = 0
        
        if myHandRating.0 > dealerHandRating.0 {
            result = 1
        } else if myHandRating.0 < dealerHandRating.0 {
            result = -1
        } else {
            if myHandRating.1 > dealerHandRating.1 {
                result = 1
            } else if myHandRating.1 < dealerHandRating.1 {
                result = -1
            }
        }
        
        let handResults = HandResults(playerHandRating: myHandRating, dealerHandRating: dealerHandRating, netgain: didFold ? -bet : bet * result, result: result, didFold: didFold)
        handResults.playRating = rateRound(handResults: handResults)
        
        return handResults
    }
    
    func rateRound(handResults : HandResults) -> PlayRating {
        
        if handResults.netGain >= 80 {
            return .bigWin
        } else if handResults.netGain < 0 && handResults.playerHandRating.0 >= 3{
            return .badBeat
        }
        
        if handResults.didFold && handResults.result == -1 {
            return .goodLaydown
        }
        
        return .none
    }
    
    
    
    
}


class HandResults {
    var playerHandRating : (Int, Int)
    var dealerHandRating : (Int, Int)
    var netGain : Int
    var result : Int
    var didFold : Bool
    var playRating : PlayRating?
    
    init(playerHandRating: (Int, Int), dealerHandRating: (Int, Int), netgain: Int, result: Int, didFold: Bool) {
        self.playerHandRating = playerHandRating
        self.dealerHandRating = dealerHandRating
        self.netGain = netgain
        self.result = result
        self.didFold = didFold
    }
}
