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
    var buttonTips: SKSpriteNode!
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
        
        let buttonWidth = size.width / 6
        let buttonHeight = size.height
        
        buttonMenu = SKSpriteNode(color: colorBlue3, size: CGSizeMake(buttonWidth, buttonHeight))
        buttonMenu.name = "buttonMenu"
        buttonMenu.position = CGPoint(x: buttonWidth / 2, y: buttonHeight / 2)
        buttonMenu.zPosition = 400
        let backImage                         = SKSpriteNode(texture: iconAtlas.textureNamed("map"))
        backImage.name                        = "backImage"
        backImage.setScale(framescale)
        buttonMenu.addChild(backImage)
        addChild(buttonMenu)
        
        buttonTips = SKSpriteNode(color: colorBlue3, size: CGSizeMake(buttonWidth, buttonHeight))
        buttonTips.name = "buttonTips"
        buttonTips.position = CGPoint(x: size.width - buttonWidth * 3 / 2 - 2 * framescale, y: buttonHeight / 2)
        let tipsImage = SKSpriteNode(texture: iconAtlas.textureNamed("tips"))
        tipsImage.name = "tipsImage"
        tipsImage.setScale(framescale * 0.9)
        buttonTips.addChild(tipsImage)
        addChild(buttonTips)

        buttonPlayPause = SKSpriteNode(color: isPause ? colorCancel : colorBlue3, size: CGSizeMake(buttonWidth, buttonHeight))
        buttonPlayPause.name                  = "buttonPlayPause"
        buttonPlayPause.position              = CGPoint(x: size.width - buttonWidth / 2, y: buttonHeight / 2)
        let clockImage = SKSpriteNode(texture: iconAtlas.textureNamed("clock"))
        clockImage.name = "clockImage"
        clockImage.setScale(framescale)
        buttonPlayPause.addChild(clockImage)
        let pointerImage = SKSpriteNode(texture: iconAtlas.textureNamed("clock-pointer"))
        pointerImage.name = "pointerImage"
        pointerImage.setScale(framescale)
        buttonPlayPause.addChild(pointerImage)
        let action = SKAction.sequence([SKAction.rotateByAngle(CGFloat(-M_PI / 4), duration: 0.1), SKAction.waitForDuration(0.9)])
        pointerImage.runAction(SKAction.repeatActionForever(action))
        addChild(buttonPlayPause)
        isPauseChange()

        let labelsize                         = (self.size.height) * 2 / 7
        let mingap                            = size.height / 7
        
        let line1 = SKShapeNode(rectOfSize: CGSizeMake(size.width - buttonWidth * 3 - 30 * framescale, 5 * framescale), cornerRadius: 5 * framescale)
        line1.fillColor = SKColor.grayColor()
        line1.alpha = 0.5
        line1.lineWidth = 0
        line1.position = CGPoint(x: buttonWidth + size.width / 4, y: size.height * 5 / 7 - 10 * framescale)
        addChild(line1)
        let moneyImg = SKSpriteNode(texture: iconAtlas.textureNamed("coint"))
        moneyImg.name = "Money Image"
        moneyImg.size = CGSizeMake(size.height / 3, size.height / 3)
        moneyImg.anchorPoint = CGPoint(x: 0, y: 0.5)
        moneyImg.position = CGPoint(x: buttonWidth + mingap, y: size.height * 5 / 7)
        addChild(moneyImg)
        moneyLabel                            = SKLabelNode(fontNamed: "SanFranciscoRounded-Black")
        moneyLabel.name                       = "MoneyLabel"
        moneyLabel.text = "888T + 888.8T"
        moneyLabel.fontColor                  = colorMoney
        moneyLabel.fontSize                   = labelsize
        moneyLabel.horizontalAlignmentMode    = .Left
        moneyLabel.verticalAlignmentMode      = .Center
        moneyLabel.position                   = CGPoint(x: buttonWidth * 4 / 3 + mingap * 1.5, y: size.height * 5 / 7)
        addChild(moneyLabel)
        
        let line2 = SKShapeNode(rectOfSize: CGSizeMake(size.width - buttonWidth * 3 - 30 * framescale, 5 * framescale), cornerRadius: 5 * framescale)
        line2.fillColor = SKColor.grayColor()
        line2.alpha = 0.5
        line2.lineWidth = 0
        line2.position = CGPoint(x: buttonWidth + size.width / 4, y: size.height * 2 / 7 - 10 * framescale)
        addChild(line2)
        let researchImg = SKSpriteNode(texture: iconAtlas.textureNamed("research"))
        researchImg.name = "research Image"
        researchImg.size = CGSizeMake(size.height / 3, size.height / 3)
        researchImg.anchorPoint = CGPoint(x: 0, y: 0.5)
        researchImg.position = CGPoint(x: buttonWidth + mingap, y: size.height * 2 / 7)
        addChild(researchImg)
        researchLabel                         = SKLabelNode(fontNamed: "SanFranciscoRounded-Black")
        researchLabel.name                    = "ResearchLabel"
        researchLabel.text = "888T + 888.8T"
        researchLabel.fontColor               = colorResearch
        researchLabel.fontSize                = labelsize
        researchLabel.horizontalAlignmentMode = .Left
        researchLabel.verticalAlignmentMode   = .Center
        researchLabel.position                = CGPoint(x: buttonWidth * 4 / 3 + mingap * 1.5, y: size.height * 2 / 7)
        addChild(researchLabel)
        
        let lineShadow = SKSpriteNode(color: SKColor.grayColor(), size: CGSizeMake(size.width, 5 * framescale))
        lineShadow.alpha = 0.7
        lineShadow.anchorPoint = CGPoint(x: 0, y: 1)
        lineShadow.position = CGPoint(x: 0, y: 0)
        lineShadow.zPosition = -60
        addChild(lineShadow)
    }
    
    func isPauseChange() {
//        buttonPlayPause.color = isPause ? colorCancel : colorBlue3
        buttonPlayPause.color = isPause ? colorBlue3 : colorBlue3
        buttonPlayPause.childNodeWithName("pointerImage")!.speed = isPause ? 0 : 1
    }
}
