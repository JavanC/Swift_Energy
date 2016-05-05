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
        
        background = SKSpriteNode(color: SKColor.blackColor(), size: size)
        background.name = "teachLayerBackground"
        background.alpha = 0.7
        
//        addChild(background)
        
        let masknode = SKSpriteNode(color: SKColor.blackColor(), size: size)
        let circle = SKShapeNode(circleOfRadius: 100)
        masknode.addChild(circle)
//
        let cropNode = SKCropNode()
        cropNode.maskNode = SKSpriteNode(texture: masknode.texture)
        cropNode.alpha = 0.7
        cropNode.addChild(background)
        addChild(cropNode)
        
//        let path = CGPathCreateMutable()
//        CGPathAddArc(path, nil, 0, 0, framescale * 200, CGFloat(M_PI_2), CGFloat(M_PI_2 - M_PI * 2 * Double(percent)), true)
//        backgroundMask = SKShapeNode(path: path)
//        backgroundMask.lineWidth = framescale * 10
//        boostLayer.addChild(boostArc)
        
//        let cropNode = SKCropNode()
//        cropNode.position = CGPoint(x: siize.width / 2, y: size.height / 2)
//        cropNode.maskNode = SKSpriteNode(color: SKColor.redColor(), size: CGSizeMake(100, 100))
        
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
