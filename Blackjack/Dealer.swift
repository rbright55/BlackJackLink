//
//  Dealer.swift
//  Blackjack
//
//  Created by Mac on 2/14/19.
//  Copyright © 2019 Ryan Bright. All rights reserved.
//

import Foundation

class Dealer:Player {
    // bool that decides what value to show and whether to show both cards face up
    private var _firstCardDown:Bool = true
    var firstCardDown:Bool {
        get {
            return _firstCardDown
        }
        set {
            self.currentHand.firstCardDown = _firstCardDown
            _firstCardDown = newValue
        }
    }
    //first card is face down
    var upCardValue:Int {
        guard self.currentHand.cards.count > 1 else {return 0}
        return self.currentHand.cards[1].rank.value
    }
    
    override init() {
        super.init()
        self.currentHand.firstCardDown = true
    }
    //TODO: add dealer rules such as hitting on soft 17(dealer has 17 with an ace at 11)
}
