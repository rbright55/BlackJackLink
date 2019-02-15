//
//  Card.swift
//  Blackjack
//
//  Created by Mac on 2/12/19.
//  Copyright © 2019 Ryan Bright. All rights reserved.
//

import Foundation
import UIKit

class Card {
    var rank:Rank
    var suit:Suit
    var description:String{
        return "\(rank) of \(suit.description)"
    }
    
    init(rank:Rank,suit:Suit){
        self.rank = rank
        self.suit = suit
    }
    
    var image:UIImage?{
        let frame = CGRect(x: 0, y: 0, width: 100, height: 150)
        let myView = UIView.init(frame: frame)
        let textLabel = UILabel(frame: frame)
        
        textLabel.textAlignment = .left
        textLabel.backgroundColor = .white
        textLabel.textColor = (self.suit == .Diamonds || self.suit == .Hearts) ? .red : .black
        textLabel.font = UIFont.boldSystemFont(ofSize: 25)
        textLabel.text = self.rank.rawValue + self.suit.rawValue
        textLabel.sizeToFit()
        myView.layer.backgroundColor = UIColor.white.cgColor
        myView.layer.borderColor = UIColor.black.cgColor
        myView.layer.borderWidth = 1.5
        myView.layer.cornerRadius = 3.5
        myView.layoutMargins = UIEdgeInsets(top: 5, left: 5, bottom: 0, right: 0)
        myView.addSubview(textLabel)
        
        UIGraphicsBeginImageContext(frame.size)
        if let currentContext = UIGraphicsGetCurrentContext() {
            myView.layer.render(in: currentContext)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return image
        }
        return nil
    }
    /*
     image sizes (height, width)
     double graphic with softbuttons 210, 370
     */
}
