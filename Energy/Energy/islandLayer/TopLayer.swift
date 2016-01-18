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

    func configureAtPosition(position: CGPoint, size: CGSize) {
        
        self.position = position
        self.size = size
        self.color = colorBlue4
        self.name = "TopLayer"
        self.anchorPoint = CGPoint(x: 0, y: 0)
        
        buttonMenu = SKSpriteNode(color: SKColor.whiteColor(), size: CGSize(width: size.height, height: size.height))
        buttonMenu.name = "ButtonMenu"
        buttonMenu.anchorPoint = CGPoint(x: 0, y: 0)
        buttonMenu.position = CGPoint(x: 0, y: 0)
        addChild(buttonMenu)
        
        let gap = (size.height - tilesScaleSize.height) / 2
        buttonPlayPause = SKSpriteNode(texture: iconAtlas.textureNamed(isPause ? "pause" : "play"))
        buttonPlayPause.name = "buttonPlayPause"
        buttonPlayPause.setScale(0.8 * framescale)
        buttonPlayPause.anchorPoint = CGPoint(x: 1, y: 0.5)
        buttonPlayPause.position = CGPoint(x: size.width - gap, y: size.height / 2)
        addChild(buttonPlayPause)
        
        let labelgap: CGFloat = size.height * 0.16
        let labelsize = (self.size.height - labelgap * 3) / 2
        moneyLabel = SKLabelNode(fontNamed: "SanFranciscoText-BoldItalic")
        moneyLabel.name = "MoneyLabel"
        moneyLabel.fontColor = colorMoney
        moneyLabel.fontSize = labelsize
        moneyLabel.horizontalAlignmentMode = .Left
        moneyLabel.position = CGPoint(x: buttonMenu.size.width + 20, y: labelgap * 2 + labelsize * 1)
        addChild(moneyLabel)

        researchLabel = SKLabelNode(fontNamed: "SanFranciscoText-BoldItalic")
        researchLabel.name = "ResearchLabel"
        researchLabel.fontColor = colorResearch
        researchLabel.fontSize = labelsize
        researchLabel.horizontalAlignmentMode = .Left
        researchLabel.position = CGPoint(x: buttonMenu.size.width + 20, y: labelgap * 1 + labelsize * 0)
        addChild(researchLabel)
    }
    
    func isPauseChange() {
        buttonPlayPause.runAction(SKAction.setTexture(iconAtlas.textureNamed(isPause ? "pause" : "play")))
    }
}
