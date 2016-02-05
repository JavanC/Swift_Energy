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
    var saveSettingButton: SKSpriteNode!
    
    init(frameSize: CGSize) {
        super.init()
        
        
        let bg = SKSpriteNode(color: SKColor.blackColor(), size: frameSize)
        bg.alpha = 0.7
        addChild(bg)
        soundButton = SwitchButton(texture: iconAtlas.textureNamed("sound"))
        soundButton.position = CGPoint(x: frameSize.width / 6, y: frameSize.height / 4)
        addChild(soundButton)
        let soundLabel = SKLabelNode(fontNamed: "SanFranciscoText-BoldItalic")
        soundLabel.text = "Sound"
        soundLabel.fontSize = 20 * framescale
        soundLabel.position = CGPoint(x: frameSize.width / 6, y: frameSize.height / 6)
        addChild(soundLabel)
        musicButton = SwitchButton(texture: iconAtlas.textureNamed("music"))
        musicButton.position = CGPoint(x: -frameSize.width / 6, y: frameSize.height / 4)
        addChild(musicButton)
        let musicLabel = SKLabelNode(fontNamed: "SanFranciscoText-BoldItalic")
        musicLabel.text = "Music"
        musicLabel.fontSize = 20 * framescale
        musicLabel.position = CGPoint(x: -frameSize.width / 6, y: frameSize.height / 6)
        addChild(musicLabel)
        let line = SKShapeNode(rectOfSize: CGSizeMake(frameSize.width * 0.8, 1 * framescale))
        line.name = "line"
        line.fillColor = SKColor.whiteColor()
        line.position = CGPoint(x: 0, y: frameSize.height / 8)
        addChild(line)
        resetButton = SKLabelNode(fontNamed: "SanFranciscoText-ThinItalic")
        resetButton.text = "Reset All Data"
        resetButton.fontSize = 40 * framescale
        resetButton.verticalAlignmentMode = .Center
        resetButton.position = CGPoint(x: 0, y: 0)
        addChild(resetButton)
        let line2 = SKShapeNode(rectOfSize: CGSizeMake(frameSize.width * 0.8, 1 * framescale))
        line2.name = "line"
        line2.fillColor = SKColor.whiteColor()
        line2.position = CGPoint(x: 0, y: -frameSize.height / 8)
        addChild(line2)
        saveSettingButton = SKSpriteNode(texture: iconAtlas.textureNamed("check"))
        saveSettingButton.size = CGSizeMake(80 * framescale, 80 * framescale)
        saveSettingButton.position = CGPoint(x: 0, y: -frameSize.height / 4)
        addChild(saveSettingButton)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}