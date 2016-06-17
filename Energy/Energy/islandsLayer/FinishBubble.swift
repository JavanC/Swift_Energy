//
//  FinishBubble.swift
//  Energy
//
//  Created by javan.chen on 2016/6/16.
//  Copyright © 2016年 Javan chen. All rights reserved.
//

import SpriteKit

class FinishBubble: SKNode {
    var bubbleName: SKLabelNode!
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
        
        bubbleName = SKLabelNode(fontNamed: "SanFranciscoRounded-Black")
        bubbleName.name = "bubbleName"
        bubbleName.text = "Congratulation!"
        bubbleName.fontSize = gap * 1.6
        bubbleName.verticalAlignmentMode = .Center
        bubbleName.position = CGPoint(x: 0, y: gap * 8.2)
        addChild(bubbleName)
        
        let line1 = SKShapeNode(rectOfSize: CGSizeMake(bubbleSize.width - 40, 0.5 * framescale))
        line1.name = "line1"
        line1.alpha = 0.5
        line1.fillColor = SKColor.whiteColor()
        line1.position = CGPoint(x: 0, y: gap * 6.8)
        addChild(line1)
        
        let machinImg = SKSpriteNode(texture: iconAtlas.textureNamed("coint"))
        machinImg.name = "machinImg"
        machinImg.setScale(1.6 * framescale)
        machinImg.position = CGPoint(x: 0, y: gap * 4.3)
        addChild(machinImg)
        
        let infoLabel1 = SKLabelNode(fontNamed: "SanFranciscoRounded-Black")
        infoLabel1.name = "buyLabel"
        infoLabel1.text = "You get a perpetual motion machine,".localized
        infoLabel1.fontSize = gap * 0.8 * framescale
        infoLabel1.verticalAlignmentMode = .Center
        infoLabel1.position = CGPoint(x: 0, y: gap * 1.6)
        addChild(infoLabel1)
        
        let infoLabel2 = SKLabelNode(fontNamed: "SanFranciscoRounded-Black")
        infoLabel2.name = "buyLabel"
        infoLabel2.text = "it has unlimited energy.".localized
        infoLabel2.fontSize = gap * 0.8 * framescale
        infoLabel2.verticalAlignmentMode = .Center
        infoLabel2.position = CGPoint(x: 0, y: gap * 0.2)
        addChild(infoLabel2)
        
        let label1 = SKLabelNode(fontNamed: "SanFranciscoRounded-Black")
        label1.name = "buildingNumber"
        label1.text = "Building".localized
        label1.fontSize = gap * 0.8 * framescale
        label1.verticalAlignmentMode = .Center
        label1.horizontalAlignmentMode = .Left
        label1.position = CGPoint(x: -bubbleSize.width / 2 + 20 * framescale, y: gap * -1.8)
        addChild(label1)
        
        let label2 = SKLabelNode(fontNamed: "SanFranciscoRounded-Black")
        label2.name = "buildingNumber"
        label2.text = "Explosion".localized
        label2.fontSize = gap * 0.8 * framescale
        label2.verticalAlignmentMode = .Center
        label2.horizontalAlignmentMode = .Left
        label2.position = CGPoint(x: -bubbleSize.width / 2 + 20 * framescale, y: gap * -3.5)
        addChild(label2)
        
        let label3 = SKLabelNode(fontNamed: "SanFranciscoRounded-Black")
        label3.name = "buildingNumber"
        label3.text = "Spend Time".localized
        label3.fontSize = gap * 0.8 * framescale
        label3.verticalAlignmentMode = .Center
        label3.horizontalAlignmentMode = .Left
        label3.position = CGPoint(x: -bubbleSize.width / 2 + 20 * framescale, y: gap * -5.2)
        addChild(label3)
        
        let bg1 = SKShapeNode(rectOfSize: CGSizeMake(bubbleSize.width - 60 * framescale - label1.frame.width, gap * 0.9 * framescale), cornerRadius: 6 * framescale)
        bg1.fillColor = SKColor.blackColor()
        bg1.lineWidth = 0
        bg1.alpha = 0.3
        bg1.position = CGPoint(x: bubbleSize.width / 2 - bg1.frame.width / 2 - 20 * framescale, y: gap * -1.8)
        addChild(bg1)
        
        let bg2 = SKShapeNode(rectOfSize: CGSizeMake(bubbleSize.width - 60 * framescale - label2.frame.width, gap * 0.9 * framescale), cornerRadius: 6 * framescale)
        bg2.fillColor = SKColor.blackColor()
        bg2.lineWidth = 0
        bg2.alpha = 0.3
        bg2.position = CGPoint(x: bubbleSize.width / 2 - bg2.frame.width / 2 - 20 * framescale, y: gap * -3.5)
        addChild(bg2)
        
        let bg3 = SKShapeNode(rectOfSize: CGSizeMake(bubbleSize.width - 60 * framescale - label3.frame.width, gap * 0.9 * framescale), cornerRadius: 6 * framescale)
        bg3.fillColor = SKColor.blackColor()
        bg3.lineWidth = 0
        bg3.alpha = 0.3
        bg3.position = CGPoint(x: bubbleSize.width / 2 - bg3.frame.width / 2 - 20 * framescale, y: gap * -5.2)
        addChild(bg3)
        
        OKButton = SKShapeNode(rectOfSize: CGSizeMake(bubbleSize.width - 40 * framescale, gap * 4 - 40 * framescale), cornerRadius: 5 * framescale)
        OKButton.name = "OKButton"
        OKButton.fillColor = colorBlue2
        OKButton.lineWidth = 0
        OKButton.position = CGPoint(x: 0, y: gap * -8)
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
