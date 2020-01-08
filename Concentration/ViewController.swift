//
//  ViewController.swift
//  Concentration
//
//  Created by Farhan Ali on 12/16/19.
//  Copyright © 2019 CS193P. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    lazy var game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
    
    var themes = [Theme(emojis: ["🦇", "😱", "🙀", "😈", "🎃", "👻", "🍭", "🍬", "🍎"], backgroundColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), cardColor: #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)),
                  Theme(emojis: ["🏀","🏈","⚽️","⚾️","🥎","🎾","🏐","🏉","🏸"], backgroundColor: #colorLiteral(red: 0.6679978967, green: 0.4751212597, blue: 0.2586010993, alpha: 1), cardColor: #colorLiteral(red: 0, green: 0.9768045545, blue: 0, alpha: 1)),
                  Theme(emojis: ["😀","😃","😄","😁","😆","😅","😂","🤣","🙂"], backgroundColor: #colorLiteral(red: 0.4392156899, green: 0.01176470611, blue: 0.1921568662, alpha: 1), cardColor: #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)),
                  Theme(emojis: ["🎁","🎄","🎅","🎉","🤶","☃️","❄️","🀩","⛄️"], backgroundColor: #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1), cardColor: #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1))]
    
    var currentTheme : Theme? = nil
    
    var emojiChoices = [String]()
    
    var emojisInUse = [Int:String]()
    
    @IBOutlet var cardButtons: [UIButton]!
    
    @IBOutlet weak var flipCountLabel: UILabel!
    
    @IBOutlet weak var scoreLabel: UILabel!

    @IBAction func startNewGame(_ sender: UIButton) {
        // make it so that no emojis are in use
        emojisInUse.removeAll()
        // set previousTheme to the currentTheme. We will be choosing a new theme, but we don't want the theme we just used to be chosen again. We will add the previous theme back in to the mix after we choose our next theme
        let previousTheme = currentTheme
        // choose new theme
        currentTheme = themes.remove(at: Int(arc4random_uniform(UInt32(themes.count))))
        // add the theme from our last game back into the themes array
        if previousTheme != nil {
            themes.append(previousTheme!)
        }
        // reset game stats
        game.reset()
        //set possble emoji choices to the ones available in our current theme
        emojiChoices = currentTheme!.emojis
        self.view.backgroundColor = currentTheme!.backgroundColor
        // update the view to represent our current state
        updateViewFromModel()
        
    }
    
    @IBAction func touchCard(_ sender: UIButton) {
        // This if statement will only allow cards to be touched when the game has started (when player clicks new game
        if (game.hasStarted) {
            if let cardNumber = cardButtons.firstIndex(of: sender) {
                if !game.cards[cardNumber].isFaceUp && !game.cards[cardNumber].isMatched {
                    game.chooseCard(at: cardNumber)
                    updateViewFromModel()
                }
            }
        }
    }
    
    func updateViewFromModel() {
        flipCountLabel.text = "Flips: \(game.flipCount)"
        scoreLabel.text = "Score: \(game.score)"
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
            } else {
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) : currentTheme!.cardColor
                
            }
        }
    }
    
    func emoji(for card: Card) -> String {
        if emojiChoices.count > 0, emojisInUse[card.identifier] == nil {
            emojisInUse[card.identifier] = emojiChoices.remove(at: Int(arc4random_uniform(UInt32(emojiChoices.count))))
        }
        return emojisInUse[card.identifier] ?? "?"
    }
}

