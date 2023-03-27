//
//  GameManager.swift
//  Pokert
//
//  Created by Sebastian Morado on 8/4/22.
//

import UIKit
import Combine

enum ButtonTypes {
    case fold, call, raise, confirm
}

enum GameState : Int {
    case start, preflop, flop, turn, river, end, folded
}

enum PlayRating : Int {
    case badBeat, goodLaydown, bigWin, none
}

class GameManager: ObservableObject {
    
    let version : String = "1.0"
    
    //Firestore Manager -----------------------------------
    var firestoreManager : FirestoreManager = FirestoreManager()
    var disposeBag = Set<AnyCancellable>()
    @Published var topUsersInLeaderboard : [UserInfo] = []
    //Saved data ----------------------------------
    
    @Published var myName : String = "Jose"
    @Published var myCountry : String = "PH"
    
    @Published var currentChips : Int = 0
    @Published var currentStreak : Int = 0
    private var isHandCurrentlyBeingPlayed : Bool = false
    
    @Published var lastFiveRounds : [Int] = [Int]()
    @Published var numberOfBadBeats : Int = 0
    @Published var numberOfGoodLaydowns : Int = 0
    @Published var numberOfBigWins : Int = 0
    
    @Published var highScore : [String: Int] = ["chips": 0, "streak" : 0]
    @Published var dateOfLastPuzzleCompleted : Date = Date.distantPast
    var didFinishTodaysPuzzle : Bool {
        return Calendar.current.isDate(Date.now, equalTo: dateOfLastPuzzleCompleted, toGranularity: .day)
    }
    
    //Current round Data -----------------------------
    
    @Published var currentBet : Int = 10
    @Published var currentRaise : Int = 0
    @Published var raiseMultipler : Int = 10
    @Published var mandatoryBet : Int = 10
    var temporaryBet : Int {
        return currentBet + (currentRaise * raiseMultipler) + mandatoryBet
    }
    @Published var justFolded : Bool = false
    @Published var currentPuzzleNumber : Int = 0
    @Published var currentGameState : GameState = .start
    @Published var isPlayerAllIn : Bool = false
    
    //--------------- NEW ---------------------
    @Published var currentHandIndex : Int = -1
    @Published var hands = [PokerHand]()
    
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
    @Published var errorText : String = "Please check your internet connection"
    @Published var currentError : FirestoreError? = .none
    
    
    //Misc
    @Published var timeBeforeNextPuzzle = "24:00:00"
    var timer : AnyCancellable?
    var dateOfLastOpen : Date = Date.distantPast
    var didDateChangeSinceLastOpen : Bool {
        return !Calendar.current.isDate(Date.now, equalTo: dateOfLastOpen, toGranularity: .day)
    }
    private var hasGottenLeaderboardData : Bool = false
    
    
    init() {
        isFinishedOnboarding = UserDefaults.standard.bool(forKey: "isFinishedOnboarding")
        hasGivenUserInformation = UserDefaults.standard.bool(forKey: "hasGivenUserInformation")
        
        //Initialize player data
        if let name = UserDefaults.standard.string(forKey: "myName"),
           let country = UserDefaults.standard.string(forKey: "myCountry") {
            myName = name
            myCountry = country
        } else {
            hasGivenUserInformation = false
        }
        
        currentChips = UserDefaults.standard.integer(forKey: "currentChips")
        currentStreak = UserDefaults.standard.integer(forKey: "currentStreak")
        numberOfBigWins = UserDefaults.standard.integer(forKey: "numberOfBigWins")
        numberOfBadBeats = UserDefaults.standard.integer(forKey: "numberOfBadBeats")
        numberOfGoodLaydowns = UserDefaults.standard.integer(forKey: "numberOfGoodLaydowns")
        isPlayerAllIn = UserDefaults.standard.bool(forKey: "isPlayerAllIn")
        if let lastFiveRoundsSaved = UserDefaults.standard.object(forKey: "lastFiveRounds") as? [Int] {
            lastFiveRounds = lastFiveRoundsSaved
        }
        if let highscoreSaved = UserDefaults.standard.object(forKey: "highScore") as? [String: Int] {
            highScore = highscoreSaved
        }
        if let dateOfLastPuzzleCompletedSaved = UserDefaults.standard.object(forKey: "dateOfLastPuzzleCompleted") as? Date {
            dateOfLastPuzzleCompleted = dateOfLastPuzzleCompletedSaved
        }
        if let dateOfLastOpenSaved = UserDefaults.standard.object(forKey: "dateOfLastOpen") as? Date {
            dateOfLastOpen = dateOfLastOpenSaved
        }
        isHandCurrentlyBeingPlayed = UserDefaults.standard.bool(forKey: "isHandCurrentlyBeingPlayed")
        
        if decodeHands(),
           UserDefaults.standard.integer(forKey: "currentBet") != 0,
           !didDateChangeSinceLastOpen {
            
            print("HANDS: \(hands)")

            let rawGameState = UserDefaults.standard.integer(forKey: "gameStateSaved")
            currentGameState = GameState(rawValue: rawGameState) ?? .start
            currentBet = UserDefaults.standard.integer(forKey: "currentBet")
            resultText = UserDefaults.standard.string(forKey: "resultText") ?? "Continue?"
            currentPuzzleNumber = UserDefaults.standard.integer(forKey: "currentPuzzleNumber")
            currentHandIndex = UserDefaults.standard.integer(forKey: "currentHandIndex")
            
            
            if isHandCurrentlyBeingPlayed {
                confirmButtonText = "CONFIRM"
                resetButtonOptions()
            } else if !isHandCurrentlyBeingPlayed && currentGameState == .end {
                roundResult = UserDefaults.standard.integer(forKey: "roundResult")
                playerHandRating = UserDefaults.standard.string(forKey: "playerHandRating") ?? ""
                dealerHandRating = UserDefaults.standard.string(forKey: "dealerHandRating") ?? ""
                confirmButtonText = "NEXT"
                isResultTextShowing = true
            }
            
        } else {
            isHandCurrentlyBeingPlayed = false
        }
        
        
        if temporaryBet >= currentChips {
            isRaiseButtonDisabled = true
        }
        
        if currentChips == 0 {
            currentStreak = 0
            currentChips = 100
        }
        
        firestoreManager.currentPokerRound
            .sink { result in
                switch result{
                case .success(let pokerRound):
                    //print(pokerRound)
                    self.isShowingErrorScreen = false
                    self.hands = pokerRound.hands
                    self.currentPuzzleNumber = pokerRound.count
                    //NEED TO RESET USER SETTINGS
                    self.prepareNewRound(isNewRoundReady: true)
                    self.saveCurrentRoundInfo()
                    self.isShowingResultsScreen = false
                case .failure(let error):
                    self.currentError = error
                    self.handleFirestoreError(error: error)
                }
            }.store(in: &disposeBag)
        
        firestoreManager.leaderboard
            .sink { result in
                switch result {
                case .success(let topTen):
                    self.topUsersInLeaderboard = topTen
                    //check if current user can fit top ten
                    self.updateLeaderboardWithMyScore()
                case .failure(let error):
                    //-----------x------TO-DO: HANDLE ERROR PROPERLY--------------------
                    //if no entries, maybe add button to refresh leaderboard?
                    print("leaderboard error: \(error.localizedDescription)")
                    self.handleFirestoreError(error: error)
                }
            }.store(in: &disposeBag)
        
        firestoreManager.currentVersion
            .sink { error in
                self.currentError = error
                self.handleFirestoreError(error: error)
                
            }.store(in: &disposeBag)
        

        
        
        timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect().sink { _ in
            self.updateTime()
            if !self.hasGottenLeaderboardData {
                self.firestoreManager.getLeaderboard()
                self.hasGottenLeaderboardData = true
            }
            //When the date changes, a new round will appear
            if self.didDateChangeSinceLastOpen {
                self.dateOfLastOpen = Date.now
                UserDefaults.standard.set(self.dateOfLastOpen, forKey: "dateOfLastOpen")
                self.isConfirmButtonDisabled = true
                self.firestoreManager.getLatestRound()
                self.firestoreManager.getCurrentAppVersion(versionInstalled: self.version)
            }
            
        }
        
    }
    
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
                if !didFinishTodaysPuzzle {
                    currentHandIndex += 1
                    confirmButtonText = "CONFIRM"
                    currentGameState = .preflop
                    currentBet = mandatoryBet
                    saveCurrentRoundInfo()
                    saveCurrentGameState(isRoundBeingPlayed: true)
                    resetButtonOptions()
                } else {
                    isShowingResultsScreen = true
                }
                
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
                        saveCurrentGameState(isRoundBeingPlayed: true)
                    case .flop:
                        currentGameState = .turn
                        resetButtonOptions()
                        saveCurrentGameState(isRoundBeingPlayed: true)
                    case .turn:
                        currentGameState = .river
                        resetButtonOptions()
                        saveCurrentGameState(isRoundBeingPlayed: true)
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
        //Update UI elements
        prepareNewRound(isNewRoundReady: false)
        
        //Check results of the round
        let myHand = hands[currentHandIndex].playerHand + hands[currentHandIndex].tableCards
        let dealerHand = hands[currentHandIndex].dealerHand + hands[currentHandIndex].tableCards
        let resultHand = PokerFunctions.shared.compareHands(myHand: myHand, dealerHand: dealerHand, bet: currentBet, didFold: didFold)
        //Change the text displayed for what hand the player and dealer has
        playerHandRating = PokerFunctions.shared.getHandRatingString(handRating: resultHand.playerHandRating)
        UserDefaults.standard.set(playerHandRating, forKey: "playerHandRating")
        dealerHandRating = PokerFunctions.shared.getHandRatingString(handRating: resultHand.dealerHandRating)
        UserDefaults.standard.set(dealerHandRating, forKey: "dealerHandRating")
        if let pr = resultHand.playRating {
            setPlayRating(playRating: pr)
        }
        //save and set all remaining info
        setResultText(netGain: resultHand.netGain)
        saveAccountInfo(netGain: resultHand.netGain)
        isResultTextShowing = true
        saveCurrentRoundInfo()
        saveCurrentGameState(isRoundBeingPlayed: false)
        
        //Update global leaderboards
        firestoreManager.getLeaderboard()
        
        if currentHandIndex == 0 {
            //only do currentStreak += 1 once but doesnt need to be after 3 rounds
            currentStreak += 1
        }
        
        //Set that todays puzzle was completed
        if currentHandIndex + 1 >= hands.count  {
            dateOfLastPuzzleCompleted = Date.now
            UserDefaults.standard.set(dateOfLastPuzzleCompleted, forKey: "dateOfLastPuzzleCompleted")
        }
        
    }
    
    private func prepareNewRound(isNewRoundReady: Bool) {
        currentRaise = 0
        isFoldPressed = false
        isRaisePressed = false
        isCheckPressed = false
        isPlayerAllIn = false
        isFoldButtonDisabled = true
        isCheckButtonDisabled = true
        isRaiseButtonDisabled = true
        isConfirmButtonDisabled = false
        playerHandRating = ""
        dealerHandRating = ""
        
        if isNewRoundReady {
            currentHandIndex = -1
            isHandCurrentlyBeingPlayed = false
            confirmButtonText = "START"
            isResultTextShowing = false
            currentGameState = .start
            currentBet = mandatoryBet
            saveCurrentGameState(isRoundBeingPlayed: false)
        } else {
            confirmButtonText = "NEXT"
        }
        
    }
    
    
    private func setResultText(netGain: Int) {
        currentChips += netGain
        
        if netGain < 0 {
            if currentChips <= 0 {
                roundResult = -1
                playSound(sound: "gameover", type: "wav")
                dateOfLastPuzzleCompleted = Date.now
                UserDefaults.standard.set(dateOfLastPuzzleCompleted, forKey: "dateOfLastPuzzleCompleted")
                resetGameData()
            } else {
                resultText = "YOU LOST \(currentBet) CHIPS"
                roundResult = -1
                playSound(sound: "lose", type: "wav")
            }

        } else if netGain > 0 {
            resultText = "YOU WON \(currentBet) CHIPS!"
            roundResult = 1
            playSound(sound: "coin", type: "wav")
        } else {
            resultText = "YOU TIED THE DEALER"
            roundResult = 0
            playSound(sound: "card", type: "wav")
        }
        UserDefaults.standard.set(roundResult, forKey: "roundResult")
    }
    
    
    func saveCurrentGameState(isRoundBeingPlayed: Bool) {
        UserDefaults.standard.set(isRoundBeingPlayed, forKey: "isHandCurrentlyBeingPlayed")
        UserDefaults.standard.set(currentBet, forKey: "currentBet")
        UserDefaults.standard.set(currentGameState.rawValue, forKey: "gameStateSaved")
        UserDefaults.standard.set(isPlayerAllIn, forKey: "isPlayerAllIn")
        
    }
    
    func saveCurrentRoundInfo() {
        encodeHands()
        UserDefaults.standard.set(currentHandIndex, forKey: "currentHandIndex")
        UserDefaults.standard.set(currentChips, forKey: "currentChips")
        UserDefaults.standard.set(currentStreak, forKey: "currentStreak")
        UserDefaults.standard.set(resultText, forKey: "resultText")
        UserDefaults.standard.set(currentPuzzleNumber, forKey: "currentPuzzleNumber")
    }
    
    
    private func saveAccountInfo(netGain: Int) {
        //update recent results
        if currentChips > 0 {
            lastFiveRounds.append(netGain)
        }
        if lastFiveRounds.count > 5 {
            lastFiveRounds.removeFirst()
        }
        //update highscore
        if currentStreak > highScore["streak"] ?? 0 {
            highScore["streak"] = currentStreak
            highScore["chips"] = currentChips
            UserDefaults.standard.set(highScore, forKey: "highScore")
        } else if currentStreak == highScore["streak"] ?? 0 {
            if currentChips > highScore["chips"] ?? 0 {
                highScore["streak"] = currentStreak
                highScore["chips"] = currentChips
                UserDefaults.standard.set(highScore, forKey: "highScore")
            }
        }
        //update other game data
        UserDefaults.standard.set(numberOfBigWins, forKey: "numberOfBigWins")
        UserDefaults.standard.set(numberOfBadBeats, forKey: "numberOfBadBeats")
        UserDefaults.standard.set(numberOfGoodLaydowns, forKey: "numberOfGoodLaydowns")
        UserDefaults.standard.set(lastFiveRounds, forKey: "lastFiveRounds")
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
    
    private func resetGameData() {
        resultText = "BANKRUPT! TRY AGAIN TOMORROW."
        currentChips = 100
        currentStreak = 0
        numberOfBigWins = 0
        numberOfBadBeats = 0
        numberOfGoodLaydowns = 0
        lastFiveRounds.removeAll()
    }
    
    private func setPlayRating(playRating: PlayRating) {
        switch playRating {
        case .badBeat:
            numberOfBadBeats += 1
        case .goodLaydown:
            numberOfGoodLaydowns += 1
        case .bigWin:
            numberOfBigWins += 1
        case .none:
            return
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
        
        let myCards = [dealtCards[0], dealtCards[1]]
        let tableCards = [dealtCards[2], dealtCards[3], dealtCards[4], dealtCards[5], dealtCards[6]]
        let dealerCards = [dealtCards[7], dealtCards[8]]
        
        let newHand = PokerHand(playerHand: myCards, dealerHand: dealerCards, tableCards: tableCards)
        
        hands = [newHand]
        
    }
    
    func updateTime() {
        let now = Date()
        let cal = Calendar.current
        let components = DateComponents(calendar: cal, hour: 0)  // <- 17:00 = 5pm
        let nextDay = cal.nextDate(after: now, matching: components, matchingPolicy: .nextTime)!
        let diff = cal.dateComponents([.hour, .minute, .second], from: now, to: nextDay)
        let date = Calendar.current.date(from: diff)
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        timeBeforeNextPuzzle = formatter.string(from: date!)
    }
    
    func finishTutorial() {
        isFinishedOnboarding = true
        UserDefaults.standard.set(true, forKey: "isFinishedOnboarding")
    }

    func pressShareButton() {
        UIPasteboard.general.string = "Pokert \(currentPuzzleNumber)\n\(currentChips)💰 / \(currentStreak)☀️"
    }
    
    private func handleFirestoreError(error: FirestoreError) {
        switch error {
        case .offlineError:
            errorText = "Please check your internet connection"
        case .outdatedVersion:
            errorText = "Please update the app to the latest version"
        default:
            errorText = "Please check your internet connection"
        }
        isShowingErrorScreen = true
        
    }
    
    func reconnectToInternet() {
        dateOfLastOpen = Date.now
        UserDefaults.standard.set(self.dateOfLastOpen, forKey: "dateOfLastOpen")
        firestoreManager.getLatestRound()
    }
    
    func openAppStore() {
        if let url = URL(string: "itms-apps://itunes.apple.com/") {
            UIApplication.shared.open(url)
        }
    }
    
    func fullReset() {
        currentChips = 100
        currentStreak = 0
        isHandCurrentlyBeingPlayed = false
        lastFiveRounds = [Int]()
        numberOfBadBeats = 0
        numberOfGoodLaydowns = 0
        numberOfBigWins = 0
        
        highScore  = ["chips": 100, "streak" : 0]
        dateOfLastPuzzleCompleted = Date.distantPast
        //Current round Data -----------------------------
        
        hands = []
        currentHandIndex = -1
        currentBet = 10
        currentRaise = 0
        raiseMultipler = 10
        mandatoryBet = 10
        
        justFolded = false
        currentPuzzleNumber = 0
        currentGameState = .start
        isPlayerAllIn = false
        
        //UI Data -------------------------
        
        //to check which button is selected
        isFoldPressed = false
        isCheckPressed = false
        isRaisePressed = false
        
        //to check which buttons are disabled
        isFoldButtonDisabled = true
        isCheckButtonDisabled = true
        isRaiseButtonDisabled = true
        isConfirmButtonDisabled = false
        
        //control what text/screen is displayed
        confirmButtonText = "START"
        roundResult = 0 // -1 if round loss, 0 if round tie, 1 if round win
        resultText = "You tied the dealer"
        isResultTextShowing = false
        isShowingResultsScreen = false
        isShowingErrorScreen = false
        isShowingLeaderboards = false
        isShowingInfoScreen = false
        isFinishedOnboarding = false
        hasGivenUserInformation = false
        playerHandRating = ""
        dealerHandRating = ""
        
        //Misc
        timeBeforeNextPuzzle = "24:00:00"
        dateOfLastOpen = Date.distantPast
        
        UserDefaults.standard.set(numberOfBigWins, forKey: "numberOfBigWins")
        UserDefaults.standard.set(numberOfBadBeats, forKey: "numberOfBadBeats")
        UserDefaults.standard.set(numberOfGoodLaydowns, forKey: "numberOfGoodLaydowns")
        UserDefaults.standard.set(lastFiveRounds, forKey: "lastFiveRounds")
        encodeHands()
        UserDefaults.standard.set(currentHandIndex, forKey: "currentHandIndex")
        UserDefaults.standard.set(currentChips, forKey: "currentChips")
        UserDefaults.standard.set(currentStreak, forKey: "currentStreak")
        UserDefaults.standard.set(resultText, forKey: "resultText")
        UserDefaults.standard.set(currentPuzzleNumber, forKey: "currentPuzzleNumber")
        UserDefaults.standard.set(isHandCurrentlyBeingPlayed, forKey: "isHandCurrentlyBeingPlayed")
        UserDefaults.standard.set(currentBet, forKey: "currentBet")
        UserDefaults.standard.set(currentGameState.rawValue, forKey: "gameStateSaved")
        UserDefaults.standard.set(isPlayerAllIn, forKey: "isPlayerAllIn")
        UserDefaults.standard.set(dateOfLastPuzzleCompleted, forKey: "dateOfLastPuzzleCompleted")
        UserDefaults.standard.set(isFinishedOnboarding, forKey: "isFinishedOnboarding")
        UserDefaults.standard.set(dateOfLastOpen, forKey: "dateOfLastOpen")
        UserDefaults.standard.set(hasGivenUserInformation, forKey: "hasGivenUserInformation")
    }
    
    func submitUserInfo() {
        hasGivenUserInformation = true
        UserDefaults.standard.set(hasGivenUserInformation, forKey: "hasGivenUserInformation")
        UserDefaults.standard.set(myName, forKey: "myName")
        UserDefaults.standard.set(myCountry, forKey: "myCountry")
    }
    
    private func updateLeaderboardWithMyScore() {
        var idOfFinalEntryInLeaderboard : String = topUsersInLeaderboard[topUsersInLeaderboard.count-1].id
        var amIOnLeaderboardAlready : Bool = false
        var positionOfNewEntry : Int = 11
        var positionOfOldEntry : Int = 11
        
        for user in topUsersInLeaderboard {
            if user.name == myName {
                amIOnLeaderboardAlready = true
                idOfFinalEntryInLeaderboard = user.id
                positionOfOldEntry = user.position
                if user.chips == currentChips && user.rounds == currentStreak { return }
            }
        }
        
        //this will be used to adjust those positions who wont be affected because of amIOnLeaderboardAlready
        var adjustedPositionCount : Int = 10 - positionOfOldEntry
        
        for user in topUsersInLeaderboard.reversed() {
            if currentStreak > user.rounds {
                positionOfNewEntry -= 1
                if !amIOnLeaderboardAlready || adjustedPositionCount <= 0 {
                    user.position += 1
                }
                
            } else if currentStreak == user.rounds {
                if currentChips > user.chips {
                    positionOfNewEntry -= 1
                    if !amIOnLeaderboardAlready || adjustedPositionCount <= 0 {
                        user.position += 1
                    }
                } else {
                    break
                }
            } else {
                break
            }
            adjustedPositionCount -= 1
        }
        
        if positionOfNewEntry > 10 {
            return
        } else {
            let newUser = UserInfo(id: firestoreManager.getNewID(), name: myName, country: myCountry, rounds: currentStreak, chips: currentChips, date: Date.now, position: positionOfNewEntry)
            if amIOnLeaderboardAlready {
                topUsersInLeaderboard.remove(at: positionOfOldEntry-1)
            } else {
                topUsersInLeaderboard.remove(at: topUsersInLeaderboard.count-1)
            }
            topUsersInLeaderboard.insert(newUser, at: positionOfNewEntry-1)
            //add new entry to firestore db
            firestoreManager.addNewEntryToLeaderboard(user: newUser)
            //remove old entry
            firestoreManager.deleteLeaderboardEntry(userID: idOfFinalEntryInLeaderboard)
        }
    }
    
    func refreshLeaderboards() {
        firestoreManager.getLeaderboard()
    }
    
    private func encodeHands() {
        do {
            // Create JSON Encoder
            let encoder = JSONEncoder()

            // Encode Note
            let data = try encoder.encode(hands)

            // Write/Set Data
            UserDefaults.standard.set(data, forKey: "hands")

        } catch {
            print("Unable to Encode Array of Hands (\(error))")
        }
    }
    
    private func decodeHands() -> Bool {
        if let data = UserDefaults.standard.data(forKey: "hands") {
            do {
                // Create JSON Decoder
                let decoder = JSONDecoder()

                // Decode Note
                hands = try decoder.decode([PokerHand].self, from: data)
                return true

            } catch {
                print("Unable to Decode Hands (\(error))")
                return false
            }
        }
        return false
    }
    
}
