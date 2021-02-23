//
//  Player.swift
//  PokerGameApp
//
//  Created by Song on 2021/02/17.
//

import Foundation

class Player {
    
    private(set) var nickname: String
    private var cards: [Card]
    
    init(nickname: String) {
        self.nickname = nickname
        self.cards = []
    }
    
    func dealt(_ card: Card) {
        self.cards.append(card)
    }
}
