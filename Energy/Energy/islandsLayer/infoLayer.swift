//
//  infoLayer.swift
//  Energy
//
//  Created by javan.chen on 2016/2/16.
//  Copyright © 2016年 Javan chen. All rights reserved.
//


import SpriteKit

class InfoLayer: SKNode {
//    var soundButton: SwitchButton!
//    var musicButton: SwitchButton!
//    var resetButton: SKLabelNode!
    var saveButton: SKSpriteNode!
    
    init(frameSize: CGSize) {
        super.init()
        
        let gap = frameSize.height / 25
        
        let bg = SKSpriteNode(color: SKColor.blackColor(), size: frameSize)
        bg.name = "background"
        bg.alpha = 0.8
        addChild(bg)
        
        let energyLabel = SKLabelNode(fontNamed: "SanFranciscoText-BoldItalic")
        energyLabel.name = "energyLabel"
        energyLabel.text = "Energy"
        energyLabel.fontSize = 80 * framescale
        energyLabel.verticalAlignmentMode = .Center
        energyLabel.position = CGPoint(x: 0, y: gap * 7)
        addChild(energyLabel)
        
        let developerLabel = SKLabelNode(fontNamed: "SanFranciscoText-BoldItalic")
        developerLabel.name = "developerLabel"
        developerLabel.text = "Developer"
        developerLabel.fontSize = 30 * framescale
        developerLabel.verticalAlignmentMode = .Center
        developerLabel.position = CGPoint(x: 0, y: gap * 3)
        addChild(developerLabel)
        
        let developerNameLabel = SKLabelNode(fontNamed: "SanFranciscoText-LightItalic")
        developerNameLabel.name = "developerNameLabel"
        developerNameLabel.text = "Javan Chen"
        developerNameLabel.fontSize = 25 * framescale
        developerNameLabel.verticalAlignmentMode = .Center
        developerNameLabel.position = CGPoint(x: 0, y: gap * 2)
        addChild(developerNameLabel)
        
        let line1 = SKShapeNode(rectOfSize: CGSizeMake(frameSize.width * 0.4, 0.5 * framescale))
        line1.name = "line1"
        line1.alpha = 0.5
        line1.fillColor = SKColor.whiteColor()
        line1.position = CGPoint(x: 0, y: gap * 1)
        addChild(line1)
        
        let artDesignLabel = SKLabelNode(fontNamed: "SanFranciscoText-BoldItalic")
        artDesignLabel.name = "artDesignLabel"
        artDesignLabel.text = "Art Design"
        artDesignLabel.fontSize = 30 * framescale
        artDesignLabel.verticalAlignmentMode = .Center
        artDesignLabel.position = CGPoint(x: 0, y: gap * 0)
        addChild(artDesignLabel)
        
        let artDesignNameLabel = SKLabelNode(fontNamed: "SanFranciscoText-LightItalic")
        artDesignNameLabel.name = "artDesignNameLabel"
        artDesignNameLabel.text = "Javan Chen"
        artDesignNameLabel.fontSize = 25 * framescale
        artDesignNameLabel.verticalAlignmentMode = .Center
        artDesignNameLabel.position = CGPoint(x: 0, y: gap * -1)
        addChild(artDesignNameLabel)
        
        let line2 = SKShapeNode(rectOfSize: CGSizeMake(frameSize.width * 0.4, 0.5 * framescale))
        line2.name = "line2"
        line2.alpha = 0.5
        line2.fillColor = SKColor.whiteColor()
        line2.position = CGPoint(x: 0, y: gap * -2)
        addChild(line2)
        
        let musicDesignLabel = SKLabelNode(fontNamed: "SanFranciscoText-BoldItalic")
        musicDesignLabel.name = "musicDesignLabel"
        musicDesignLabel.text = "Music Design"
        musicDesignLabel.fontSize = 30 * framescale
        musicDesignLabel.verticalAlignmentMode = .Center
        musicDesignLabel.position = CGPoint(x: 0, y: gap * -3)
        addChild(musicDesignLabel)
        
        let musicDesignNameLabel = SKLabelNode(fontNamed: "SanFranciscoText-LightItalic")
        musicDesignNameLabel.name = "musicDesignNameLabel"
        musicDesignNameLabel.text = "Music Atelier Amacha"
        musicDesignNameLabel.fontSize = 25 * framescale
        musicDesignNameLabel.verticalAlignmentMode = .Center
        musicDesignNameLabel.position = CGPoint(x: 0, y: gap * -4)
        addChild(musicDesignNameLabel)

        saveButton = SKSpriteNode(texture: iconAtlas.textureNamed("check"))
        saveButton.name = "saveButton"
        saveButton.size = CGSizeMake(80 * framescale, 80 * framescale)
        saveButton.position = CGPoint(x: 0, y: gap * -8)
        addChild(saveButton)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}