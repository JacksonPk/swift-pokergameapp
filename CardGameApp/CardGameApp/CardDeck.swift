//
//  CardDeck.swift
//  CardGameApp
//
//  Created by delma on 06/02/2020.
//  Copyright © 2020 delma. All rights reserved.
//

import Foundation
struct CardDeck {
    var cards :[Card] = []
    
    init() {
        Card.Number.allCases.map { number in
            Card.Pattern.allCases.map{ pattern in
                cards.append(Card(number: number, pattern: pattern ))
            }
        }
    }
    
    func count() -> Int {
        return cards.count
    }
    
    mutating func shuffle() {
        self.cards = cards.shuffled()
    }
    
    mutating func removeOn() -> Card {
        return cards.removeFirst()
    }
    
    func reset() {
        type(of: self).init()
    }
    
}
