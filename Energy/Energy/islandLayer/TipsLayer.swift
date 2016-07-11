//
//  TipsLayer.swift
//  Energy
//
//  Created by javan.chen on 2016/5/17.
//  Copyright © 2016年 Javan chen. All rights reserved.
//

import SpriteKit

class TipsLayer: SKNode {
    var OKButton: SKShapeNode!
    
    init(size: CGSize) {
        super.init()
        self.alpha = 0

        let gap = size.height / 25
        
        let tipsImage = SKSpriteNode(color: colorBlue2, size: size)
        tipsImage.size = size
        addChild(tipsImage)
        
        let tipsLabel = SKLabelNode(fontNamed: "SanFranciscoRounded-Black".localized)
        tipsLabel.name = "tipsLabel"
        tipsLabel.text = "Tips"
        tipsLabel.fontSize = 60 * framescale
        tipsLabel.verticalAlignmentMode = .Center
        tipsLabel.position = CGPoint(x: 0, y: gap * 11)
        addChild(tipsLabel)
        
        let imgSize = CGSizeMake(170 * framescale, 170 * framescale)
        
        let tipImg_1 = SKSpriteNode(imageNamed: "Tips1")
        tipImg_1.name = "tip_img_1"
        tipImg_1.size = imgSize
        tipImg_1.position = CGPoint(x: -4 * gap, y: 7 * gap)
        addChild(tipImg_1)
        
        let line1 = SKShapeNode(rectOfSize: CGSizeMake(size.width * 0.9, 1 * framescale))
        line1.name = "line1"
        line1.lineWidth = 0
        line1.fillColor = SKColor.whiteColor()
        line1.position = CGPoint(x: 0, y: 4.15 * gap)
        addChild(line1)
        
        let tipImg_2 = SKSpriteNode(imageNamed: "Tips2")
        tipImg_2.name = "tip_img_1"
        tipImg_2.size = imgSize
        tipImg_2.position = CGPoint(x: -4 * gap, y: 1.3 * gap)
        addChild(tipImg_2)
        
        let line2 = SKShapeNode(rectOfSize: CGSizeMake(size.width * 0.9, 1 * framescale))
        line2.name = "line1"
        line2.lineWidth = 0
        line2.fillColor = SKColor.whiteColor()
        line2.position = CGPoint(x: 0, y: -1.55 * gap)
        addChild(line2)
        
        let tipImg_3 = SKSpriteNode(imageNamed: "Tips3")
        tipImg_3.name = "tip_img_1"
        tipImg_3.size = imgSize
        tipImg_3.position = CGPoint(x: -4 * gap, y: -4.4 * gap)
        addChild(tipImg_3)
        
        OKButton = SKShapeNode(circleOfRadius: 40 * framescale)
        OKButton.name = "OKButton"
        OKButton.fillColor = SKColor.clearColor()
        OKButton.strokeColor = SKColor.whiteColor()
        OKButton.lineWidth = 3 * framescale
        OKButton.position = CGPoint(x: 0, y: -9 * gap)
        OKButton.zPosition = 1
        let checkImg = SKSpriteNode(texture: iconAtlas.textureNamed("check"))
        checkImg.size = CGSizeMake(40 * framescale, 40 * framescale)
        OKButton.addChild(checkImg)
        addChild(OKButton)
    }
    
    func showLayer(isShow: Bool) {
        self.removeAllActions()
        if isShow {
            self.runAction(SKAction.sequence([SKAction.unhide(), SKAction.fadeInWithDuration(0.5)]))
        } else {
            self.runAction(SKAction.sequence([SKAction.fadeOutWithDuration(0.5), SKAction.hide()]))
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}