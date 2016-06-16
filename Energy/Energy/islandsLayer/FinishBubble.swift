//
//  FinishBubble.swift
//  Energy
//
//  Created by javan.chen on 2016/6/16.
//  Copyright © 2016年 Javan chen. All rights reserved.
//

import SpriteKit

class FinishBubble: SKNode {
    var islandName: SKLabelNode!
    var buyInfoLabel: SKLabelNode!
    var OKButton: SKShapeNode!
    
    init(bubbleSize: CGSize) {
        super.init()
        
        let gap = bubbleSize.height / 20
        
        let bg = SKShapeNode(rectOfSize: bubbleSize, cornerRadius: 15 * framescale)
        bg.name = "background"
        bg.fillColor = colorBlue4
        bg.strokeColor = colorBlue2
        bg.lineWidth = 5 * framescale
        bg.alpha = 0.7
        addChild(bg)
        
        islandName = SKLabelNode(fontNamed: "SanFranciscoRounded-Black")
        islandName.name = "islaneName"
        islandName.text = "Congratulation!"
        islandName.fontSize = gap * 1.6
        islandName.verticalAlignmentMode = .Center
        islandName.position = CGPoint(x: 0, y: gap * 8.2)
        addChild(islandName)
        
        let line1 = SKShapeNode(rectOfSize: CGSizeMake(bubbleSize.width - 40, 0.5 * framescale))
        line1.name = "line1"
        line1.alpha = 0.5
        line1.fillColor = SKColor.whiteColor()
        line1.position = CGPoint(x: 0, y: gap * 6.8)
        addChild(line1)
        
        buyInfoLabel = SKLabelNode(fontNamed: "SanFranciscoRounded-Black")
        buyInfoLabel.name = "buyLabel"
        buyInfoLabel.text = "You don't have enough money.".localized
        buyInfoLabel.fontSize = 25 * framescale
        buyInfoLabel.verticalAlignmentMode = .Center
        buyInfoLabel.position = CGPoint(x: 0, y: gap * -0.6)
        addChild(buyInfoLabel)
        
        OKButton = SKShapeNode(rectOfSize: CGSizeMake(bubbleSize.width - 40 * framescale, gap * 4 - 40 * framescale), cornerRadius: 5 * framescale)
        OKButton.name = "OKButton"
        OKButton.fillColor = colorBlue2
        OKButton.lineWidth = 0
        OKButton.position = CGPoint(x: 0, y: gap * -3)
        let OKLabel = SKLabelNode(fontNamed: "SanFranciscoRounded-Black")
        OKLabel.name = "OKLabel"
        OKLabel.text = "OK".localized
        OKLabel.fontSize = 40 * framescale
        OKLabel.verticalAlignmentMode = .Center
        OKButton.addChild(OKLabel)
        addChild(OKButton)
    }
    
    func showBubble() {
        self.runAction(SKAction.sequence([SKAction.unhide(), SKAction.fadeInWithDuration(0.3)]))
    }
    func hideBubble(duration duration: Double = 0.3) {
        OKButton.alpha     = 1
        self.runAction(SKAction.sequence([SKAction.fadeOutWithDuration(duration), SKAction.hide()]))
    }
    func update() {
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
