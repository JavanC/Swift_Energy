//
//  GameScene.swift
//  Energy
//
//  Created by javan.chen on 2015/12/1.
//  Copyright (c) 2015年 Javan chen. All rights reserved.
//

import SpriteKit

let topsize = CGSizeMake(9, 1.5)
let midsize = CGSizeMake(9, 11)
var tilesScaleSize: CGSize!
var nowMapNumber: Int = 0
var buildingMapLayers = [BuildingMapLayer]()
var colorEnergy = UIColor(red: 0.519, green: 0.982, blue: 1.000, alpha: 1.000)
var colorReserch = UIColor(red: 0.231, green: 0.705, blue: 0.275, alpha: 1.000)

var money: Int = 100
var reserch: Int = 100
var buildLevel = [BuildType: Int]()
func getBuildLevel(buildType: BuildType) -> Int { return buildLevel[buildType]! }
func setBuildLevel(buildType: BuildType, level: Int){ buildLevel[buildType] = level }

class GameScene: SKScene {
    
    enum TouchType: Int {
        case Information, Energy, Reserch, Builded, Sell
    }
    let tilesize = CGSizeMake(64, 64)
    var framescale: CGFloat!
    var gameTimer: NSTimer!

    //    var defaults: NSUserDefaults!
    
    var touchType: TouchType = .Energy
    var topLayer = TopLayer()
    var buildingSelectLayer = BuildingSelectLayer()
    var buttonLayer = ButtonLayer()
    var bottomLayer = BottomLayer()
    var reserchLayer = ReserchLayer()
    
    var info_Building: Building!
    
    override func didMoveToView(view: SKView) {
        
        framescale = frame.size.width / (midsize.width * 64)
        tilesScaleSize = CGSize(width: tilesize.width * framescale, height: tilesize.width * framescale)
        gameTimer = NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector: "tickUpdata", userInfo: nil, repeats: true)
        //        defaults = NSUserDefaults.standardUserDefaults()
        // initial Build Level
        for count in 0..<BuildType.BuildMenuLength.hashValue { buildLevel[BuildType(rawValue: count)!] = 0 }
        setBuildLevel(.Wind, level: 1)
        
        // Top Layer
        let topLayerSize = CGSizeMake(frame.size.width, topsize.height * tilesScaleSize.height)
        let topLayerPosition = CGPoint(x: 0, y: frame.size.height - topLayerSize.height)
        topLayer.configureAtPosition(topLayerPosition, size: topLayerSize)
        topLayer.zPosition = 200
        addChild(topLayer)
        
        // Building Map Layer
        let buildingMapLayer_1 = BuildingMapLayer()
        let buildingMapLayerPosition = CGPoint(x: 0, y: frame.size.height - topLayer.size.height)
        buildingMapLayer_1.configureAtPosition(buildingMapLayerPosition, maplevel: .One)
        buildingMapLayer_1.setScale(framescale)
        buildingMapLayer_1.zPosition = 1
        addChild(buildingMapLayer_1)
        buildingMapLayers.append(buildingMapLayer_1)
        
        buildingMapLayer_1.setTileMapElement(coord: CGPoint(x: 0, y: 0), buildType: .Wind)
        buildingMapLayer_1.setTileMapElement(coord: CGPoint(x: 1, y: 0), buildType: .Wind)
        buildingMapLayer_1.setTileMapElement(coord: CGPoint(x: 2, y: 0), buildType: .Wind)
        
        // Button Layer
        let buttonLayerSize = CGSizeMake(frame.size.width, 100)
        buttonLayer.configureAtPosition(CGPoint(x: 0, y: 0), size: buttonLayerSize)
        buttonLayer.zPosition = 200
        addChild(buttonLayer)
        
        // Building Select Layer
        let buildingSelectLayerSize = buildingMapLayer_1.size
        let buildingSelectLayerPosition = CGPoint(x: 0, y: frame.size.height - topLayer.size.height - buildingSelectLayerSize.height)
        buildingSelectLayer.configureAtPosition(buildingSelectLayerPosition, midSize: buildingSelectLayerSize)
        buildingSelectLayer.zPosition = 50
        addChild(buildingSelectLayer)
        buildingSelectLayer.showPage(false)

        info_Building = buildingMapLayer_1.buildingForCoord(CGPoint(x: 0, y: 0))!
        
        //  Reserch Layer
        let reserchLayerSize = buildingMapLayer_1.size
        let reserchLayerPosition = CGPoint(x: 0, y: frame.size.height - topLayer.size.height - buildingSelectLayerSize.height)
        reserchLayer.configureAtPosition(reserchLayerPosition, midSize: reserchLayerSize)
        reserchLayer.zPosition = 50
        addChild(reserchLayer)
        
        // Bottom Layer
        let bottomLayerSize = CGSizeMake(frame.size.width, frame.size.height - topLayer.size.height - buildingMapLayer_1.size.height - buttonLayer.size.height)
        let bottomLayerPosition = CGPoint(x: 0, y: buttonLayer.size.height)
        bottomLayer.configureAtPosition(bottomLayerPosition, size: bottomLayerSize)
        bottomLayer.zPosition = 100
        addChild(bottomLayer)
        let count = reserchLayer.elements.count
        let maxPage = (count / 6) + 1
        bottomLayer.pageReserch.changeMaxPage(maxPage)
    }

    func changeTouchTypeAndShowPage(touchType: TouchType) {
        self.touchType = touchType
        switch touchType {
        case .Information:
            // Show
            buttonLayer.tapButtonNil()
            bottomLayer.ShowPageInformation()
            buildingMapLayers[nowMapNumber].runAction(SKAction.unhide())
            // Hide
            bottomLayer.pageBuild.closeSelectInformation()
            buildingSelectLayer.showPage(false)
            reserchLayer.showPage(false)
            
        case .Energy:
            // Show
            buttonLayer.tapButtonEnergy()
            bottomLayer.showPageEnergy()
            buildingMapLayers[nowMapNumber].runAction(SKAction.unhide())
            // Hide
            bottomLayer.pageBuild.closeSelectInformation()
            buildingSelectLayer.showPage(false)
            reserchLayer.showPage(false)
            
        case .Reserch:
            // Show
            buttonLayer.tapButtonReserch()
            bottomLayer.showPageReserch()
            reserchLayer.showPage(true)
            // Hide
            buildingMapLayers[nowMapNumber].runAction(SKAction.sequence([SKAction.waitForDuration(0.2), SKAction.hide()]))
            bottomLayer.pageBuild.closeSelectInformation()
            buildingSelectLayer.showPage(false)
            
        case .Builded:
            // Show
            buttonLayer.tapButtonBuild()
            bottomLayer.ShowPageBuild()
            buildingSelectLayer.changePage(bottomLayer.pageBuild.selectNumber)
            if buildingSelectLayer.show {
                // Show
                bottomLayer.pageBuild.openSelectInformation()
                buildingSelectLayer.showPage(true)
                // Hide
                buildingMapLayers[nowMapNumber].runAction(SKAction.sequence([SKAction.waitForDuration(0.2), SKAction.hide()]))
            } else {
                // Show
                buildingMapLayers[nowMapNumber].runAction(SKAction.unhide())
                // Hide
                bottomLayer.pageBuild.closeSelectInformation()
                buildingSelectLayer.showPage(false)
            }
            // Hide
            reserchLayer.showPage(false)
            
        case .Sell:
            // Show
            buttonLayer.tapButtonBuild()
            bottomLayer.ShowPageBuild()
            buildingMapLayers[nowMapNumber].runAction(SKAction.unhide())
            // Hide
            bottomLayer.pageBuild.closeSelectInformation()
            buildingSelectLayer.showPage(false)
            reserchLayer.showPage(false)
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.locationInNode(self)
            let nodes = nodesAtPoint(location)
            for node in nodes {
                if node.hidden { return }
//                print(node)

                switch node {
                    
                // Button
                case topLayer.buttonMenu:
                    print("Menu Button")
                    
                case topLayer.buttonRebuild:
                    print("Rebuild Button")
                    
                case buttonLayer.buttonBuild:
                    print("Build Button")
                    changeTouchTypeAndShowPage((buttonLayer.buttonStatus != "build" ? .Builded : .Energy))
                    if touchType == .Builded && bottomLayer.pageBuild.selectNumber == 5{
                        changeTouchTypeAndShowPage(.Sell)
                    }
                    
                case buttonLayer.buttonEnergy:
                    print("Energy Button")
                    changeTouchTypeAndShowPage(.Energy)
                    
                case buttonLayer.buttonReserch:
                    print("Reserch Button")
                    changeTouchTypeAndShowPage((buttonLayer.buttonStatus != "reserch" ? .Reserch : .Energy))
                    
                // Building Map
                case buildingMapLayers[nowMapNumber]:
                    print("Building Map Layer")
                    let buildingmaplocation = touch.locationInNode(buildingMapLayers[nowMapNumber])
                    let coord = buildingMapLayers[nowMapNumber].position2Coord(buildingmaplocation)
                    switch touchType {
                    case .Information, .Energy, .Reserch:
                        if buildingMapLayers[nowMapNumber].buildingForCoord(coord)!.activate {
                            info_Building = buildingMapLayers[nowMapNumber].buildingForCoord(coord)
                            changeTouchTypeAndShowPage(.Information)
                        }
                        
                    case .Builded:
                        if buildingMapLayers[nowMapNumber].buildingForCoord(coord)!.activate {
                            info_Building = buildingMapLayers[nowMapNumber].buildingForCoord(coord)
                            changeTouchTypeAndShowPage(.Information)
                        } else {
                            let building = bottomLayer.pageBuild.buildMenu[bottomLayer.pageBuild.selectNumber - 1]
                            let price = BuildingData.init(buildType: building).buildPrice
                            if money >= price {
                                buildingMapLayers[nowMapNumber].setTileMapElement(coord: coord, buildType: building)
                                money -= price
                            }
                        }
                        
                    case .Sell:
                        if buildingMapLayers[nowMapNumber].buildingForCoord(coord)!.activate {
                            let price = buildingMapLayers[nowMapNumber].buildingForCoord(coord)!.buildingData.buildPrice
                            money += price
                            buildingMapLayers[nowMapNumber].removeBuilding(coord)
                            buildingMapLayers[nowMapNumber].setTileMapElement(coord: coord, buildType: .Nil)
                        }
                    }
                    
                // Build Select Page
                case buildingSelectLayer:
                    let nodes = nodesAtPoint(location)
                    for node in nodes {
                        if node.hidden { return }
                        if node.name == "BuildingSelectElement" {
                            let buildType = (node as! BuildingSelectElement).buildType
                            bottomLayer.pageBuild.changeSelectBuildType(buildType)
                        }
                        if node.name == "Upgrade" {
                            let buildType = (node.parent as! BuildingSelectElement).buildType
                            let nowLevel = getBuildLevel(buildType)
                            let upgradePrice = BuildingData(buildType: buildType, level: nowLevel).nextLevelPrice
                            if upgradePrice <= money {
                                money -= upgradePrice
                                setBuildLevel(buildType, level: nowLevel + 1)
                                bottomLayer.pageBuild.selectInfo.nowLevelImformation(buildType)
                                buildingMapLayers[nowMapNumber].reloadBuildingMap()
                            }
                        }
                        if node.name == "Degrade" {
                            let buildType = (node.parent as! BuildingSelectElement).buildType
                            let nowLevel = getBuildLevel(buildType)
                            let degrradePrice = BuildingData(buildType: buildType, level: nowLevel - 1).nextLevelPrice
                            money += degrradePrice
                            setBuildLevel(buildType, level: nowLevel - 1)
                            bottomLayer.pageBuild.selectInfo.nowLevelImformation(buildType)
                            buildingMapLayers[nowMapNumber].reloadBuildingMap()
                        }
                    }
                    
                // Reserch Page
                case bottomLayer.pageReserch.nextPage:
                    let nowPage = bottomLayer.pageReserch.nowPage
                    bottomLayer.pageReserch.changePage(nowPage + 1)
                    reserchLayer.changePage(nowPage + 1)
                
                case bottomLayer.pageReserch.prevPage:
                    let nowPage = bottomLayer.pageReserch.nowPage
                    bottomLayer.pageReserch.changePage(nowPage - 1)
                    reserchLayer.changePage(nowPage - 1)
                    
                case reserchLayer:
                    let nodes = nodesAtPoint(location)
                    for node in nodes {
                        if node.hidden { return }
                        if node.name == "ReserchButton" {
                            let reserchElement = (node.parent as! ReserchElement)
                            let reserchPrice = reserchElement.reserchPrice
                            if reserchPrice > reserch { return }
                            reserch -= reserchPrice
                            let buildType = reserchElement.buildType
                            let reserchType = reserchElement.reserchType
                            if reserchType == .Develop {
                                setBuildLevel(buildType, level: 1)
                            } else if reserchType == .Rebuild {
                                let nowLevel = getBuildLevel(buildType)
                                setBuildLevel(buildType, level: nowLevel + 1000)
                            }
                            reserchLayer.updateReserchPage()
                            buildingMapLayers[nowMapNumber].reloadBuildingMap()
                            let count = reserchLayer.elements.count
                            let maxPage = (count / 6) + 1
                            bottomLayer.pageReserch.changeMaxPage(maxPage)
                        }
                    }
                    
                // Builded Page
                case bottomLayer.pageBuild.images[0]:
                    print("Builded image1")
                    if bottomLayer.pageBuild.selectNumber == 1 { buildingSelectLayer.showPage(true) }
                    bottomLayer.pageBuild.changeSelectNumber(1)
                    changeTouchTypeAndShowPage(.Builded)
                    
                case bottomLayer.pageBuild.images[1]:
                    print("Builded image2")
                    if bottomLayer.pageBuild.selectNumber == 2 { buildingSelectLayer.showPage(true) }
                    bottomLayer.pageBuild.changeSelectNumber(2)
                    changeTouchTypeAndShowPage(.Builded)
                    
                case bottomLayer.pageBuild.images[2]:
                    print("Builded image3")
                    if bottomLayer.pageBuild.selectNumber == 3 { buildingSelectLayer.showPage(true) }
                    bottomLayer.pageBuild.changeSelectNumber(3)
                    changeTouchTypeAndShowPage(.Builded)
                    
                case bottomLayer.pageBuild.images[3]:
                    print("Builded image4")
                    if bottomLayer.pageBuild.selectNumber == 4 { buildingSelectLayer.showPage(true) }
                    bottomLayer.pageBuild.changeSelectNumber(4)
                    changeTouchTypeAndShowPage(.Builded)
                    
                case bottomLayer.pageBuild.images[4]:
                    print("Sell image")
                    bottomLayer.pageBuild.changeSelectNumber(5)
                    changeTouchTypeAndShowPage(.Sell)
                    
                case bottomLayer.pageBuild.selectInfo:
                    print("Builded select info")
                    buildingSelectLayer.showPage(false)
                    changeTouchTypeAndShowPage(.Builded)
                    
                // Energy Page
                case bottomLayer.pageEnergy.energy_ProgressBack:
                    print("Energy Preogree")
                    money += buildingMapLayers[nowMapNumber].energy
                    buildingMapLayers[nowMapNumber].energy = 0
    
                default:
                    break
                }
            }
        }
    }
    
    override func update(currentTime: CFTimeInterval) {
        
        buildingSelectLayer.updateBuildingSelectPage()
        bottomLayer.pageInformation.changeInformation(info_Building)
        
        // Updata imformation
        topLayer.moneyLabel.text = "Money: \(money) + \(buildingMapLayers[nowMapNumber].money_TickAdd)"
        topLayer.reserchLabel.text = "Reserch: \(reserch) + \(buildingMapLayers[nowMapNumber].reserch_TickAdd)"
        let percent = CGFloat(buildingMapLayers[nowMapNumber].energy) / CGFloat(buildingMapLayers[nowMapNumber].energyMax)
        bottomLayer.pageEnergy.progressPercent(percent)
        bottomLayer.pageEnergy.energyLabel.text = "Energy: \(buildingMapLayers[nowMapNumber].energy) (Max:\(buildingMapLayers[nowMapNumber].energyMax))"
    }
   
    func tickUpdata() {
        // Update map data
        buildingMapLayers[nowMapNumber].Update()
        
        // Calculate money and reserch
        money += buildingMapLayers[nowMapNumber].money_TickAdd
        reserch += buildingMapLayers[nowMapNumber].reserch_TickAdd

//        save()
    }
//    func save() {
//        defaults.setInteger(money, forKey: "Money")
//    }
}
