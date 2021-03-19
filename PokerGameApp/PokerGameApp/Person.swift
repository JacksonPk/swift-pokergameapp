//
//  Player.swift
//  PokerGameApp
//
//  Created by jinseo park on 3/16/21.
//

import Foundation

/* Pocker 에서 플레이어, 딜러는 각자 할당받는 카드가 있다.
    딜러가 보통 카드를 나누어준다.
 */
class Person : CustomStringConvertible {
    var description: String {
        return "\(self.personType) , \(self.cardsInHand)"
    }
    enum PersonType : String {
        case Player, Dealer
    }    
    private var personType : PersonType
    private var cardsInHand : [Card] = []
    
    init(_ personType : PersonType) {
        self.personType = personType
    }
    
    func getCard(starter gameType : GameType , from deck : CardDeck) {
        for _ in 0 ..< gameType.getValue() {
            guard let card = deck.pickOneCard() else { return }
            cardsInHand.append(card)
        }
        
    }
        
}
