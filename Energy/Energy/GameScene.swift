//
//  GameScene.swift
//  Energy
//
//  Created by javan.chen on 2015/12/1.
//  Copyright (c) 2015年 Javan chen. All rights reserved.
//

import SpriteKit

enum TouchType: Int {
    case Building, Energy, Reserch, BuildSelect
}

let frame = 5

class GameScene: SKScene {
    var colorEnergy = UIColor(red: 0.519, green: 0.982, blue: 1.000, alpha: 1.000)
    var colorReserch = UIColor(red: 0.231, green: 0.705, blue: 0.275, alpha: 1.000)
    var framescale: CGFloat!
    var gameTimer: NSTimer!
    let tilesize = CGSizeMake(64, 64)
    var tilesScaleSize: CGSize!
    let topsize = CGSizeMake(9, 2)
    let midsize = CGSizeMake(9, 10)
    var topArea: SKSpriteNode!
    var midArea: SKSpriteNode!
    var botArea: SKSpriteNode!
    var touchType: TouchType = .Energy

    // Top
    var money: Int = 10
    var reserch: Int = 0
    var buttonMenu: SKSpriteNode!
    var buttonRebuild: SKSpriteNode!

    // Middle
    var buildingMap: BuildingMap!
    
    // Bottom
    var buttonBuile: SKSpriteNode!
    var buttonEnergy: SKSpriteNode!
    var buttonReserch: SKSpriteNode!

    // Bottom 1 - Information
    var bottomPage_Info: SKSpriteNode!
    var info_Building: Building!
    
    // Bottom 2 - Energy
    var bottomPage_Energy: SKSpriteNode!
    var energy_maxLabel: SKLabelNode!
    var energy_ProgressFront: SKSpriteNode!
    var energy_ProgressBack: SKSpriteNode!

    // Bottom 3 - Build
    var bottomPage_Build: SKSpriteNode!
    var buildSelect: Int = 0
    var buildSelectMenu = [BuildType]()
    var buildSelectPoint = [CGPoint]()
    var buildSelectBox: SKSpriteNode!
    
    var ShowBuildSelectPage: Bool = false
    var buildSelectPage: SKSpriteNode!
    
    // Bottom 4 - Reserch
    
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
        botArea.zPosition = 2
        addChild(botArea)
        
        // Top Area
        let labelgap: CGFloat = 15
        let labelsize = (topArea.size.height - labelgap * 4) / 3
        let labelName = ["energyLabel", "reserchLabel", "moneyLabel"]
        let labelColor = [colorEnergy, colorReserch, SKColor.yellowColor()]
        for i in 1...3 {
            let label = SKLabelNode(fontNamed: "Verdana-Bold")
            label.name = labelName[i - 1]
            label.fontColor = labelColor[i - 1]
            label.fontSize = labelsize
            label.horizontalAlignmentMode = .Left
            label.position = CGPoint(x: labelgap, y: labelgap * CGFloat(i) + labelsize * CGFloat(i - 1))
            topArea.addChild(label)
        }
        buttonMenu = SKSpriteNode(color: SKColor.blackColor(), size: tilesScaleSize)
        buttonMenu.anchorPoint = CGPoint(x: 0, y: 0)
        buttonMenu.position = CGPoint(x: topArea.size.width - 64 * 3 * framescale, y: 64 * framescale)
        topArea.addChild(buttonMenu)
        buttonRebuild = SKSpriteNode(color: SKColor.whiteColor(), size: tilesScaleSize)
        buttonRebuild.anchorPoint = CGPoint(x: 0, y: 0)
        buttonRebuild.position = CGPoint(x: topArea.size.width - 64 * 2 * framescale, y: 64 * framescale)
        topArea.addChild(buttonRebuild)
        
        // Middle Area
        buildingMap = BuildingMap()
        buildingMap.configureAtPosition(CGPoint(x: 0, y: 0), maplevel: .One)
        buildingMap.setScale(framescale)
        midArea.addChild(buildingMap)
        buildingMap.setTileMapElement(coord: CGPoint(x: 0, y: 0), buildType: .Office)
        buildingMap.setTileMapElement(coord: CGPoint(x: 1, y: 0), buildType: .Fire)
        buildingMap.setTileMapElement(coord: CGPoint(x: 2, y: 0), buildType: .Generator)
        buildingMap.setTileMapElement(coord: CGPoint(x: 3, y: 0), buildType: .Generator)
        
        // Bottom Area button
        buttonBuile = SKSpriteNode(color: SKColor.brownColor(), size: CGSize(width: botArea.size.width / 4, height: 100))
        buttonBuile.anchorPoint = CGPoint(x: 0, y: 0)
        buttonBuile.position = CGPoint(x: 0, y: 0)
        buttonBuile.zPosition = 100
        botArea.addChild(buttonBuile)
        buttonEnergy = SKSpriteNode(color: colorEnergy, size: CGSize(width: botArea.size.width / 2, height: 100))
        buttonEnergy.anchorPoint = CGPoint(x: 0, y: 0)
        buttonEnergy.position = CGPoint(x: botArea.size.width / 4, y: 0)
        buttonEnergy.zPosition = 100
        botArea.addChild(buttonEnergy)
        buttonReserch = SKSpriteNode(color: colorReserch, size: CGSize(width: botArea.size.width / 4, height: 100))
        buttonReserch.anchorPoint = CGPoint(x: 0, y: 0)
        buttonReserch.position = CGPoint(x: botArea.size.width * 3 / 4, y: 0)
        buttonReserch.zPosition = 100
        botArea.addChild(buttonReserch)
        
        // Bottom Area 1 - Building information
        bottomPage_Info = SKSpriteNode(color: SKColor.redColor(), size: CGSize(width: botArea.size.width, height: botArea.size.height - 100))
        bottomPage_Info.anchorPoint = CGPoint(x: 0, y: 0)
        bottomPage_Info.position = CGPoint(x: 0, y: -botArea.size.height * 2)
        botArea.addChild(bottomPage_Info)
        let infoImage = buildingImage("infoImage", buildType: .Nil)
        infoImage.position = CGPoint(x: 40 + infoImage.size.width / 2, y: bottomPage_Info.size.height / 2)
        bottomPage_Info.addChild(infoImage)
        let infogap: CGFloat = 15
        let infosize = (bottomPage_Info.size.height - 5 * infogap) / 4
        for i in 1...4 {
            let label = SKLabelNode(fontNamed: "Verdana-Bold")
            label.name = "info\(i)"
            label.fontSize = infosize
            label.horizontalAlignmentMode = .Left
            label.position = CGPoint(x: infoImage.size.width + 80, y: infogap * (5 - CGFloat(i)) + infosize * (4 - CGFloat(i)))
            bottomPage_Info.addChild(label)
        }
        
        // Bottom Area 2 - Energy progress
        bottomPage_Energy = SKSpriteNode(color: SKColor.blueColor(), size: CGSize(width: botArea.size.width, height: botArea.size.height - 100))
        bottomPage_Energy.anchorPoint = CGPoint(x: 0, y: 0)
        bottomPage_Energy.position = CGPoint(x: 0, y: -botArea.size.height * 2)
        botArea.addChild(bottomPage_Energy)
        let energy_ProgressSize = CGSize(width: bottomPage_Energy.size.width * 3 / 4, height: bottomPage_Energy.size.height / 2)
        energy_ProgressBack = SKSpriteNode(color: colorEnergy, size: energy_ProgressSize)
        energy_ProgressBack.alpha = 0.3
        energy_ProgressBack.anchorPoint = CGPoint(x: 0, y: 0.5)
        energy_ProgressBack.position = CGPoint(x: bottomPage_Energy.size.width / 8, y: bottomPage_Energy.size.height / 2)
        bottomPage_Energy.addChild(energy_ProgressBack)
        energy_ProgressFront = SKSpriteNode(color: colorEnergy, size: energy_ProgressSize)
        energy_ProgressFront.alpha = 0.7
        energy_ProgressFront.anchorPoint = CGPoint(x: 0, y: 0.5)
        energy_ProgressFront.position = CGPoint(x: bottomPage_Energy.size.width / 8, y: bottomPage_Energy.size.height / 2)
        bottomPage_Energy.addChild(energy_ProgressFront)
        energy_maxLabel = SKLabelNode(fontNamed: "Verdana-Bold")
        energy_maxLabel.text = "Energy: \(buildingMap.energy) (Max:\(buildingMap.energyMax))"
        energy_maxLabel.fontColor = colorEnergy
        energy_maxLabel.fontSize = labelsize
        energy_maxLabel.horizontalAlignmentMode = .Left
        energy_maxLabel.position = CGPoint(x: bottomPage_Energy.size.width / 8, y: bottomPage_Energy.size.height * 3 / 4 + 10)
        bottomPage_Energy.addChild(energy_maxLabel)
        
        // Bottom Area 3 - Building select
        bottomPage_Build = SKSpriteNode(color: SKColor.brownColor(), size: CGSize(width: botArea.size.width, height: botArea.size.height - 100))
        bottomPage_Build.anchorPoint = CGPoint(x: 0, y: 0)
        bottomPage_Build.position = CGPoint(x: 0, y: -botArea.size.height * 2)
        botArea.addChild(bottomPage_Build)
        let selectGap = (bottomPage_Build.size.width - 5 * tilesScaleSize.width) / 6
        for i in 1...5 {
            buildSelectPoint.append(CGPoint(x: selectGap * CGFloat(i) + tilesScaleSize.width * (0.5 + CGFloat(i - 1)), y: bottomPage_Build.size.height / 2))
        }
        buildSelectMenu = [BuildType]([.Wind, .Fire, .Generator, .Office])
        for i in 1...4 {
            let build = buildingImage("build\(i)", buildType: buildSelectMenu[i - 1])
            build.position = buildSelectPoint[i - 1]
            bottomPage_Build.addChild(build)
        }
        let buildingSell = SKSpriteNode(color: SKColor.yellowColor(), size: tilesScaleSize)
        buildingSell.name = "build5"
        buildingSell.position = buildSelectPoint[4]
        bottomPage_Build.addChild(buildingSell)
        
        buildSelectBox = SKSpriteNode(color: SKColor.redColor(), size: tilesScaleSize)
        buildSelectBox.setScale(1.1)
        buildSelectBox.position = buildSelectPoint[0]
        bottomPage_Build.addChild(buildSelectBox)
        
        buildSelectPage = SKSpriteNode(color: SKColor.blackColor(), size: CGSize(width: midArea.size.width * 4, height: midArea.size.height))
        buildSelectPage.anchorPoint = CGPoint(x: 0, y: 0)
        buildSelectPage.position = CGPoint(x: 0, y: botArea.size.height)
        buildSelectPage.zPosition = -1
        botArea.addChild(buildSelectPage)
        
        
        let building1_6 = BuildingData(buildType: .Wind, level: buildingMap.getBuildingLevel(.Wind))
        let levelinfo1_6 = building1_6.buildingLevelInfo(.Wind)
        let build1_6 = addBuildingSelectElement(.Wind, info1text: levelinfo1_6[0], info2text: levelinfo1_6[1], info3text: levelinfo1_6[2])
        build1_6.position = CGPoint(x:20, y:20)
        buildSelectPage.addChild(build1_6)
        
        let building1_5 = BuildingData(buildType: .Fire, level: buildingMap.getBuildingLevel(.Fire))
        let levelinfo1_5 = building1_5.buildingLevelInfo(.Fire)
        let build1_5 = addBuildingSelectElement(.Fire, info1text: levelinfo1_5[0], info2text: levelinfo1_5[1], info3text: levelinfo1_5[2])
        build1_5.position = CGPoint(x: 20, y: 40 + build1_5.size.height)
        buildSelectPage.addChild(build1_5)

        let building2_6 = BuildingData(buildType: .Wind, level: buildingMap.getBuildingLevel(.Wind))
        let levelinfo2_6 = building2_6.buildingLevelInfo(.Wind)
        let build2_6 = addBuildingSelectElement(.Wind, info1text: levelinfo2_6[0], info2text: levelinfo2_6[1], info3text: levelinfo2_6[2])
        build2_6.position = CGPoint(x:20 + botArea.size.width, y:20)
        buildSelectPage.addChild(build2_6)
        
        // Bottom Area 4 - Reserch upgrade
        
    }
    func buildingImage(name: String, buildType: BuildType) -> SKSpriteNode {
        let buildingImage = SKSpriteNode(imageNamed: BuildingData(buildType: buildType).imageName)
        buildingImage.name = name
        buildingImage.size = tilesScaleSize
        return buildingImage
    }
    func addBuildingSelectElement(buildType: BuildType, info1text: String, info2text: String, info3text: String) -> SKSpriteNode {
        let Gap: CGFloat = 20
        let SelectElementSize = (midArea.size.height - Gap * 7) / 6
        let SpriteNode = SKSpriteNode(color: SKColor.grayColor(), size: CGSize(width: midArea.size.width - Gap * 2, height: SelectElementSize))
        SpriteNode.anchorPoint = CGPoint(x: 0, y: 0)
        
        let buildingImage = SKSpriteNode(imageNamed: BuildingData(buildType: buildType).imageName)
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
                touchType = .Energy
                buttonBuile.alpha = 1
                // menu buttom
                buttonMenu.containsPoint(topAreaLocation)
            }
            
            // Touch Middle Area
            if midArea.containsPoint(location) {
                let midAreaLocation = touch.locationInNode(midArea)
                
                // Touch building Map
                if buildingMap.containsPoint(midAreaLocation) {
                    let buildingmaplocation = touch.locationInNode(buildingMap)
                    let coord = buildingMap.position2Coord(buildingmaplocation)
                    
                    if touchType == .Building || touchType == .Energy || (buildSelect != 4 && buildingMap.buildingForCoord(coord)!.activate) {
                        if buildingMap.buildingForCoord(coord)!.activate {
                            buttonBuile.alpha = 1
                            touchType = .Building
                            info_Building = buildingMap.buildingForCoord(coord)
                        }
                    }
                    
                    if touchType == .BuildSelect {
                        
                        // Sell Building
                        if buildSelect == 4 {
                            if buildingMap.buildingForCoord(coord)!.activate {
                                let price = buildingMap.buildingForCoord(coord)!.buildingData.buildPrice
                                money += price
                                buildingMap.removeBuilding(coord)
                                buildingMap.setTileMapElement(coord: coord, buildType: .Nil)
                            }
                        // build Building
                        } else {
                            let building = buildSelectMenu[buildSelect]
                            let price = BuildingData.init(buildType: building).buildPrice
                            if money >= price {
                                buildingMap.setTileMapElement(coord: coord, buildType: building)
                                money -= price
                            }
                        }
                    }
                }
                // Touch Select Page

            }
            // Touch Bottom Area
            if botArea.containsPoint(location) {
                let bottomLocation = touch.locationInNode(botArea)
                
                // touch build Button
                if buttonBuile.containsPoint(bottomLocation) {
                    touchType = (touchType != .BuildSelect ? .BuildSelect : .Energy)
                }
                if buttonEnergy.containsPoint(bottomLocation) {
                    touchType = .Energy
                }
                if buttonReserch.containsPoint(bottomLocation) {
                    touchType = (touchType != .Reserch ? .Reserch : .Energy)
                }
                // Energy Progress
                if bottomPage_Energy.containsPoint(bottomLocation) {
                    print("sell")
                    money += buildingMap.energy
                    buildingMap.energy = 0
                }
                // BuildSelect
                if bottomPage_Build.containsPoint(bottomLocation) {
                    let nodes = nodesAtPoint(bottomLocation)
                    for node in nodes {
                        for i in 1...5 {
                            if node.name == "build\(i)" {
                                // Change or ReTap
                                if buildSelect != i - 1 {
                                    buildSelect = i - 1
                                    buildSelectBox.position = node.position
                                } else {
                                    ShowBuildSelectPage = !ShowBuildSelectPage
                                }
                                // building sell
                                if buildSelect == 4 {
                                    ShowBuildSelectPage = false
                                }
                            }
                        }
                    }
                }
                // Reserch Upgrade
            }
        }
    }
    
    func floatBottomPage(touchType: TouchType) {
        let Up = SKAction.moveTo(CGPoint(x: 0, y: 100), duration: 0.1)
        let Down = SKAction.moveTo(CGPoint(x: 0, y: -botArea.size.height * 2), duration: 0.1)
        switch touchType {
        case .Building:
            buttonBuile.alpha = 1
            buttonReserch.alpha = 1
            bottomPage_Energy.runAction(Down)
            bottomPage_Build.runAction(Down){ self.bottomPage_Info.runAction(Up) }
        case .BuildSelect:
            buttonBuile.alpha = 0.5
            buttonReserch.alpha = 1
            bottomPage_Energy.runAction(Down)
            bottomPage_Info.runAction(Down){ self.bottomPage_Build.runAction(Up) }
        case .Energy:
            buttonBuile.alpha = 1
            buttonReserch.alpha = 1
            bottomPage_Build.runAction(Down)
            bottomPage_Info.runAction(Down){ self.bottomPage_Energy.runAction(Up) }
        case .Reserch:
            buttonBuile.alpha = 1
            buttonReserch.alpha = 0.5
            break
        }
    }
    func floatBuildSelectPage(On: Bool) {
        let Up = SKAction.moveToY(botArea.size.height, duration: 0.1)
        let Down = SKAction.moveToY(-buildSelectPage.size.height, duration: 0.1)
        if On {
            buildSelectPage.runAction(Up) { self.buildingMap.position = CGPoint(x: self.midArea.size.width, y: 0) }
        } else {
            buildingMap.position = CGPoint(x: 0, y: 0)
            buildSelectPage.runAction(Down)
        }
        buildSelectPage.runAction(SKAction.moveToX(-botArea.size.width * CGFloat(buildSelect), duration: 0.1))
    }
    
    override func update(currentTime: CFTimeInterval) {
        
        floatBottomPage(touchType)
        
        switch touchType {
        case .Building:
            bottomPage_Info.childNodeWithName("infoImage")!.removeFromParent()
            let infobuildType = info_Building.buildingData.buildType
            let infoImage = buildingImage("infoImage", buildType: infobuildType)
            infoImage.position = CGPoint(x: 40 + infoImage.size.width / 2, y: bottomPage_Info.size.height / 2)
            bottomPage_Info.addChild(infoImage)
            let info = info_Building.buildingData.buildingInfo(infobuildType)
            for i in 1 ... 4 {
                (bottomPage_Info.childNodeWithName("info\(i)") as! SKLabelNode).text = ""
            }
            for i in 1...info.count {
                (bottomPage_Info.childNodeWithName("info\(i)") as! SKLabelNode).text = info[i - 1]
            }
            
        case .Energy:
            let persent = CGFloat(buildingMap.energy) / CGFloat(buildingMap.energyMax)
            energy_ProgressFront.xScale = persent
            
        case .BuildSelect:
            break
            
        case .Reserch:
            break
        }
        
        floatBuildSelectPage(ShowBuildSelectPage)
    }
   
    func tickUpdata() {
        // 1. Update map data
        buildingMap.Update()
        
        // 2. Calculate money and reserch
        money += buildingMap.money_TickAdd
        reserch += buildingMap.reserch_TickAdd

        // 3. Updata imformation
        (topArea.childNodeWithName("moneyLabel") as! SKLabelNode).text = "Money: \(money) + \(buildingMap.money_TickAdd)"
        (topArea.childNodeWithName("reserchLabel") as! SKLabelNode).text = "Reserch: \(reserch) + \(buildingMap.reserch_TickAdd)"
        let persent = CGFloat(buildingMap.energy) / CGFloat(buildingMap.energyMax) * 100
        (topArea.childNodeWithName("energyLabel") as! SKLabelNode).text = "Energy: \(persent)%"
        
        energy_maxLabel.text = "Energy: \(buildingMap.energy) (Max:\(buildingMap.energyMax))"
        
        //        save()
    }
//    func save() {
//        defaults.setInteger(money, forKey: "Money")
//    }
}
