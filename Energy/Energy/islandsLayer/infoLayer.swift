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
        bg.alpha = 0.8
        addChild(bg)
        let word = SKLabelNode(fontNamed: "SanFranciscoText-BoldItalic")
        word.text = "Energy"
        word.fontSize = 80 * framescale
        word.verticalAlignmentMode = .Center
        word.position = CGPoint(x: 0, y: gap * 7)
        addChild(word)
        let developer = SKLabelNode(fontNamed: "SanFranciscoText-BoldItalic")
        developer.text = "Developer"
        developer.fontSize = 30 * framescale
        developer.verticalAlignmentMode = .Center
        developer.position = CGPoint(x: 0, y: gap * 3)
        addChild(developer)
        let name = SKLabelNode(fontNamed: "SanFranciscoText-LightItalic")
        name.text = "Javan Chen"
        name.fontSize = 25 * framescale
        name.verticalAlignmentMode = .Center
        name.position = CGPoint(x: 0, y: gap * 2)
        addChild(name)
        let line = SKShapeNode(rectOfSize: CGSizeMake(frameSize.width * 0.4, 0.5 * framescale))
        line.alpha = 0.7
        line.fillColor = SKColor.whiteColor()
        line.position = CGPoint(x: 0, y: gap * 1)
        addChild(line)
        let art = SKLabelNode(fontNamed: "SanFranciscoText-BoldItalic")
        art.text = "Art Design"
        art.fontSize = 30 * framescale
        art.verticalAlignmentMode = .Center
        art.position = CGPoint(x: 0, y: gap * 0)
        addChild(art)
        let name2 = SKLabelNode(fontNamed: "SanFranciscoText-LightItalic")
        name2.text = "Javan Chen"
        name2.fontSize = 25 * framescale
        name2.verticalAlignmentMode = .Center
        name2.position = CGPoint(x: 0, y: gap * -1)
        addChild(name2)
        let line2 = SKShapeNode(rectOfSize: CGSizeMake(frameSize.width * 0.4, 0.5 * framescale))
        line2.alpha = 0.7
        line2.fillColor = SKColor.whiteColor()
        line2.position = CGPoint(x: 0, y: gap * -2)
        addChild(line2)
        let music = SKLabelNode(fontNamed: "SanFranciscoText-BoldItalic")
        music.text = "Music Design"
        music.fontSize = 30 * framescale
        music.verticalAlignmentMode = .Center
        music.position = CGPoint(x: 0, y: gap * -3)
        addChild(music)
        let name3 = SKLabelNode(fontNamed: "SanFranciscoText-LightItalic")
        name3.text = "Music Atelier Amacha"
        name3.fontSize = 25 * framescale
        name3.verticalAlignmentMode = .Center
        name3.position = CGPoint(x: 0, y: gap * -4)
        addChild(name3)

        saveButton = SKSpriteNode(texture: iconAtlas.textureNamed("check"))
        saveButton.size = CGSizeMake(80 * framescale, 80 * framescale)
        saveButton.position = CGPoint(x: 0, y: gap * -8)
        addChild(saveButton)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}