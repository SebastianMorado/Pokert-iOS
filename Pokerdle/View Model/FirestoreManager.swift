//
//  FirestoreManager.swift
//  Pokert
//
//  Created by Sebastian Morado on 9/21/22.
//

import Foundation
import FirebaseFirestore
import Combine

enum FirestoreError: Error {
    case offlineError, invalidDataError, outdatedVersion
}

class FirestoreManager: ObservableObject {
	static let shared : FirestoreManager = FirestoreManager()
    let currentPokerRound = PassthroughSubject<Result<PokerRound, FirestoreError>, Never>()
    let leaderboard = PassthroughSubject<Result<[UserInfo], FirestoreError>, Never>()
    let currentVersion = PassthroughSubject<FirestoreError, Never>()
	
	private init () {}
    
    func getLatestRound() {
		
        let db = Firestore.firestore()
        let dateToSearch = createDateString()
        let docRef = db.collection("rounds").document(dateToSearch)
        
        
        docRef.getDocument { (document, error) in
            guard error == nil else {
                self.currentPokerRound.send(.failure(FirestoreError.offlineError))
                return
            }
            if let document = document, document.exists {
                let data = document.data()
                if let data = data {
                    if let numberOfHands = data["numberOfHands"] as? Int,
                       let count = data["count"] as? Int {
                        
                        //search "hands" collection
                        docRef.collection("hands").getDocuments { querySnapshot, error in
                            guard error == nil else {
                                self.currentPokerRound.send(.failure(FirestoreError.offlineError))
                                return
                            }
                            var pokerHands : [PokerHand] = []
                            for document in querySnapshot!.documents {
                                let data = document.data()
                                if let playerHand = data["playerHand"] as? [String],
                                   let dealerHand = data["dealerHand"] as? [String],
                                   let tableCards = data["tableCards"] as? [String] {
                                    let newPokerHand = PokerHand(playerHand: playerHand, dealerHand: dealerHand, tableCards: tableCards)
                                    pokerHands.append(newPokerHand)
                                } else {
                                    self.currentPokerRound.send(.failure(.invalidDataError))
                                }
                            }
                            if pokerHands.count < numberOfHands {
                                self.currentPokerRound.send(.failure(.invalidDataError))
                            } else {
                                let newPokerRound = PokerRound(count: count, hands: pokerHands)
                                self.currentPokerRound.send(.success(newPokerRound))
                            }
                        }
    
                    } else {
                        self.currentPokerRound.send(.failure(.invalidDataError))
                    }
                } else {
                    self.currentPokerRound.send(.failure(FirestoreError.offlineError))
                }
            }

        }
    }
    
    func createDateString() -> String {
        let currentDate = Date.now
        let formatter = DateFormatter()
        formatter.dateFormat = "MMddyy"
        let dateToSearch = formatter.string(from: currentDate)
        return dateToSearch
    }
    
    func getLeaderboard() {
        let db = Firestore.firestore()
        let docRef = db.collection("leaderboard").order(by: "rounds", descending: true).order(by: "chips", descending: true).order(by: "date", descending: false).limit(to: 10)
        
        docRef.getDocuments { query, error in
            guard error == nil else {
                self.leaderboard.send(.failure(.invalidDataError))
                return
            }
            
            if let documents = query?.documents, !documents.isEmpty {
                var topTen : [UserInfo] = []
                var count = 1
                for doc in documents {
                    let data = doc.data()
                    if let name = data["name"] as? String,
                       let chips = data["chips"] as? Int,
                       let rounds = data["rounds"] as? Int,
                       let country = data["country"] as? String,
                       let date = data["date"] as? Timestamp {
                        let user = UserInfo(id: doc.documentID, name: name, country: country, rounds: rounds, chips: chips, date: date.dateValue(), position: count)
                        topTen.append(user)
                        count += 1
                    }
                }
                self.leaderboard.send(.success(topTen))
                
            } else {
                self.leaderboard.send(.failure(.invalidDataError))
            }
        }
    }
    
    func getNewID() -> String {
        let db = Firestore.firestore()
        return db.collection("leaderboard").document().documentID
    }
    
    func addNewEntryToLeaderboard(user: UserInfo) {
        let db = Firestore.firestore()
        let docRef =  db.collection("leaderboard").document(user.id)
        
        docRef.setData(
            [
                "name": user.name,
                "chips": user.chips,
                "rounds": user.rounds,
                "country": user.country,
                "date": Timestamp(date: user.date)
            ]
        ) { error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                print("successfully written")
            }
        }
        
    }
    
    func deleteLeaderboardEntry(userID: String) {
        let db = Firestore.firestore()
        let docRef =  db.collection("leaderboard").document(userID)
        
        docRef.delete { error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                print("successfully deleted")
            }
        }
    }
    
    func getCurrentAppVersion(versionInstalled : String) {
        let db = Firestore.firestore()
        let docRef =  db.collection("versions").order(by: "date", descending: true).limit(to: 1)
        
        docRef.getDocuments { query, error in
            
            guard error == nil else {
                self.currentVersion.send(.invalidDataError)
                return
            }
            
            if let documents = query?.documents, !documents.isEmpty, let doc = documents.first {
                let data = doc.data()
                if let latestVersion = data["version_number"] as? String {
                    print("Latest Version: \(latestVersion)")
                    if versionInstalled != latestVersion {
                        print("Current Version: \(versionInstalled)")
                        self.currentVersion.send(.outdatedVersion)
                    } else {
                        print("App is updated!")
                    }
                }
            }
            
        }
    }
}
