//
//  GameManager.swift
//  Blackjack
//
//  Created by Mac on 2/14/19.
//  Copyright © 2019 Ryan Bright. All rights reserved.
//

import Foundation

class GameManager {
    // Singleton
    static let shared = GameManager()
    
    var gameState:GameState = .NotStarted
    //number of decks to play with
    var numOfDecks = 1
    var player = Player()
    var dealer = Dealer()
    
    var cardsAvailable:[Card] = []
    var cardsPlayed:[Card] = []
    
    init() {
        self.refreshDeck()
    }
    
    func refreshDeck(){
        //starting cards
        if numOfDecks < 1 {numOfDecks = 1}
        
        if cardsAvailable.count + cardsPlayed.count != 52 {
            for _ in 1...numOfDecks{
                for suit in Suit.allSuites{
                    for rank in Rank.allRanks {
                        cardsAvailable.append(Card(rank: rank, suit: suit))
                    }
                }
            }
        }else{
            cardsAvailable += cardsPlayed
            cardsPlayed.removeAll()
            //remove the cards in player hands
            let cardsInHands:[Card] = self.dealer.currentHand.cards + self.player.currentHand.cards
            cardsPlayed += cardsInHands
            for card in cardsInHands {
                let index = cardsAvailable.firstIndex(where: {$0.description == card.description})!
                cardsAvailable.remove(at: index)
            }
        }
        cardsAvailable.shuffle()
        
    }
    
    //Function to start game and deal cards
    func dealCards(){
        guard cardsAvailable.count >= 4 else {return}

        self.player.currentHand.cards.append(cardPulled())
        self.dealer.currentHand.cards.append(cardPulled())
        self.player.currentHand.cards.append(cardPulled())
        self.dealer.currentHand.cards.append(cardPulled())
    }
    
    func cardPulled() -> Card{
        //TODO: Check number of cards and shuffle if necessary
        let nextCard = cardsAvailable.randomElement()!
        cardsPlayed.append(nextCard)
        let index = cardsAvailable.firstIndex(where: {$0.description == nextCard.description})!
        cardsAvailable.remove(at: index)
        return nextCard
    }
    
    func hit(){
        switch self.gameState {
        case .PlayersTurn:
            self.player.currentHand.cards.append(cardPulled())
        case .DealersTurn:
            self.dealer.currentHand.cards.append(cardPulled())
        default:
            return
        }
    }
    func stand(){
        //change hand state, turn, game state
        switch self.gameState {
        case .PlayersTurn:
            self.gameState = .DealersTurn
        case .DealersTurn:
            self.gameState = .ShowCards
        default:
            return
        }
        //TODO: advance to next screen
    }
    
    
    
}
