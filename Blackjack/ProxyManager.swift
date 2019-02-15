//
//  ProxyManager.swift
//  Blackjack
//
//  Created by Mac on 2/13/19.
//  Copyright © 2019 Ryan Bright. All rights reserved.
//

import UIKit
import SmartDeviceLink

class ProxyManager: NSObject {
    private let appName = "Blackjack"
    private let shortAppName = "Blackjack"
    private let appID = "555"
    private let appType:SDLAppHMIType = .default
    
    
    //Manager
    fileprivate var sdlManager: SDLManager!
    
    // Singleton
    static let shared = ProxyManager()
    
    private override init() {
        super.init()
        
        // Used for USB Connection
        let lifecycleConfiguration = SDLLifecycleConfiguration(appName: appName, fullAppId: appID)
        
   
        // App icon image
        if let appImage = UIImage(named: "icon") {
            let appIcon = SDLArtwork(image: appImage, name: "icon", persistent: true, as: .JPG /* or .PNG */)
            lifecycleConfiguration.appIcon = appIcon
        }
        
        lifecycleConfiguration.shortAppName = shortAppName
        lifecycleConfiguration.appType = appType
        
        let configuration = SDLConfiguration(lifecycle: lifecycleConfiguration, lockScreen: .enabled(), logging: .debug(), fileManager: .default())
        
        sdlManager = SDLManager(configuration: configuration, delegate: self)
    }
    
    func connect() {
        // Start watching for a connection with a SDL Core
        sdlManager.start { (success, error) in
            if success {
                // Your app has successfully connected with the SDL Core
            }
        }
    }
    
    //MARK: Game Functions
    
    //send start view
    func showStartView(){
        guard GameManager.shared.gameState == .NotStarted else {return}
        let softButtonState1 = SDLSoftButtonState(stateName: "default", text: "Play", artwork: nil)
        let startButtonObject = SDLSoftButtonObject(name: "Play", states: [softButtonState1], initialStateName: "default") { (buttonPress, buttonEvent) in
            guard buttonPress != nil else { return }
            GameManager.shared.gameState = .PlayersTurn
            self.showPlayersTurn()
        }
        
        sdlManager.screenManager.beginUpdates()
        sdlManager.screenManager.softButtonObjects = [startButtonObject]
        sdlManager.screenManager.endUpdates()
    }
    
    func showPlayersTurn(){
        //hit button
        let softButtonState1 = SDLSoftButtonState(stateName: "default", text: "Hit", artwork: nil)
        let hitButtonObject = SDLSoftButtonObject(name: "Hit", states: [softButtonState1], initialStateName: "default") { (buttonPress, buttonEvent) in
            if buttonPress != nil {
                GameManager.shared.hit()
                self.updateCardsShown()
            }
        }
        //stand button
        let standButtonState1 = SDLSoftButtonState(stateName: "default", text: "Stand", artwork: nil)
        let standButtonObject = SDLSoftButtonObject(name: "Stand", states: [standButtonState1], initialStateName: "default") { (buttonPress, buttonEvent) in
            if buttonPress != nil {
                GameManager.shared.stand()
            }
        }
        self.updateCardsShown()
        sdlManager.screenManager.beginUpdates()
        sdlManager.screenManager.softButtonObjects = [hitButtonObject,standButtonObject]
        sdlManager.screenManager.endUpdates()
    }
    
    func updateCardsShown(){
        let leftImage = SDLArtwork(image: GameManager.shared.dealer.currentHand.handImage()!, persistent: false, as: .PNG)
        let rightImage = SDLArtwork(image: GameManager.shared.player.currentHand.handImage()!, persistent: false, as: .PNG)
        sdlManager.screenManager.beginUpdates()
        sdlManager.screenManager.primaryGraphic = leftImage
        sdlManager.screenManager.secondaryGraphic = rightImage
        sdlManager.screenManager.endUpdates()
    }
}

//MARK: SDLManagerDelegate
extension ProxyManager: SDLManagerDelegate {
    func managerDidDisconnect() {
        print("Manager disconnected!")
    }
    
    func hmiLevel(_ oldLevel: SDLHMILevel, didChangeToLevel newLevel: SDLHMILevel) {
        print("Went from HMI level \(oldLevel) to HMI level \(newLevel)")
        if newLevel == .full {
            let layout = SDLSetDisplayLayout(predefinedLayout: .doubleGraphicWithSoftButtons)
            
            self.sdlManager.send(request: layout, responseHandler: {request, response, error in
                guard response?.success as! Bool else{return}
                self.showStartView()
            })
        }
    }
}
