//
//  Hand.swift
//  Blackjack
//
//  Created by Mac on 2/14/19.
//  Copyright © 2019 Ryan Bright. All rights reserved.
//

import Foundation
import UIKit

class Hand {
    var cards:[Card] = []
    //TODO: Should maybe calculate the highest value under 21
    var value:Int{
        var val = 0
        self.cards.forEach({val += $0.rank.value})
        return val
    }
    var state:HandState = .Active
    var hasAce:Bool {
        return self.cards.contains(where: {$0.rank == Rank.ace})
    }
    var firstCardDown = false
    
    func handImage()->UIImage?{
        guard self.cards.count > 1 else{return nil}
        //TODO: figure out if this is the dealers hand or players hand to know if card should be face down
        //get player card images
        let bottomImage = self.cards.first?.image!
        
        let xOffset = 20
        let yOffset = 35
        let size = CGSize(width: (bottomImage?.size.width)!+CGFloat(xOffset*(self.cards.count-1)), height: (bottomImage?.size.height)!+CGFloat(yOffset*(self.cards.count-1)))
        UIGraphicsBeginImageContext(size)
        for i in 0...(self.cards.count-1){
            if i == 0{
                bottomImage?.draw(at: CGPoint(x: 0, y: 0))
            }
            let newX = xOffset*i
            let newY = yOffset*i
            let nextImage = self.cards[i].image
            nextImage?.draw(at: CGPoint(x: newX, y: newY))
        }
        
        //TODO: Draw score at the bottom of the view
        let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return newImage
    }
}
