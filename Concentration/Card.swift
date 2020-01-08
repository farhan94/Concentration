//
//  Card.swift
//  Concentration
//
//  Created by Farhan Ali on 12/16/19.
//  Copyright © 2019 CS193P. All rights reserved.
//

import Foundation

struct Card {
    
    static var identifierFactory = 0
    
    var isFaceUp = false
    var isMatched = false
    var hasBeenSeenBefore = false
    var identifier: Int

    static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
}
