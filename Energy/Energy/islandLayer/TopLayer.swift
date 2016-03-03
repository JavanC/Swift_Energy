//
//  TopLayer.swift
//  Energy
//
//  Created by javan.chen on 2015/12/18.
//  Copyright © 2015年 Javan chen. All rights reserved.
//

import SpriteKit

class TopLayer: SKSpriteNode {
    
    var buttonMenu: SKSpriteNode!
    var buttonPlayPause: SKSpriteNode!
    var moneyLabel: SKLabelNode!
    var researchLabel: SKLabelNode!
    var boostLabel: SKLabelNode!

    func configureAtPosition(position: CGPoint, size: CGSize) {

        self.position                         = position
        self.size                             = size
        self.color                            = colorBlue4
        self.name                             = "TopLayer"
        self.anchorPoint                      = CGPoint(x: 0, y: 0)

        let gap                               = (size.height - tilesScaleSize.height) / 2
        
        buttonMenu = SKSpriteNode(color: colorBlue3, size: CGSizeMake(size.height, size.height))
        buttonMenu.name = "buttonMenu"
        buttonMenu.position = CGPoint(x: size.height / 2, y: size.height / 2)
        buttonMenu.zPosition = 500
        let backImage                            = SKSpriteNode(texture: iconAtlas.textureNamed("map"))
        backImage.name                       = "backImage"
        backImage.setScale(framescale)
        buttonMenu.addChild(backImage)
        addChild(buttonMenu)

        buttonPlayPause                       = SKSpriteNode(texture: iconAtlas.textureNamed(isPause ? "button_pause" : "button_play"))
        buttonPlayPause.name                  = "buttonPlayPause"
        buttonPlayPause.setScale(0.6 * framescale)
        buttonPlayPause.anchorPoint           = CGPoint(x: 1, y: 0.5)
        buttonPlayPause.position              = CGPoint(x: size.width - gap, y: size.height / 2)
        addChild(buttonPlayPause)

        let labelsize                         = (self.size.height) * 2 / 7
        let mingap = size.height / 7
        
        let line1 = SKShapeNode(rectOfSize: CGSizeMake(220 * framescale, 5 * framescale), cornerRadius: 5 * framescale)
        line1.fillColor = SKColor.grayColor()
        line1.alpha = 0.5
        line1.lineWidth = 0
        line1.position = CGPoint(x: size.height + mingap + 110 * framescale, y: size.height * 5 / 7 - 10 * framescale)
        addChild(line1)
        let moneyImg = SKSpriteNode(texture: iconAtlas.textureNamed("coint"))
        moneyImg.name = "Money Image"
        moneyImg.size = CGSizeMake(size.height / 3, size.height / 3)
        moneyImg.anchorPoint = CGPoint(x: 0, y: 0.5)
        moneyImg.position = CGPoint(x: size.height + mingap, y: size.height * 5 / 7)
        addChild(moneyImg)
        moneyLabel                            = SKLabelNode(fontNamed: "SanFranciscoRounded-Black")
        moneyLabel.name                       = "MoneyLabel"
        moneyLabel.text = "888T + 888.8T"
        moneyLabel.fontColor                  = colorMoney
        moneyLabel.fontSize                   = labelsize
        moneyLabel.horizontalAlignmentMode    = .Left
        moneyLabel.verticalAlignmentMode      = .Center
        moneyLabel.position                   = CGPoint(x: size.height * 4 / 3 + mingap * 1.5, y: size.height * 5 / 7)
        addChild(moneyLabel)
        
        let line2 = SKShapeNode(rectOfSize: CGSizeMake(220 * framescale, 5 * framescale), cornerRadius: 5 * framescale)
        line2.fillColor = SKColor.grayColor()
        line2.alpha = 0.5
        line2.lineWidth = 0
        line2.position = CGPoint(x: size.height + mingap + 110 * framescale, y: size.height * 2 / 7 - 10 * framescale)
        addChild(line2)
        let researchImg = SKSpriteNode(texture: iconAtlas.textureNamed("research"))
        researchImg.name = "research Image"
        researchImg.size = CGSizeMake(size.height / 3, size.height / 3)
        researchImg.anchorPoint = CGPoint(x: 0, y: 0.5)
        researchImg.position = CGPoint(x: size.height + mingap, y: size.height * 2 / 7)
        addChild(researchImg)
        researchLabel                         = SKLabelNode(fontNamed: "SanFranciscoRounded-Black")
        researchLabel.name                    = "ResearchLabel"
        researchLabel.text = "888T + 888.8T"
        researchLabel.fontColor               = colorResearch
        researchLabel.fontSize                = labelsize
        researchLabel.horizontalAlignmentMode = .Left
        researchLabel.verticalAlignmentMode   = .Center
        researchLabel.position                = CGPoint(x: size.height * 4 / 3 + mingap * 1.5, y: size.height * 2 / 7)
        addChild(researchLabel)
    }
    
    func isPauseChange() {
        buttonPlayPause.runAction(SKAction.setTexture(iconAtlas.textureNamed(isPause ? "button_pause" : "button_play")))
    }
}
