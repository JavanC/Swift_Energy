//
//  BoostLayer.swift
//  Energy
//
//  Created by javan.chen on 2016/5/13.
//  Copyright © 2016年 Javan chen. All rights reserved.
//

import SpriteKit

class BoostLayer: SKNode {
    init(size: CGSize) {
        super.init()

        let boostBG = SKSpriteNode(color: SKColor.blackColor(), size: size)
        boostBG.name = "boostBG"
        boostBG.alpha = 0.7
        addChild(boostBG)
        
        let boostLabel = SKLabelNode(fontNamed: "SanFranciscoRounded-Black".localized)
        boostLabel.name = "boostLabel"
        boostLabel.text = "TIME RECOVER".localized
        boostLabel.fontColor = SKColor.whiteColor()
        boostLabel.fontSize = 44 * framescale
        boostLabel.verticalAlignmentMode = .Center
        addChild(boostLabel)
        
        let boostPSLabel = SKLabelNode(fontNamed: "SanFranciscoRounded-Black".localized)
        boostPSLabel.name = "boostPSLabel"
        boostPSLabel.text = "- Max recover one hour -".localized
        boostPSLabel.fontColor = SKColor.whiteColor()
        boostPSLabel.fontSize = 30 * framescale
        boostPSLabel.verticalAlignmentMode = .Center
        boostPSLabel.position = CGPoint(x: 0, y: -52 * framescale)
        addChild(boostPSLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}