//
//  Player.swift
//  PokerGameApp
//
//  Created by jinseo park on 3/16/21.
//

import Foundation

/*
 요구사항
 게임 타입 = 5스타터, 7스타터
 사람 = 딜러(init), 플레이어 (Min: 1, max: 4)
 */

enum PokerGameError : Error {
    case initError
}
enum GameType : Int {
    case FiveStarter = 5
    case SevenStarter = 7
    
    func getValue() -> Int {
        return self.rawValue
    }
}

enum NumOfPlayers : Int {
    case One = 1,Two,Three,Four
    
    /*직접적인 rawValue를 쓰지않기 위해 함수로 제작*/
    func getValue() -> Int {
        return self.rawValue
    }
}

fileprivate var DEALER : Int = 1

class PokerGame {
    
    var deck = CardDeck()
    var totalPlayers : [Person] = [Person.init(.Dealer)] /*딜러는 무조건 존재하기 때문에.*/
    var typeOfGame : GameType
    
    /* 총 플레이어 수와 게임 타입을 정해야 한다.*/
    init( howManyPlayers numberOfPlayers : NumOfPlayers , whichStarter typeOfGame : GameType ) {
        
        self.typeOfGame = typeOfGame
                        
        /*계속 헷갈리는 부분 : rawValue를 사용하지 않고 가능한 것인지 -> 함수로 제작*/
        for _ in 0 ..< numberOfPlayers.getValue() {
            self.totalPlayers.append(Person.init(.Player))
        }
        
    }
        
    /*모든 플레이어에게 게임타입별 카드개수를 나누어 준다.*/
    func giveCardsToPlayerNDealer() {
        for player in 0 ..< self.totalPlayers.count {
        
            self.totalPlayers[player].getCard(starter: self.typeOfGame, from: deck)
            
        }
    }
    
}

