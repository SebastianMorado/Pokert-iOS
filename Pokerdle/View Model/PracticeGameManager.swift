//
//  PracticeGameManager.swift
//  Pokert
//
//  Created by Sebastian Morado on 11/8/22.
//

import Foundation

class PracticeGameManager: ObservableObject {
    
    @Published var currentChips : Int = 100
    @Published var currentStreak : Int = 0
    
    //Current round Data -----------------------------
    
    @Published var myCards = [String]()
    @Published var dealerCards = [String]()
    @Published var tableCards = [String]()
    @Published var currentBet : Int = 10
    @Published var currentRaise : Int = 0
    @Published var raiseMultipler : Int = 10
    @Published var mandatoryBet : Int = 10
    var temporaryBet : Int {
        return currentBet + (currentRaise * raiseMultipler) + mandatoryBet
    }
    @Published var justFolded : Bool = false
    @Published var currentGameState : GameState = .start
    @Published var isPlayerAllIn : Bool = false
    
    //UI Data -------------------------
    
    //to check which button is selected
    @Published var isFoldPressed : Bool = false
    @Published var isCheckPressed : Bool = false
    @Published var isRaisePressed : Bool = false
    
    //to check which buttons are disabled
    @Published var isFoldButtonDisabled : Bool = true
    @Published var isCheckButtonDisabled : Bool = true
    @Published var isRaiseButtonDisabled : Bool = true
    @Published var isConfirmButtonDisabled : Bool = false
    
    //control what text/screen is displayed
    @Published var confirmButtonText : String = "START"
    @Published var roundResult : Int = 0 // -1 if round loss, 0 if round tie, 1 if round win
    @Published var resultText : String = "You tied the dealer"
    @Published var isResultTextShowing : Bool = false
    @Published var isShowingResultsScreen : Bool = false
    @Published var isShowingErrorScreen : Bool = false
    @Published var isShowingInfoScreen : Bool = false
    @Published var isShowingLeaderboards : Bool = false
    @Published var isFinishedOnboarding : Bool = false
    @Published var hasGivenUserInformation : Bool = false
    @Published var playerHandRating : String = ""
    @Published var dealerHandRating : String = ""
    
    func buttonPressed(button: ButtonTypes) {
        if button == .call {
            if !isCheckPressed {
                isConfirmButtonDisabled = false
                if isFoldPressed { isFoldPressed.toggle() }
                if isRaisePressed { isRaisePressed.toggle() }
                currentRaise = 0
            } else {
                isConfirmButtonDisabled = true
            }
            isCheckPressed.toggle()
        }
        if button == .fold {
            if !isFoldPressed {
                isConfirmButtonDisabled = false
                if isCheckPressed { isCheckPressed.toggle() }
                if isRaisePressed { isRaisePressed.toggle() }
                currentRaise = 0
            } else {
                isConfirmButtonDisabled = true
            }
            isFoldPressed.toggle()
        }
        if button == .raise {
            if !isRaisePressed {
                isConfirmButtonDisabled = false
                if isFoldPressed { isFoldPressed.toggle() }
                if isCheckPressed { isCheckPressed.toggle() }
                if temporaryBet < currentChips {
                    currentRaise = 1
                }
                isRaisePressed.toggle()
            } else {
                if currentRaise == 1 && temporaryBet < currentChips {
                    currentRaise = 2
                } else {
                    currentRaise = 0
                    isConfirmButtonDisabled = true
                    isRaisePressed.toggle()
                }
            }
        }
        if button == .confirm {
            //START GAME
            if currentGameState == .start || currentGameState == .end || justFolded {
                dealCards()
                confirmButtonText = "CONFIRM"
                currentGameState = .preflop
                currentBet = mandatoryBet
                resetButtonOptions()
                
            } else {
                //print(currentGameState)
                if isFoldPressed {
                    justFolded = true
                    currentGameState = .end
                    endRound(didFold: true)
                } else {
                    if !isPlayerAllIn {
                        currentBet += (currentRaise * raiseMultipler) + mandatoryBet
                    }
                    if currentBet >= currentChips {
                        isPlayerAllIn = true
                    }
                    switch currentGameState {
                    case .preflop:
                        currentGameState = .flop
                        resetButtonOptions()
                    case .flop:
                        currentGameState = .turn
                        resetButtonOptions()
                    case .turn:
                        currentGameState = .river
                        resetButtonOptions()
                    case .river:
                        currentGameState = .end
                        endRound(didFold: false)
                    default:
                        print("Case out of range")
                    }
                    
                    
                }
                
            }
        }
    }
    
    private func endRound(didFold: Bool) {
        //Update UI elmenets
        prepareNewRound()
        //Check results of the round
        let resultHand = PokerFunctions.shared.compareHands(myHand: myCards + tableCards, dealerHand: dealerCards + tableCards, bet: currentBet, didFold: didFold)
        //Change the text displayed for what hand the player and dealer has
        playerHandRating = PokerFunctions.shared.getHandRatingString(handRating: resultHand.playerHandRating)
        dealerHandRating = PokerFunctions.shared.getHandRatingString(handRating: resultHand.dealerHandRating)
        //save and set all remaining ingo
        setResultText(netGain: resultHand.netGain)
        isResultTextShowing = true
        
        
    }
    
    private func prepareNewRound() {
        currentRaise = 0
        isFoldPressed = false
        isRaisePressed = false
        isCheckPressed = false
        isPlayerAllIn = false
        isFoldButtonDisabled = true
        isCheckButtonDisabled = true
        isRaiseButtonDisabled = true
        isConfirmButtonDisabled = false
        confirmButtonText = "NEXT"
    }
    
    private func setResultText(netGain: Int) {
        currentChips += netGain
        
        if netGain < 0 {
            if currentChips <= 0 {
                resetGameData()
                playSound(sound: "gameover", type: "wav")
            } else {
                resultText = "YOU LOST \(currentBet) CHIPS"
                roundResult = -1
                currentStreak += 1
                playSound(sound: "lose", type: "wav")
            }

        } else if netGain > 0 {
            resultText = "YOU WON \(currentBet) CHIPS!"
            roundResult = 1
            currentStreak += 1
            playSound(sound: "coin", type: "wav")
        } else {
            resultText = "YOU TIED THE DEALER"
            roundResult = 0
            currentStreak += 1
            playSound(sound: "card", type: "wav")
        }
        UserDefaults.standard.set(roundResult, forKey: "roundResult")
    }
    
    private func resetGameData() {
        resultText = "Lost. Resetting Data."
        currentChips = 100
        currentStreak = 0
    }
    
    private func resetButtonOptions() {
        isConfirmButtonDisabled = true
        isFoldButtonDisabled = false
        if currentBet + mandatoryBet >= currentChips { isRaiseButtonDisabled = true }
        else { isRaiseButtonDisabled = false }
        isCheckButtonDisabled = false
        isFoldPressed = false
        isRaisePressed = false
        isCheckPressed = false
        currentRaise = 0
        justFolded = false
        isResultTextShowing = false
        playerHandRating = ""
        dealerHandRating = ""
        
        if currentBet >= currentChips {
            isPlayerAllIn = true
        }
        
    }
    
    private func dealCards() {
        var dealtCards = [String]()
        for i in 1...9 {
            while dealtCards.count < i {
                let newRank = Int.random(in: 2...14)
                let newSuit = Int.random(in: 0...3)
                let newCard = PokerFunctions.shared.generateCardString(rank: newRank, suit: newSuit)
                if !dealtCards.contains(newCard) {
                    dealtCards.append(newCard)
                }
            }
            
        }
        
        myCards = [dealtCards[0], dealtCards[1]]
        tableCards = [dealtCards[2], dealtCards[3], dealtCards[4], dealtCards[5], dealtCards[6]]
        dealerCards = [dealtCards[7], dealtCards[8]]
        
    }
    
}
