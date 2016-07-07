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
    var confirmNode: SKNode!
    var resetYesButton: SKShapeNode!
    var resetNoButton: SKShapeNode!
    var saveButton: SKShapeNode!
    
    init(frameSize: CGSize) {
        super.init()
        let gap = frameSize.height / 25
    
        let bg = SKSpriteNode(color: SKColor.blackColor(), size: frameSize)
        bg.name = "background"
        bg.alpha = 0.8
        addChild(bg)
        
        let settingLabel = SKLabelNode(fontNamed: "SanFranciscoRounded-Black".localized)
        settingLabel.name = "settingLabel"
        settingLabel.text = "Setting".localized
        settingLabel.fontSize = 60 * framescale
        settingLabel.verticalAlignmentMode = .Center
        settingLabel.position = CGPoint(x: 0, y: gap * 8)
        addChild(settingLabel)
        
        soundButton = SwitchButton(texture: iconAtlas.textureNamed("sound"))
        soundButton.name = "soundButton"
        soundButton.position = CGPoint(x: frameSize.width / 6, y: gap * 4)
        addChild(soundButton)
        
        let soundLabel = SKLabelNode(fontNamed: "SanFranciscoRounded-Black".localized)
        soundLabel
        soundLabel.name = "soundLabel"
        soundLabel.text = "Sound".localized
        soundLabel.fontSize = 20 * framescale
        soundLabel.position = CGPoint(x: frameSize.width / 6, y: gap * 2)
        addChild(soundLabel)
        
        musicButton = SwitchButton(texture: iconAtlas.textureNamed("music"))
        musicButton.name = "musicButton"
        musicButton.position = CGPoint(x: -frameSize.width / 6, y: gap * 4)
        addChild(musicButton)
        
        let musicLabel = SKLabelNode(fontNamed: "SanFranciscoRounded-Black".localized)
        musicLabel.name = "musicLabel"
        musicLabel.text = "Music".localized
        musicLabel.fontSize = 20 * framescale
        musicLabel.position = CGPoint(x: -frameSize.width / 6, y: gap * 2)
        addChild(musicLabel)
        
        let line1 = SKShapeNode(rectOfSize: CGSizeMake(frameSize.width * 0.6, 1 * framescale))
        line1.name = "line1"
        line1.lineWidth = 0
        line1.fillColor = SKColor.whiteColor()
        line1.position = CGPoint(x: 0, y: gap * 1)
        addChild(line1)
        
        resetButton = SKLabelNode(fontNamed: "SanFranciscoRounded-Black".localized)
        resetButton.name = "resetButton"
        resetButton.text = "Reset All Data".localized
        resetButton.fontSize = 30 * framescale
        resetButton.verticalAlignmentMode = .Center
        resetButton.position = CGPoint(x: 0, y: gap * -1)
        addChild(resetButton)
        
        confirmNode = SKNode()
        confirmNode.hidden = true
        addChild(confirmNode)
        let confirmLabel = SKLabelNode(fontNamed: "SanFranciscoRounded-Black".localized)
        confirmLabel.name = "ConfirmLabel"
        confirmLabel.text = "Confirm reset all data?".localized
        confirmLabel.fontSize = 30 * framescale
        confirmLabel.verticalAlignmentMode = .Center
        confirmLabel.position = CGPoint(x: 0, y: gap * 0)
        confirmNode.addChild(confirmLabel)
        resetNoButton = SKShapeNode(rectOfSize: CGSizeMake(80 * framescale, 50 * framescale), cornerRadius: 10)
        resetNoButton.name = "no node"
        resetNoButton.position = CGPoint(x: -frameSize.width / 7, y: gap * -1.65)
        resetNoButton.lineWidth = 3 * framescale
        let noLabel = SKLabelNode(fontNamed: "SanFranciscoRounded-Black".localized)
        noLabel.name = "no Label"
        noLabel.text = "No".localized
        noLabel.fontSize = 30 * framescale
        noLabel.verticalAlignmentMode = .Center
        resetNoButton.addChild(noLabel)
        confirmNode.addChild(resetNoButton)
        resetYesButton = SKShapeNode(rectOfSize: CGSizeMake(80 * framescale, 50 * framescale), cornerRadius: 10)
        resetYesButton.name = "yes node"
        resetYesButton.position = CGPoint(x: frameSize.width / 7, y: gap * -1.65)
        resetYesButton.lineWidth = 3 * framescale
        let yesLabel = SKLabelNode(fontNamed: "SanFranciscoRounded-Black".localized)
        yesLabel.name = "yes Label"
        yesLabel.text = "Yes".localized
        yesLabel.fontSize = 30 * framescale
        yesLabel.verticalAlignmentMode = .Center
        resetYesButton.addChild(yesLabel)
        confirmNode.addChild(resetYesButton)
        
        let line2 = SKShapeNode(rectOfSize: CGSizeMake(frameSize.width * 0.6, 1 * framescale))
        line2.name = "line2"
        line2.lineWidth = 0
        line2.fillColor = SKColor.whiteColor()
        line2.position = CGPoint(x: 0, y: gap * -3)
        addChild(line2)
        
        let noAdLabel = SKLabelNode(fontNamed: "SanFranciscoRounded-Black".localized)
        noAdLabel.name = "noAdLabel"
        noAdLabel.text = "No Ad"
        noAdLabel.fontSize = 30 * framescale
        noAdLabel.verticalAlignmentMode = .Center
        noAdLabel.position = CGPoint(x: 0, y: gap * -4.5)
        addChild(noAdLabel)
        
        saveButton = SKShapeNode(circleOfRadius: 40 * framescale)
        saveButton.name = "saveButton"
        saveButton.fillColor = SKColor.clearColor()
        saveButton.strokeColor = SKColor.whiteColor()
        saveButton.lineWidth = 3 * framescale
        saveButton.position = CGPoint(x: 0, y: gap * -8)
        let checkImg = SKSpriteNode(texture: iconAtlas.textureNamed("check"))
        checkImg.size = CGSizeMake(40 * framescale, 40 * framescale)
        saveButton.addChild(checkImg)
        addChild(saveButton)
    }
    
    func showResetConfirm(isShow: Bool, duration: Double = 0.5) {
        if isShow {
            resetButton.runAction(SKAction.sequence([SKAction.fadeOutWithDuration(duration), SKAction.hide()])) {
                self.confirmNode.runAction(SKAction.sequence([SKAction.unhide(), SKAction.fadeInWithDuration(duration)]))
            }
        } else {
            confirmNode.runAction(SKAction.sequence([SKAction.fadeOutWithDuration(duration), SKAction.hide()])) {
                self.resetButton.runAction(SKAction.sequence([SKAction.unhide(), SKAction.fadeInWithDuration(duration)]))
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}