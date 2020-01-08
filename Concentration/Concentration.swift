//
//  Concentration.swift
//  Concentration
//
//  Created by Farhan Ali on 12/16/19.
//  Copyright © 2019 CS193P. All rights reserved.
//

import Foundation

class Concentration {
    
    var cards = [Card]()
    
    var indexOfOneAndOnlyFaceUpCard: Int?
    
    var score = 0
    
    var flipCount = 0
    
    var hasStarted = false
    
    init(numberOfPairsOfCards: Int) {
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        self.shuffleCards()
    }
    
    func chooseCard(at index: Int) {
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                if cards[index].identifier == cards[matchIndex].identifier {
                    cards[index].isMatched = true
                    cards[matchIndex].isMatched = true
                    // award some points and check for if game is over hasStarted = false
                    score += 2
                }
                cards[index].isFaceUp = true
                flipCount += 1
                // if cards[index] not matched and has been seen before, then subtract points
                if !cards[index].isMatched && cards[index].hasBeenSeenBefore {
                    score -= 1
                }
                // TODO: if cards matchIndex not matched and hasbeen seen before then subtract points
                if !cards[matchIndex].isMatched && cards[matchIndex].hasBeenSeenBefore {
                    score -= 1
                }
                cards[index].hasBeenSeenBefore = true
                cards[matchIndex].hasBeenSeenBefore = true
                indexOfOneAndOnlyFaceUpCard = nil

            } else {
                // either no cards or 2 cards face up
                for flipDownIndex in cards.indices {
                    cards[flipDownIndex].isFaceUp = false
                }
                cards[index].isFaceUp = true
                flipCount += 1
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    private func shuffleCards() {
        // create new card array where we will store cards in random order
        var shuffledCards = [Card]()
        for _ in 1...cards.count {
            // remove cards randomly from cards array
            shuffledCards += [cards.remove(at: Int(arc4random_uniform(UInt32(cards.count))))]
        }
        cards = shuffledCards
    }
    
    func reset() {
        // restart the game i.e. setting game state to be as if it is starting a new game. This will make all cards face down and not be matches, shuffle cards etc
        for index in cards.indices {
            // make it so that no cards are face up and no cards are matched
            cards[index].isFaceUp = false
            cards[index].isMatched = false
            cards[index].hasBeenSeenBefore = false
        }
        // MARK: a324234
        indexOfOneAndOnlyFaceUpCard = nil
        flipCount = 0
        score = 0
        //shuffle the cards so the order is different from last game
        shuffleCards()
        // game has started now
        hasStarted = true
    }
}
