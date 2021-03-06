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
    var finishBubble: FinishBubble!
    
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
            
            finishBubble = FinishBubble(bubbleSize: CGSizeMake(frame.width * 0.93, frame.height * 0.64))
            finishBubble.alpha = 0
            finishBubble.hidden = true
            finishBubble.zPosition = 100
            finishBubble.position = CGPoint(x: frame.width / 2, y: frame.height * 2 / 5)
            worldLayer.addChild(finishBubble)
            
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
            isMusicContinue = false
            NSNotificationCenter.defaultCenter().postNotificationName("playMusic", object: 0)
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
            NSNotificationCenter.defaultCenter().postNotificationName("playMusic", object: 0)
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
        if finishBubble.hidden == false {
            let NodePosition = convertPoint(location, toNode: finishBubble)
            if finishBubble.OKButton.containsPoint(NodePosition) { finishBubble.OKButton.alpha = 0.7 }
            return
        }
        if settingButton.containsPoint(location) {
            settingButton.alpha = 0.7
        }
        if infoButton.containsPoint(location) {
            infoButton.alpha = 0.7
        }
        
        for i in 0...6 {
            if worldLayer.islandNodes[i].selectRange.containsPoint(location) {
                print("touch island")
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
        if finishBubble.hidden == false {
            let NodePosition = convertPoint(location, toNode: finishBubble)
            finishBubble.OKButton.alpha = finishBubble.OKButton.containsPoint(NodePosition) ? 0.7 : 1
            return
        }
        
        settingButton.alpha = settingButton.containsPoint(location) ? 0.7 : 1
        infoButton.alpha = infoButton.containsPoint(location) ? 0.7 : 1
        
        var inMap = false
        for i in 0...6 {
            if worldLayer.islandNodes[i].selectRange.containsPoint(location) {
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
                        for backgroundMusic in backgroundMusics {
                            backgroundMusic.volume = 0
                        }
                        print("music off")
                    } else {
                        settingLayer.musicButton.on()
                        if !isSoundMute{ runAction(soundTap) }
                        for backgroundMusic in backgroundMusics {
                            backgroundMusic.volume = 0.5
                        }
                        print("music on")
                    }
                }
                if node == settingLayer.resetButton {
                    if !isSoundMute{ runAction(soundSelect) }
                    settingLayer.resetNoButton.alpha  = 1
                    settingLayer.resetYesButton.alpha = 1
                    settingLayer.showResetConfirm(true)
                }
                if node == settingLayer.resetNoButton {
                    if !isSoundMute{ runAction(soundSelect) }
                    settingLayer.resetButton.alpha    = 0
                    settingLayer.resetNoButton.alpha  = 1
                    settingLayer.resetYesButton.alpha = 1
                    settingLayer.showResetConfirm(false)
                }
                if node == settingLayer.resetYesButton {
                    if !isSoundMute{ runAction(soundSelect) }
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
                    confirmBubble.hideBubble()
                    if !isSoundMute{ runAction(soundTap) }
                }
                if node == confirmBubble.buyButton {
                    confirmBubble.hideBubble(duration: 0)
                    money -= confirmBubble.buyPrice
                    if !isSoundMute{ runAction(soundSell) }
                    
                    if confirmBubble.islandNum == 6 {
                        isFinishTarget = true
                        finishTime = spendTime
                        finishBubble.updateFinishData()
                        print("buy target and show finish bubble")
                        finishBubble.showBubble()
                        return
                    }
                    if confirmBubble.islandNum == 5 {
                        worldLayer.islandNodes[6].targetLanding()
                    }
                    maps[confirmBubble.islandNum].isSold = true
                    worldLayer.islandNodes[confirmBubble.islandNum].lockedImg.hidden = true
                    buyIsland(confirmBubble.islandNum + 1)
                }
            }
            return
        }
        if finishBubble.hidden == false {
            for node in nodes {
                if node.hidden { return }
                if node == finishBubble.OKButton {
                    finishBubble.hideBubble()
                    if !isSoundMute{ runAction(soundTap) }
                }
            }
            return
        }
        
        if settingButton.containsPoint(location) {
            if !isSoundMute{ runAction(soundClick) }
            settingButton.alpha = 1
            settingLayer.showResetConfirm(false, duration: 0)
            settingLayer.runAction(SKAction.sequence([SKAction.unhide(), SKAction.fadeInWithDuration(0.3)]))
        }
        
        if infoButton.containsPoint(location) {
            if !isSoundMute{ runAction(soundClick) }
            infoButton.alpha = 1
            infoLayer.runAction(SKAction.sequence([SKAction.unhide(), SKAction.fadeInWithDuration(0.3)]))
        }
        
        for i in 0...5 {
            if worldLayer.islandNodes[i].selectRange.containsPoint(location) {
                worldLayer.mapHighlight(0)
                if !isSoundMute{ runAction(soundAction) }
                
                if !maps[i].isSold {
                    confirmBubble.showBubble(i)
                } else {
                    nowMapNumber = i
                    print("Go to Map\(i+1)")
                    self.view?.presentScene(islandScene, transition: door_Fade)
                }
            }
        }
        
        if !worldLayer.islandNodes[6].hidden && worldLayer.islandNodes[6].selectRange.containsPoint(location) {
            worldLayer.mapHighlight(0)
            if !isSoundMute{ runAction(soundAction) }
            if !isFinishTarget {
                confirmBubble.showBubble(6)
            } else {
                print("show finish page")
                finishBubble.showBubble()
            }
        }
    }
    
    func buyIsland(islandNum: Int) {
        if islandNum > 6 || islandNum < 2 { return }
        if !isSoundMute{ runAction(soundBuyIsland) }
        let buyAnimation = SKNode()
        buyAnimation.name = "buy animation"
        buyAnimation.alpha = 0
        buyAnimation.setScale(0.8)
        buyAnimation.position = CGPoint(x: frame.width / 2, y: frame.maxY / 2)
        addChild(buyAnimation)
        let light = SKSpriteNode(imageNamed: "lights")
        light.size = CGSizeMake(frame.width, frame.width)
        light.runAction(SKAction.repeatActionForever(SKAction.rotateByAngle(CGFloat(-M_PI), duration: 30)))
        light.zPosition = 0
        buyAnimation.addChild(light)
        let islandImg = SKSpriteNode(imageNamed: "buyIsland\(islandNum)")
        islandImg.size = CGSizeMake(400 * framescale, 400 * framescale)
        islandImg.zPosition = 1
        buyAnimation.addChild(islandImg)
        let islandName = SKLabelNode(fontNamed: "SanFranciscoRounded-Black".localized)
        islandName.name = "islandName"
        switch islandNum {
        case 2: islandName.text = "Tree Island".localized
        case 3: islandName.text = "Canyon Island".localized
        case 4: islandName.text = "Coconut Island".localized
        case 5: islandName.text = "Sand Island".localized
        case 6: islandName.text = "Mainland".localized
        default: break
        }
        islandName.fontSize = 40 * framescale
        islandName.verticalAlignmentMode = .Center
        islandName.position = CGPoint(x: 0, y: -115 * framescale)
        islandName.zPosition = 3
        buyAnimation.addChild(islandName)
        let islandNameBG = SKShapeNode(rectOfSize: CGSizeMake(islandName.frame.width + 40 * framescale, 60 * framescale), cornerRadius: 10 * framescale)
        islandNameBG.alpha = 0.8
        islandNameBG.fillColor = SKColor.grayColor()
        islandNameBG.lineWidth = 0
        islandNameBG.position = CGPoint(x: 0, y: -115 * framescale)
        islandNameBG.zPosition = 2
        buyAnimation.addChild(islandNameBG)
        let actionfade = SKAction.group([SKAction.fadeInWithDuration(0.4), SKAction.scaleTo(1.1, duration: 0.4)])
        actionfade.timingMode = SKActionTimingMode.EaseInEaseOut
        let actionIn = SKAction.sequence([actionfade, SKAction.scaleTo(1, duration: 0.2)])
        actionIn.timingMode = SKActionTimingMode.EaseIn
        let actionOut = SKAction.group([SKAction.moveByX(0, y: -150 * framescale, duration: 0.4), SKAction.fadeOutWithDuration(0.3)])
        actionOut.timingMode = SKActionTimingMode.EaseInEaseOut
        RunAfterDelay(2.4) { if !isSoundMute{ self.runAction(soundWhoosh) } }
        let seq = SKAction.sequence([actionIn, SKAction.waitForDuration(2), actionOut, SKAction.removeFromParent()])
        buyAnimation.runAction(seq)
    }
    
    func resetAllData() {
        
        // until boost end to reset data
        while isBoost {}
        
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
            NSNotificationCenter.defaultCenter().postNotificationName("playMusic", object: 0)
            // reset loading number and world position
            self.worldLayer.position = CGPoint(x: 0, y: -self.frame.height)
            self.worldLayer.skyBackground.hidden = false
            self.loadingNum = 1
            self.view?.presentScene(islandsScene)
            // reset game status
            isPause         = false
            isRebuild       = true
            isHaveTeach     = false
            isBoost         = false
            isSoundMute     = false
            isMusicMute     = false
            isFinishTarget  = false
            // reset game data
            money           = 1
            research        = 0
            spendTime       = 0
            finishBuilding  = 0
            finishExplosion = 0
            finishTime      = 0
            // reset mapUnlocked
            for i in 0..<6 {
                maps[i].isSold = i == 0 ? true : false
                if i != 0 {
                    self.worldLayer.islandNodes[i].lockedImg.hidden = false
                }
            }
            self.worldLayer.islandNodes[6].hidden = true
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
        if !isHaveTeach {
            worldLayer.islandNodes[0].isHighlight(true)
        }
        worldLayer.timeLabel.text        = hourToString(spendTime)
        worldLayer.moneyLabel.text       = numberToString(money, isInt: true)
        worldLayer.researchLabel.text    = numberToString(research, isInt: true)
        if worldLayer.isShowTickAdd { worldLayer.showTickAdd() }
        confirmBubble.update()
    }
}