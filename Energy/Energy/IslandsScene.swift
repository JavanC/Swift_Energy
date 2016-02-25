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
    var infoHighlightFlag: Bool = false
    var infoLayer: InfoLayer!
    var settingButton: SKSpriteNode!
    var settingHighlightFlag: Bool = false
    var settingLayer: SettingLayer!
    
    var mapsRange: [SKShapeNode] = []
    var selectMaps: [SKSpriteNode] = []
    var nowSelectNum: Int = 0
    var lockeds: [SKShapeNode] = []
    
    var confirmBubble: ConfirmBubble!
    
    var isShowTickAdd: Bool = false
    var isFirstShowTickAdd: Bool = true
    var spentTimeLabel: SKLabelNode!
    var moneyLabel: SKLabelNode!
    
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
            
            for i in 0..<6 {
                let locked = SKShapeNode(circleOfRadius: 20 * framescale)
                locked.name = "locked \(i)"
                locked.hidden = mapUnlockeds[i]
                locked.fillColor = SKColor.grayColor()
                locked.strokeColor = SKColor.whiteColor()
                locked.lineWidth = 3 * framescale
                locked.zPosition = 10
                locked.position = CGPoint(x: mapsRange[i].position.x + 40 * framescale, y: mapsRange[i].position.y - 40 * framescale)
                let img = SKSpriteNode(texture: iconAtlas.textureNamed("locked2"))
                img.size = CGSizeMake(18 * framescale, 18 * framescale)
                locked.addChild(img)
                addChild(locked)
                lockeds.append(locked)
            }
            
            confirmBubble = ConfirmBubble(bubbleSize: CGSizeMake(frame.width * 0.8, frame.width * 0.5))
            confirmBubble.alpha = 0
            confirmBubble.hidden = true
            confirmBubble.zPosition = 100
            confirmBubble.position = CGPoint(x: frame.width / 2, y: frame.height / 2)
            self.addChild(confirmBubble)
            
            infoButton = SKSpriteNode(texture: iconAtlas.textureNamed("button_info"))
            infoButton.setScale(framescale)
            infoButton.position = CGPoint(x: frame.width - (52 + 64 + 10) * framescale, y: frame.height - 52 * framescale)
            self.addChild(infoButton)
            
            infoLayer = InfoLayer(frameSize: frame.size)
            infoLayer.alpha = 0
            infoLayer.hidden = true
            infoLayer.zPosition = 100
            infoLayer.position = CGPoint(x: frame.width / 2, y: frame.height / 2)
            self.addChild(infoLayer)

            settingButton = SKSpriteNode(texture: iconAtlas.textureNamed("setting"))
            settingButton.setScale(framescale)
            settingButton.position = CGPoint(x: frame.width - 52 * framescale, y: frame.height - 52 * framescale)
            self.addChild(settingButton)
            
            settingLayer = SettingLayer(frameSize: frame.size)
            settingLayer.alpha = 0
            settingLayer.hidden = true
            settingLayer.zPosition = 100
            settingLayer.position = CGPoint(x: frame.width / 2, y: frame.height / 2)
            self.addChild(settingLayer)
            
            moneyLabel = SKLabelNode(fontNamed: "SanFranciscoRounded-Black")
            moneyLabel.name = "money label"
            moneyLabel.text = numberToString(money, isInt: true)
            moneyLabel.fontSize = 40 * framescale
            moneyLabel.fontColor = colorMoney
            moneyLabel.horizontalAlignmentMode = .Left
            moneyLabel.position = CGPoint(x: 20 * framescale, y: 20 * framescale)
            addChild(moneyLabel)
            
            let label = SKLabelNode(fontNamed: "SanFranciscoRounded-Black")
            label.name = "spentTimeLabel"
            label.text = "SPEND  TIME"
            label.fontSize = 20 * framescale
            label.fontColor = SKColor.whiteColor()
            label.position = CGPoint(x: frame.width / 2, y: frame.height / 8)
//            addChild(label)
            
            spentTimeLabel = SKLabelNode(fontNamed: "SanFranciscoRounded-Black")
            spentTimeLabel.name = "spentTimeLabel"
            spentTimeLabel.fontSize = 30 * framescale
            spentTimeLabel.fontColor = SKColor.whiteColor()
            spentTimeLabel.position = CGPoint(x: frame.width / 2, y: label.position.y - 50 * framescale)
//            self.addChild(spentTimeLabel)
            
            contentCreated = true
            // remove first touch delay
//            dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INTERACTIVE, 0)) {
                self.settingLayer.containsPoint(CGPoint(x: 0, y: 0))
                self.infoLayer.containsPoint(CGPoint(x: 0,y: 0))
                self.confirmBubble.containsPoint(CGPoint(x: 0, y:0))
//            }
            // remove first load  delay
            print("load 5")
            self.view?.presentScene(menuScene)
        }
        
        isShowTickAdd = false
        isFirstShowTickAdd = true
        RunAfterDelay(3) {
            self.isShowTickAdd = true
        }
        print("load 7")
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
                        if !isSoundMute{ runAction(soundTap) }
                        print("sount on")
                    }
                }
                if node == settingLayer.musicButton.shape {
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
                if node == settingLayer.saveButton {
                    if !isSoundMute{ runAction(soundTap) }
                    settingLayer.runAction(SKAction.sequence([SKAction.fadeOutWithDuration(0.3), SKAction.hide()]))
                }
            }
            return
        }
        
        if infoLayer.hidden == false {
            for node in nodes {
                if node.hidden { return }
                if node == infoLayer.saveButton {
                    if !isSoundMute{ runAction(soundTap) }
                    infoLayer.runAction(SKAction.sequence([SKAction.fadeOutWithDuration(0.3), SKAction.hide()]))
                }
            }
            return
        }
        
        if confirmBubble.hidden == false {
            for node in nodes {
                if node.hidden { return }
                if node == confirmBubble.OKButton || node == confirmBubble.cancelButton {
                    confirmBubble.hideBubble()
                    runAction(soundTap)
                }
                if node == confirmBubble.buyButton {
                    confirmBubble.alpha = 0
                    confirmBubble.hidden = true
                    money -= confirmBubble.buyPrice
                    mapUnlockeds[confirmBubble.islandNum] = true
                    lockeds[confirmBubble.islandNum].hidden = true
                    runAction(soundSell)
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
        
        if infoButton.containsPoint(location) {
            infoButtonHighlight(true)
        }
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.locationInNode(self)
        
        if settingLayer.hidden == false || infoLayer.hidden == false || confirmBubble.hidden == false { return }
        
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
        
        if infoButton.containsPoint(location) {
            infoButtonHighlight(true)
        } else {
            infoButtonHighlight(false)
        }
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.locationInNode(self)
        
        if settingLayer.hidden == false || infoLayer.hidden == false || confirmBubble.hidden == false { return }
        
        for i in 0...5 {
            if mapsRange[i].containsPoint(location) {
                mapHighlight(0)
                print("Map\(i+1)")
                if !isSoundMute{ runAction(soundAction) }
                
                if !mapUnlockeds[i] {
                    confirmBubble.showBubble(i)
                } else {
                    nowMapNumber = i
                    self.view?.presentScene(islandScene, transition: door_Fade)
                }
            }
        }
        
        if settingButton.containsPoint(location) {
            settingButtonHighlight(false)
            settingLayer.runAction(SKAction.sequence([SKAction.unhide(), SKAction.fadeInWithDuration(0.3)]))
        }
        
        if infoButton.containsPoint(location) {
            infoButtonHighlight(false)
            infoLayer.runAction(SKAction.sequence([SKAction.unhide(), SKAction.fadeInWithDuration(0.3)]))
        }
    }
    
    func infoButtonHighlight(isHighlight: Bool) {
        if infoHighlightFlag != isHighlight {
            infoHighlightFlag = isHighlight
            print("now select info button \(isHighlight)")
            if infoHighlightFlag == true {
                runAction(soundClick)
            }
        }
        if isHighlight {
            infoButton.setScale(framescale * 1.1)
        } else {
            infoButton.setScale(framescale)
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
    
    func showTickAdd() {
        if maps[0].tickAddDone && isFirstShowTickAdd {
            for i in 0..<6 {
                maps[i].tickAddDone = false
            }
            isFirstShowTickAdd = false
            return
        }
        
        for i in 0..<6 {
            if maps[i].tickAddDone {

                let fadeout = SKAction.fadeOutWithDuration(1.5)
                let moveup = SKAction.moveByX(0, y: 100 * framescale, duration: 1.5)
                let group = SKAction.group([fadeout, moveup])
                let tickAction = SKAction.sequence([group, SKAction.removeFromParent()])
                
                if maps[i].money_TickAdd != 0 {
                    let addMoney = SKLabelNode(fontNamed: "SanFranciscoRounded-Black")
                    addMoney.name = "add Money"
                    addMoney.text = "+\(numberToString(maps[i].money_TickAdd))"
                    addMoney.fontColor = colorMoney
                    addMoney.fontSize = 30 * framescale
                    addMoney.position = CGPoint(x: mapsRange[i].position.x, y:mapsRange[i].position.y + 15 * framescale)
                    addMoney.runAction(tickAction)
                    addChild(addMoney)
                }
                
                if maps[i].research_TickAdd != 0 {
                    let addResearch = SKLabelNode(fontNamed: "SanFranciscoRounded-Black")
                    addResearch.name = "add research"
                    addResearch.text = "+\(numberToString(maps[i].research_TickAdd))"
                    addResearch.fontColor = colorResearch
                    addResearch.fontSize = 30 * framescale
                    addResearch.position = CGPoint(x: mapsRange[i].position.x, y:mapsRange[i].position.y - 15 * framescale)
                    addResearch.runAction(tickAction)
                    addChild(addResearch)
                }
                
                maps[i].tickAddDone = false
            }
        }
    }
    
    override func update(currentTime: CFTimeInterval) {
        spentTimeLabel.text = hourToString(spendTime)
        moneyLabel.text = numberToString(money, isInt: true)
        if isShowTickAdd { showTickAdd() }
        confirmBubble.update()
    }
}