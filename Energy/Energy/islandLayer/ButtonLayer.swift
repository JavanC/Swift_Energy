//
//  ButtonLayer.swift
//  Energy
//
//  Created by javan.chen on 2015/12/18.
//  Copyright © 2015年 Javan chen. All rights reserved.
//

import SpriteKit

class ButtonLayer: SKSpriteNode {

    var buttonBuild: SKSpriteNode!
    var buttonSell: SKSpriteNode!
    var buttonEnergy: SKSpriteNode!
    var buttonUpgrade: SKSpriteNode!
    var buttonResearch: SKSpriteNode!
    
    func configureAtPosition(position: CGPoint, size: CGSize) {
        self.position = position
        self.size = size
        self.color = SKColor.grayColor()
        self.name = "ButtonLayer"
        self.anchorPoint = CGPoint(x: 0, y: 0)
        
        buttonBuild = SKSpriteNode(color: colorBackground, size: CGSize(width: size.width / 5, height: size.height))
        buttonBuild.name = "ButtonBuild"
        buttonBuild.anchorPoint = CGPoint(x: 0, y: 0)
        buttonBuild.position = CGPoint(x: 0, y: 0)
        addChild(buttonBuild)
        let texture = SKSpriteNode(imageNamed: "btest123")
        
        buttonBuild.addChild(texture)
//        buttonBuild.runAction(SKAction.setTexture(SKTexture(imageNamed: "button build")))
        
        buttonSell = SKSpriteNode(color: colorBackground, size: CGSize(width: size.width / 5, height: size.height))
        buttonSell.name = "ButtonSell"
        buttonSell.anchorPoint = CGPoint(x: 0, y: 0)
        buttonSell.position = CGPoint(x: size.width * 1 / 5, y: 0)
        addChild(buttonSell)
        
        buttonEnergy = SKSpriteNode(color: colorBackground, size: CGSize(width: size.width / 5, height: size.height))
        buttonEnergy.name = "ButtonEnergy"
        buttonEnergy.anchorPoint = CGPoint(x: 0, y: 0)
        buttonEnergy.position = CGPoint(x: size.width * 2 / 5, y: 0)
        addChild(buttonEnergy)
  
        buttonUpgrade = SKSpriteNode(color: colorBackground, size: CGSize(width: size.width / 5, height: size.height))
        buttonUpgrade.name = "ButtonUpgrade"
        buttonUpgrade.anchorPoint = CGPoint(x: 0, y: 0)
        buttonUpgrade.position = CGPoint(x: size.width * 3 / 5, y: 0)
        addChild(buttonUpgrade)
        
        buttonResearch = SKSpriteNode(color: colorBackground, size: CGSize(width: size.width / 5, height: size.height))
        buttonResearch.name = "ButtonResearch"
        buttonResearch.anchorPoint = CGPoint(x: 0, y: 0)
        buttonResearch.position = CGPoint(x: size.width * 4 / 5, y: 0)
        addChild(buttonResearch)
        
        tapButtonNil()
    }
    
    func tapButtonNil() {
        buttonBuild.alpha = 1
        buttonSell.alpha = 1
        buttonEnergy.alpha = 1
    }
    func tapButtonBuild() {
        buttonBuild.alpha = 0.6
        buttonSell.alpha = 1
        buttonEnergy.alpha = 1
    }
    func tapButtonSell() {
        buttonBuild.alpha = 1
        buttonSell.alpha = 0.6
        buttonEnergy.alpha = 1
    }
    func tapButtonEnergy() {
        buttonBuild.alpha = 1
        buttonSell.alpha = 1
        buttonEnergy.alpha = 0.6
    }
}