//
//  IslandsScene.swift
//  Energy
//
//  Created by javan.chen on 2015/12/25.
//  Copyright © 2015年 Javan chen. All rights reserved.
//

import SpriteKit

class IslandsScene: SKScene {
    
    var contentCreated: Bool = false
    var leftarrow: SKSpriteNode!
    var backButton: SKLabelNode!
    var settingButton: SKSpriteNode!
    var settingLayer: SettingLayer!
    
    var map1Button: SKLabelNode!
    var map2Button: SKLabelNode!
    
    var spentTimeLabel: SKLabelNode!
    
    override func didMoveToView(view: SKView) {
        
        if !contentCreated {
            
            leftarrow = SKSpriteNode(texture: iconAtlas.textureNamed("arrow_left"))
            leftarrow.size = CGSizeMake(44 * framescale, 44 * framescale)
            leftarrow.anchorPoint = CGPoint(x: 0, y: 1)
            leftarrow.position = CGPoint(x: 10 * framescale, y: frame.size.height - 30 * framescale)
            self.addChild(leftarrow)
            backButton = SKLabelNode(fontNamed: "SanFranciscoText-BoldItalic")
            backButton.text = "Menu"
            backButton.horizontalAlignmentMode = .Left
            backButton.verticalAlignmentMode = .Center
            backButton.fontColor = SKColor.whiteColor()
            backButton.fontSize = 35 * framescale
            backButton.position = CGPoint(x: (15 + 44) * framescale, y: frame.size.height - (30 + 22) * framescale)
            self.addChild(backButton)
            
            settingButton = SKSpriteNode(texture: iconAtlas.textureNamed("setting"))
            settingButton.setScale(framescale)
            settingButton.position = CGPoint(x: frame.width - 52 * framescale, y: frame.height - 52 * framescale)
            self.addChild(settingButton)
            
            settingLayer = SettingLayer(frameSize: frame.size)
            settingLayer.alpha = 0
            settingLayer.hidden = true
            settingLayer.zPosition = 10
            settingLayer.position = CGPoint(x: frame.width / 2, y: frame.height / 2)
            self.addChild(settingLayer)
            
            map1Button = SKLabelNode(fontNamed: "SanFranciscoText-BoldItalic")
            map1Button.text = "Select Map1"
            map1Button.fontSize = 45 * framescale
            map1Button.position = CGPoint(x:frame.size.width / 2, y:frame.size.height / 2 + 100 * framescale)
            self.addChild(map1Button)
            
            map2Button = SKLabelNode(fontNamed: "SanFranciscoText-BoldItalic")
            map2Button.text = "Select Map2"
            map2Button.fontSize = 45 * framescale
            map2Button.position = CGPoint(x:frame.size.width / 2, y:frame.size.height / 2 - 100 * framescale)
            self.addChild(map2Button)
            
            let label = SKLabelNode(fontNamed: "SanFranciscoText-BoldItalic")
            label.name = "spentTimeLabel"
            label.text = "SPEND  TIME"
            label.fontSize = 20 * framescale
            label.fontColor = SKColor.whiteColor()
            label.position = CGPoint(x: frame.width / 2, y: frame.height / 8)
            addChild(label)
            
            spentTimeLabel = SKLabelNode(fontNamed: "SanFranciscoText-BoldItalic")
            spentTimeLabel.name = "spentTimeLabel"
            spentTimeLabel.fontSize = 30 * framescale
            spentTimeLabel.fontColor = SKColor.whiteColor()
            spentTimeLabel.position = CGPoint(x: frame.width / 2, y: label.position.y - 50 * framescale)
            self.addChild(spentTimeLabel)
            

            
            contentCreated = true
            // remove first touch delay
            settingLayer.containsPoint(CGPoint(x: 0, y: 0))
            // remove first load  delay
            self.view?.presentScene(islandScene)
        }
    }
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.locationInNode(self)
        let nodes = nodesAtPoint(location)
        
        if settingLayer.hidden == false {
            for node in nodes {
                if node.hidden { return }
                if node == settingLayer.soundButton.shape {
                    isSoundMute = !isSoundMute
                    if isSoundMute {
                        settingLayer.soundButton.off()
                        print("sound Mute")
                    } else {
                        settingLayer.soundButton.on()
                        print("sount on")
                    }
                }
                if node == settingLayer.musicButton.shape {
                    isMusicMute = !isMusicMute
                    if isMusicMute {
                        settingLayer.musicButton.off()
                        backgroundMusicPlayer.pause()
                        print("music Mute")
                    } else {
                        settingLayer.musicButton.on()
                        backgroundMusicPlayer.play()
                        print("music on")
                    }
                }
                if node == settingLayer.saveSettingButton {
                    settingLayer.runAction(SKAction.sequence([SKAction.fadeOutWithDuration(0.2), SKAction.hide()]))
                }
            }
            return
        }
        
        for node in nodes {
            if node.hidden { return }
            switch node {
                
            case leftarrow, backButton:
                if !isSoundMute{ runAction(soundTap) }
                let doors = SKTransition.moveInWithDirection(SKTransitionDirection.Left, duration: 0.3)
                self.view?.presentScene(menuScene, transition: doors)
                
            case settingButton:
                print("setting")
                settingLayer.runAction(SKAction.sequence([SKAction.unhide(), SKAction.fadeInWithDuration(0.2)]))
            case map1Button:
                print("Map1")
                nowMapNumber = 0
                if !isSoundMute{ runAction(soundTap) }
                let doors = SKTransition.revealWithDirection(SKTransitionDirection.Left, duration: 0.3)
                self.view?.presentScene(islandScene, transition: doors)
                
            case map2Button:
                print("Map2")
                nowMapNumber = 1
                if !isSoundMute{ runAction(soundTap) }
                let doors = SKTransition.revealWithDirection(SKTransitionDirection.Left, duration: 0.3)
                self.view?.presentScene(islandScene, transition: doors)
                
            default:break
            }
        }
    }

    func hourToString(value: Int) -> String {
        let day = value / 86400
        let hour = (value % 86400) / 3600
        let min = (value % 3600) / 60
        let sec = value % 60
        
        var timeString = ""
        if day > 0 {
            timeString += "\(day) day" + (day == 1 ? " " : "s ")
        }
        if hour < 10 { timeString += "0" }
        timeString += "\(hour):"
        if min < 10 { timeString += "0" }
        timeString += "\(min):"
        if sec < 10 { timeString += "0" }
        timeString += "\(sec)"
        return timeString
    }
    
    override func update(currentTime: CFTimeInterval) {
        spentTimeLabel.text = hourToString(spendTime)
    }
}
