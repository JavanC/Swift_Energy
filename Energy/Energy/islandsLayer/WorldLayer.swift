//
//  WorldLayer.swift
//  Energy
//
//  Created by javan.chen on 2016/3/4.
//  Copyright © 2016年 Javan chen. All rights reserved.
//

import SpriteKit

class WorldLayer: SKNode {
    var frameSize: CGSize!
    var skyBackground: SKSpriteNode!
    
    var clouds: [SKSpriteNode] = []
    var mapsLock: [SKSpriteNode] = []
    var mapsRange: [SKShapeNode] = []
    var mapsSelect: [SKSpriteNode] = []
    var nowSelectNum: Int = 0
    
    var isShowTickAdd: Bool = false
    var isFirstShowTickAdd: Bool = true
    
    var moneyLabel: SKLabelNode!
    var researchLabel: SKLabelNode!
    var timeLabel: SKLabelNode!

    init(frameSize: CGSize) {
        self.frameSize = frameSize
        super.init()
        
        skyBackground = SKSpriteNode(imageNamed: "Launch_background")
        skyBackground.name = "skyBackground"
        skyBackground.size = frameSize
        skyBackground.position = CGPoint(x: frameSize.width / 2, y: frameSize.height * 3 / 2)
        addChild(skyBackground)
        
        let emitter = SKEmitterNode(fileNamed: "Starfield.sks")!
        emitter.setScale(framescale)
        emitter.position = CGPoint(x: 0, y: frameSize.height / 2 - 400 * framescale)
        emitter.advanceSimulationTime(40)
        emitter.zPosition = 1
        skyBackground.addChild(emitter)
        
        let islandsBackground = SKSpriteNode(texture: backgroundAtlas.textureNamed("Maps_background"))
        islandsBackground.name = "Maps_background"
        islandsBackground.size = frameSize
        islandsBackground.zPosition = -6
        islandsBackground.position = CGPoint(x: frameSize.width / 2, y: frameSize.height / 2)
        addChild(islandsBackground)
        
        let mountain = SKSpriteNode(texture: mapsAtlas.textureNamed("Maps_mountain"))
        mountain.name = "Maps_mountain"
        mountain.size = frameSize
        mountain.zPosition = -4
        mountain.position = islandsBackground.position
        addChild(mountain)
        
        for i in 1...4 {
            let cloud = SKSpriteNode(texture: mapsAtlas.textureNamed("Maps_cloud\(i)"))
            cloud.name = "Maps_cloud\(i)"
            cloud.size = frameSize
            if i == 3 { cloud.zPosition = -5 }
            if i == 2 { cloud.zPosition = -3 }
            if i == 4 { cloud.zPosition = -2 }
            if i == 1 { cloud.zPosition = -1 }
            cloud.position = islandsBackground.position
            addChild(cloud)
            clouds.append(cloud)
        }
        
        for i in 1...6 {
            let selectMap = SKSpriteNode(texture: mapsAtlas.textureNamed("Maps_select\(i)"))
            selectMap.name = "Maps_select\(i)"
            selectMap.size = frameSize
            selectMap.hidden = true
            selectMap.position = CGPoint(x: frameSize.width / 2, y: frameSize.height / 2)
            addChild(selectMap)
            mapsSelect.append(selectMap)
        }
        
        mapsLock.append(SKSpriteNode())
        for i in 2...6 {
            let lockMap = SKSpriteNode(texture: mapsAtlas.textureNamed("Maps_locked\(i)"))
            lockMap.name = "Maps_locked\(i)"
            lockMap.size = frameSize
            lockMap.hidden = mapUnlockeds[i-1]
            lockMap.position = CGPoint(x: frameSize.width / 2, y: frameSize.height / 2)
            addChild(lockMap)
            mapsLock.append(lockMap)
        }
        
        let map1 = SKShapeNode(circleOfRadius: 60 * framescale)
        map1.name = "map1Range"
        map1.lineWidth = 0
        map1.position = CGPoint(x: 110 * framescale, y: 160 * framescale)
        addChild(map1)
        mapsRange.append(map1)
        let map2 = SKShapeNode(circleOfRadius: 80 * framescale)
        map2.name = "map2Range"
        map2.lineWidth = 0
        map2.position = CGPoint(x: 420 * framescale, y: 220 * framescale)
        addChild(map2)
        mapsRange.append(map2)
        let map3 = SKShapeNode(circleOfRadius: 80 * framescale)
        map3.name = "map3Range"
        map3.lineWidth = 0
        map3.position = CGPoint(x: 100 * framescale, y: 400 * framescale)
        addChild(map3)
        mapsRange.append(map3)
        let map4 = SKShapeNode(circleOfRadius: 90 * framescale)
        map4.name = "map4Range"
        map4.lineWidth = 0
        map4.position = CGPoint(x: 460 * framescale, y: 500 * framescale)
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
        map6.position = CGPoint(x: 380 * framescale, y: 720 * framescale)
        addChild(map6)
        mapsRange.append(map6)
        
        
        let moneyInfo = SKNode()
        moneyInfo.position = CGPoint(x: 84 * framescale, y: 40 * framescale)
        addChild(moneyInfo)
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
        addChild(researchInfo)
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
        addChild(timeInfo)
        let timeBG = SKShapeNode(rectOfSize: CGSizeMake(240 * framescale, 45 * framescale), cornerRadius: 10 * framescale)
        timeBG.fillColor = SKColor.blackColor()
        timeBG.lineWidth = 0
        timeBG.alpha = 0.3
        timeInfo.addChild(timeBG)
        let timeImg = SKSpriteNode(texture: iconAtlas.textureNamed("clock2"))
        timeImg.name = "time image"
        timeImg.size = CGSizeMake(45 * framescale, 45 * framescale)
        timeImg.position = CGPoint(x: -100 * framescale, y: 0)
        timeInfo.addChild(timeImg)
        timeLabel = SKLabelNode(fontNamed: "SanFranciscoRounded-Black")
        timeLabel.name = "time label"
        timeLabel.text = "00:00:00"
        timeLabel.fontSize = 30 * framescale
        timeLabel.fontColor = SKColor.whiteColor()
        timeLabel.horizontalAlignmentMode = .Left
        timeLabel.verticalAlignmentMode = .Center
        timeLabel.position = CGPoint(x: -70 * framescale, y: 0)
        timeInfo.addChild(timeLabel)
    }
    
    func cloudsMove() {
        let p1 = CGPoint(x: 150 * framescale, y: frameSize.height / 2)
        let p2 = CGPoint(x: 0, y: frameSize.height / 2)
        let p3 = CGPoint(x: frameSize.width, y: frameSize.height / 2)
        let p4 = CGPoint(x: frameSize.width - 150 * framescale, y: frameSize.height / 2)
        for i in 0...3 {
            clouds[i].removeAllActions()
        }
        clouds[0].position = CGPoint(x: 250 * framescale, y: frameSize.height / 2)
        clouds[1].position = CGPoint(x: -200 * framescale, y: frameSize.height / 2)
        clouds[2].position = CGPoint(x: frameSize.width / 2 + 100 * framescale, y: frameSize.height / 2)
        clouds[3].position = CGPoint(x: 0 * framescale, y: frameSize.height / 2)
        clouds[0].runAction(SKAction.repeatActionForever(SKAction.sequence([SKAction.moveByX(700 * framescale, y: 0, duration: 80), SKAction.moveTo(p1, duration: 0)])))
        clouds[1].runAction(SKAction.repeatActionForever(SKAction.sequence([SKAction.moveByX(900 * framescale, y: 0,
            duration: 120), SKAction.moveTo(p2, duration: 0)])))
        clouds[2].runAction(SKAction.repeatActionForever(SKAction.sequence([SKAction.moveByX(-700 * framescale, y: 0, duration: 160), SKAction.moveTo(p3, duration: 0)])))
        clouds[3].runAction(SKAction.repeatActionForever(SKAction.sequence([SKAction.moveByX(-700 * framescale, y: 0,
            duration: 100), SKAction.moveTo(p4, duration: 0)])))
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
            mapsSelect[i].hidden = true
        }
        if mapNum >= 1 && mapNum <= 6 {
            mapsSelect[mapNum-1].hidden = false
        }
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
                    addMoney.position = CGPoint(x: mapsRange[i].position.x, y: mapsRange[i].position.y + 15 * framescale)
                    addMoney.runAction(tickAction)
                    addChild(addMoney)
                }
                
                if maps[i].research_TickAdd != 0 {
                    let addResearch = SKLabelNode(fontNamed: "SanFranciscoRounded-Black")
                    addResearch.name = "add research"
                    addResearch.text = "+\(numberToString(maps[i].research_TickAdd))"
                    addResearch.fontColor = colorResearch
                    addResearch.fontSize = 30 * framescale
                    addResearch.position = CGPoint(x: mapsRange[i].position.x, y: mapsRange[i].position.y - 15 * framescale)
                    addResearch.runAction(tickAction)
                    addChild(addResearch)
                }
                
                maps[i].tickAddDone = false
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
