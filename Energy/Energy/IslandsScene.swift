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
    var infoHighlightFlag: Bool = false
    var infoLayer: InfoLayer!
    var settingButton: SKSpriteNode!
    var settingHighlightFlag: Bool = false
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
            
            moneyLabel = SKLabelNode(fontNamed: "SanFranciscoRounded-Black")
            moneyLabel.name = "money label"
            moneyLabel.text = numberToString(money, isInt: true)
            moneyLabel.fontSize = 40 * framescale
            moneyLabel.fontColor = colorMoney
            moneyLabel.horizontalAlignmentMode = .Left
            moneyLabel.position = CGPoint(x: 20 * framescale, y: 20 * framescale)
            islandsLayer.addChild(moneyLabel)
            
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
                let move = SKAction.moveTo(CGPoint(x: 0, y:0), duration: 4)
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
        let nodes = nodesAtPoint(location)
        
        if settingLayer.hidden == false || infoLayer.hidden == false || confirmBubble.hidden == false || skyBackground.hidden == false { return }
        
        for node in nodes {
            for i in 0...5 {
                if node == mapsRange[i] {
                    mapHighlight(i+1)
                }
            }
            if node == settingButton {
                settingButtonHighlight(true)
            }
            if node == infoButton {
                infoButtonHighlight(true)
            }
        }
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.locationInNode(self)
        let nodes = nodesAtPoint(location)
        
        if settingLayer.hidden == false || infoLayer.hidden == false || confirmBubble.hidden == false || skyBackground.hidden == false { return }
        
        var inMap = false
        for node in nodes {
            if node.hidden { return }
            
            for i in 0...5 {
                if node == mapsRange[i] {
                    inMap = true
                    mapHighlight(i+1)
                }
            }
            if inMap == false {
                mapHighlight(0)
            }
            
            if node == settingButton {
                settingButtonHighlight(true)
            } else {
                settingButtonHighlight(false)
            }
            
            if node == infoButton {
                infoButtonHighlight(true)
            } else {
                infoButtonHighlight(false)
            }
        }
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.locationInNode(self)
        let nodes = nodesAtPoint(location)
        
        if skyBackground.hidden == false { return }
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
                    lockMaps[confirmBubble.islandNum].hidden = true
                    runAction(soundSell)
                }
            }
            return
        }
        for node in nodes {
            for i in 0...5 {
                if node == mapsRange[i] {
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
            
            if node == settingButton {
                settingButtonHighlight(false)
                settingLayer.runAction(SKAction.sequence([SKAction.unhide(), SKAction.fadeInWithDuration(0.3)]))
            }
            
            if node == infoButton {
                infoButtonHighlight(false)
                infoLayer.runAction(SKAction.sequence([SKAction.unhide(), SKAction.fadeInWithDuration(0.3)]))
            }
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
            infoButton.setScale(framescale * 1.2)
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
            settingButton.setScale(framescale * 1.2)
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