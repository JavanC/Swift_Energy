//
//  SettingLayer.swift
//  Energy
//
//  Created by javan.chen on 2016/2/5.
//  Copyright © 2016年 Javan chen. All rights reserved.
//

import SpriteKit

class SwitchButton: SKNode {
    var image: SKSpriteNode!
    var shape: SKShapeNode!
    
    init(texture: SKTexture) {
        super.init()
        shape = SKShapeNode(ellipseOfSize: CGSizeMake(80 * framescale,80 * framescale))
        shape.fillColor = colorEnergy
        shape.strokeColor = SKColor.whiteColor()
        shape.lineWidth = 3 * framescale
        addChild(shape)
        
        image = SKSpriteNode(texture: texture)
        image.size = CGSizeMake(30 * framescale, 30 * framescale)
        addChild(image)
    }
    func on() {
        shape.fillColor = colorEnergy
    }
    func off() {
        shape.fillColor = SKColor.grayColor()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class SettingLayer: SKNode {
    var soundButton: SwitchButton!
    var musicButton: SwitchButton!
    var resetButton: SKLabelNode!
    var saveButton: SKSpriteNode!
    
    init(frameSize: CGSize) {
        super.init()
        let gap = frameSize.height / 25
    
        let bg = SKSpriteNode(color: SKColor.blackColor(), size: frameSize)
        bg.name = "background"
        bg.alpha = 0.8
        addChild(bg)
        
        let settingLabel = SKLabelNode(fontNamed: "SanFranciscoRounded-Black")
        settingLabel.name = "settingLabel"
        settingLabel.text = "Setting"
        settingLabel.fontSize = 60 * framescale
        settingLabel.verticalAlignmentMode = .Center
        settingLabel.position = CGPoint(x: 0, y: gap * 8)
        addChild(settingLabel)
        
        soundButton = SwitchButton(texture: iconAtlas.textureNamed("sound"))
        soundButton.name = "soundButton"
        soundButton.position = CGPoint(x: frameSize.width / 6, y: gap * 3.5)
        addChild(soundButton)
        
        let soundLabel = SKLabelNode(fontNamed: "SanFranciscoRounded-Black")
        soundLabel.name = "soundLabel"
        soundLabel.text = "Sound"
        soundLabel.fontSize = 20 * framescale
        soundLabel.position = CGPoint(x: frameSize.width / 6, y: gap * 1.5)
        addChild(soundLabel)
        
        musicButton = SwitchButton(texture: iconAtlas.textureNamed("music"))
        musicButton.name = "musicButton"
        musicButton.position = CGPoint(x: -frameSize.width / 6, y: gap * 3.5)
        addChild(musicButton)
        
        let musicLabel = SKLabelNode(fontNamed: "SanFranciscoRounded-Black")
        musicLabel.name = "musicLabel"
        musicLabel.text = "Music"
        musicLabel.fontSize = 20 * framescale
        musicLabel.position = CGPoint(x: -frameSize.width / 6, y: gap * 1.5)
        addChild(musicLabel)
        
        let line1 = SKShapeNode(rectOfSize: CGSizeMake(frameSize.width * 0.6, 0.5 * framescale))
        line1.name = "line1"
        line1.alpha = 0.5
        line1.fillColor = SKColor.whiteColor()
        line1.position = CGPoint(x: 0, y: gap * 0.5)
        addChild(line1)
        
        resetButton = SKLabelNode(fontNamed: "SanFranciscoRounded-Black")
        resetButton.name = "resetButton"
        resetButton.text = "Reset All Data"
        resetButton.fontSize = 30 * framescale
        resetButton.verticalAlignmentMode = .Center
        resetButton.position = CGPoint(x: 0, y: gap * -1)
        addChild(resetButton)
        
        let line2 = SKShapeNode(rectOfSize: CGSizeMake(frameSize.width * 0.6, 0.5 * framescale))
        line2.name = "line2"
        line2.alpha = 0.7
        line2.fillColor = SKColor.whiteColor()
        line2.position = CGPoint(x: 0, y: gap * -2.5)
        addChild(line2)
        
        let noAdLabel = SKLabelNode(fontNamed: "SanFranciscoRounded-Black")
        noAdLabel.name = "noAdLabel"
        noAdLabel.text = "No Ad"
        noAdLabel.fontSize = 30 * framescale
        noAdLabel.verticalAlignmentMode = .Center
        noAdLabel.position = CGPoint(x: 0, y: gap * -4)
        addChild(noAdLabel)
        
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