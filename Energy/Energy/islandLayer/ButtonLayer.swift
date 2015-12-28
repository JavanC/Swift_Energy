//
//  ButtonLayer.swift
//  Energy
//
//  Created by javan.chen on 2015/12/18.
//  Copyright © 2015年 Javan chen. All rights reserved.
//

import SpriteKit

class ButtonLayer: SKSpriteNode {

    var buttonStatus: String!
    var buttonBuild: SKSpriteNode!
    var buttonSell: SKSpriteNode!
    var buttonEnergy: SKSpriteNode!
    var buttonUpgrade: SKSpriteNode!
    var buttonReserch: SKSpriteNode!
    
    func configureAtPosition(position: CGPoint, size: CGSize) {
        self.position = position
        self.size = size
        self.color = SKColor.grayColor()
        self.name = "ButtonLayer"
        self.anchorPoint = CGPoint(x: 0, y: 0)
        
        buttonBuild = SKSpriteNode(color: SKColor.brownColor(), size: CGSize(width: size.width * 2 / 11, height: size.height))
        buttonBuild.name = "ButtonBuild"
        buttonBuild.anchorPoint = CGPoint(x: 0, y: 0)
        buttonBuild.position = CGPoint(x: 0, y: 0)
        addChild(buttonBuild)
        
        buttonSell = SKSpriteNode(color: SKColor.yellowColor(), size: CGSize(width: size.width * 2 / 11, height: size.height))
        buttonSell.name = "ButtonSell"
        buttonSell.anchorPoint = CGPoint(x: 0, y: 0)
        buttonSell.position = CGPoint(x: size.width * 2 / 11, y: 0)
        addChild(buttonSell)
        
        buttonEnergy = SKSpriteNode(color: colorEnergy, size: CGSize(width: size.width * 3 / 11, height: size.height))
        buttonEnergy.name = "ButtonEnergy"
        buttonEnergy.anchorPoint = CGPoint(x: 0, y: 0)
        buttonEnergy.position = CGPoint(x: size.width * 4 / 11, y: 0)
        addChild(buttonEnergy)
  
        buttonUpgrade = SKSpriteNode(color: SKColor.greenColor(), size: CGSize(width: size.width * 2 / 11, height: size.height))
        buttonUpgrade.name = "ButtonUpgrade"
        buttonUpgrade.anchorPoint = CGPoint(x: 0, y: 0)
        buttonUpgrade.position = CGPoint(x: size.width * 7 / 11, y: 0)
        addChild(buttonUpgrade)
        
        buttonReserch = SKSpriteNode(color: colorReserch, size: CGSize(width: size.width * 2 / 11, height: size.height))
        buttonReserch.name = "ButtonReserch"
        buttonReserch.anchorPoint = CGPoint(x: 0, y: 0)
        buttonReserch.position = CGPoint(x: size.width * 9 / 11, y: 0)
        addChild(buttonReserch)
        
        tapButtonNil()
    }
    
    func tapButtonNil() {
        buttonStatus = "nil"
        buttonBuild.alpha = 1
        buttonReserch.alpha = 1
        buttonEnergy.alpha = 1
    }
    func tapButtonBuild() {
        buttonStatus = "build"
        buttonBuild.alpha = 0.6
        buttonReserch.alpha = 1
        buttonEnergy.alpha = 1
    }
    func tapButtonEnergy() {
        buttonStatus = "energy"
        buttonBuild.alpha = 1
        buttonReserch.alpha = 1
        buttonEnergy.alpha = 0.6
    }
    func tapButtonReserch() {
        buttonStatus = "reserch"
        buttonBuild.alpha = 1
        buttonReserch.alpha = 0.6
        buttonEnergy.alpha = 1
    }
}