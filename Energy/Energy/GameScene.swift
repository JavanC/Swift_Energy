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
    case Building, Energy, Reserch, BuildSelect, Sell
}

class GameScene: SKScene {
    
    let tilesize = CGSizeMake(64, 64)
    let topsize = CGSizeMake(9, 1.5)
    let midsize = CGSizeMake(9, 10)
    var framescale: CGFloat!
    var gameTimer: NSTimer!
    var money: Int = 10
    var reserch: Int = 0
    //    var defaults: NSUserDefaults!
    
    var touchType: TouchType = .Energy
    var topLayer = TopLayer()
    var buildingSelectLayer = BuildingSelectLayer()
    var buttonLayer = ButtonLayer()
    var bottomLayer = BottomLayer()
    
    var ShowBuildSelectPage: Bool = false
    var info_Building: Building!

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
        buildingSelectLayer.showPage(false)

        info_Building = buildingMapLayer.buildingForCoord(CGPoint(x: 0, y: 0))!
        
        //  Reserch upgrade
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.locationInNode(self)
            let nodes = nodesAtPoint(location)
            for node in nodes {
                
//                print(node)
                
                switch node {
                case topLayer.buttonMenu:
                    print("Menu Button")
                    
                case topLayer.buttonRebuild:
                    print("Rebuild Button")
                    
                case buttonLayer.buttonBuild:
                    print("Build Button")
                    touchType = (buttonLayer.buttonStatus != "build" ? .BuildSelect : .Energy)
                    
                case buttonLayer.buttonEnergy:
                    print("Energy Button")
                    touchType = .Energy
                    
                case buttonLayer.buttonReserch:
                    print("Reserch Button")
                    touchType = (buttonLayer.buttonStatus != "reserch" ? .Reserch : .Energy)
                    
                case buildingMapLayer:
                    print("Building Map Layer")
                    let buildingmaplocation = touch.locationInNode(buildingMapLayer)
                    let coord = buildingMapLayer.position2Coord(buildingmaplocation)
                    switch touchType {
                    case .Building, .Energy, .Reserch:
                        if buildingMapLayer.buildingForCoord(coord)!.activate {
                            touchType = .Building
                            info_Building = buildingMapLayer.buildingForCoord(coord)
                        }
                        
                    case .BuildSelect:
                        if !(buildingMapLayer.buildingForCoord(coord)!.activate) {
                            let building = bottomLayer.pageBuild.buildMenu[bottomLayer.pageBuild.selectNumber - 1]
                            let price = BuildingData.init(buildType: building).buildPrice
                            if money >= price {
                                buildingMapLayer.setTileMapElement(coord: coord, buildType: building)
                                money -= price
                            }
                        } else {
                            touchType = .Building
                            info_Building = buildingMapLayer.buildingForCoord(coord)
                        }
                        
                    case .Sell:
                        if buildingMapLayer.buildingForCoord(coord)!.activate {
                            let price = buildingMapLayer.buildingForCoord(coord)!.buildingData.buildPrice
                            money += price
                            buildingMapLayer.removeBuilding(coord)
                            buildingMapLayer.setTileMapElement(coord: coord, buildType: .Nil)
                        }
                    }
                    
                case bottomLayer.pageBuild:
                    print("Page Build")
                    touchType = .BuildSelect
                    let buildLocation = touch.locationInNode(bottomLayer)
                    for i in 1...5 {
                        if bottomLayer.pageBuild.childNodeWithName("SelectImage\(i)")!.containsPoint(buildLocation) {
                            if bottomLayer.pageBuild.selectNumber != i {
                                bottomLayer.pageBuild.changeSelectNumber(i)
                            } else {
                                ShowBuildSelectPage = !ShowBuildSelectPage
                            }
                            if bottomLayer.pageBuild.selectNumber == 5 {
                                ShowBuildSelectPage = false
                                touchType = .Sell
                            }
                        }
                    }
    
                default:
                    break
                }
            }
            print(touchType)
        }
    }
    
    override func update(currentTime: CFTimeInterval) {
        switch touchType {
        case .Building:
            buttonLayer.tapButtonNil()
            bottomLayer.pageInformation.changeInformation(info_Building)
            bottomLayer.ShowPageInformation()
            
        case .BuildSelect:
            buttonLayer.tapButtonBuild()
            bottomLayer.ShowPageBuild()
            buildingSelectLayer.showPage(ShowBuildSelectPage)
            buildingSelectLayer.changePage(bottomLayer.pageBuild.selectNumber)
            
        case .Energy:
            buttonLayer.tapButtonEnergy()
            bottomLayer.showPageEnergy()
            
        case .Reserch:
            buttonLayer.tapButtonReserch()
            bottomLayer.showPageReserch()
            
        case .Sell:
            buildingSelectLayer.showPage(ShowBuildSelectPage)
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
        let percent = CGFloat(buildingMapLayer.energy) / CGFloat(buildingMapLayer.energyMax)
        bottomLayer.pageEnergy.progressPercent(percent)
        bottomLayer.pageEnergy.energyLabel.text = "Energy: \(buildingMapLayer.energy) (Max:\(buildingMapLayer.energyMax))"
//        save()
    }
//    func save() {
//        defaults.setInteger(money, forKey: "Money")
//    }
}
