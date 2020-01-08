//
//  Theme.swift
//  Concentration
//
//  Created by Farhan Ali on 12/16/19.
//  Copyright © 2019 CS193P. All rights reserved.
//

import Foundation
import UIKit

// Theme object, used for creating new themes
class Theme {
    
    var emojis = [String]()
    var backgroundColor : UIColor
    var cardColor : UIColor

    init(emojis: [String], backgroundColor: UIColor, cardColor: UIColor) {
        self.emojis = emojis
        self.backgroundColor = backgroundColor
        self.cardColor = cardColor
    }
}
