//
//  ViewController.swift
//  Blackjack
//
//  Created by Mac on 2/12/19.
//  Copyright © 2019 Ryan Bright. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var image: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        GameManager.shared.dealCards()
        self.image.image = GameManager.shared.dealer.currentHand.handImage()
    }


}

