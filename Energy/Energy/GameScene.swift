//
//  GameScene.swift
//  Energy
//
//  Created by javan.chen on 2015/12/1.
//  Copyright (c) 2015年 Javan chen. All rights reserved.
//

import SpriteKit

var tilesScaleSize: CGSize!
var buildingMapLayer = BuildingMapLayer()
var colorEnergy = UIColor(red: 0.519, green: 0.982, blue: 1.000, alpha: 1.000)
var colorReserch = UIColor(red: 0.231, green: 0.705, blue: 0.275, alpha: 1.000)
enum TouchType: Int {
    case Building, Energy, Reserch, BuildSelect
}

class GameScene: SKScene {
    
    let tilesize = CGSizeMake(64, 64)
    let topsize = CGSizeMake(9, 1.5)
    let midsize = CGSizeMake(9, 10)
    var framescale: CGFloat!
    
    var gameTimer: NSTimer!
    var touchType: TouchType = .Energy
    var topLayer = TopLayer()
    var buildingSelectLayer = BuildingSelectLayer()
    var buttonLayer = ButtonLayer()
    var bottomLayer = BottomLayer()
    
    
    
    var botArea: SKSpriteNode!
    
    // Top
    var money: Int = 10
    var reserch: Int = 0

    // Bottom - button
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
    
    // Bottom 4 - Reserch
    
    //    var defaults: NSUserDefaults!
    
    override func didMoveToView(view: SKView) {
        
        framescale = frame.size.width / (midsize.width * 64)
        tilesScaleSize = CGSize(width: tilesize.width * framescale, height: tilesize.width * framescale)
        gameTimer = NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector: "tickUpdata", userInfo: nil, repeats: true)
        //        defaults = NSUserDefaults.standardUserDefaults()
        
        // Top Layer
        let topLayerSize = CGSizeMake(frame.size.width, topsize.height * tilesScaleSize.height)
        let topLayerPosition = CGPoint(x: 0, y: frame.size.height - topLayerSize.height)
        topLayer.configureAtPosition(topLayerPosition, size: topLayerSize)
        addChild(topLayer)
        
        // Building Map Layer
        let buildingMapLayerPosition = CGPoint(x: 0, y: frame.size.height - topLayer.size.height)
        buildingMapLayer.configureAtPosition(buildingMapLayerPosition, maplevel: .One)
        buildingMapLayer.setScale(framescale)
        addChild(buildingMapLayer)
        buildingMapLayer.setTileMapElement(coord: CGPoint(x: 0, y: 0), buildType: .Office)
        buildingMapLayer.setTileMapElement(coord: CGPoint(x: 1, y: 0), buildType: .Fire)
        buildingMapLayer.setTileMapElement(coord: CGPoint(x: 2, y: 0), buildType: .Generator)
        
        // Button Layer
        let buttonLayerSize = CGSizeMake(frame.size.width, 100)
        buttonLayer.configureAtPosition(CGPoint(x: 0, y: 0), size: buttonLayerSize)
        addChild(buttonLayer)
        
        // Bottom Layer
        let bottomLayerSize = CGSizeMake(frame.size.width, frame.size.height - topLayer.size.height - buildingMapLayer.size.height - buttonLayer.size.height)
        let bottomLayerPosition = CGPoint(x: 0, y: buttonLayer.size.height)
        bottomLayer.configureAtPosition(bottomLayerPosition, size: bottomLayerSize)
        addChild(bottomLayer)
        
        // Building Select Layer
        let buildingSelectLayerSize = buildingMapLayer.size
        let buildingSelectLayerPosition = CGPoint(x: 0, y: frame.size.height - topLayer.size.height - buildingSelectLayerSize.height)
        buildingSelectLayer.configureAtPosition(buildingSelectLayerPosition, midSize: buildingSelectLayerSize)
        buildingSelectLayer.zPosition = 2
        addChild(buildingSelectLayer)
        buildingSelectLayer.showPage(false, page: 1)
        

        
        
        
        
        
    
        botArea = SKSpriteNode(color: SKColor.grayColor(), size: CGSizeMake(frame.size.width, frame.size.height - (topsize.height + midsize.height) * tilesScaleSize.height))
        botArea.name = "botArea"
        botArea.anchorPoint = CGPoint(x: 0, y: 0)
        botArea.position = CGPoint(x: 0, y: 0)
        botArea.zPosition = 2
//        addChild(botArea)
        
        // Bottom Area button
        buttonBuile = SKSpriteNode(color: SKColor.brownColor(), size: CGSize(width: botArea.size.width / 4, height: 100))
        buttonBuile.anchorPoint = CGPoint(x: 0, y: 0)
        buttonBuile.position = CGPoint(x: 0, y: 0)
        buttonBuile.zPosition = 100
//        botArea.addChild(buttonBuile)
        buttonEnergy = SKSpriteNode(color: colorEnergy, size: CGSize(width: botArea.size.width / 2, height: 100))
        buttonEnergy.anchorPoint = CGPoint(x: 0, y: 0)
        buttonEnergy.position = CGPoint(x: botArea.size.width / 4, y: 0)
        buttonEnergy.zPosition = 100
//        botArea.addChild(buttonEnergy)
        buttonReserch = SKSpriteNode(color: colorReserch, size: CGSize(width: botArea.size.width / 4, height: 100))
        buttonReserch.anchorPoint = CGPoint(x: 0, y: 0)
        buttonReserch.position = CGPoint(x: botArea.size.width * 3 / 4, y: 0)
        buttonReserch.zPosition = 100
//        botArea.addChild(buttonReserch)
        
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
        energy_maxLabel.text = "Energy: \(buildingMapLayer.energy) (Max:\(buildingMapLayer.energyMax))"
        energy_maxLabel.fontColor = colorEnergy
        let labelgap: CGFloat = 18
        let labelsize = (topLayer.size.height - labelgap * 3) / 2
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
        buildSelectMenu = [.Wind, .Fire, .Generator, .Office]
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
        
        // Bottom Area 4 - Reserch upgrade
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.locationInNode(self)
            let nodes = nodesAtPoint(location)
            for node in nodes {
                
                print(node)
                
                switch node {
                case topLayer.buttonMenu:
                    print("Menu Button")
                    
                case topLayer.buttonRebuild:
                    print("Rebuild Button")
                    
                case buildingMapLayer:
                    print("Building Map Layer")
                    let buildingmaplocation = touch.locationInNode(buildingMapLayer)
                    let coord = buildingMapLayer.position2Coord(buildingmaplocation)
                    print(buildingMapLayer.buildingForCoord(coord))
                    bottomLayer.pageInformation.changeInformation(buildingMapLayer.buildingForCoord(coord)!)
                    
                case bottomLayer.pageBuild:
                    print("Page Build")
                    
                case buttonLayer.buttonBuild:
                    print("Build Button")
                    buttonLayer.tapButtonBuild()
                    
                case buttonLayer.buttonEnergy:
                    print("Energy Button")
                    buttonLayer.tapButtonEnergy()
                    
                case buttonLayer.buttonReserch:
                    print("Reserch Button")
                    buttonLayer.tapButtonReserch()
                    
                default:
                    break
                }
            }
            
            
            
            // Touch Top Area
            if topLayer.containsPoint(location) {
                let topAreaLocation = touch.locationInNode(topLayer)
                // reset touch type
                touchType = .Energy
                buttonBuile.alpha = 1
                // menu buttom
                if topLayer.buttonMenu.containsPoint(topAreaLocation) {
                    print("123")
                }
            }
            
            
            // Touch building Map
            if buildingMapLayer.containsPoint(location) {
                let buildingmaplocation = touch.locationInNode(buildingMapLayer)
                let coord = buildingMapLayer.position2Coord(buildingmaplocation)
                
                if touchType == .Building || touchType == .Energy || (buildSelect != 4 && buildingMapLayer.buildingForCoord(coord)!.activate) {
                    if buildingMapLayer.buildingForCoord(coord)!.activate {
                        buttonBuile.alpha = 1
                        touchType = .Building
//                        info_Building = buildingMapLayer.buildingForCoord(coord)
                    }
                }
                
                if touchType == .BuildSelect {
                    
                    // Sell Building
                    if buildSelect == 4 {
                        if buildingMapLayer.buildingForCoord(coord)!.activate {
                            let price = buildingMapLayer.buildingForCoord(coord)!.buildingData.buildPrice
                            money += price
                            buildingMapLayer.removeBuilding(coord)
                            buildingMapLayer.setTileMapElement(coord: coord, buildType: .Nil)
                        }
                        // build Building
                    } else {
                        let building = buildSelectMenu[buildSelect]
                        let price = BuildingData.init(buildType: building).buildPrice
                        if money >= price {
                            buildingMapLayer.setTileMapElement(coord: coord, buildType: building)
                            money -= price
                        }
                    }
                }
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
                    money += buildingMapLayer.energy
                    buildingMapLayer.energy = 0
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
                                print(ShowBuildSelectPage)
                            }
                        }
                    }
                }
                // Reserch Upgrade
            }
        }
    }
    
    override func update(currentTime: CFTimeInterval) {
        
        buildingSelectLayer.showPage(ShowBuildSelectPage, page: buildSelect + 1)
        floatBottomPage(touchType)
        
        switch touchType {
        case .Building:
            break
//            bottomPage_Info.childNodeWithName("infoImage")!.removeFromParent()
//            let infobuildType = info_Building.buildingData.buildType
//            let infoImage = buildingImage("infoImage", buildType: infobuildType)
//            infoImage.position = CGPoint(x: 40 + infoImage.size.width / 2, y: bottomPage_Info.size.height / 2)
//            bottomPage_Info.addChild(infoImage)
//            let info = info_Building.buildingData.buildingInfo(infobuildType)
//            for i in 1 ... 4 {
//                (bottomPage_Info.childNodeWithName("info\(i)") as! SKLabelNode).text = ""
//            }
//            for i in 1...info.count {
//                (bottomPage_Info.childNodeWithName("info\(i)") as! SKLabelNode).text = info[i - 1]
//            }
            
        case .Energy:
            let persent = CGFloat(buildingMapLayer.energy) / CGFloat(buildingMapLayer.energyMax)
            energy_ProgressFront.xScale = persent
            
        case .BuildSelect:
            break
            
        case .Reserch:
            break
        }
    }
   
    func tickUpdata() {
        // 1. Update map data
        buildingMapLayer.Update()
        
        // 2. Calculate money and reserch
        money += buildingMapLayer.money_TickAdd
        reserch += buildingMapLayer.reserch_TickAdd

        // 3. Updata imformation
        topLayer.moneyLabel.text = "Money: \(money) + \(buildingMapLayer.money_TickAdd)"
        topLayer.reserchLabel.text = "Reserch: \(reserch) + \(buildingMapLayer.reserch_TickAdd)"
//        let persent = CGFloat(buildingMap.energy) / CGFloat(buildingMap.energyMax) * 100
//        (topArea.childNodeWithName("energyLabel") as! SKLabelNode).text = "Energy: \(persent)%"
        
        energy_maxLabel.text = "Energy: \(buildingMapLayer.energy) (Max:\(buildingMapLayer.energyMax))"
        
        //        save()
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
    
    // Creat Building Image
    func buildingImage(name: String, buildType: BuildType) -> SKSpriteNode {
        let buildingImage = SKSpriteNode(imageNamed: BuildingData(buildType: buildType).imageName)
        buildingImage.name = name
        buildingImage.size = tilesScaleSize
        return buildingImage
    }
//    func save() {
//        defaults.setInteger(money, forKey: "Money")
//    }
}
