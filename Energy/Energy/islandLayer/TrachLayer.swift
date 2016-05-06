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
    
    func configureAtPosition(position: CGPoint, size: CGSize) {
        
        self.position = position
        self.size     = size
        self.name     = "TeachLayer"
        
        background = SKSpriteNode(color: SKColor.greenColor(), size: size)
        background.name = "teachLayerBackground"
//        background.alpha = 0.7
        
        let circle = SKShapeNode(circleOfRadius: 100)
        circle.lineWidth = 29
        circle.strokeColor = SKColor.blueColor()
        circle.fillColor = SKColor.blackColor()
        circle.blendMode = SKBlendMode.Subtract
        background.addChild(circle)
        addChild(background)
//
//        let crop = SKCropNode()
//        crop.addChild(background)
//        crop.maskNode = SKSpriteNode(color: SKColor.greenColor(), size: CGSizeMake(200, 200))
//
//        addChild(crop)
        
        
        OKButton = SKShapeNode(rectOfSize: CGSizeMake(80 * framescale, 50 * framescale), cornerRadius: 10 * framescale)
        OKButton.name = "OKButton"
        OKButton.position = CGPoint(x: size.width / 2, y: size.height * 3 / 10)
        OKButton.lineWidth = 3 * framescale
        let OKLabel = SKLabelNode(fontNamed: "SanFranciscoRounded-Black")
        OKLabel.name = "OKLabel"
        OKLabel.text = "OK"
        OKLabel.fontSize = 30 * framescale
        OKLabel.verticalAlignmentMode = .Center
        OKButton.addChild(OKLabel)
//        addChild(OKButton)
    }
}
