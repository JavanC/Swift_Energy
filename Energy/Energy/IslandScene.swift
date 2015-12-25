//
//  IslandScene.swift
//  Energy
//
//  Created by javan.chen on 2015/12/25.
//  Copyright © 2015年 Javan chen. All rights reserved.
//

import SpriteKit

var tilesScaleSize: CGSize!

class IslandScene: SKScene {
    
    enum TouchType: Int {
        case Information, Energy, Builded, Sell
    }
    let topTileSize = CGSizeMake(9, 1.5)
    let midTileSize = CGSizeMake(9, 11)
    let tilesize = CGSizeMake(64, 64)
    var framescale: CGFloat!
    var gameTimer: NSTimer!
    
    var touchType: TouchType = .Energy
    var topLayer: TopLayer!
    var buttonLayer: ButtonLayer!
    var bottomLayer: BottomLayer!
    var buildingSelectLayer: BuildingSelectLayer!
    var isShowSelectLayer: Bool = false
    
    var info_Building: Building!
    
    override func didMoveToView(view: SKView) {
        framescale = frame.size.width / (midTileSize.width * 64)
        tilesScaleSize = CGSize(width: tilesize.width * framescale, height: tilesize.width * framescale)
        gameTimer = NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector: "tickUpdata", userInfo: nil, repeats: true)
        //        defaults = NSUserDefaults.standardUserDefaults()
        
        // Top Layer
        let topLayerSize = CGSizeMake(frame.size.width, topTileSize.height * tilesScaleSize.height)
        let topLayerPosition = CGPoint(x: 0, y: frame.size.height - topLayerSize.height)
        topLayer = TopLayer()
        topLayer.configureAtPosition(topLayerPosition, size: topLayerSize)
        topLayer.zPosition = 200
        addChild(topLayer)
        
        // Map Layer
        maps[nowMapNumber].position = CGPoint(x: 0, y: frame.size.height - topLayer.size.height)
        maps[nowMapNumber].setScale(framescale)
        maps[nowMapNumber].zPosition = 1
        addChild(maps[nowMapNumber])
        maps[nowMapNumber].setTileMapElement(coord: CGPoint(x: 1, y: 0), buildType: .Wind)
        maps[nowMapNumber].setTileMapElement(coord: CGPoint(x: 0, y: 1), buildType: .Generator)
        maps[nowMapNumber].setTileMapElement(coord: CGPoint(x: 1, y: 1), buildType: .Fire)
        maps[nowMapNumber].setTileMapElement(coord: CGPoint(x: 2, y: 1), buildType: .Generator)
        maps[nowMapNumber].setTileMapElement(coord: CGPoint(x: 0, y: 0), buildType: .Office)
        
        // Button Layer
        let buttonLayerSize = CGSizeMake(frame.size.width, 100)
        buttonLayer = ButtonLayer()
        buttonLayer.configureAtPosition(CGPoint(x: 0, y: 0), size: buttonLayerSize)
        buttonLayer.zPosition = 200
        addChild(buttonLayer)
        
        // Bottom Layer
        let bottomLayerSize = CGSizeMake(frame.size.width, frame.size.height - topLayer.size.height - maps[nowMapNumber].size.height - buttonLayer.size.height)
        let bottomLayerPosition = CGPoint(x: 0, y: buttonLayer.size.height)
        bottomLayer = BottomLayer()
        bottomLayer.configureAtPosition(bottomLayerPosition, size: bottomLayerSize)
        bottomLayer.zPosition = 100
        addChild(bottomLayer)
        
        // Building Select Layer
        let buildingSelectLayerSize = maps[nowMapNumber].size
        let buildingSelectLayerPosition = CGPoint(x: 0, y: frame.size.height - topLayer.size.height - buildingSelectLayerSize.height)
        buildingSelectLayer = BuildingSelectLayer()
        buildingSelectLayer.configureAtPosition(buildingSelectLayerPosition, midSize: buildingSelectLayerSize)
        buildingSelectLayer.zPosition = 50
        addChild(buildingSelectLayer)
        
        info_Building = maps[nowMapNumber].buildingForCoord(CGPoint(x: 0, y: 0))!
    }
    
    func showBuildSelectPage() {
        buildingSelectLayer.changePage(bottomLayer.pageBuild.selectNumber)
        maps[nowMapNumber].runAction(SKAction.sequence([SKAction.waitForDuration(0.2), SKAction.hide()]))
        bottomLayer.pageBuild.openSelectInformation()
        buildingSelectLayer.showPage(true)
    }
    
    func changeTouchTypeAndShowPage(touchType: TouchType) {
        self.touchType = touchType
        
        maps[nowMapNumber].runAction(SKAction.unhide())
        bottomLayer.pageBuild.closeSelectInformation()
        buildingSelectLayer.showPage(false)
        
        switch touchType {
        case .Information:
            buttonLayer.tapButtonNil()
            bottomLayer.ShowPageInformation()
            
        case .Energy:
            buttonLayer.tapButtonEnergy()
            bottomLayer.showPageEnergy()
            
        case .Builded:
            buildingSelectLayer.changePage(bottomLayer.pageBuild.selectNumber)
            buttonLayer.tapButtonBuild()
            bottomLayer.ShowPageBuild()
            
        case .Sell:
            buttonLayer.tapButtonBuild()
            bottomLayer.ShowPageBuild()
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.locationInNode(self)
            let nodes = nodesAtPoint(location)
            for node in nodes {
                if node.hidden { return }
                switch node {
                    
                // Button
                case topLayer.buttonMenu:
                    print("Menu Button")
                    
                case topLayer.buttonRebuild:
                    print("Rebuild Button")
                    maps[nowMapNumber].Update()
                    print(maps[0].buildingForCoord(CGPoint(x: 1, y: 1))?.buildingData.hot_Current)
                    
                    
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
                
                // Energy Page
                case bottomLayer.pageEnergy.energy_ProgressBack:
                    print("Energy Preogree")
                    money += maps[nowMapNumber].energy
                    maps[nowMapNumber].energy = 0
                    
                // Builded Page
                case bottomLayer.pageBuild.images[0]:
                    print("Builded image1")
                    if bottomLayer.pageBuild.selectNumber == 1 { showBuildSelectPage(); break }
                    bottomLayer.pageBuild.changeSelectNumber(1)
                    changeTouchTypeAndShowPage(.Builded)
                    
                case bottomLayer.pageBuild.images[1]:
                    print("Builded image2")
                    if bottomLayer.pageBuild.selectNumber == 2 { showBuildSelectPage(); break }
                    bottomLayer.pageBuild.changeSelectNumber(2)
                    changeTouchTypeAndShowPage(.Builded)
                    
                case bottomLayer.pageBuild.images[2]:
                    print("Builded image3")
                    if bottomLayer.pageBuild.selectNumber == 3 { showBuildSelectPage(); break }
                    bottomLayer.pageBuild.changeSelectNumber(3)
                    changeTouchTypeAndShowPage(.Builded)
                    
                case bottomLayer.pageBuild.images[3]:
                    print("Builded image4")
                    if bottomLayer.pageBuild.selectNumber == 4 { showBuildSelectPage(); break }
                    bottomLayer.pageBuild.changeSelectNumber(4)
                    changeTouchTypeAndShowPage(.Builded)
                    
                case bottomLayer.pageBuild.images[4]:
                    print("Sell image")
                    bottomLayer.pageBuild.changeSelectNumber(5)
                    changeTouchTypeAndShowPage(.Sell)
                    
                case bottomLayer.pageBuild.selectInfo:
                    print("Builded select info")
                    changeTouchTypeAndShowPage(.Builded)
                    
                // Building Map
                case maps[nowMapNumber]:
                    print("Building Map Layer")
                    let buildingmaplocation = touch.locationInNode(maps[nowMapNumber])
                    let coord = maps[nowMapNumber].position2Coord(buildingmaplocation)
                    switch touchType {
                    case .Information, .Energy:
                        if maps[nowMapNumber].buildingForCoord(coord)!.activate {
                            info_Building = maps[nowMapNumber].buildingForCoord(coord)
                            print(info_Building.buildingData.buildType)
                            changeTouchTypeAndShowPage(.Information)
                        }
                        
                    case .Builded:
                        if maps[nowMapNumber].buildingForCoord(coord)!.activate {
                            info_Building = maps[nowMapNumber].buildingForCoord(coord)
                            changeTouchTypeAndShowPage(.Information)
                        } else {
                            let building = bottomLayer.pageBuild.buildMenu[bottomLayer.pageBuild.selectNumber - 1]
                            let price = BuildingData.init(buildType: building).buildPrice
                            if money >= price {
                                maps[nowMapNumber].setTileMapElement(coord: coord, buildType: building)
                                money -= price
                            }
                        }
                        
                    case .Sell:
                        if maps[nowMapNumber].buildingForCoord(coord)!.activate {
                            let price = maps[nowMapNumber].buildingForCoord(coord)!.buildingData.buildPrice
                            money += price
                            maps[nowMapNumber].removeBuilding(coord)
                            maps[nowMapNumber].setTileMapElement(coord: coord, buildType: .Nil)
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
//                        if node.name == "Upgrade" {
//                            let buildType = (node.parent as! BuildingSelectElement).buildType
////                            let upgradePrice = BuildingData(buildType: buildType).nextLevelPrice
//                            if upgradePrice <= money {
//                                money -= upgradePrice
//                                setBuildLevel(buildType, level: nowLevel + 1)
//                                bottomLayer.pageBuild.selectInfo.nowLevelImformation(buildType)
//                                buildingMapLayers[nowMapNumber].reloadBuildingMap()
//                            }
//                        }
//                        if node.name == "Degrade" {
//                            let buildType = (node.parent as! BuildingSelectElement).buildType
//                            let nowLevel = getBuildLevel(buildType)
//                            let degrradePrice = BuildingData(buildType: buildType, level: nowLevel - 1).nextLevelPrice
//                            money += degrradePrice
//                            setBuildLevel(buildType, level: nowLevel - 1)
//                            bottomLayer.pageBuild.selectInfo.nowLevelImformation(buildType)
//                            buildingMapLayers[nowMapNumber].reloadBuildingMap()
//                        }
                    }
//
//                    // Reserch Page
//                case bottomLayer.pageReserch.nextPage:
//                    let nowPage = bottomLayer.pageReserch.nowPage
//                    bottomLayer.pageReserch.changePage(nowPage + 1)
//                    reserchLayer.changePage(nowPage + 1)
//                    
//                case bottomLayer.pageReserch.prevPage:
//                    let nowPage = bottomLayer.pageReserch.nowPage
//                    bottomLayer.pageReserch.changePage(nowPage - 1)
//                    reserchLayer.changePage(nowPage - 1)
//                    
//                case reserchLayer:
//                    let nodes = nodesAtPoint(location)
//                    for node in nodes {
//                        if node.hidden { return }
//                        if node.name == "ReserchButton" {
//                            let reserchElement = (node.parent as! ReserchElement)
//                            let reserchPrice = reserchElement.reserchPrice
//                            if reserchPrice > reserch { return }
//                            reserch -= reserchPrice
//                            let buildType = reserchElement.buildType
//                            let reserchType = reserchElement.reserchType
//                            if reserchType == .Develop {
//                                setBuildLevel(buildType, level: 1)
//                            } else if reserchType == .Rebuild {
//                                let nowLevel = getBuildLevel(buildType)
//                                setBuildLevel(buildType, level: nowLevel + 1000)
//                            }
//                            reserchLayer.updateReserchPage()
//                            buildingMapLayers[nowMapNumber].reloadBuildingMap()
//                            let count = reserchLayer.elements.count
//                            let maxPage = (count / 6) + 1
//                            bottomLayer.pageReserch.changeMaxPage(maxPage)
//                        }
//                    }
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
        topLayer.moneyLabel.text = "Money: \(money) + \(maps[nowMapNumber].money_TickAdd)"
        topLayer.reserchLabel.text = "Reserch: \(reserch) + \(maps[nowMapNumber].reserch_TickAdd)"
        let percent = CGFloat(maps[nowMapNumber].energy) / CGFloat(maps[nowMapNumber].energyMax)
        bottomLayer.pageEnergy.progressPercent(percent)
        bottomLayer.pageEnergy.energyLabel.text = "Energy: \(maps[nowMapNumber].energy) (Max:\(maps[nowMapNumber].energyMax))"

    }
    
    func tickUpdata() {
        for i in 0...1 {
            // Update map data
            maps[i].Update()
            // Calculate money and reserch
            money += maps[i].money_TickAdd
            reserch += maps[i].reserch_TickAdd
        }
        //        save()
    }
    //    func save() {
    //        defaults.setInteger(money, forKey: "Money")
    //    }
}