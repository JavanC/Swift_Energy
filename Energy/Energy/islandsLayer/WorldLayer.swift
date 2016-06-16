//
//  WorldLayer.swift
//  Energy
//
//  Created by javan.chen on 2016/3/4.
//  Copyright © 2016年 Javan chen. All rights reserved.
//

import SpriteKit

class IslandNode: SKSpriteNode {
    
    var islandNum: Int!
    var selectImg: SKSpriteNode!
    var selectRange: SKShapeNode!
    
    func configureNode(frameSize: CGSize, selectNum: Int, RangePosition: CGPoint, RangeRadius: CGFloat) {
        self.anchorPoint = CGPoint(x: 0, y: 0)
        self.islandNum = selectNum
        
        selectImg = SKSpriteNode(imageNamed: "Maps_select\(selectNum)")
        selectImg.name = "Maps_select\(selectNum)"
        selectImg.size = frameSize
        selectImg.hidden = true
        selectImg.position = CGPoint(x: frameSize.width / 2, y: frameSize.height / 2)
        addChild(selectImg)
        selectRange = SKShapeNode(circleOfRadius: RangeRadius)
        selectRange.name = "Select\(selectNum)Range"
        selectRange.lineWidth = 2
        selectRange.position = RangePosition
        addChild(selectRange)
    }
    func isHighlight(isHighlight: Bool) {
        selectImg.hidden = !isHighlight
    }
}

class WorldLayer: SKNode {
    var frameSize: CGSize!
    var skyBackground: SKSpriteNode!
    
    var clouds: [SKSpriteNode] = []
    var mapsLock: [SKSpriteNode] = []
    var mapsRange: [SKShapeNode] = []
    var mapsSelect: [SKSpriteNode] = []
    var islandNodes: [IslandNode] = []
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
        
        let islandsBackground = SKSpriteNode(imageNamed: "Maps_background")
        islandsBackground.name = "Maps_background"
        islandsBackground.size = frameSize
        islandsBackground.zPosition = -6
        islandsBackground.position = CGPoint(x: frameSize.width / 2, y: frameSize.height / 2)
        addChild(islandsBackground)
        
        let mountain = SKSpriteNode(imageNamed: "Maps_mountain")
        mountain.name = "Maps_mountain"
        mountain.size = frameSize
        mountain.zPosition = -4
        mountain.position = islandsBackground.position
        addChild(mountain)
        
        for i in 1...4 {
            let cloud = SKSpriteNode(imageNamed: "Maps_cloud\(i)")
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
        
        
        var rangePositions: [CGPoint] = []
        rangePositions.append(CGPoint(x: 110 * framescale, y: 160 * framescale))
        rangePositions.append(CGPoint(x: 420 * framescale, y: 220 * framescale))
        rangePositions.append(CGPoint(x: 100 * framescale, y: 400 * framescale))
        rangePositions.append(CGPoint(x: 460 * framescale, y: 500 * framescale))
        rangePositions.append(CGPoint(x: 100 * framescale, y: 610 * framescale))
        rangePositions.append(CGPoint(x: 380 * framescale, y: 720 * framescale))
        rangePositions.append(CGPoint(x: 115 * framescale, y: 920 * framescale))
        let rangeRadius: [CGFloat] = [60, 80, 80, 90, 90, 90, 70]
        
        for i in 1...7 {
            let island = IslandNode()
            island.configureNode(frameSize, selectNum: i, RangePosition: rangePositions[i-1], RangeRadius: rangeRadius[i-1])
            addChild(island)
            islandNodes.append(island)
        }
        
        
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
        timeImg.zPosition = 10
        timeInfo.addChild(timeImg)
        timeLabel = SKLabelNode(fontNamed: "SanFranciscoRounded-Black")
        timeLabel.name = "time label"
        timeLabel.text = "00:00:00"
        timeLabel.fontSize = 30 * framescale
        timeLabel.fontColor = SKColor.whiteColor()
        timeLabel.horizontalAlignmentMode = .Left
        timeLabel.verticalAlignmentMode = .Center
        timeLabel.position = CGPoint(x: -90 * framescale, y: 0)
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
            if nowSelectNum >= 1 && nowSelectNum <= 7 {
                if !isSoundMute{ runAction(soundSelect) }
            }
        }
        
        for i in 0...5 {
            islandNodes[i].isHighlight(false)
        }
        if mapNum >= 1 && mapNum <= 6 {
            islandNodes[mapNum-1].isHighlight(true)
        }
//        if mapNum == 1 {
//            
//        } else {
//            islandNodes[0].isHighlight(false)
//        }
//        for i in 0...0 {
//            islandNodes[i].selectImg.hidden = true
//            mapsSelect[i].hidden = true
//        }
//        if mapNum >= 1 && mapNum <= 6 {
//            islandNodes[mapNum-1].selectImg.hidden = false
//            mapsSelect[mapNum-1].hidden = false
//        }
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
