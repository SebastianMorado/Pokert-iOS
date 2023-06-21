//
//  PokerdleTests.swift
//  PokerdleTests
//
//  Created by Sebastian Morado on 5/17/23.
//

import XCTest
@testable import Pokerdle

final class PokerdleTests: XCTestCase {
	
	let pokerFunc = PokerFunctions.shared
	
	
	//A variety of poker hands to test with
	let highCardB = ["AH", "4D", "6C", "8S", "TH", "2C", "3S"]
	let highCardS = ["QH", "4D", "6C", "8S", "TH", "2C", "3S"]
	
	let pairB = ["AH", "AD", "5C", "7C", "8H", "2C", "3S"]
	let pairS = ["AH", "AD", "4C", "6C", "8H", "2C", "3S"]
	
	let twoPairB = ["AH", "AD", "KC", "KD", "6H", "2C", "3S"]
	let twoPairS = ["AH", "AD", "QC", "QD", "6H", "2C", "3S"]
	
	let threeOfAKindB = ["AH", "AD", "AC", "4H", "6S", "2C", "3S"]
	let threeOfAKindS = ["KH", "KD", "KC", "4H", "6S", "2C", "3S"]
	
	let straightB = ["AD", "KH", "QD", "JH", "TD", "2C", "3S"]
	let straightS = ["9D", "KH", "QD", "JH", "TD", "2C", "3S"]
	
	let flushB = ["AH", "KH", "QH", "JH", "9H", "2C", "3S"]
	let flushS = ["8H", "KH", "QH", "JH", "9H", "2C", "3S"]
	
	let fullHouseB = ["AH", "AD", "KC", "KD", "KH", "2C", "3S"]
	let fullHouseS = ["AH", "AD", "QC", "QD", "QH", "2C", "3S"]
	
	let fourOfAKindB = ["AH", "AD", "AC", "AS", "9H", "2C", "3S"]
	let fourOfAKindS = ["KH", "KD", "KC", "KS", "9H", "2C", "3S"]
	
	let straightFlushB = ["KH", "QH", "JH", "TH", "AH", "2C", "3S"]
	let straightFlushS = ["KH", "QH", "JH", "TH", "9H", "2C", "3S"]
	
	let bet = 10
	let didFold = false
	
	
	func testCompareHighCard() {

		let vsHighCard = pokerFunc.compareHands(myHand: highCardB, dealerHand: highCardS, bet: bet, didFold: didFold)
		XCTAssertEqual(vsHighCard.result, 1)
		let vsPair = pokerFunc.compareHands(myHand: highCardB, dealerHand: pairB, bet: bet, didFold: didFold)
		XCTAssertEqual(vsPair.result, -1)
		let vsSelf = pokerFunc.compareHands(myHand: highCardB, dealerHand: highCardB, bet: bet, didFold: didFold)
		XCTAssertEqual(vsSelf.result, 0)
		
	}
	
	func testComparePair() {
		let vsPair = pokerFunc.compareHands(myHand: pairB, dealerHand: pairS, bet: bet, didFold: didFold)
		XCTAssertEqual(vsPair.result, 1)
		let vsTwoPair = pokerFunc.compareHands(myHand: pairB, dealerHand: twoPairB, bet: bet, didFold: didFold)
		XCTAssertEqual(vsTwoPair.result, -1)
		let vsSelf = pokerFunc.compareHands(myHand: pairB, dealerHand: pairB, bet: bet, didFold: didFold)
		XCTAssertEqual(vsSelf.result, 0)
		
	}
	
	func testCompareTwoPair() {
		let vsTwoPair = pokerFunc.compareHands(myHand: twoPairB, dealerHand: twoPairS, bet: bet, didFold: didFold)
		XCTAssertEqual(vsTwoPair.result, 1)
		let vsThree = pokerFunc.compareHands(myHand: twoPairB, dealerHand: threeOfAKindB, bet: bet, didFold: didFold)
		XCTAssertEqual(vsThree.result, -1)
		let vsSelf = pokerFunc.compareHands(myHand: twoPairB, dealerHand: twoPairB, bet: bet, didFold: didFold)
		XCTAssertEqual(vsSelf.result, 0)
		
	}
	
	func testCompareThreeOfAKind() {
		let vsThree = pokerFunc.compareHands(myHand: threeOfAKindB, dealerHand: threeOfAKindS, bet: bet, didFold: didFold)
		XCTAssertEqual(vsThree.result, 1)
		let vsStraight = pokerFunc.compareHands(myHand: threeOfAKindB, dealerHand: straightB, bet: bet, didFold: didFold)
		XCTAssertEqual(vsStraight.result, -1)
		let vsSelf = pokerFunc.compareHands(myHand: threeOfAKindB, dealerHand: threeOfAKindB, bet: bet, didFold: didFold)
		XCTAssertEqual(vsSelf.result, 0)
		
	}
	
	func testCompareStraight() {
		let vsStraight = pokerFunc.compareHands(myHand: straightB, dealerHand: straightS, bet: bet, didFold: didFold)
		XCTAssertEqual(vsStraight.result, 1)
		let vsFlush = pokerFunc.compareHands(myHand: straightB, dealerHand: flushB, bet: bet, didFold: didFold)
		XCTAssertEqual(vsFlush.result, -1)
		let vsSelf = pokerFunc.compareHands(myHand: straightB, dealerHand: straightB, bet: bet, didFold: didFold)
		XCTAssertEqual(vsSelf.result, 0)
		
	}
	
	func testCompareFlush() {
		let vsFlush = pokerFunc.compareHands(myHand: flushB, dealerHand: flushS, bet: bet, didFold: didFold)
		XCTAssertEqual(vsFlush.result, 1)
		let vsFullHouse = pokerFunc.compareHands(myHand: flushB, dealerHand: fullHouseB, bet: bet, didFold: didFold)
		XCTAssertEqual(vsFullHouse.result, -1)
		let vsSelf = pokerFunc.compareHands(myHand: flushB, dealerHand: flushB, bet: bet, didFold: didFold)
		XCTAssertEqual(vsSelf.result, 0)
		
	}
	
	func testCompareFullHouse() {
		let vsFullHouse = pokerFunc.compareHands(myHand: fullHouseB, dealerHand: fullHouseS, bet: bet, didFold: didFold)
		XCTAssertEqual(vsFullHouse.result, 1)
		let vsFour = pokerFunc.compareHands(myHand: fullHouseB, dealerHand: fourOfAKindB, bet: bet, didFold: didFold)
		XCTAssertEqual(vsFour.result, -1)
		let vsSelf = pokerFunc.compareHands(myHand: fullHouseB, dealerHand: fullHouseB, bet: bet, didFold: didFold)
		XCTAssertEqual(vsSelf.result, 0)
		
	}
	
	func testCompareFourOfAKind() {
		let vsFour = pokerFunc.compareHands(myHand: fourOfAKindB, dealerHand: fourOfAKindS, bet: bet, didFold: didFold)
		XCTAssertEqual(vsFour.result, 1)
		let vsSF = pokerFunc.compareHands(myHand: fourOfAKindB, dealerHand: straightFlushB, bet: bet, didFold: didFold)
		XCTAssertEqual(vsSF.result, -1)
		let vsSelf = pokerFunc.compareHands(myHand: fourOfAKindB, dealerHand: fourOfAKindB, bet: bet, didFold: didFold)
		XCTAssertEqual(vsSelf.result, 0)
		
	}
	
	func testCompare() {
		let vsSF = pokerFunc.compareHands(myHand: straightFlushB, dealerHand: straightFlushS, bet: bet, didFold: didFold)
		XCTAssertEqual(vsSF.result, 1)
		let vsSelf = pokerFunc.compareHands(myHand: straightFlushB, dealerHand: straightFlushB, bet: bet, didFold: didFold)
		XCTAssertEqual(vsSelf.result, 0)
		
	}

}
