//
//  Player.swift
//  PokerGameApp
//
//  Created by Song on 2021/02/17.
//

import Foundation

class Player {
    
    private var cards: [Card]
    
    init() {
        self.cards = []
    }
    
    func dealt(_ card: Card) {
        self.cards.append(card)
    }
    
    func showdown() -> [Card] {
        return cards
    }
}
