//
//  GameScene.swift
//  Energy
//
//  Created by javan.chen on 2015/12/1.
//  Copyright (c) 2015年 Javan chen. All rights reserved.
//

import SpriteKit

enum TouchType: Int {
    case Nil, Sell, Reserch, Building, BuildSelect
}

class GameScene: SKScene {
    var colorEnergy = UIColor(red: 0.519, green: 0.982, blue: 1.000, alpha: 1.000)
    var colorReserch = UIColor(red: 0.231, green: 0.705, blue: 0.275, alpha: 1.000)
    var framescale: CGFloat!
    var gameTimer: NSTimer!
    let tilesize = CGSizeMake(64, 64)
    var tilesScaleSize: CGSize!
    let topsize = CGSizeMake(9, 2)
    let midsize = CGSizeMake(9, 11)
    var topArea: SKSpriteNode!
    var midArea: SKSpriteNode!
    var botArea: SKSpriteNode!
    var touchType: TouchType = .Nil

    // Top
    var moneyLabel: SKLabelNode!
    var money: Int = 10
    var money_add: Int = 0
    var reserchLabel: SKLabelNode!
    var reserch: Int = 0
    var reserch_add: Int = 0
    var energyLabel: SKLabelNode!
    var energy: Int = 50
    var energy_add: Int = 0
    var energy_max: Int = 100
    var buttonMenu: SKSpriteNode!
    var buttonRebuild: SKSpriteNode!
    var buttonPause: SKSpriteNode!
    var buttonSell: SKSpriteNode!
    var buttonBuile: SKSpriteNode!
    var buttonReserch: SKSpriteNode!
    // Middle
    var buildingMap: BuildingMap!
    
    // Bottom 1
    var bottomPage_Energy: SKSpriteNode!
    var energy_maxLabel: SKLabelNode!
    var energy_ProgressFront: SKSpriteNode!
    var energy_ProgressBack: SKSpriteNode!
    // Bottom 2
    var bottomPage_Info: SKSpriteNode!
    var info_Building: Building!
    // Bottom 3
    var bottomPage_Build: SKSpriteNode!
    var buildSelect: Int = 0
    var buildSelectMenu = [BuildType]()
    var buildSelectPoint = [CGPoint]()
    var buildSelectBox: SKSpriteNode!
    
    var buildSelectPage: SKSpriteNode!
    
    // Bottom 4
    
    //    var defaults: NSUserDefaults!
    
    override func didMoveToView(view: SKView) {
        
        framescale = frame.size.width / (midsize.width * 64)
        tilesScaleSize = CGSize(width: tilesize.width * framescale, height: tilesize.width * framescale)
        
        gameTimer = NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector: "tickUpdata", userInfo: nil, repeats: true)
        //        defaults = NSUserDefaults.standardUserDefaults()
        
        // Add three Area
        topArea = SKSpriteNode(color: SKColor.grayColor(), size: CGSizeMake(frame.size.width, topsize.height * tilesScaleSize.height))
        topArea.name = "topArea"
        topArea.anchorPoint = CGPoint(x: 0, y: 0)
        topArea.position = CGPoint(x: 0, y: frame.size.height - topArea.size.height)
        addChild(topArea)
        midArea = SKSpriteNode(color: SKColor.whiteColor(), size: CGSizeMake(frame.size.width, midsize.height * tilesScaleSize.height))
        midArea.name = "midArea"
        midArea.anchorPoint = CGPoint(x: 0, y: 1)
        midArea.position = CGPoint(x: 0, y: frame.size.height - topArea.size.height)
        addChild(midArea)
        botArea = SKSpriteNode(color: SKColor.grayColor(), size: CGSizeMake(frame.size.width, frame.size.height - (topsize.height + midsize.height) * tilesScaleSize.height))
        botArea.name = "botArea"
        botArea.anchorPoint = CGPoint(x: 0, y: 0)
        botArea.position = CGPoint(x: 0, y: 0)
        botArea.zPosition = 1
        addChild(botArea)
        
        // Top Area
        let labelgap: CGFloat = 15
        let labelsize = (topArea.size.height - labelgap * 4) / 3
        moneyLabel = SKLabelNode(fontNamed: "Verdana-Bold")
        moneyLabel.text = "Money: \(money) + \(money_add)"
        moneyLabel.fontColor = SKColor.yellowColor()
        moneyLabel.fontSize = labelsize
        moneyLabel.horizontalAlignmentMode = .Left
        moneyLabel.position = CGPoint(x: 16, y: labelgap * 3 + labelsize * 2)
        topArea.addChild(moneyLabel)
        reserchLabel = SKLabelNode(fontNamed: "Verdana-Bold")
        reserchLabel.text = "Reserch: \(reserch) + \(reserch_add)"
        reserchLabel.fontColor = colorReserch
        reserchLabel.fontSize = labelsize
        reserchLabel.horizontalAlignmentMode = .Left
        reserchLabel.position = CGPoint(x: 16, y: labelgap * 2 + labelsize * 1)
        topArea.addChild(reserchLabel)
        energyLabel = SKLabelNode(fontNamed: "Verdana-Bold")
        energyLabel.text = "Energy: \(CGFloat(energy) / CGFloat(energy_max) * 100)%"
        energyLabel.fontColor = colorEnergy
        energyLabel.fontSize = labelsize
        energyLabel.horizontalAlignmentMode = .Left
        energyLabel.position = CGPoint(x: 16, y: labelgap * 1 + labelsize * 0)
        topArea.addChild(energyLabel)
        buttonMenu = SKSpriteNode(color: SKColor.blackColor(), size: tilesScaleSize)
        buttonMenu.anchorPoint = CGPoint(x: 0, y: 0)
        buttonMenu.position = CGPoint(x: topArea.size.width - 64 * 3 * framescale, y: 64 * framescale)
        topArea.addChild(buttonMenu)
        buttonRebuild = SKSpriteNode(color: SKColor.grayColor(), size: tilesScaleSize)
        buttonRebuild.anchorPoint = CGPoint(x: 0, y: 0)
        buttonRebuild.position = CGPoint(x: topArea.size.width - 64 * 2 * framescale, y: 64 * framescale)
        topArea.addChild(buttonRebuild)
        buttonPause = SKSpriteNode(color: SKColor.whiteColor(), size: tilesScaleSize)
        buttonPause.anchorPoint = CGPoint(x: 0, y: 0)
        buttonPause.position = CGPoint(x: topArea.size.width - 64 * 1 * framescale, y: 64 * framescale)
        topArea.addChild(buttonPause)
        buttonSell = SKSpriteNode(color: SKColor.yellowColor(), size: tilesScaleSize)
        buttonSell.anchorPoint = CGPoint(x: 0, y: 0)
        buttonSell.position = CGPoint(x: topArea.size.width - 64 * 3 * framescale, y: 0)
        topArea.addChild(buttonSell)
        buttonBuile = SKSpriteNode(color: colorEnergy, size: tilesScaleSize)
        buttonBuile.anchorPoint = CGPoint(x: 0, y: 0)
        buttonBuile.position = CGPoint(x: topArea.size.width - 64 * 2 * framescale, y: 0)
        topArea.addChild(buttonBuile)
        buttonReserch = SKSpriteNode(color: colorReserch, size: tilesScaleSize)
        buttonReserch.anchorPoint = CGPoint(x: 0, y: 0)
        buttonReserch.position = CGPoint(x: topArea.size.width - 64 * 1 * framescale, y: 0)
        topArea.addChild(buttonReserch)
        
        // Middle Area
        buildingMap = BuildingMap()
        buildingMap.configureAtPosition(CGPoint(x: 0, y: 0), maplevel: .One)
        buildingMap.setScale(framescale)
        midArea.addChild(buildingMap)
        buildingMap.setTileMapElement(coord: CGPoint(x: 0, y: 0), buildType: .Office)
        buildingMap.setTileMapElement(coord: CGPoint(x: 1, y: 0), buildType: .Fire)
        buildingMap.setTileMapElement(coord: CGPoint(x: 2, y: 0), buildType: .Generator)
        buildingMap.setTileMapElement(coord: CGPoint(x: 3, y: 0), buildType: .Generator)
        
        // Bottom Area 1 - Energy progress
        let energy_ProgressSize = CGSize(width: botArea.size.width * 3 / 4, height: botArea.size.height / 2)
        bottomPage_Energy = SKSpriteNode(color: SKColor.blueColor(), size: botArea.size)
        bottomPage_Energy.anchorPoint = CGPoint(x: 0, y: 0)
        botArea.addChild(bottomPage_Energy)
        energy_ProgressBack = SKSpriteNode(color: colorEnergy, size: energy_ProgressSize)
        energy_ProgressBack.alpha = 0.3
        energy_ProgressBack.anchorPoint = CGPoint(x: 0, y: 0.5)
        energy_ProgressBack.position = CGPoint(x: botArea.size.width / 8, y: botArea.size.height / 2)
        bottomPage_Energy.addChild(energy_ProgressBack)
        energy_ProgressFront = SKSpriteNode(color: colorEnergy, size: energy_ProgressSize)
        energy_ProgressFront.alpha = 0.7
        energy_ProgressFront.anchorPoint = CGPoint(x: 0, y: 0.5)
        energy_ProgressFront.position = CGPoint(x: botArea.size.width / 8, y: botArea.size.height / 2)
        bottomPage_Energy.addChild(energy_ProgressFront)
        energy_maxLabel = SKLabelNode(fontNamed: "Verdana-Bold")
        energy_maxLabel.text = "Energy: \(energy) (Max:\(energy_max))"
        energy_maxLabel.fontColor = colorEnergy
        energy_maxLabel.fontSize = labelsize
        energy_maxLabel.horizontalAlignmentMode = .Left
        energy_maxLabel.position = CGPoint(x: botArea.size.width / 8, y: botArea.size.height * 3 / 4 + 10)
        bottomPage_Energy.addChild(energy_maxLabel)
        
        // Bottom Area 2 - Building information
        bottomPage_Info = SKSpriteNode(color: SKColor.redColor(), size: botArea.size)
        bottomPage_Info.anchorPoint = CGPoint(x: 0, y: 0)
        bottomPage_Info.position = CGPoint(x: 0, y: -botArea.size.height * 2)
        botArea.addChild(bottomPage_Info)
        let infoImage = buildingImage("infoImage", buildType: .Nil)
        infoImage.position = CGPoint(x: 40 + infoImage.size.width / 2, y: bottomPage_Info.size.height / 2)
        bottomPage_Info.addChild(infoImage)
        let infogap: CGFloat = 15
        let infosize = (botArea.size.height - 6 * infogap) / 5
        for i in 1...5 {
            let label = SKLabelNode(fontNamed: "Verdana-Bold")
            label.name = "info\(i)"
            label.fontSize = infosize
            label.horizontalAlignmentMode = .Left
            label.position = CGPoint(x: infoImage.size.width + 80, y: infogap * (6 - CGFloat(i)) + infosize * (5 - CGFloat(i)))
            bottomPage_Info.addChild(label)
        }
        
        // Bottom Area 3 - Building select
        bottomPage_Build = SKSpriteNode(color: SKColor.brownColor(), size: botArea.size)
        bottomPage_Build.anchorPoint = CGPoint(x: 0, y: 0)
        bottomPage_Build.position = CGPoint(x: 0, y: -botArea.size.height * 2)
        botArea.addChild(bottomPage_Build)
        let selectGap = (botArea.size.width - 4 * tilesScaleSize.width) / 5
        for i in 1...4 {
            buildSelectPoint.append(CGPoint(x: selectGap * CGFloat(i) + tilesScaleSize.width * (0.5 + CGFloat(i - 1)), y: bottomPage_Build.size.height / 2))
        }
        buildSelectMenu = [BuildType]([.Wind, .Fire, .Generator, .Office])
        for i in 1...4 {
            let build = buildingImage("build\(i)", buildType: buildSelectMenu[i - 1])
            build.position = buildSelectPoint[i - 1]
            bottomPage_Build.addChild(build)
        }
        buildSelectBox = SKSpriteNode(color: SKColor.redColor(), size: tilesScaleSize)
        buildSelectBox.setScale(1.1)
        buildSelectBox.position = buildSelectPoint[0]
        bottomPage_Build.addChild(buildSelectBox)
        
        buildSelectPage = SKSpriteNode(color: SKColor.blackColor(), size: midArea.size)
        buildSelectPage.anchorPoint = CGPoint(x: 0, y: 0)
        buildSelectPage.position = CGPoint(x: 0, y: botArea.size.height)
//        botArea.addChild(buildSelectPage)
//        let build1_6 = addBuildingSelectElement(.Wind, info1text: "!23123", info2text: "rwerwer", info3text: "123123123")
//        build1_6.position = CGPoint(x:20, y:20)
//        buildSelectPage.addChild(build1_6)
        // Bottom Area 5 - Reserch upgrade
        
    }
    func buildingImage(name: String, buildType: BuildType) -> SKSpriteNode {
        let buildingImage = SKSpriteNode(imageNamed: BuildingData(buildType: buildType, level: 1).imageName)
        buildingImage.name = name
        buildingImage.size = tilesScaleSize
        return buildingImage
    }
    func addBuildingSelectElement(buildType: BuildType, info1text: String, info2text: String, info3text: String) -> SKSpriteNode {
        
        let Gap: CGFloat = 20
        let SelectElementSize = (midArea.size.height - Gap * 7) / 6
        let SpriteNode = SKSpriteNode(color: SKColor.grayColor(), size: CGSize(width: midArea.size.width - Gap * 2, height: SelectElementSize))
        SpriteNode.anchorPoint = CGPoint(x: 0, y: 0)
        
        let buildingImage = SKSpriteNode(imageNamed: BuildingData(buildType: buildType, level: 1).imageName)
        buildingImage.anchorPoint = CGPoint(x: 0, y: 0.5)
        buildingImage.size = CGSize(width: tilesize.width * framescale, height: tilesize.height * framescale)
        buildingImage.position = CGPoint(x: Gap, y: SpriteNode.size.height / 2)
        SpriteNode.addChild(buildingImage)
        
        let infoGap: CGFloat = 8
        let infoSize = (SpriteNode.size.height - infoGap * 4) / 3
        let infotext = [info1text, info2text, info3text]
        for i in 1...3 {
            let label = SKLabelNode(fontNamed: "Verdana-Bold")
            label.name = "info\(CGFloat(i))"
            label.text = infotext[i - 1]
            label.fontSize = infoSize
            label.horizontalAlignmentMode = .Left
            label.position = CGPoint(x: tilesize.width * framescale + Gap * 2, y: infoGap * (4 - CGFloat(i)) + infoSize * (3 - CGFloat(i)))
            SpriteNode.addChild(label)
        }
        
        let buildingUpgrade = SKSpriteNode(color: SKColor.greenColor(), size: buildingImage.size)
        buildingUpgrade.name = "Upgrade_" + String(buildType)
        buildingUpgrade.anchorPoint = CGPoint(x: 1, y: 0.5)
        buildingUpgrade.position = CGPoint(x: SpriteNode.size.width - Gap, y: SpriteNode.size.height / 2)
        SpriteNode.addChild(buildingUpgrade)
        let buildingDegrade = SKSpriteNode(color: SKColor.redColor(), size: buildingImage.size)
        buildingDegrade.name = "Degrade_" + String(buildType)
        buildingDegrade.anchorPoint = CGPoint(x: 1, y: 0.5)
        buildingDegrade.position = CGPoint(x: SpriteNode.size.width - Gap * 2 - buildingImage.size.width, y: SpriteNode.size.height / 2)
        SpriteNode.addChild(buildingDegrade)
        
        return SpriteNode
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.locationInNode(self)
            
            // Touch Top Area
            if topArea.containsPoint(location) {
                let topAreaLocation = touch.locationInNode(topArea)
                
                // reset touch type
                touchType = .Nil
                buttonSell.alpha = 1
                buttonBuile.alpha = 1
                // touch build Button
                if buttonBuile.containsPoint(topAreaLocation) {
                    touchType = .BuildSelect
                    buttonBuile.alpha = 0.3
                }
                // touch SELL Button
                if buttonSell.containsPoint(topAreaLocation) {
                    touchType = .Sell
                    buttonSell.alpha = 0.3
                }
            }
            
            // Touch Map Area
            if midArea.containsPoint(location) {
                let buildingmaplocation = touch.locationInNode(buildingMap)
                let coord = buildingMap.position2Coord(buildingmaplocation)
                if touchType == .Building || touchType == .Nil || touchType == .BuildSelect {
                    if buildingMap.buildingForCoord(coord)!.activate {
                        buttonSell.alpha = 1
                        buttonBuile.alpha = 1
                        touchType = .Building
                        info_Building = buildingMap.buildingForCoord(coord)
                    }
                }
                
                if touchType == .Sell {
                    if buildingMap.buildingForCoord(coord)!.activate {
                        let price = buildingMap.buildingForCoord(coord)!.buildingData.buildPrice
                        money += price
                        buildingMap.removeBuilding(coord)
                        buildingMap.setTileMapElement(coord: coord, buildType: .Nil)
                    }
                }

                
                if touchType == .BuildSelect {
                    let building = buildSelectMenu[buildSelect]
                    let price = BuildingData.init(buildType: building, level: 1).buildPrice
                    if money >= price {
                        buildingMap.setTileMapElement(coord: coord, buildType: building)
                        money -= price
                    }
                }
            }
            // Touch Bottom Area
            if botArea.containsPoint(location) {
                let bottomLocation = touch.locationInNode(botArea)
                // Energy Progress
                if energy_ProgressBack.containsPoint(bottomLocation) {
                    money += energy
                    energy = 0
                }
                // BuildSelect
                if bottomPage_Build.containsPoint(bottomLocation) {
                    let nodes = nodesAtPoint(bottomLocation)
                    for node in nodes {
                        for i in 1...4 {
                            if node.name == "build\(i)" {
                                buildSelect = i - 1
                                buildSelectBox.position = node.position
                            }
                        }
                    }
                }
            }
        }
    }
    
    func floatBottomPage(pageNum: Int) {
        let Up = SKAction.moveTo(CGPoint(x: 0, y: 0), duration: 0.1)
        let Down = SKAction.moveTo(CGPoint(x: 0, y: -botArea.size.height * 2), duration: 0.1)
        if pageNum == 1 {
            bottomPage_Build.runAction(Down)
            bottomPage_Info.runAction(Down){ self.bottomPage_Energy.runAction(Up) }
        }
        if pageNum == 2 {
            bottomPage_Energy.runAction(Down)
            bottomPage_Build.runAction(Down){ self.bottomPage_Info.runAction(Up) }
        }
        if pageNum == 3 {
            bottomPage_Energy.runAction(Down)
            bottomPage_Info.runAction(Down){ self.bottomPage_Build.runAction(Up) }
        }
    }
    
    override func update(currentTime: CFTimeInterval) {

        switch touchType {
        case .Nil:
            floatBottomPage(1)
            let persent = CGFloat(energy) / CGFloat(energy_max)
            energy_ProgressFront.xScale = persent
            
        case .Sell:
            floatBottomPage(1)
            let persent = CGFloat(energy) / CGFloat(energy_max)
            energy_ProgressFront.xScale = persent
            
        case .Building:
            floatBottomPage(2)
            bottomPage_Info.childNodeWithName("infoImage")!.removeFromParent()
            let infobuildType = info_Building.buildingData.buildType
            let infoImage = buildingImage("infoImage", buildType: infobuildType)
            infoImage.position = CGPoint(x: 40 + infoImage.size.width / 2, y: bottomPage_Info.size.height / 2)
            bottomPage_Info.addChild(infoImage)
            let info = info_Building.buildingData.buildingInfo(infobuildType)
            for i in 1 ... 5 {
                (bottomPage_Info.childNodeWithName("info\(i)") as! SKLabelNode).text = ""
            }
            for i in 1...info.count {
                (bottomPage_Info.childNodeWithName("info\(i)") as! SKLabelNode).text = info[i - 1]
            }
            
        case .BuildSelect:
            floatBottomPage(3)
            
        case .Reserch:
            break
        }
    }
   
    func tickUpdata() {
        // 1. Update map data
        buildingMap.Update()
        
        // 2. Calculate reserch
        reserch += reserch_add
        
        // 3. Calculate energy
        energy_add = 0
        for (_, line) in buildingMap.buildings.enumerate() {
            for (_, building) in line.enumerate() {
                if (building!.activate == true && building?.buildingData.energy_Current != nil) {
                    energy_add += (building?.buildingData.energy_Current)!
                    building?.buildingData.energy_Current = 0
                }
            }
        }
        energy += energy_add
        
        // 4. Calculate money
        money_add = 0
        for (_, line) in buildingMap.buildings.enumerate() {
            for (_, building) in line.enumerate() {
                if (building!.activate == true && building?.buildingData.money_Sales != nil) {
                    money_add += (building?.buildingData.money_Sales)!
                }
            }
        }
        if energy >= money_add {
            money += money_add
            energy -= money_add
        } else {
            money_add = energy
            money += money_add
            energy = 0
        }
        
        // 5. Calculate energy max
        if energy > energy_max {
            energy = energy_max
        }
        
        // 6. Updata imformation
        moneyLabel.text = "Money: \(money) + \(money_add)"
        reserchLabel.text = "Reserch: \(reserch) + \(reserch_add)"
        let persent = CGFloat(energy) / CGFloat(energy_max) * 100
        energyLabel.text = "Energy: \(persent)%"
        energy_maxLabel.text = "Energy: \(energy) (Max:\(energy_max))"
        
        //        save()
    }
//    func save() {
//        defaults.setInteger(money, forKey: "Money")
//    }
}
