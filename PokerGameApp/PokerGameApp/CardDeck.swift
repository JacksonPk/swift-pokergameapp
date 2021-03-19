//
//  CardDeck.swift
//  PokerGameApp
//
//  Created by jinseo park on 3/16/21.
//

import Foundation


class CardDeck{
    
    
    private var deck : [Card] = []
    private var countOfDeck : Int {
        return deck.count
    }
    private var aCard : Card?
    
    init() {
        //52장 총 4종류의 13개씩 있어야한다.
        resetDeck()
    }
    
    func pickOneCard() -> Card? {
        
        if self.deck.count != 0 {
            let card = self.deck.removeLast()
            self.aCard = card
            return card
        }else {
            return nil
        }
    }
    
    /* Durstenfeld's version Shuffle a Deck. */
    func shuffleDeck() {
        
        var newDeck : [Card] = []
        while countOfDeck > 0 {
            let randNum = Int.random(in: 0 ..< countOfDeck)
            (self.deck[countOfDeck - 1], self.deck[randNum]) = (self.deck[randNum], self.deck[countOfDeck - 1])
            newDeck.append(self.deck.removeLast())
        }
        self.deck = newDeck

    }
    
    /* Reset the card. */
    func resetDeck() {
        
        self.deck.removeAll()
        /* append all kind of cards to deck. */
        SuitCard.allCases.forEach {
            let suit = $0
            NumberOfCard.allCases.forEach {
                let numberOfCard = $0
                self.deck.append(Card.init(suit, numberOfCard))
            }
        }

    }
    
}


