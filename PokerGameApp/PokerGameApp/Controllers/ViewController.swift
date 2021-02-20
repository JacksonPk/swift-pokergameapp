//
//  ViewController.swift
//  PokerGameApp
//
//  Created by Song on 2021/02/15.
//

import UIKit

class ViewController: UIViewController {
    
    var deckForTest = CardDeck()
    var deckForGame = CardDeck()
    
    let segmentedControlStackView = UIStackView()
    let gameTypeSegmentedControl = UISegmentedControl()
    let numberOfPlayersSegmentedControl = UISegmentedControl()
    let playerStackView = UIStackView()
    
    var currentNumberOfPlayers = PokerGame.Size.twoPlayers
    var currentGameType = PokerGame.StudPoker.sevenCardStud
    
    override func viewDidLoad() {
        super.viewDidLoad()
        testScenarios()
        
        if let backgroundImage = UIImage(named: "bg_pattern") {
            self.view.backgroundColor = UIColor(patternImage: backgroundImage)
        }
        
        createNewGame(with: currentGameType)
        
        setProperties(of: segmentedControlStackView, axis: .vertical)
        segmentedControlStackView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        setConstraints(of: segmentedControlStackView, padding: 100.0)
        
        gameTypeSegmentedControl.insertSegment(withTitle: PokerGame.StudPoker.sevenCardStud.description, at: 0, animated: true)
        gameTypeSegmentedControl.insertSegment(withTitle: PokerGame.StudPoker.fiveCardStud.description, at: 1, animated: true)
        setProperties(of: gameTypeSegmentedControl)
        gameTypeSegmentedControl.addTarget(self, action: #selector(gameTypeChanged(_:)), for: .valueChanged)
        
        numberOfPlayersSegmentedControl.insertSegment(withTitle: PokerGame.Size.twoPlayers.description, at: 0, animated: true)
        numberOfPlayersSegmentedControl.insertSegment(withTitle: PokerGame.Size.threePlayers.description, at: 1, animated: true)
        numberOfPlayersSegmentedControl.insertSegment(withTitle: PokerGame.Size.fourPlayers.description, at: 2, animated: true)
        setProperties(of: numberOfPlayersSegmentedControl)
        numberOfPlayersSegmentedControl.addTarget(self, action: #selector(numberOfPlayersChanged(_:)), for: .valueChanged)
        
        setProperties(of: playerStackView, axis: .vertical)
        playerStackView.distribution = .equalSpacing
        playerStackView.topAnchor.constraint(equalTo: segmentedControlStackView.bottomAnchor, constant: 5).isActive = true
        playerStackView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        setConstraints(of: playerStackView, padding: 0)
    }
    
    @objc func gameTypeChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            currentGameType = .sevenCardStud
        case 1:
            currentGameType = .fiveCardStud
        default:
            break
        }
        createNewGame(with: currentGameType)
    }
    
    @objc func numberOfPlayersChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            currentNumberOfPlayers = PokerGame.Size.twoPlayers
        case 1:
            currentNumberOfPlayers = PokerGame.Size.threePlayers
        case 2:
            currentNumberOfPlayers = PokerGame.Size.fourPlayers
        default:
            break
        }
        createNewGame(with: currentNumberOfPlayers)
    }
    
    func clearPlayerStackView() {
        playerStackView.subviews.forEach { $0.removeFromSuperview() }
    }
    
    func updateGameInfo(with selectedGame: PokerGame.StudPoker) -> PokerGame {
        let dealer = Dealer(cardDeck: deckForGame)
        let players = Players(numberOfPlayers: currentNumberOfPlayers)
        let game = PokerGame(dealer: dealer, players: players, gameType: selectedGame)
        game.startGame()
        return game
    }
    
    func updateGameInfo(with selectedNumberOfPlayers: PokerGame.Size) -> PokerGame {
        let dealer = Dealer(cardDeck: deckForGame)
        let players = Players(numberOfPlayers: selectedNumberOfPlayers)
        let gameType = currentGameType
        let game = PokerGame(dealer: dealer, players: players, gameType: gameType)
        game.startGame()
        return game
    }
    
    func updatePlayerStackView(for game: PokerGame) {
        game.getPlayersResult().forEach {
            let cardInfoStackView = makeCardInfoStackView(nickname: $0.getOwnerName(), cardViews: $0.makeCardViews())
            playerStackView.addArrangedSubview(cardInfoStackView)
        }
        let dealerCardInfo = makeCardInfoStackView(nickname: game.getDealerResult().getOwnerName(), cardViews: game.getDealerResult().makeCardViews())
        playerStackView.addArrangedSubview(dealerCardInfo)
    }
    
    func setProperties(of stackView: UIStackView, axis: NSLayoutConstraint.Axis) {
        self.view.addSubview(stackView)
        stackView.axis = axis
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 5.0
    }
    
    func setProperties(of segmentedControl: UISegmentedControl) {
        segmentedControlStackView.addArrangedSubview(segmentedControl)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.heightAnchor.constraint(equalToConstant: 31).isActive = true
        
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.black], for: .selected)
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.white], for: .normal)
    }
    
    func setConstraints(of view: UIView, padding: CGFloat) {
        view.translatesAutoresizingMaskIntoConstraints = false
        view.leadingAnchor.constraint(equalTo: self.view.layoutMarginsGuide.leadingAnchor, constant: padding).isActive = true
        view.trailingAnchor.constraint(equalTo: self.view.layoutMarginsGuide.trailingAnchor, constant: -padding).isActive = true
    }
    
    func makeCardStackView(with cardViews: [UIImageView]) -> UIStackView {
        let cardStackView = UIStackView()
        cardViews.forEach { cardStackView.addArrangedSubview($0) }
        cardStackView.spacing = -10.0
        return cardStackView
    }
    
    func makeCardInfoStackView(nickname: String, cardViews: [UIImageView]) -> UIStackView {
        let cardInfoStackView = UIStackView()
        cardInfoStackView.translatesAutoresizingMaskIntoConstraints = false
        cardInfoStackView.axis = .vertical
        cardInfoStackView.alignment = .fill
        cardInfoStackView.distribution = .fill
        
        let nameLabel = UILabel()
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        cardInfoStackView.addArrangedSubview(nameLabel)
        nameLabel.text = nickname
        nameLabel.textColor = UIColor.white
        
        let cardStackView = makeCardStackView(with: cardViews)
        cardInfoStackView.addArrangedSubview(cardStackView)
        return cardInfoStackView
    }
    
    func createNewGame<T>(with info: T) {
        clearPlayerStackView()
        if T.self is PokerGame.StudPoker.Type {
            let newGame = updateGameInfo(with: currentGameType)
            updatePlayerStackView(for: newGame)
        } else if T.self is PokerGame.Size.Type {
            let newGame = updateGameInfo(with: currentNumberOfPlayers)
            updatePlayerStackView(for: newGame)
        }
    }
    
    func testScenarios() {
        print(Test(testCase: .create, testDeck: deckForTest, expectedValue: 52))
        deckForTest.shuffle()
        print(Test(testCase: .shuffle, testDeck: deckForTest, expectedValue: 52))
        let _ = deckForTest.removeOne()
        print(Test(testCase: .removeOne, testDeck: deckForTest, expectedValue: 51))
        deckForTest.reset()
        print(Test(testCase: .reset, testDeck: deckForTest, expectedValue: 52))
    }
}
