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
    var labels: [SKLabelNode]!
    
    func configureAtPosition(position: CGPoint, size: CGSize) {
        
        self.position = position
        self.size     = size
        self.name     = "TeachLayer"
        
        background = SKSpriteNode(color: SKColor.blackColor(), size: size)
        background.name = "teachLayerBackground"
        background.alpha = 0.7
        addChild(background)
        
//        let Label = SKMultilineLabel(text: "Welcome to the first play! Click here to build buildings.", labelWidth: Int(size.width) - Int(80 * framescale), pos: CGPoint(x: 0, y: 0), fontName: "ArialMT", fontSize: 30 * framescale, fontColor: SKColor.whiteColor(), leading: Int(50 * framescale),  shouldShowBorder: false)
//        addChild(Label)
        
//        OKButton = SKShapeNode(rectOfSize: CGSizeMake(80 * framescale, 50 * framescale), cornerRadius: 10 * framescale)
//        OKButton.name = "OKButton"
//        OKButton.position = CGPoint(x: size.width / 2, y: size.height * 3 / 10)
//        OKButton.lineWidth = 3 * framescale
//        let OKLabel = SKLabelNode(fontNamed: "SanFranciscoRounded-Black")
//        OKLabel.name = "OKLabel"
//        OKLabel.text = "OK"
//        OKLabel.fontSize = 30 * framescale
//        OKLabel.verticalAlignmentMode = .Center
//        OKButton.addChild(OKLabel)
//        addChild(OKButton)
    }
}
