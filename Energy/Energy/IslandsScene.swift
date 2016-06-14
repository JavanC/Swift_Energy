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
    var loadingNum: Int = 0
    
    var worldLayer: WorldLayer!
    var infoButton: SKSpriteNode!
    var infoLayer: InfoLayer!
    var settingButton: SKSpriteNode!
    var settingLayer: SettingLayer!
    var confirmBubble: ConfirmBubble!
    
    override func didMoveToView(view: SKView) {
        
        if !contentCreated {
            
            worldLayer = WorldLayer(frameSize: frame.size)
            worldLayer.position = CGPoint(x: 0, y: -frame.height)
            addChild(worldLayer)

            confirmBubble = ConfirmBubble(bubbleSize: CGSizeMake(frame.width * 0.8, frame.width * 0.5))
            confirmBubble.alpha = 0
            confirmBubble.hidden = true
            confirmBubble.zPosition = 100
            confirmBubble.position = CGPoint(x: frame.width / 2, y: frame.height / 2)
            worldLayer.addChild(confirmBubble)
            
            infoButton = SKSpriteNode(texture: iconAtlas.textureNamed("button_info"))
            infoButton.setScale(framescale)
            infoButton.position = CGPoint(x: frame.width - (52 + 64 + 10) * framescale, y: frame.height - 52 * framescale)
            worldLayer.addChild(infoButton)
            
            infoLayer = InfoLayer(frameSize: frame.size)
            infoLayer.alpha = 0
            infoLayer.hidden = true
            infoLayer.zPosition = 100
            infoLayer.position = CGPoint(x: frame.width / 2, y: frame.height / 2)
            worldLayer.addChild(infoLayer)

            settingButton = SKSpriteNode(texture: iconAtlas.textureNamed("setting"))
            settingButton.setScale(framescale)
            settingButton.position = CGPoint(x: frame.width - 52 * framescale, y: frame.height - 52 * framescale)
            worldLayer.addChild(settingButton)
            
            settingLayer = SettingLayer(frameSize: frame.size)
            settingLayer.alpha = 0
            settingLayer.hidden = true
            settingLayer.zPosition = 100
            settingLayer.position = CGPoint(x: frame.width / 2, y: frame.height / 2)
            worldLayer.addChild(settingLayer)
   
            contentCreated = true
            // remove first touch delay
            dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INTERACTIVE, 0)) {
                self.settingLayer.containsPoint(CGPoint(x: 0, y: 0))
                self.infoLayer.containsPoint(CGPoint(x: 0,y: 0))
                self.confirmBubble.containsPoint(CGPoint(x: 0, y:0))
            }
            // remove first load  delay
            print("load 1")
            self.view?.presentScene(researchScene)
        }
        
        switch loadingNum {
        case 0:
            print("load 5")
            loadingNum = 1
        case 1:
            print("load 9")
            RunAfterDelay(3){
                let move = SKAction.moveTo(CGPoint(x: 0, y:0), duration: 4)
                move.timingMode = SKActionTimingMode.EaseInEaseOut
                let wait = SKAction.waitForDuration(4)
                let hide = SKAction.hide()
                self.worldLayer.runAction(SKAction.sequence([move]))
                self.worldLayer.skyBackground.runAction(SKAction.sequence([wait, hide]))
            }
            worldLayer.isShowTickAdd = false
            worldLayer.isFirstShowTickAdd = true
            worldLayer.cloudsMove()
            RunAfterDelay(10) {
                self.worldLayer.isShowTickAdd = true
            }
            NSNotificationCenter.defaultCenter().postNotificationName("hideAd", object: nil)
            print("load 10")
            loadingNum = 2
        default:
            worldLayer.isShowTickAdd = false
            worldLayer.isFirstShowTickAdd = true
            worldLayer.cloudsMove()
            RunAfterDelay(3) {
                self.worldLayer.isShowTickAdd = true
            }
            NSNotificationCenter.defaultCenter().postNotificationName("hideAd", object: nil)
            print("load 10")
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.locationInNode(self)
        
        if worldLayer.skyBackground.hidden == false { return }
        
        if infoLayer.hidden == false {
            let NodePosition = convertPoint(location, toNode: infoLayer)
            if infoLayer.saveButton.containsPoint(NodePosition) { infoLayer.saveButton.alpha = 0.7 }
            return
        }
        if settingLayer.hidden == false {
            let NodePosition = convertPoint(location, toNode: settingLayer)
            if settingLayer.soundButton.containsPoint(NodePosition) { settingLayer.soundButton.alpha = 0.7 }
            if settingLayer.musicButton.containsPoint(NodePosition) { settingLayer.musicButton.alpha = 0.7 }
            if settingLayer.resetButton.containsPoint(NodePosition) { settingLayer.resetButton.alpha = 0.7 }
            if settingLayer.resetNoButton.containsPoint(NodePosition) { settingLayer.resetNoButton.alpha = 0.7 }
            if settingLayer.resetYesButton.containsPoint(NodePosition) { settingLayer.resetYesButton.alpha = 0.7 }
            if settingLayer.saveButton.containsPoint(NodePosition) { settingLayer.saveButton.alpha = 0.7 }
            return
        }
        if confirmBubble.hidden == false {
            let NodePosition = convertPoint(location, toNode: confirmBubble)
            if confirmBubble.OKButton.containsPoint(NodePosition) { confirmBubble.OKButton.alpha = 0.7 }
            if confirmBubble.cancelButton.containsPoint(NodePosition) { confirmBubble.cancelButton.alpha = 0.7 }
            if confirmBubble.buyButton.containsPoint(NodePosition) { confirmBubble.buyButton.alpha = 0.7 }
            return
        }
        if settingButton.containsPoint(location) {
            settingButton.alpha = 0.7
        }
        if infoButton.containsPoint(location) {
            infoButton.alpha = 0.7
        }
        for i in 0...5 {
            if worldLayer.mapsRange[i].containsPoint(location) {
                worldLayer.mapHighlight(i+1)
            }
        }
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.locationInNode(self)
        
        if worldLayer.skyBackground.hidden == false { return }
        
        if infoLayer.hidden == false {
            let NodePosition = convertPoint(location, toNode: infoLayer)
            infoLayer.saveButton.alpha = infoLayer.saveButton.containsPoint(NodePosition) ? 0.7 : 1
            return
        }
        if settingLayer.hidden == false {
            let NodePosition = convertPoint(location, toNode: settingLayer)
            settingLayer.soundButton.alpha = settingLayer.soundButton.containsPoint(NodePosition) ? 0.7 : 1
            settingLayer.musicButton.alpha = settingLayer.musicButton.containsPoint(NodePosition) ? 0.7 : 1
            settingLayer.resetButton.alpha = settingLayer.resetButton.containsPoint(NodePosition) ? 0.7 : 1
            settingLayer.resetNoButton.alpha = settingLayer.resetNoButton.containsPoint(NodePosition) ? 0.7 : 1
            settingLayer.resetYesButton.alpha = settingLayer.resetYesButton.containsPoint(NodePosition) ? 0.7 : 1
            settingLayer.saveButton.alpha = settingLayer.saveButton.containsPoint(NodePosition) ? 0.7 : 1
            return
        }
        if confirmBubble.hidden == false {
            let NodePosition = convertPoint(location, toNode: confirmBubble)
            confirmBubble.OKButton.alpha = confirmBubble.OKButton.containsPoint(NodePosition) ? 0.7 : 1
            confirmBubble.cancelButton.alpha = confirmBubble.cancelButton.containsPoint(NodePosition) ? 0.7 : 1
            confirmBubble.buyButton.alpha = confirmBubble.buyButton.containsPoint(NodePosition) ? 0.7 : 1
            return
        }
        
        settingButton.alpha = settingButton.containsPoint(location) ? 0.7 : 1
        infoButton.alpha = infoButton.containsPoint(location) ? 0.7 : 1
        
        var inMap = false
        for i in 0...5 {
            if worldLayer.mapsRange[i].containsPoint(location) {
                inMap = true
                worldLayer.mapHighlight(i+1)
            }
        }
        if inMap == false {
            worldLayer.mapHighlight(0)
        }
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.locationInNode(self)
        let nodes = nodesAtPoint(location)
        
        if worldLayer.skyBackground.hidden == false { return }
        
        if infoLayer.hidden == false {
            for node in nodes {
                if node.hidden { return }
                if node == infoLayer.saveButton {
                    infoLayer.saveButton.alpha = 1
                    if !isSoundMute{ runAction(soundTap) }
                    infoLayer.runAction(SKAction.sequence([SKAction.fadeOutWithDuration(0.3), SKAction.hide()]))
                }
            }
            return
        }
        if settingLayer.hidden == false {
            for node in nodes {
                if node.hidden { return }
                if node == settingLayer.soundButton {
                    settingLayer.soundButton.alpha = 1
                    isSoundMute = !isSoundMute
                    if isSoundMute {
                        settingLayer.soundButton.off()
                        print("sound off")
                    } else {
                        settingLayer.soundButton.on()
                        if !isSoundMute{ runAction(soundTap) }
                        print("sount on")
                    }
                }
                if node == settingLayer.musicButton {
                    settingLayer.musicButton.alpha = 1
                    isMusicMute = !isMusicMute
                    if isMusicMute {
                        settingLayer.musicButton.off()
                        if !isSoundMute{ runAction(soundTap) }
                        backgroundMusicPlayer.pause()
                        print("music off")
                    } else {
                        settingLayer.musicButton.on()
                        if !isSoundMute{ runAction(soundTap) }
                        backgroundMusicPlayer.play()
                        print("music on")
                    }
                }
                if node == settingLayer.resetButton {
                    settingLayer.resetNoButton.alpha  = 1
                    settingLayer.resetYesButton.alpha = 1
                    settingLayer.showResetConfirm(true)
                }
                if node == settingLayer.resetNoButton {
                    settingLayer.resetButton.alpha    = 0
                    settingLayer.resetNoButton.alpha  = 1
                    settingLayer.resetYesButton.alpha = 1
                    settingLayer.showResetConfirm(false)
                }
                if node == settingLayer.resetYesButton {
                    settingLayer.resetButton.alpha    = 0
                    settingLayer.resetNoButton.alpha  = 1
                    settingLayer.resetYesButton.alpha = 1
                    resetAllData()
                }
                if node == settingLayer.saveButton {
                    settingLayer.saveButton.alpha = 1
                    if !isSoundMute{ runAction(soundTap) }
                    settingLayer.runAction(SKAction.sequence([SKAction.fadeOutWithDuration(0.3), SKAction.hide()]))
                }
            }
            return
        }
        if confirmBubble.hidden == false {
            for node in nodes {
                if node.hidden { return }
                if node == confirmBubble.OKButton || node == confirmBubble.cancelButton {
                    confirmBubble.OKButton.alpha     = 1
                    confirmBubble.cancelButton.alpha = 1
                    confirmBubble.buyButton.alpha    = 1
                    confirmBubble.hideBubble()
                    if !isSoundMute{ runAction(soundTap) }
                }
                if node == confirmBubble.buyButton {
                    confirmBubble.OKButton.alpha     = 1
                    confirmBubble.cancelButton.alpha = 1
                    confirmBubble.buyButton.alpha    = 1
                    confirmBubble.alpha  = 1
                    confirmBubble.hidden = true
                    money -= confirmBubble.buyPrice
                    maps[confirmBubble.islandNum].isSold = true
                    worldLayer.mapsLock[confirmBubble.islandNum].hidden = true
                    if !isSoundMute{ runAction(soundSell) }
                }
            }
            return
        }
        
        if settingButton.containsPoint(location) {            
            settingButton.alpha = 1
            settingLayer.showResetConfirm(false, duration: 0)
            settingLayer.runAction(SKAction.sequence([SKAction.unhide(), SKAction.fadeInWithDuration(0.3)]))
        }
        
        if infoButton.containsPoint(location) {
            infoButton.alpha = 1
            infoLayer.runAction(SKAction.sequence([SKAction.unhide(), SKAction.fadeInWithDuration(0.3)]))
        }
        for i in 0...5 {
            if worldLayer.mapsRange[i].containsPoint(location) {
                worldLayer.mapHighlight(0)
                print("Map\(i+1)")
                if !isSoundMute{ runAction(soundAction) }
                
                if !maps[i].isSold {
                    confirmBubble.showBubble(i)
                } else {
                    nowMapNumber = i
                    self.view?.presentScene(islandScene, transition: door_Fade)
                }
            }
        }
    }
    
    func hourToString(value: Int) -> String {
        let day = value / 86400
        let hour = (value % 86400) / 3600
        let min = (value % 3600) / 60
        let sec = value % 60
        
        var timeString = ". "
        if day < 10 { timeString += " "}
        timeString += day > 0 ? "\(day)D " : "   "
        if hour < 10 { timeString += "0" }
        timeString += "\(hour):"
        if min < 10 { timeString += "0" }
        timeString += "\(min):"
        if sec < 10 { timeString += "0" }
        timeString += "\(sec)"
        return timeString
    }
    
    func resetAllData() {
        let black = SKSpriteNode(color: SKColor.blackColor(), size: frame.size)
        black.alpha = 0
        black.position = CGPoint(x: frame.width / 2, y: frame.height / 2)
        black.zPosition = 1000
        let fadeIn = SKAction.fadeInWithDuration(1)
        let wait = SKAction.waitForDuration(0.5)
        let fadeOut = SKAction.fadeOutWithDuration(2)
        let remove = SKAction.removeFromParent()
        black.runAction(SKAction.sequence([fadeIn, wait, fadeOut, remove]))
        addChild(black)
        
        RunAfterDelay(1) {
            // hide setting layer
            self.settingLayer.alpha = 0
            self.settingLayer.hidden = true
            // reset background music
            backgroundMusicPlayer.currentTime = 0
            // reset loading number and world position
            self.worldLayer.position = CGPoint(x: 0, y: -self.frame.height)
            self.worldLayer.skyBackground.hidden = false
            self.loadingNum = 1
            self.view?.presentScene(islandsScene)
            // reset game data
            money       = 1
            research    = 1
            spendTime   = 0
            isPause     = false
            isRebuild   = true
            isSoundMute = false
            isMusicMute = false
            // reset mapUnlocked
            for i in 1..<6 {
                maps[i].isSold = i == 0 ? true : false
                self.worldLayer.mapsLock[i].hidden = i == 0 ? true : false
            }
            // reset upgrade and research level
            for count in 0..<UpgradeType.UpgradeTypeLength.hashValue {
                upgradeLevel[UpgradeType(rawValue: count)!] = 0
            }
            for count in 0..<ResearchType.ResearchTypeLength.hashValue {
                researchLevel[ResearchType(rawValue: count)!] = 0
            }
            researchLevel[ResearchType.WindTurbineResearch] = 1
            // reset maps data
            for map in maps {
                map.initialMapData()
            }
        }
    }
    
    override func update(currentTime: CFTimeInterval) {
        worldLayer.timeLabel.text       = hourToString(spendTime)
        worldLayer.moneyLabel.text      = numberToString(money, isInt: true)
        worldLayer.researchLabel.text   = numberToString(research, isInt: true)
        if worldLayer.isShowTickAdd { worldLayer.showTickAdd() }
        confirmBubble.update()
    }
}