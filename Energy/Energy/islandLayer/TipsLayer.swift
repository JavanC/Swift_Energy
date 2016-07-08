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
        
        let tipsImage = SKSpriteNode(imageNamed: "Tips")
        tipsImage.size = size
        addChild(tipsImage)
        
        
        OKButton = SKShapeNode(circleOfRadius: 40 * framescale)
        OKButton.name = "OKButton"
        OKButton.fillColor = SKColor.clearColor()
        OKButton.strokeColor = SKColor.whiteColor()
        OKButton.lineWidth = 3 * framescale
        OKButton.position = CGPoint(x: 0, y: -size.height / 3)
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