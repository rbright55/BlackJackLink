//
//  enums.swift
//  Blackjack
//
//  Created by Mac on 2/12/19.
//  Copyright © 2019 Ryan Bright. All rights reserved.
//

import Foundation

enum GameState{
    case NotStarted
    case PlayersTurn
    case DealersTurn
    case ShowCards
    case GameEnded
}
enum HandState:String{
    case Active = "Active", Stood = "Stood", Busted = "Busted", Lost = "Lost", Tied = "Tied", Blackjack = "Blackjack"
}
enum Suit:String{
    case Spades = "♠️", Hearts = "♥️", Diamonds = "♦️", Clubs = "♣️"
    var description:String{
        switch self {
        case .Spades:
            return "spades"
        case .Hearts:
            return "hearts"
        case .Diamonds:
            return "diamonds"
        case .Clubs:
            return "clubs"
        }
    }
    static var allSuites:[Suit] = [.Spades,.Hearts,.Diamonds,.Clubs]
}
enum Rank:String {
    case two = "2"
    case three = "3"
    case four = "4"
    case five = "5"
    case six = "6"
    case seven = "7"
    case eight = "8"
    case nine = "9"
    case ten = "10"
    case jack = "J"
    case queen = "Q"
    case king = "K"
    case ace = "A"
    
    var value:Int {
        switch self {
        case .two:
            return 2
        case .three:
            return 3
        case .four:
            return 4
        case .five:
            return 5
        case .six:
            return 6
        case .seven:
            return 7
        case .eight:
            return 8
        case .nine:
            return 9
        case .ten:
            return 10
        case .jack:
            return 10
        case .queen:
            return 10
        case .king:
            return 10
        case .ace:
            return 1
        }
    }
    var altValue:Int?{
        switch self {
        case .ace:
            return 11
        default:
            return nil
        }
    }
    static var allRanks:[Rank] = [.two,.three,.four,.five,.six,.seven,.eight,.nine,.ten,.jack,.queen,.king,.ace]
}

