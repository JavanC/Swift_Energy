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
    var infoButton: SKSpriteNode!
    var settingButton: SKSpriteNode!
    var settingHighlightFlag: Bool = false
    var settingLayer: SettingLayer!
    
    var mapsRange: [SKShapeNode] = []
    var selectMaps: [SKSpriteNode] = []
    var nowSelectNum: Int = 0
    
    var spentTimeLabel: SKLabelNode!
    
    override func didMoveToView(view: SKView) {
        
        if !contentCreated {
            
            let background = SKSpriteNode(texture: backgroundAtlas.textureNamed("Maps"))
            background.name = "background"
            background.size = frame.size
            background.zPosition = -1
            background.position = CGPoint(x: frame.width / 2, y: frame.height / 2)
            addChild(background)
            
            for i in 1...6 {
                let selectMap = SKSpriteNode(texture: backgroundAtlas.textureNamed("selectMap\(i)"))
                selectMap.name = "selectMap\(i)"
                selectMap.size = frame.size
                selectMap.hidden = true
                selectMap.position = CGPoint(x: frame.width / 2, y: frame.height / 2)
                addChild(selectMap)
                selectMaps.append(selectMap)
            }
            
            let map1 = SKShapeNode(circleOfRadius: 60 * framescale)
            map1.name = "map1Range"
            map1.lineWidth = 0
            map1.position = CGPoint(x: 120 * framescale, y: 160 * framescale)
            addChild(map1)
            mapsRange.append(map1)
            let map2 = SKShapeNode(circleOfRadius: 80 * framescale)
            map2.name = "map2Range"
            map2.lineWidth = 0
            map2.position = CGPoint(x: 410 * framescale, y: 220 * framescale)
            addChild(map2)
            mapsRange.append(map2)
            let map3 = SKShapeNode(circleOfRadius: 80 * framescale)
            map3.name = "map3Range"
            map3.lineWidth = 0
            map3.strokeColor = SKColor.blackColor()
            map3.position = CGPoint(x: 95 * framescale, y: 400 * framescale)
            addChild(map3)
            mapsRange.append(map3)
            let map4 = SKShapeNode(circleOfRadius: 90 * framescale)
            map4.name = "map4Range"
            map4.lineWidth = 0
            map4.position = CGPoint(x: 450 * framescale, y: 500 * framescale)
            addChild(map4)
            mapsRange.append(map4)
            let map5 = SKShapeNode(circleOfRadius: 90 * framescale)
            map5.name = "map5Range"
            map5.lineWidth = 0
            map5.position = CGPoint(x: 100 * framescale, y: 610 * framescale)
            addChild(map5)
            mapsRange.append(map5)
            let map6 = SKShapeNode(circleOfRadius: 90 * framescale)
            map6.name = "map6Range"
            map6.lineWidth = 0
            map6.position = CGPoint(x: 410 * framescale, y: 720 * framescale)
            addChild(map6)
            mapsRange.append(map6)
            
            infoButton = SKSpriteNode(texture: iconAtlas.textureNamed("button_info"))
            infoButton.setScale(framescale)
            infoButton.position = CGPoint(x: frame.width - (52 + 64 + 10) * framescale, y: frame.height - 52 * framescale)
            self.addChild(infoButton)
            
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
            
            let label = SKLabelNode(fontNamed: "SanFranciscoText-BoldItalic")
            label.name = "spentTimeLabel"
            label.text = "SPEND  TIME"
            label.fontSize = 20 * framescale
            label.fontColor = SKColor.whiteColor()
            label.position = CGPoint(x: frame.width / 2, y: frame.height / 8)
//            addChild(label)
            
            spentTimeLabel = SKLabelNode(fontNamed: "SanFranciscoText-BoldItalic")
            spentTimeLabel.name = "spentTimeLabel"
            spentTimeLabel.fontSize = 30 * framescale
            spentTimeLabel.fontColor = SKColor.whiteColor()
            spentTimeLabel.position = CGPoint(x: frame.width / 2, y: label.position.y - 50 * framescale)
//            self.addChild(spentTimeLabel)
            
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
                        print("sound off")
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
                        print("music off")
                    } else {
                        settingLayer.musicButton.on()
                        backgroundMusicPlayer.play()
                        print("music on")
                    }
                }
                if node == settingLayer.saveSettingButton {
                    settingLayer.runAction(SKAction.sequence([SKAction.fadeOutWithDuration(0.3), SKAction.hide()]))
                }
            }
            return
        }
        
        for i in 0...5 {
            if mapsRange[i].containsPoint(location) {
                mapHighlight(i+1)
            }
        }
        
        if settingButton.containsPoint(location) {
            settingButtonHighlight(true)
        }
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.locationInNode(self)
        
        var inMap = false
        for i in 0...5 {
            if mapsRange[i].containsPoint(location) {
                inMap = true
                mapHighlight(i+1)
            }
        }
        if inMap == false {
            mapHighlight(0)
        }
        
        if settingButton.containsPoint(location) {
            settingButtonHighlight(true)
        } else {
            settingButtonHighlight(false)
        }
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.locationInNode(self)
        
        for i in 0...5 {
            if mapsRange[i].containsPoint(location) {
                print("Map\(i+1)")
                mapHighlight(0)
                nowMapNumber = i
                if !isSoundMute{ runAction(soundAction) }
                let doors = SKTransition.fadeWithDuration(2)
                self.view?.presentScene(islandScene, transition: doors)
            }
        }
        
        if settingButton.containsPoint(location) {
            settingButtonHighlight(false)
            settingLayer.runAction(SKAction.sequence([SKAction.unhide(), SKAction.fadeInWithDuration(0.3)]))
        }
    }
    
    func settingButtonHighlight(isHighlight: Bool) {
        if settingHighlightFlag != isHighlight {
            settingHighlightFlag = isHighlight
            print("now select setting button \(isHighlight)")
            if settingHighlightFlag == true {
                runAction(soundClick)
            }
        }
        if isHighlight {
            settingButton.setScale(framescale * 1.1)
        } else {
            settingButton.setScale(framescale)
        }
    }
    
    func mapHighlight(mapNum: Int) {
        if nowSelectNum != mapNum {
            nowSelectNum = mapNum
            print("now select \(nowSelectNum)")
            if nowSelectNum >= 1 && nowSelectNum <= 6 {
                runAction(soundClick)
            }
        }
        for i in 0...5 {
            selectMaps[i].hidden = true
        }
        if mapNum >= 1 && mapNum <= 6 {
            selectMaps[mapNum-1].hidden = false
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