//
//  TrachLayer.swift
//  Energy
//
//  Created by javan.chen on 2016/5/5.
//  Copyright © 2016年 Javan chen. All rights reserved.
//

import SpriteKit

class TeachLayer: SKSpriteNode {
    
    var background: SKSpriteNode!
    var OKButton: SKShapeNode!
    var backgroundMask: SKShapeNode!
    var labels = [SKLabelNode]()
    
    func configureAtPosition(position: CGPoint, size: CGSize) {
        
        self.position = position
        self.size     = size
        self.name     = "TeachLayer"
        
        background = SKSpriteNode(imageNamed: "Teach1-EN")
        background.name = "teachImages"
        background.size = size
        addChild(background)

        OKButton = SKShapeNode(circleOfRadius: 40 * framescale)
        OKButton.strokeColor = SKColor.whiteColor()
        OKButton.lineWidth = 3 * framescale
        OKButton.position = CGPoint(x: 0, y: -size.height / 5)
        OKButton.zPosition = 1
        let image = SKSpriteNode(texture: iconAtlas.textureNamed("check"))
        image.size = CGSizeMake(30 * framescale, 30 * framescale)
        OKButton.addChild(image)
        background.addChild(OKButton)
        
    }
    
    func changeTeachStep(step: Int) {
        
        if step >= 1 && step <= 13 {
            print("Teach\(step)-EN")
            background.texture = SKTexture(imageNamed: "Teach\(step)-EN".localized)
        } else {
            print("else step")
            self.hidden = true
        }
    }
}
