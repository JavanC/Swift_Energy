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
    var buttonEnergy: SKSpriteNode!
    var buttonReserch: SKSpriteNode!
    
    func configureAtPosition(position: CGPoint, size: CGSize) {
        self.position = position
        self.size = size
        self.color = SKColor.grayColor()
        self.name = "ButtonLayer"
        self.anchorPoint = CGPoint(x: 0, y: 0)
        
        buttonBuild = SKSpriteNode(color: SKColor.brownColor(), size: CGSize(width: size.width / 4, height: 100))
        buttonBuild.name = "ButtonBuild"
        buttonBuild.anchorPoint = CGPoint(x: 0, y: 0)
        buttonBuild.position = CGPoint(x: 0, y: 0)
        addChild(buttonBuild)
        
        buttonEnergy = SKSpriteNode(color: colorEnergy, size: CGSize(width: size.width / 2, height: 100))
        buttonBuild.name = "ButtonEnergy"
        buttonEnergy.anchorPoint = CGPoint(x: 0, y: 0)
        buttonEnergy.position = CGPoint(x: size.width / 4, y: 0)
        addChild(buttonEnergy)
        
        buttonReserch = SKSpriteNode(color: colorReserch, size: CGSize(width: size.width / 4, height: 100))
        buttonBuild.name = "ButtonReserch"
        buttonReserch.anchorPoint = CGPoint(x: 0, y: 0)
        buttonReserch.position = CGPoint(x: size.width * 3 / 4, y: 0)
        addChild(buttonReserch)
    }
    
    func tapButtonNil() {
        buttonBuild.alpha = 1
        buttonReserch.alpha = 1
        buttonEnergy.alpha = 1
    }
    func tapButtonBuild() {
        buttonBuild.alpha = 0.8
        buttonReserch.alpha = 1
        buttonEnergy.alpha = 1
    }
    func tapNilEnergy() {
        buttonBuild.alpha = 1
        buttonReserch.alpha = 1
        buttonEnergy.alpha = 0.8
    }
    func tapNilReserch() {
        buttonBuild.alpha = 1
        buttonReserch.alpha = 0.8
        buttonEnergy.alpha = 1
    }
}