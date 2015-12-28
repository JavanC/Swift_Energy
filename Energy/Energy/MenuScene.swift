//
//  GameScene.swift
//  Energy
//
//  Created by javan.chen on 2015/12/25.
//  Copyright (c) 2015年 Javan chen. All rights reserved.
//

import SpriteKit
// Game UI Data
var colorEnergy = UIColor(red: 0.519, green: 0.982, blue: 1.000, alpha: 1.000)
var colorReserch = UIColor(red: 0.231, green: 0.705, blue: 0.275, alpha: 1.000)
// Game Data
enum BuildingType: Int {
    case Nil, Wind, Fire, Generator, Office, BuildingTypeLength
}
enum UpgradeType: Int {
    case Wind_Heat_Max, Fire_Heat_Max, Fire_Heat_Produce, Office_Sell, UpgradeTypeLength
}
enum ReserchType: Int {
    case Wind_Rebuild, Fire_Develope, Fire_Rebuild, Office_Develope, ReserchTypeLength
}
// User Data
var money: Int = 100
var reserch: Int = 100
var upgradeLevel = [UpgradeType: Int]()
var reserchLevel = [ReserchType: Int]()
var maps = [BuildingMapLayer]()
var nowMapNumber: Int = 0

class MenuScene: SKScene {
    
    var contentCreated: Bool = false
    var stertGameButton: SKLabelNode!

    override func didMoveToView(view: SKView) {
        if !contentCreated {
            self.backgroundColor = SKColor.whiteColor()
            stertGameButton = SKLabelNode(fontNamed:"Verdana-Bold")
            stertGameButton.text = "Stert Game"
            stertGameButton.fontSize = 45
            stertGameButton.fontColor = SKColor.blackColor()
            stertGameButton.position = CGPoint(x: CGRectGetMidX(frame), y: CGRectGetMidY(frame))
            self.addChild(stertGameButton)
            initialLevelData()
            contentCreated = true
        }
    }
    
    func initialLevelData() {
        for count in 0..<UpgradeType.UpgradeTypeLength.hashValue {
            upgradeLevel[UpgradeType(rawValue: count)!] = 1
        }
        for count in 0..<ReserchType.ReserchTypeLength.hashValue {
            reserchLevel[ReserchType(rawValue: count)!] = 1
        }
        for _ in 0..<8 {
            let buildingMapLayer = BuildingMapLayer()
            buildingMapLayer.configureAtPosition(CGPoint(x: 0, y: 0))
            maps.append(buildingMapLayer)
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch in touches {
            let location = touch.locationInNode(self)
            if stertGameButton.containsPoint(location) {
                print("tap")
                let doors = SKTransition.revealWithDirection(SKTransitionDirection.Left, duration: 0.3)
                self.view?.presentScene(islandsScene, transition: doors)
            }
        }
    }
   
    override func update(currentTime: CFTimeInterval) {
    }
}
