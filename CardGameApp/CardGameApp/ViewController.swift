//
//  ViewController.swift
//  CardGameApp
//
//  Created by Keunna Lee on 2020/02/08.
//  Copyright © 2020 Keunna Lee. All rights reserved.
//

import UIKit
import UIKit

class ViewController: UIViewController {
    // 스택 뷰 설정
    let cardsStack: UIStackView = {
        let horizontalStackView = UIStackView()
        horizontalStackView.translatesAutoresizingMaskIntoConstraints = false
        horizontalStackView.axis = .horizontal
        horizontalStackView.distribution = .fillEqually
        horizontalStackView.spacing = 4
        
        return horizontalStackView
    }()
    
    func setStackView() {
        cardsStack.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 40).isActive = true
        cardsStack.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 5).isActive = true
        cardsStack.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -5).isActive = true
    }
    
    // 스택뷰에 넣을 이미지 뷰 생성
    func makeCard() -> UIImageView {
        let card = UIImageView(image:  #imageLiteral(resourceName: "card-back"))
        card.contentMode = .scaleAspectFit
        card.heightAnchor.constraint(equalTo: card.widthAnchor, multiplier: 1.27).isActive = true
        return card
    }
    
    func addCards() {
        for _ in 0 ..< 7 {
            cardsStack.addArrangedSubview(makeCard())
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(patternImage:  #imageLiteral(resourceName: "bg_pattern"))
        addCards()
        self.view.addSubview(cardsStack)
        setStackView ()
        CardDeck()
        
        print("명령어를 입력해주세요 :)")
        let command = readLine() ?? ""
        
        switch command {
        case InputView.command.reset.rawValue :
            var cardDeck = CardDeck()
            cardDeck.reset()
        case InputView.command.shuffle.rawValue :
            var cardDeck = CardDeck()
            cardDeck.shuffle()
        case InputView.command.count.rawValue :
            var cardDeck = CardDeck()
            cardDeck.count()
        case InputView.command.removeOne.rawValue :
            var cardDeck = CardDeck()
            cardDeck.removeOne(of: )
        default:
            <#code#>
        }
        
    }
}
