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
    var choiceCircle: SKShapeNode!
    var energyArc: SKShapeNode!
    
    func configureAtPosition(position: CGPoint, size: CGSize) {
        self.position = position
        self.size = size
        self.color = SKColor.grayColor()
        self.name = "ButtonLayer"
        self.anchorPoint = CGPoint(x: 0, y: 0)
        
        buttonBuild = SKSpriteNode(color: colorBlue4, size: CGSizeMake(size.width / 5, size.height))
        buttonBuild.name = "ButtonBuild"
        buttonBuild.position = CGPoint(x: size.width * 1 / 10, y: size.height / 2)
        buttonBuild.zPosition = 1
        let buildImage = SKSpriteNode(imageNamed: "Button_build")
        buildImage.name = "ButtonBuildImage"
        
        buildImage.setScale(framescale * 0.7)
        buildImage.position = CGPoint(x: 2, y: -5)
        buildImage.zPosition = 100
        buttonBuild.addChild(buildImage)
        addChild(buttonBuild)
        
        buttonSell = SKSpriteNode(color: colorBlue4, size: CGSizeMake(size.width / 5, size.height))
        buttonSell.name = "ButtonSell"
        buttonSell.position = CGPoint(x: size.width * 3 / 10, y: size.height / 2)
        buttonSell.zPosition = 1
        let sellImage = SKSpriteNode(imageNamed: "Button_sell")
        sellImage.name = "ButtonSellImage"
        sellImage.setScale(framescale * 0.7)
        sellImage.position = CGPoint(x: 0, y: -3)
        sellImage.zPosition = 100
        buttonSell.addChild(sellImage)
        addChild(buttonSell)
        
        buttonEnergy = SKSpriteNode(color: colorBlue4, size: CGSizeMake(size.width / 5, size.height))
        buttonEnergy.name = "ButtonEnergy"
        buttonEnergy.position = CGPoint(x: size.width * 5 / 10, y: size.height / 2)
        buttonEnergy.zPosition = 1
        let energyImage = SKSpriteNode(imageNamed: "Button_lightning")
        energyImage.name = "ButtonEnergyImage"
        energyImage.setScale(framescale * 0.4)
        energyImage.position = CGPoint(x: 1, y: -4)
        energyImage.zPosition = 100
        buttonEnergy.addChild(energyImage)
        addChild(buttonEnergy)
        
        buttonUpgrade = SKSpriteNode(color: colorBlue4, size: CGSizeMake(size.width / 5, size.height))
        buttonUpgrade.name = "ButtonUpgrade"
        buttonUpgrade.position = CGPoint(x: size.width * 7 / 10, y: size.height / 2)
        buttonUpgrade.zPosition = 1
        let upgradeImage = SKSpriteNode(imageNamed: "Button_upgrade")
        upgradeImage.name = "ButtonUpgradeImage"
        upgradeImage.setScale(framescale * 0.6)
        upgradeImage.position = CGPoint(x: 0, y: -3)
        upgradeImage.zPosition = 100
        buttonUpgrade.addChild(upgradeImage)
        addChild(buttonUpgrade)
        
        buttonResearch = SKSpriteNode(color: colorBlue4, size: CGSizeMake(size.width / 5, size.height))
        buttonResearch.name = "ButtonResearch"
        buttonResearch.position = CGPoint(x: size.width * 9 / 10, y: size.height / 2)
        buttonResearch.zPosition = 1
        let researchImage = SKSpriteNode(imageNamed: "Button_research")
        researchImage.name = "ButtonResearchImage"
        researchImage.setScale(framescale * 0.6)
        researchImage.position = CGPoint(x: 0, y: -3)
        researchImage.zPosition = 100
        buttonResearch.addChild(researchImage)
        addChild(buttonResearch)
        
        choiceCircle = SKShapeNode(circleOfRadius: framescale * 35)
        choiceCircle.fillColor = colorBlue2
        choiceCircle.strokeColor = colorBlue2
        choiceCircle.alpha = 1
        choiceCircle.position = CGPoint(x: buttonEnergy.position.x, y: buttonEnergy.position.y - 2)
        choiceCircle.zPosition = 10
        addChild(choiceCircle)
        
        tapButtonEnergy()
    }
    
    func drawEnergyCircle(percent: CGFloat) {
        if energyArc != nil {
            energyArc.removeFromParent()
        }
        let path = CGPathCreateMutable()
        CGPathAddArc(path, nil, buttonEnergy.position.x, buttonEnergy.position.y - 2, framescale * 25.0, CGFloat(M_PI_2), CGFloat(M_PI_2 - M_PI * 2 * Double(percent)), true)
        energyArc = SKShapeNode(path: path)
        energyArc.zPosition = 100
        energyArc.lineWidth = framescale * 5
        addChild(energyArc)
    }
    
    func tapButtonNil(duration: Double = 0.0) {
        choiceCircle.runAction(SKAction.fadeOutWithDuration(duration))
    }
    func tapButtonBuild(duration: Double = 0.0) {
        choiceCircle.setScale(1)
        choiceCircle.runAction(SKAction.fadeAlphaTo(1, duration: duration))
        choiceCircle.runAction(SKAction.moveTo(CGPoint(x: buttonBuild.position.x, y: buttonBuild.position.y - 2), duration: duration))
    }
    func tapButtonSell(duration: Double = 0.0) {
        choiceCircle.setScale(1)
        choiceCircle.runAction(SKAction.fadeAlphaTo(1, duration: duration))
        choiceCircle.runAction(SKAction.moveTo(CGPoint(x: buttonSell.position.x, y: buttonSell.position.y - 2), duration: duration))
    }
    func tapButtonEnergy(duration: Double = 0.0) {
        choiceCircle.setScale(1)
        choiceCircle.runAction(SKAction.fadeAlphaTo(1, duration: duration))
        choiceCircle.runAction(SKAction.moveTo(CGPoint(x: buttonEnergy.position.x, y: buttonEnergy.position.y - 2), duration: duration))
    }
    func tapButtonUpgrade() {
        let fadeIn = SKAction.fadeAlphaTo(1, duration: 0.1)
        let moveTo = SKAction.moveTo(CGPoint(x: buttonUpgrade.position.x, y: buttonUpgrade.position.y - 2), duration: 0.1)
        let group = SKAction.group([fadeIn, moveTo])
        let delay = SKAction.waitForDuration(0.1)
        let scale = SKAction.scaleTo(0.2, duration: 0.2)
        let moveDown = SKAction.moveToY(-40, duration: 0.2)
        choiceCircle.runAction(SKAction.sequence([group, delay, scale, delay, moveDown]))
    }
    func tapButtonResearch() {
        let fadeIn = SKAction.fadeAlphaTo(1, duration: 0.1)
        let moveTo = SKAction.moveTo(CGPoint(x: buttonResearch.position.x, y: buttonResearch.position.y - 2), duration: 0.1)
        let group = SKAction.group([fadeIn, moveTo])
        let delay = SKAction.waitForDuration(0.1)
        let scale = SKAction.scaleTo(0.2, duration: 0.2)
        let moveDown = SKAction.moveToY(-40, duration: 0.2)
        choiceCircle.runAction(SKAction.sequence([group, delay, scale, delay, moveDown]))
    }
}