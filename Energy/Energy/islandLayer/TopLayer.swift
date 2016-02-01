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
        buttonMenu                            = SKSpriteNode(texture: iconAtlas.textureNamed("map"))
        buttonMenu.name                       = "buttonMap"
        buttonMenu.setScale(0.8 * framescale)
        buttonMenu.anchorPoint                = CGPoint(x: 0, y: 0.5)
        buttonMenu.position                   = CGPoint(x: gap, y: size.height / 2)
        buttonMenu.zPosition                  = 500
        addChild(buttonMenu)

        buttonPlayPause                       = SKSpriteNode(texture: iconAtlas.textureNamed(isPause ? "button_pause" : "button_play"))
        buttonPlayPause.name                  = "buttonPlayPause"
        buttonPlayPause.setScale(0.6 * framescale)
        buttonPlayPause.anchorPoint           = CGPoint(x: 1, y: 0.5)
        buttonPlayPause.position              = CGPoint(x: size.width - gap, y: size.height / 2)
        addChild(buttonPlayPause)

        let labelsize                         = (self.size.height) * 2 / 7
        moneyLabel                            = SKLabelNode(fontNamed: "SanFranciscoText-BoldItalic")
        moneyLabel.name                       = "MoneyLabel"
        moneyLabel.fontColor                  = colorMoney
        moneyLabel.fontSize                   = labelsize
        moneyLabel.horizontalAlignmentMode    = .Left
        moneyLabel.verticalAlignmentMode      = .Center
        moneyLabel.position                   = CGPoint(x: tilesScaleSize.width + gap * 2, y: size.height * 5 / 7)
        addChild(moneyLabel)

        researchLabel                         = SKLabelNode(fontNamed: "SanFranciscoText-BoldItalic")
        researchLabel.name                    = "ResearchLabel"
        researchLabel.fontColor               = colorResearch
        researchLabel.fontSize                = labelsize
        researchLabel.horizontalAlignmentMode = .Left
        researchLabel.verticalAlignmentMode   = .Center
        researchLabel.position                = CGPoint(x: tilesScaleSize.width + gap * 2, y: size.height * 2 / 7)
        addChild(researchLabel)
    
    }
    
    func isPauseChange() {
        buttonPlayPause.runAction(SKAction.setTexture(iconAtlas.textureNamed(isPause ? "button_pause" : "button_play")))
    }
}
