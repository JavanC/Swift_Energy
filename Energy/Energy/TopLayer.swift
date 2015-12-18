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
    var buttonRebuild: SKSpriteNode!
    var moneyLabel: SKLabelNode!
    var reserchLabel: SKLabelNode!

    func configureAtPosition(position: CGPoint, size: CGSize) {
        
        self.position = position
        self.size = size
        self.color = SKColor.grayColor()
        self.name = "TopLayer"
        self.anchorPoint = CGPoint(x: 0, y: 0)
        
        buttonMenu = SKSpriteNode(color: SKColor.whiteColor(), size: CGSize(width: size.height, height: size.height))
        buttonMenu.name = "ButtonMenu"
        buttonMenu.anchorPoint = CGPoint(x: 0, y: 0)
        buttonMenu.position = CGPoint(x: 0, y: 0)
        addChild(buttonMenu)
        
        buttonRebuild = SKSpriteNode(color: SKColor.whiteColor(), size: CGSize(width: 64, height: 64))
        buttonRebuild.name = "ButtonRebuild"
        buttonRebuild.anchorPoint = CGPoint(x: 1, y: 1)
        buttonRebuild.position = CGPoint(x: self.size.width, y: self.size.height)
        addChild(buttonRebuild)
        
        let labelgap: CGFloat = 18
        let labelsize = (self.size.height - labelgap * 3) / 2
        moneyLabel = SKLabelNode(fontNamed: "Verdana-Bold")
        moneyLabel.name = "MoneyLabel"
        moneyLabel.fontColor = SKColor.yellowColor()
        moneyLabel.fontSize = labelsize
        moneyLabel.horizontalAlignmentMode = .Left
        moneyLabel.position = CGPoint(x: buttonMenu.size.width + 20, y: labelgap * 2 + labelsize * 1)
        addChild(moneyLabel)

        reserchLabel = SKLabelNode(fontNamed: "Verdana-Bold")
        reserchLabel.name = "ReserchLabel"
        reserchLabel.fontColor = colorReserch
        reserchLabel.fontSize = labelsize
        reserchLabel.horizontalAlignmentMode = .Left
        reserchLabel.position = CGPoint(x: buttonMenu.size.width + 20, y: labelgap * 1 + labelsize * 0)
        addChild(reserchLabel)
    }
}
