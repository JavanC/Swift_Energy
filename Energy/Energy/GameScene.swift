//
//  GameScene.swift
//  Energy
//
//  Created by javan.chen on 2015/12/1.
//  Copyright (c) 2015年 Javan chen. All rights reserved.
//

import SpriteKit

enum TouchType: Int {
    case Nil, Sell, Reserch, Building, Build1, Build2, Build3, Build4
}

class GameScene: SKScene {
    var colorEnergy = UIColor(red: 0.519, green: 0.982, blue: 1.000, alpha: 1.000)
    var colorReserch = UIColor(red: 0.231, green: 0.705, blue: 0.275, alpha: 1.000)
    var framescale: CGFloat!
    var gameTimer: NSTimer!
    let tilesize = CGSizeMake(64, 64)
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
    var energy_Progress: SKSpriteNode!
    var energy_maxLabel: SKLabelNode!
    var energy_ProgressFront: SKSpriteNode!
    var energy_ProgressBack: SKSpriteNode!
    // Bottom 2
    var info: SKSpriteNode!
    var info_Building: Building!
    var info_1: SKLabelNode!
    var info_2: SKLabelNode!
    var info_3: SKLabelNode!
    var info_4: SKLabelNode!
    // Bottom 3
    var buildSelect: SKSpriteNode!
    var buildBox: SKSpriteNode!
    var build1: SKSpriteNode!
    var build1_select: BuildMenu!
    var build2: SKSpriteNode!
    var build2_select: BuildMenu!
    var build3: SKSpriteNode!
    var build3_select: BuildMenu!
    var build4: SKSpriteNode!
    var build4_select: BuildMenu!
    
    var buildSelectPage: SKSpriteNode!
    var buildSelectInfo: SKSpriteNode!
    
    // Bottom 4
    
    //    var defaults: NSUserDefaults!
    
    override func didMoveToView(view: SKView) {
        
        framescale = frame.size.width / (midsize.width * 64)
        gameTimer = NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector: "tickUpdata", userInfo: nil, repeats: true)
        //        defaults = NSUserDefaults.standardUserDefaults()
        
        // Add three Area
        topArea = SKSpriteNode(color: SKColor.grayColor(), size: CGSizeMake(frame.size.width, topsize.height * tilesize.height * framescale))
        topArea.name = "topArea"
        topArea.anchorPoint = CGPoint(x: 0, y: 0)
        topArea.position = CGPoint(x: 0, y: frame.size.height - topArea.size.height)
        addChild(topArea)
        midArea = SKSpriteNode(color: SKColor.whiteColor(), size: CGSizeMake(frame.size.width, midsize.height * tilesize.height * framescale))
        midArea.name = "midArea"
        midArea.anchorPoint = CGPoint(x: 0, y: 1)
        midArea.position = CGPoint(x: 0, y: frame.size.height - topArea.size.height)
        addChild(midArea)
        botArea = SKSpriteNode(color: SKColor.grayColor(), size: CGSizeMake(frame.size.width, frame.size.height - (topsize.height + midsize.height) * tilesize.height * framescale))
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
        let persent = CGFloat(energy) / CGFloat(energy_max) * 100
        energyLabel = SKLabelNode(fontNamed: "Verdana-Bold")
        energyLabel.text = "Energy: \(persent)%"
        energyLabel.fontColor = colorEnergy
        energyLabel.fontSize = labelsize
        energyLabel.horizontalAlignmentMode = .Left
        energyLabel.position = CGPoint(x: 16, y: labelgap * 1 + labelsize * 0)
        topArea.addChild(energyLabel)
        buttonMenu = SKSpriteNode(color: SKColor.blackColor(), size: CGSize(width: 64 * framescale, height: 64 * framescale))
        buttonMenu.anchorPoint = CGPoint(x: 0, y: 0)
        buttonMenu.position = CGPoint(x: topArea.size.width - 64 * 3 * framescale, y: 64 * framescale)
        topArea.addChild(buttonMenu)
        buttonRebuild = SKSpriteNode(color: SKColor.grayColor(), size: CGSize(width: 64 * framescale, height: 64 * framescale))
        buttonRebuild.anchorPoint = CGPoint(x: 0, y: 0)
        buttonRebuild.position = CGPoint(x: topArea.size.width - 64 * 2 * framescale, y: 64 * framescale)
        topArea.addChild(buttonRebuild)
        buttonPause = SKSpriteNode(color: SKColor.whiteColor(), size: CGSize(width: 64 * framescale, height: 64 * framescale))
        buttonPause.anchorPoint = CGPoint(x: 0, y: 0)
        buttonPause.position = CGPoint(x: topArea.size.width - 64 * 1 * framescale, y: 64 * framescale)
        topArea.addChild(buttonPause)
        buttonSell = SKSpriteNode(color: SKColor.yellowColor(), size: CGSize(width: 64 * framescale, height: 64 * framescale))
        buttonSell.anchorPoint = CGPoint(x: 0, y: 0)
        buttonSell.position = CGPoint(x: topArea.size.width - 64 * 3 * framescale, y: 0)
        topArea.addChild(buttonSell)
        buttonBuile = SKSpriteNode(color: colorEnergy, size: CGSize(width: 64 * framescale, height: 64 * framescale))
        buttonBuile.anchorPoint = CGPoint(x: 0, y: 0)
        buttonBuile.position = CGPoint(x: topArea.size.width - 64 * 2 * framescale, y: 0)
        topArea.addChild(buttonBuile)
        buttonReserch = SKSpriteNode(color: colorReserch, size: CGSize(width: 64 * framescale, height: 64 * framescale))
        buttonReserch.anchorPoint = CGPoint(x: 0, y: 0)
        buttonReserch.position = CGPoint(x: topArea.size.width - 64 * 1 * framescale, y: 0)
        topArea.addChild(buttonReserch)
        
        // Middle Area
        buildingMap = BuildingMap()
        buildingMap.configureAtPosition(CGPoint(x: 0, y: 0), maplevel: .One)
        buildingMap.setScale(framescale)
        midArea.addChild(buildingMap)
        buildingMap.setTileMapElement(coord: CGPoint(x: 0, y: 0), buildMenu: .Office)
        buildingMap.setTileMapElement(coord: CGPoint(x: 1, y: 0), buildMenu: .Fire)
        buildingMap.setTileMapElement(coord: CGPoint(x: 2, y: 0), buildMenu: .Generator)
        buildingMap.setTileMapElement(coord: CGPoint(x: 3, y: 0), buildMenu: .Generator)
        
        // Bottom Area 1 - Energy progress
        let energy_ProgressSize = CGSize(width: botArea.size.width * 3 / 4, height: botArea.size.height / 2)
        energy_Progress = SKSpriteNode(color: SKColor.blueColor(), size: botArea.size)
        energy_Progress.anchorPoint = CGPoint(x: 0, y: 0)
        botArea.addChild(energy_Progress)
        energy_ProgressBack = SKSpriteNode(color: colorEnergy, size: energy_ProgressSize)
        energy_ProgressBack.alpha = 0.3
        energy_ProgressBack.anchorPoint = CGPoint(x: 0, y: 0.5)
        energy_ProgressBack.position = CGPoint(x: botArea.size.width / 8, y: botArea.size.height / 2)
        energy_Progress.addChild(energy_ProgressBack)
        energy_ProgressFront = SKSpriteNode(color: colorEnergy, size: energy_ProgressSize)
        energy_ProgressFront.alpha = 0.7
        energy_ProgressFront.anchorPoint = CGPoint(x: 0, y: 0.5)
        energy_ProgressFront.position = CGPoint(x: botArea.size.width / 8, y: botArea.size.height / 2)
        energy_Progress.addChild(energy_ProgressFront)
        energy_maxLabel = SKLabelNode(fontNamed: "Verdana-Bold")
        energy_maxLabel.text = "Energy: \(energy) (Max:\(energy_max))"
        energy_maxLabel.fontColor = colorEnergy
        energy_maxLabel.fontSize = labelsize
        energy_maxLabel.horizontalAlignmentMode = .Left
        energy_maxLabel.position = CGPoint(x: botArea.size.width / 8, y: botArea.size.height * 3 / 4 + 10)
        energy_Progress.addChild(energy_maxLabel)
        
        // Bottom Area 2 - Building information
        let infogap: CGFloat = 15
        let infosize = (botArea.size.height - 5 * infogap) / 4
        info = SKSpriteNode(color: SKColor.redColor(), size: botArea.size)
        info.anchorPoint = CGPoint(x: 0, y: 0)
        info.position = CGPoint(x: 0, y: -botArea.size.height * 2)
        botArea.addChild(info)
        info_1 = SKLabelNode(fontNamed: "Verdana-Bold")
        info_1.fontSize = infosize
        info_1.horizontalAlignmentMode = .Left
        info_1.position = CGPoint(x: infogap * 2, y: infogap * 4 + infosize * 3)
        info.addChild(info_1)
        info_2 = SKLabelNode(fontNamed: "Verdana-Bold")
        info_2.fontSize = infosize
        info_2.horizontalAlignmentMode = .Left
        info_2.position = CGPoint(x: infogap * 2, y: infogap * 3 + infosize * 2)
        info.addChild(info_2)
        info_3 = SKLabelNode(fontNamed: "Verdana-Bold")
        info_3.fontSize = infosize
        info_3.horizontalAlignmentMode = .Left
        info_3.position = CGPoint(x: infogap * 2, y: infogap * 2 + infosize * 1)
        info.addChild(info_3)
        info_4 = SKLabelNode(fontNamed: "Verdana-Bold")
        info_4.fontSize = infosize
        info_4.horizontalAlignmentMode = .Left
        info_4.position = CGPoint(x: infogap * 2, y: infogap * 1)
        info.addChild(info_4)
        
        // Bottom Area 3 - Building select
        buildSelect = SKSpriteNode(color: SKColor.brownColor(), size: botArea.size)
        buildSelect.anchorPoint = CGPoint(x: 0, y: 0)
        buildSelect.position = CGPoint(x: 0, y: -botArea.size.height * 2)
        botArea.addChild(buildSelect)
        build1 = SKSpriteNode()
        build1.name = "build1"
        build1.position = CGPoint(x: buildSelect.size.width * 1 / 8, y: buildSelect.size.height / 2)
        buildSelect.addChild(build1)
        build2 = SKSpriteNode()
        build2.name = "build2"
        build2.position = CGPoint(x: buildSelect.size.width * 3 / 8, y: buildSelect.size.height / 2)
        buildSelect.addChild(build2)
        build3 = SKSpriteNode()
        build3.name = "build3"
        build3.position = CGPoint(x: buildSelect.size.width * 5 / 8, y: buildSelect.size.height / 2)
        buildSelect.addChild(build3)
        build4 = SKSpriteNode()
        build4.name = "build4"
        build4.position = CGPoint(x: buildSelect.size.width * 7 / 8, y: buildSelect.size.height / 2)
        buildSelect.addChild(build4)
        buildBox = SKSpriteNode(color: SKColor.redColor(), size: CGSize(width: tilesize.width * framescale * 1.1, height: tilesize.height * framescale * 1.1))
        buildBox.position = build1.position
        buildSelect.addChild(buildBox)
        
        build1_select = .Wind
        let build1_selectNode = SKSpriteNode(imageNamed: "風力")
        build1_selectNode.size = CGSize(width: tilesize.width * framescale, height: tilesize.height * framescale)
        build1.addChild(build1_selectNode)
        build2_select = .Fire
        let build2_selectNode = SKSpriteNode(imageNamed: "火力")
        build2_selectNode.size = CGSize(width: tilesize.width * framescale, height: tilesize.height * framescale)
        build2.addChild(build2_selectNode)
        build3_select = .Generator
        let build3_selectNode = SKSpriteNode(imageNamed: "發電機1")
        build3_selectNode.size = CGSize(width: tilesize.width * framescale, height: tilesize.height * framescale)
        build3.addChild(build3_selectNode)
        build4_select = .Office
        let build4_selectNode = SKSpriteNode(imageNamed: "辦公室1")
        build4_selectNode.size = CGSize(width: tilesize.width * framescale, height: tilesize.height * framescale)
        build4.addChild(build4_selectNode)
        
        buildSelectPage = SKSpriteNode(color: SKColor.blackColor(), size: midArea.size)
        buildSelectPage.anchorPoint = CGPoint(x: 0, y: 0)
        buildSelectPage.position = CGPoint(x: 0, y: botArea.size.height)
        botArea.addChild(buildSelectPage)
        
        buildSelectInfo = AddBuildingSelectElement(.Wind, info1text: "123123", info2text: "12313123", info3text: "13123123")
        buildSelectInfo.position = CGPoint(x: 20, y: 20)
        buildSelectPage.addChild(buildSelectInfo)
        
        

        
        
        
        
//        var buildingUpgrade: SKLabelNode!
//        var buildingDegrade: SKLabelNode!
        
        
        
//        var buildInfo: SKSpriteNode!
//        var buildImage: SKSpriteNode!
//        var buildData: SKSpriteNode!
//        var buildingUpgrade: SKLabelNode!
//        var buildingDegrade: SKLabelNode!
        
        
//        buildingImage = SKSpriteNode(imageNamed: "風力")
//        buildingImage.size = CGSize(width: tilesize.width * framescale, height: tilesize.height * framescale)
//        buildingImage.anchorPoint = CGPoint(x: 0, y: 0.5)
//        buildingImage.position = CGPoint(x: 30, y: buildingSelect.size.height / 2)
//        buildingSelect.addChild(buildingImage)
//        buildingmenu = SKSpriteNode(color: SKColor.whiteColor(), size: CGSize(width: buildingImage.size.width, height: buildingImage.size.height / 2))
//        buildingmenu.anchorPoint = CGPoint(x: 0, y: 0)
//        buildingmenu.position = CGPoint(x: 0, y: buildingImage.size.height / 2)
//        buildingImage.addChild(buildingmenu)
//        buildingInfo = SKLabelNode(fontNamed: "Verdana-Blod")
        
        
        
        
//        var buildingInfo: SKLabelNode!
//        var buildingUpgrade: SKLabelNode!
//        var buildingDegrade: SKLabelNode!
        
        // Bottom Area 5 - Reserch upgrade
        
    }
    
    func AddBuildingSelectElement(buildMenu: BuildMenu, info1text: String, info2text: String, info3text: String) -> SKSpriteNode {
        
        let Gap: CGFloat = 20
        let SpriteNode = SKSpriteNode(color: SKColor.grayColor(), size: CGSize(width: midArea.size.width - Gap * 2, height: (midArea.size.height - Gap * 7) / 6))
        SpriteNode.anchorPoint = CGPoint(x: 0, y: 0)
        
        let buildingImage = SKSpriteNode(imageNamed: BuildingData(building: buildMenu, level: 1).imageName)
        buildingImage.anchorPoint = CGPoint(x: 0, y: 0.5)
        buildingImage.size = CGSize(width: tilesize.width * framescale, height: tilesize.height * framescale)
        buildingImage.position = CGPoint(x: Gap, y: SpriteNode.size.height / 2)
        SpriteNode.addChild(buildingImage)
        
        let infoGap: CGFloat = 8
        let infoSize = (SpriteNode.size.height - infoGap * 4) / 3
        let Info1 = SKLabelNode(fontNamed: "Verdana-Bold")
        Info1.text = info1text
        Info1.fontSize = infoSize
        Info1.horizontalAlignmentMode = .Left
        Info1.position = CGPoint(x: tilesize.width * framescale + Gap * 2, y: infoGap * 3 + infoSize * 2)
        SpriteNode.addChild(Info1)
        let info2 = SKLabelNode(fontNamed: "Verdana-Bold")
        info2.text = info2text
        info2.fontSize = infoSize
        info2.horizontalAlignmentMode = .Left
        info2.position = CGPoint(x: tilesize.width * framescale + Gap * 2, y: infoGap * 2 + infoSize * 1)
        SpriteNode.addChild(info2)
        let info3 = SKLabelNode(fontNamed: "Verdana-Bold")
        info3.text = info3text
        info3.fontSize = infoSize
        info3.horizontalAlignmentMode = .Left
        info3.position = CGPoint(x: tilesize.width * framescale + Gap * 2, y: infoGap * 1)
        SpriteNode.addChild(info3)
        
        let buildingUpgrade = SKSpriteNode(color: SKColor.greenColor(), size: buildingImage.size)
        buildingUpgrade.anchorPoint = CGPoint(x: 1, y: 0.5)
        buildingUpgrade.position = CGPoint(x: SpriteNode.size.width - Gap, y: SpriteNode.size.height / 2)
        SpriteNode.addChild(buildingUpgrade)
        let buildingDegrade = SKSpriteNode(color: SKColor.redColor(), size: buildingImage.size)
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
                    touchType = .Build1
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
                print(coord)
                
                
                if touchType == .Building || touchType == .Nil || touchType == .Build1 || touchType == .Build2 || touchType == .Build3 || touchType == .Build4 {
                    if buildingMap.buildingForCoord(coord)!.activate {
                        buttonSell.alpha = 1
                        buttonBuile.alpha = 1
                        touchType = .Building
                        info_Building = buildingMap.buildingForCoord(coord)
                    }
                }
                
                if touchType == .Sell {
                    if buildingMap.buildingForCoord(coord)!.activate {
                        let price = buildingMap.buildingForCoord(coord)!.buildingData.price
                        money += price
                        buildingMap.removeBuilding(coord)
                        buildingMap.setTileMapElement(coord: coord, buildMenu: .Nil)
                    }
                }

                
                if touchType == .Build1 {
                    let building = build1_select
                    let price = BuildingData.init(building: building, level: 1).price
                    if money >= price {
                        buildingMap.setTileMapElement(coord: coord, buildMenu: building)
                        money -= price
                    }
                }
                if touchType == .Build2 {
                    let building = build2_select
                    let price = BuildingData.init(building: building, level: 1).price
                    if money >= price {
                        buildingMap.setTileMapElement(coord: coord, buildMenu: building)
                        money -= price
                    }
                }
                if touchType == .Build3 {
                    let building = build3_select
                    let price = BuildingData.init(building: building, level: 1).price
                    if money >= price {
                        buildingMap.setTileMapElement(coord: coord, buildMenu: building)
                        money -= price
                    }
                }
                if touchType == .Build4 {
                    let building = build4_select
                    let price = BuildingData.init(building: building, level: 1).price
                    if money >= price {
                        buildingMap.setTileMapElement(coord: coord, buildMenu: building)
                        money -= price
                    }
                }
            }
            // Touch Bottom Area
            if botArea.containsPoint(location) {
                let bottomLocation = touch.locationInNode(botArea)
                if touchType == .Sell {
                    if energy_Progress.containsPoint(bottomLocation) {
                        money += energy
                        energy = 0
                    }
                }
                if buildSelect.containsPoint(bottomLocation) {
                    if build1.containsPoint(bottomLocation) {
                        touchType = .Build1
                    }
                    if build2.containsPoint(bottomLocation) {
                        touchType = .Build2
                    }
                    if build3.containsPoint(bottomLocation) {
                        touchType = .Build3
                    }
                    if build4.containsPoint(bottomLocation) {
                        touchType = .Build4
                    }
                }
            }
        }
    }
    
    override func update(currentTime: CFTimeInterval) {
        let Up = SKAction.moveTo(CGPoint(x: 0, y: 0), duration: 0.1)
        let Down = SKAction.moveTo(CGPoint(x: 0, y: -botArea.size.height * 2), duration: 0.1)
        // Touch nil & sell
        if touchType == .Nil || touchType == .Sell {
            buildSelect.runAction(Down)
            info.runAction(Down){ self.energy_Progress.runAction(Up) }
            
            let persent = CGFloat(energy) / CGFloat(energy_max)
            energy_ProgressFront.xScale = persent
        }
        // Touch building
        if touchType == .Building {
            energy_Progress.runAction(Down)
            buildSelect.runAction(Down){ self.info.runAction(Up) }
            
            if info_Building.buildMenu == .Wind {
                info_1.text = "Time: \(info_Building.buildingData.time_Current) / \(info_Building.buildingData.time_Max)"
                info_2.text = "Produce Energy: \(info_Building.buildingData.hot2Energy_Max)"
                info_3.text = "Sell Money: \(info_Building.buildingData.price)"
            }
            if info_Building.buildMenu == .Fire {
                info_1.text = "Time: \(info_Building.buildingData.time_Current) / \(info_Building.buildingData.time_Max)"
                info_2.text = "Produce Hot: \(info_Building.buildingData.hot_Produce)"
                info_3.text = "Sell Money: \(info_Building.buildingData.price)"
            }
            if info_Building.buildMenu == .Generator {
                info_1.text = "Hot: \(info_Building.buildingData.hot_Current) / \(info_Building.buildingData.hot_Max)"
                info_2.text = "Converted Energy: \(info_Building.buildingData.hot2Energy_Max)"
                info_3.text = "Sell Money: \(info_Building.buildingData.price)"
            }
            if info_Building.buildMenu == .Office {
                info_1.text = "Hot: \(info_Building.buildingData.hot_Current) / \(info_Building.buildingData.hot_Max)"
                info_2.text = "Produce Money: \(info_Building.buildingData.money_Sales)"
                info_3.text = "Sell Money: \(info_Building.buildingData.price)"
            }
        }
        // Touch building select
        if touchType == .Build1 {
            energy_Progress.runAction(Down)
            info.runAction(Down){ self.buildSelect.runAction(Up) }
            
            buildBox.position = build1.position
        }
        if touchType == .Build2 {
            buildBox.position = build2.position
        }
        if touchType == .Build3 {
            buildBox.position = build3.position
        }
        if touchType == .Build4 {
            buildBox.position = build4.position
        }
    }
   
    func tickUpdata() {
        print(touchType)
        print(build1.position)
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
