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
    var islandsLayer: SKNode!
    var skyBackground: SKSpriteNode!
    
    var infoButton: SKSpriteNode!
    var infoLayer: InfoLayer!
    var settingButton: SKSpriteNode!
    var settingLayer: SettingLayer!
    var confirmBubble: ConfirmBubble!
    
    var clouds: [SKSpriteNode] = []
    var mapsRange: [SKShapeNode] = []
    var selectMaps: [SKSpriteNode] = []
    var lockMaps: [SKSpriteNode] = []
    var lockSelectMaps: [SKSpriteNode] = []
    var nowSelectNum: Int = 0
    
    var isShowTickAdd: Bool = false
    var isFirstShowTickAdd: Bool = true
    var spentTimeLabel: SKLabelNode!
    var moneyLabel: SKLabelNode!
    var researchLabel: SKLabelNode!
    
    override func didMoveToView(view: SKView) {
        
        if !contentCreated {

            islandsLayer = SKNode()
            islandsLayer.position = CGPoint(x: 0, y: -frame.height)
            addChild(islandsLayer)
            
            skyBackground = SKSpriteNode(imageNamed: "Launch_background")
            skyBackground.name = "skyBackground"
            skyBackground.size = frame.size
            skyBackground.position = CGPoint(x: frame.width / 2, y: frame.height * 3 / 2)
            islandsLayer.addChild(skyBackground)
            
            let emitter = SKEmitterNode(fileNamed: "Starfield.sks")!
            emitter.setScale(framescale)
            emitter.position = CGPoint(x: 0, y: frame.height / 2 - 400 * framescale)
            emitter.advanceSimulationTime(40)
            emitter.zPosition = 1
            skyBackground.addChild(emitter)
            
            let islandsBackground = SKSpriteNode(texture: backgroundAtlas.textureNamed("Maps_background"))
            islandsBackground.name = "Maps_background"
            islandsBackground.size = frame.size
            islandsBackground.zPosition = -6
            islandsBackground.position = CGPoint(x: frame.width / 2, y: frame.height / 2)
            islandsLayer.addChild(islandsBackground)
            
            let mountain = SKSpriteNode(texture: mapsAtlas.textureNamed("Maps_mountain"))
            mountain.name = "Maps_mountain"
            mountain.size = frame.size
            mountain.zPosition = -4
            mountain.position = islandsBackground.position
            islandsLayer.addChild(mountain)
            
            for i in 1...4 {
                let cloud = SKSpriteNode(texture: mapsAtlas.textureNamed("Maps_cloud\(i)"))
                cloud.name = "Maps_cloud\(i)"
                cloud.size = frame.size
                if i == 3 { cloud.zPosition = -5 }
                if i == 2 { cloud.zPosition = -3 }
                if i == 4 { cloud.zPosition = -2 }
                if i == 1 { cloud.zPosition = -1 }
                cloud.position = islandsBackground.position
                islandsLayer.addChild(cloud)
                clouds.append(cloud)
            }
            
            for i in 1...6 {
                let selectMap = SKSpriteNode(texture: mapsAtlas.textureNamed("Maps_unlocked_select\(i)"))
                selectMap.name = "Maps_unlocked_select\(i)"
                selectMap.size = frame.size
                selectMap.hidden = true
                selectMap.position = CGPoint(x: frame.width / 2, y: frame.height / 2)
                islandsLayer.addChild(selectMap)
                selectMaps.append(selectMap)
            }
            
            for i in 1...6 {
                let lockMap = SKSpriteNode(texture: mapsAtlas.textureNamed("Maps_locked_unselect\(i)"))
                lockMap.name = "Maps_locked_unselect\(i)"
                lockMap.size = frame.size
                lockMap.hidden = mapUnlockeds[i-1]
                lockMap.position = CGPoint(x: frame.width / 2, y: frame.height / 2)
                islandsLayer.addChild(lockMap)
                lockMaps.append(lockMap)
            }

            let map1 = SKShapeNode(circleOfRadius: 60 * framescale)
            map1.name = "map1Range"
            map1.lineWidth = 0
            map1.position = CGPoint(x: 110 * framescale, y: 160 * framescale)
            islandsLayer.addChild(map1)
            mapsRange.append(map1)
            let map2 = SKShapeNode(circleOfRadius: 80 * framescale)
            map2.name = "map2Range"
            map2.lineWidth = 0
            map2.position = CGPoint(x: 420 * framescale, y: 220 * framescale)
            islandsLayer.addChild(map2)
            mapsRange.append(map2)
            let map3 = SKShapeNode(circleOfRadius: 80 * framescale)
            map3.name = "map3Range"
            map3.lineWidth = 0
            map3.position = CGPoint(x: 100 * framescale, y: 400 * framescale)
            islandsLayer.addChild(map3)
            mapsRange.append(map3)
            let map4 = SKShapeNode(circleOfRadius: 90 * framescale)
            map4.name = "map4Range"
            map4.lineWidth = 0
            map4.position = CGPoint(x: 460 * framescale, y: 500 * framescale)
            islandsLayer.addChild(map4)
            mapsRange.append(map4)
            let map5 = SKShapeNode(circleOfRadius: 90 * framescale)
            map5.name = "map5Range"
            map5.lineWidth = 0
            map5.position = CGPoint(x: 100 * framescale, y: 610 * framescale)
            islandsLayer.addChild(map5)
            mapsRange.append(map5)
            let map6 = SKShapeNode(circleOfRadius: 90 * framescale)
            map6.name = "map6Range"
            map6.lineWidth = 0
            map6.position = CGPoint(x: 380 * framescale, y: 720 * framescale)
            islandsLayer.addChild(map6)
            mapsRange.append(map6)
            
            confirmBubble = ConfirmBubble(bubbleSize: CGSizeMake(frame.width * 0.8, frame.width * 0.5))
            confirmBubble.alpha = 0
            confirmBubble.hidden = true
            confirmBubble.zPosition = 100
            confirmBubble.position = CGPoint(x: frame.width / 2, y: frame.height / 2)
            islandsLayer.addChild(confirmBubble)
            
            infoButton = SKSpriteNode(texture: iconAtlas.textureNamed("button_info"))
            infoButton.setScale(framescale)
            infoButton.position = CGPoint(x: frame.width - (52 + 64 + 10) * framescale, y: frame.height - 52 * framescale)
            islandsLayer.addChild(infoButton)
            
            infoLayer = InfoLayer(frameSize: frame.size)
            infoLayer.alpha = 0
            infoLayer.hidden = true
            infoLayer.zPosition = 100
            infoLayer.position = CGPoint(x: frame.width / 2, y: frame.height / 2)
            islandsLayer.addChild(infoLayer)

            settingButton = SKSpriteNode(texture: iconAtlas.textureNamed("setting"))
            settingButton.setScale(framescale)
            settingButton.position = CGPoint(x: frame.width - 52 * framescale, y: frame.height - 52 * framescale)
            islandsLayer.addChild(settingButton)
            
            settingLayer = SettingLayer(frameSize: frame.size)
            settingLayer.alpha = 0
            settingLayer.hidden = true
            settingLayer.zPosition = 100
            settingLayer.position = CGPoint(x: frame.width / 2, y: frame.height / 2)
            islandsLayer.addChild(settingLayer)
            
            let moneyInfo = SKNode()
            moneyInfo.position = CGPoint(x: 84 * framescale, y: 40 * framescale)
            islandsLayer.addChild(moneyInfo)
            let moneyBG = SKShapeNode(rectOfSize: CGSizeMake(130 * framescale, 45 * framescale), cornerRadius: 10 * framescale)
            moneyBG.fillColor = SKColor.blackColor()
            moneyBG.lineWidth = 0
            moneyBG.alpha = 0.3
            moneyInfo.addChild(moneyBG)
            let moneyImg = SKSpriteNode(texture: iconAtlas.textureNamed("coint"))
            moneyImg.name = "money image"
            moneyImg.size = CGSizeMake(50 * framescale, 50 * framescale)
            moneyImg.position = CGPoint(x: -45 * framescale, y: 0)
            moneyInfo.addChild(moneyImg)
            moneyLabel = SKLabelNode(fontNamed: "SanFranciscoRounded-Black")
            moneyLabel.name = "money label"
            moneyLabel.text = numberToString(money, isInt: true)
            moneyLabel.fontSize = 30 * framescale
            moneyLabel.fontColor = colorMoney
            moneyLabel.horizontalAlignmentMode = .Center
            moneyLabel.verticalAlignmentMode = .Center
            moneyLabel.position = CGPoint(x: 20 * framescale, y: 0)
            moneyInfo.addChild(moneyLabel)
            
            let researchInfo = SKNode()
            researchInfo.position = CGPoint(x: 233 * framescale, y: 40 * framescale)
            islandsLayer.addChild(researchInfo)
            let researchBG = SKShapeNode(rectOfSize: CGSizeMake(130 * framescale, 45 * framescale), cornerRadius: 10 * framescale)
            researchBG.fillColor = SKColor.blackColor()
            researchBG.lineWidth = 0
            researchBG.alpha = 0.3
            researchInfo.addChild(researchBG)
            let researchImg = SKSpriteNode(texture: iconAtlas.textureNamed("research"))
            researchImg.name = "research image"
            researchImg.size = CGSizeMake(60 * framescale, 60 * framescale)
            researchImg.position = CGPoint(x: -45 * framescale, y: 0)
            researchInfo.addChild(researchImg)
            researchLabel = SKLabelNode(fontNamed: "SanFranciscoRounded-Black")
            researchLabel.name = "research label"
            researchLabel.text = numberToString(research, isInt: true)
            researchLabel.fontSize = 30 * framescale
            researchLabel.fontColor = colorResearch
            researchLabel.horizontalAlignmentMode = .Center
            researchLabel.verticalAlignmentMode = .Center
            researchLabel.position = CGPoint(x: 20 * framescale, y: 0)
            researchInfo.addChild(researchLabel)
    
            let timeInfo = SKNode()
            timeInfo.position = CGPoint(x: 437 * framescale, y: 40 * framescale)
            islandsLayer.addChild(timeInfo)
            let timeBG = SKShapeNode(rectOfSize: CGSizeMake(240 * framescale, 45 * framescale), cornerRadius: 10 * framescale)
            timeBG.fillColor = SKColor.blackColor()
            timeBG.lineWidth = 0
            timeBG.alpha = 0.3
            timeInfo.addChild(timeBG)
            let timeImg = SKSpriteNode(texture: iconAtlas.textureNamed("clock"))
            timeImg.name = "time image"
            timeImg.size = CGSizeMake(45 * framescale, 45 * framescale)
            timeImg.position = CGPoint(x: -100 * framescale, y: 0)
            timeInfo.addChild(timeImg)
            spentTimeLabel = SKLabelNode(fontNamed: "SanFranciscoRounded-Black")
            spentTimeLabel.name = "time label"
            spentTimeLabel.text = hourToString(spendTime)
            spentTimeLabel.fontSize = 30 * framescale
            spentTimeLabel.fontColor = SKColor.whiteColor()
            spentTimeLabel.horizontalAlignmentMode = .Left
            spentTimeLabel.verticalAlignmentMode = .Center
            spentTimeLabel.position = CGPoint(x: -70 * framescale, y: 0)
            timeInfo.addChild(spentTimeLabel)
            
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
            RunAfterDelay(2){
                let move = SKAction.moveTo(CGPoint(x: 0, y:0), duration: 0)
//                let move = SKAction.moveTo(CGPoint(x: 0, y:0), duration: 4)
                let wait = SKAction.waitForDuration(4)
                let hide = SKAction.hide()
                self.islandsLayer.runAction(SKAction.sequence([move]))
                self.skyBackground.runAction(SKAction.sequence([wait, hide]))
            }
            isShowTickAdd = false
            isFirstShowTickAdd = true
            cloudsMove()
            RunAfterDelay(9) {
                self.isShowTickAdd = true
            }
            print("load 10")
            loadingNum = 2
        default:
            isShowTickAdd = false
            isFirstShowTickAdd = true
            cloudsMove()
            RunAfterDelay(3) {
                self.isShowTickAdd = true
            }
            print("load 10")
        }
    }
    
    func cloudsMove() {
        let p1 = CGPoint(x: 150 * framescale, y: frame.height / 2)
        let p2 = CGPoint(x: 0, y: frame.height / 2)
        let p3 = CGPoint(x: frame.width, y: frame.height / 2)
        let p4 = CGPoint(x: frame.width - 150 * framescale, y: frame.height / 2)
        for i in 0...3 {
            clouds[i].removeAllActions()
        }
        clouds[0].position = CGPoint(x: 250 * framescale, y: frame.height / 2)
        clouds[1].position = CGPoint(x: -200 * framescale, y: frame.height / 2)
        clouds[2].position = CGPoint(x: frame.width / 2 + 100 * framescale, y: frame.height / 2)
        clouds[3].position = CGPoint(x: 0 * framescale, y: frame.height / 2)
        clouds[0].runAction(SKAction.repeatActionForever(SKAction.sequence([SKAction.moveByX(700 * framescale, y: 0, duration: 80), SKAction.moveTo(p1, duration: 0)])))
        clouds[1].runAction(SKAction.repeatActionForever(SKAction.sequence([SKAction.moveByX(900 * framescale, y: 0,
            duration: 120), SKAction.moveTo(p2, duration: 0)])))
        clouds[2].runAction(SKAction.repeatActionForever(SKAction.sequence([SKAction.moveByX(-700 * framescale, y: 0, duration: 160), SKAction.moveTo(p3, duration: 0)])))
        clouds[3].runAction(SKAction.repeatActionForever(SKAction.sequence([SKAction.moveByX(-700 * framescale, y: 0,
            duration: 100), SKAction.moveTo(p4, duration: 0)])))
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.locationInNode(self)
        
        if skyBackground.hidden == false { return }
        
        if infoLayer.hidden == false {
            let NodePosition = convertPoint(location, toNode: infoLayer)
            if infoLayer.saveButton.containsPoint(NodePosition) { infoLayer.saveButton.alpha = 0.7 }
            return
        }
        if settingLayer.hidden == false {
            let NodePosition = convertPoint(location, toNode: settingLayer)
            if settingLayer.soundButton.containsPoint(NodePosition) { settingLayer.soundButton.alpha = 0.7 }
            if settingLayer.musicButton.containsPoint(NodePosition) { settingLayer.musicButton.alpha = 0.7 }
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
            if mapsRange[i].containsPoint(location) {
                mapHighlight(i+1)
            }
        }
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.locationInNode(self)
        
        if skyBackground.hidden == false { return }
        
        if infoLayer.hidden == false {
            let NodePosition = convertPoint(location, toNode: infoLayer)
            infoLayer.saveButton.alpha = infoLayer.saveButton.containsPoint(NodePosition) ? 0.7 : 1
            return
        }
        if settingLayer.hidden == false {
            let NodePosition = convertPoint(location, toNode: settingLayer)
            settingLayer.soundButton.alpha = settingLayer.soundButton.containsPoint(NodePosition) ? 0.7 : 1
            settingLayer.musicButton.alpha = settingLayer.musicButton.containsPoint(NodePosition) ? 0.7 : 1
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
            if mapsRange[i].containsPoint(location) {
                inMap = true
                mapHighlight(i+1)
            }
        }
        if inMap == false {
            mapHighlight(0)
        }
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.locationInNode(self)
        let nodes = nodesAtPoint(location)
        
        if skyBackground.hidden == false { return }
        
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
                    confirmBubble.OKButton.alpha = 1
                    confirmBubble.cancelButton.alpha = 1
                    confirmBubble.buyButton.alpha = 1
                    confirmBubble.hideBubble()
                    runAction(soundTap)
                }
                if node == confirmBubble.buyButton {
                    confirmBubble.OKButton.alpha = 1
                    confirmBubble.cancelButton.alpha = 1
                    confirmBubble.buyButton.alpha = 1
                    confirmBubble.alpha = 1
                    confirmBubble.hidden = true
                    money -= confirmBubble.buyPrice
                    mapUnlockeds[confirmBubble.islandNum] = true
                    lockMaps[confirmBubble.islandNum].hidden = true
                    runAction(soundSell)
                }
            }
            return
        }
        
        if settingButton.containsPoint(location) {
            settingButton.alpha = 1
            settingLayer.runAction(SKAction.sequence([SKAction.unhide(), SKAction.fadeInWithDuration(0.3)]))
        }
        
        if infoButton.containsPoint(location) {
            infoButton.alpha = 1
            infoLayer.runAction(SKAction.sequence([SKAction.unhide(), SKAction.fadeInWithDuration(0.3)]))
        }
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
    }
    
    func mapHighlight(mapNum: Int) {
        if nowSelectNum != mapNum {
            nowSelectNum = mapNum
            print("now select \(nowSelectNum)")
            if nowSelectNum >= 1 && nowSelectNum <= 6 {
                runAction(soundSelect)
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
            timeString += "\(day)8D "
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
        researchLabel.text = numberToString(research, isInt: true)
        if isShowTickAdd { showTickAdd() }
        confirmBubble.update()
    }
}