//
//  IslandScene.swift
//  Energy
//
//  Created by javan.chen on 2015/12/25.
//  Copyright © 2015年 Javan chen. All rights reserved.
//

import SpriteKit


class IslandScene: SKScene {
    
    var contentCreated: Bool = false
    enum TouchType: Int {
        case Information, Energy, Builded, Sell
    }
    let topTileSize = CGSizeMake(9, 1.5)
    let midTileSize = CGSizeMake(9, 11)
    let buttonTileSize = CGSizeMake(9, 1.5)
    let tilesize = CGSizeMake(64, 64)
    var gameTimer: NSTimer!
    
    var touchType: TouchType = .Energy
    var topLayer: TopLayer!
    var buttonLayer: ButtonLayer!
    var bottomLayer: BottomLayer!
    var buildingSelectLayer: BuildingSelectLayer!
    var isShowSelectLayer: Bool = false
    
    var info_Building: Building!
    
    override func didMoveToView(view: SKView) {
        
        // First initial
        if !contentCreated {
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
            let mapLayerSize = CGSizeMake(tilesScaleSize.width * midTileSize.width, tilesScaleSize.height * midTileSize.height)
            for count in 0..<maps.count {
                maps[count].position = CGPoint(x: 0, y: frame.size.height - topLayer.size.height)
                maps[count].setScale(framescale)
                maps[count].zPosition = 1
                addChild(maps[count])
            }
            
            maps[0].setTileMapElement(coord: CGPoint(x: 2, y: 2), buildType: BuildingType.WindTurbine)
//            maps[0].setTileMapElement(coord: CGPoint(x: 2, y: 3), buildType: BuildingType.SmallGenerator)
//            maps[0].setTileMapElement(coord: CGPoint(x: 3, y: 3), buildType: BuildingType.HeatExchanger)
//            maps[0].setTileMapElement(coord: CGPoint(x: 4, y: 3), buildType: BuildingType.CoalBurner)
            
            
            
//            maps[0].setTileMapElement(coord: CGPoint(x: 0, y: 2), buildType: BuildingType.SmallGenerator)
//            maps[0].setTileMapElement(coord: CGPoint(x: 1, y: 1), buildType: BuildingType.SmallGenerator)
//            maps[0].setTileMapElement(coord: CGPoint(x: 0, y: 0), buildType: BuildingType.SmallGenerator)
//            maps[0].setTileMapElement(coord: CGPoint(x: 0, y: 1), buildType: BuildingType.CoalBurner)
//            maps[0].setTileMapElement(coord: CGPoint(x: 2, y: 1), buildType: BuildingType.SmallGenerator)
//            maps[0].setTileMapElement(coord: CGPoint(x: 0, y: 0), buildType: BuildingType.SmallOffice)
            maps[1].setTileMapElement(coord: CGPoint(x: 1, y: 0), buildType: BuildingType.SmallGenerator)
            info_Building = maps[nowMapNumber].buildingForCoord(CGPoint(x: 0, y: 0))!
            
            // Button Layer
            let buttonLayerSize = CGSizeMake(frame.size.width, buttonTileSize.height * tilesScaleSize.height)
            buttonLayer = ButtonLayer()
            buttonLayer.configureAtPosition(CGPoint(x: 0, y: 0), size: buttonLayerSize)
            buttonLayer.zPosition = 200
            addChild(buttonLayer)
            
            // Bottom Layer
            let bottomLayerSize = CGSizeMake(frame.size.width, frame.size.height - topLayer.size.height - mapLayerSize.height - buttonLayer.size.height)
            let bottomLayerPosition = CGPoint(x: 0, y: buttonLayer.size.height)
            bottomLayer = BottomLayer()
            bottomLayer.configureAtPosition(bottomLayerPosition, size: bottomLayerSize)
            bottomLayer.zPosition = 100
            addChild(bottomLayer)
            
            // Building Select Layer
            let buildingSelectLayerSize = mapLayerSize
            let buildingSelectLayerPosition = CGPoint(x: 0, y: frame.size.height - topLayer.size.height - buildingSelectLayerSize.height)
            buildingSelectLayer = BuildingSelectLayer(position: buildingSelectLayerPosition, midSize: buildingSelectLayerSize)
            buildingSelectLayer.zPosition = 50
            addChild(buildingSelectLayer)
            
            // initial
            if isRebuild {
                bottomLayer.pageBuild.rebuildOn()
            } else {
                bottomLayer.pageBuild.rebuildOff()
            }
        
            contentCreated = true
        }
        
        // Only show now map
        for count in 0..<8 { maps[count].hidden = true }
        maps[nowMapNumber].hidden = false
        
        // back to Energy type
        self.touchType = .Energy
        maps[nowMapNumber].runAction(SKAction.unhide())
        bottomLayer.pageBuild.closeSelectInformation()
        buildingSelectLayer.showPage(false, duration: 0)
        bottomLayer.showPage(BottomLayer.PageType.PageEnergy, duration: 0)
        buttonLayer.beginButtonEnergy()
    }
    
    func showBuildSelectPage() {
        buildingSelectLayer.updateSelectLayer()
        buildingSelectLayer.changePage(bottomLayer.pageBuild.selectNumber)
        maps[nowMapNumber].runAction(SKAction.sequence([SKAction.waitForDuration(0.2), SKAction.hide()]))
        bottomLayer.pageBuild.openSelectInformation()
        buildingSelectLayer.showPage(true)
    }
    
    func changeTouchTypeAndShowPage(touchType: TouchType, duration: Double = 0.0) {
        self.touchType = touchType
        maps[nowMapNumber].runAction(SKAction.unhide())
        bottomLayer.pageBuild.closeSelectInformation()
        buildingSelectLayer.showPage(false)
        switch touchType {
        case .Information:
            buttonLayer.tapButtonNil(duration)
            bottomLayer.showPage(BottomLayer.PageType.PageInformation, duration: duration)
            
        case .Energy:
            buttonLayer.tapButtonEnergy(duration)
            bottomLayer.showPage(BottomLayer.PageType.PageEnergy, duration: duration)
            
        case .Builded:
            buttonLayer.tapButtonBuild(duration)
            bottomLayer.showPage(BottomLayer.PageType.PageBuild, duration: duration)
            
        case .Sell:
            buttonLayer.tapButtonSell(duration)
            bottomLayer.showPage(BottomLayer.PageType.PageSell, duration: duration)
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
                    changeTouchTypeAndShowPage(touchType)
                    let doors = SKTransition.moveInWithDirection(SKTransitionDirection.Left, duration: 0.3)
                    self.view?.presentScene(islandsScene, transition: doors)
                    
                case topLayer.buttonPlayPause:
                    print("Pause: \(isPause)")
                    isPause = !isPause
                    topLayer.isPauseChange()
                    if isPause { gameTimer.invalidate() }
                    else { gameTimer = NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector: "tickUpdata", userInfo: nil, repeats: true) }
                    
                case buttonLayer.buttonBuild:
                    print("Build Button")
                    changeTouchTypeAndShowPage(.Builded, duration: 0.1)
                    
                case buttonLayer.buttonSell:
                    print("Sell Button")
                    changeTouchTypeAndShowPage(.Sell, duration: 0.1)
                    
                case buttonLayer.buttonEnergy:
                    print("Energy Button")
                    changeTouchTypeAndShowPage(.Energy, duration: 0.1)
                    
                case buttonLayer.buttonUpgrade:
                    print("Upgrade Button")
                    buttonLayer.tapButtonUpgrade()
                    RunAfterDelay(0.8) {
                        let doors = SKTransition.moveInWithDirection(SKTransitionDirection.Down, duration: 0.3)
                        self.view?.presentScene(upgradeScene, transition: doors)
                    }
                    
                case buttonLayer.buttonResearch:
                    print("Research Button")
                    buttonLayer.tapButtonResearch()
                    RunAfterDelay(0.8) {
                        let doors = SKTransition.moveInWithDirection(SKTransitionDirection.Down, duration: 0.3)
                        self.view?.presentScene(researchScene, transition: doors)
                    }
                        
                // Energy Page
                case bottomLayer.pageEnergy.energy_ProgressBack:
                    print("Energy Preogree")
                    money += maps[nowMapNumber].energy
                    maps[nowMapNumber].energy = 0
                    // draw energy circle
                    let percent = CGFloat(maps[nowMapNumber].energy) / CGFloat(maps[nowMapNumber].energyMax)
                    buttonLayer.drawEnergyCircle(percent)
                    
                // Builded Page
                case bottomLayer.pageBuild.images[0]:
                    print("Builded image1")
                    if bottomLayer.pageBuild.selectNumber == 1 { showBuildSelectPage() }
                    bottomLayer.pageBuild.changeSelectNumber(1)
                    
                case bottomLayer.pageBuild.images[1]:
                    print("Builded image2")
                    if bottomLayer.pageBuild.selectNumber == 2 { showBuildSelectPage() }
                    bottomLayer.pageBuild.changeSelectNumber(2)
                    
                case bottomLayer.pageBuild.images[2]:
                    print("Builded image3")
                    if bottomLayer.pageBuild.selectNumber == 3 { showBuildSelectPage() }
                    bottomLayer.pageBuild.changeSelectNumber(3)
                    
                case bottomLayer.pageBuild.images[3]:
                    print("Builded image4")
                    if bottomLayer.pageBuild.selectNumber == 4 { showBuildSelectPage() }
                    bottomLayer.pageBuild.changeSelectNumber(4)
                    
                case bottomLayer.pageBuild.rebuildButton:
                    print("rebuild button")
                    isRebuild = !isRebuild
                    for count in 0..<8 { maps[count].autoRebuild = isRebuild }
                    if isRebuild {
                        bottomLayer.pageBuild.rebuildOn()
                    } else {
                        bottomLayer.pageBuild.rebuildOff()
                    }
                    
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
                            bottomLayer.pageInformation.changeInformation(info_Building.buildingData)
                            changeTouchTypeAndShowPage(.Information, duration: 0.1)
                        }
                        
                    case .Builded:
                        if maps[nowMapNumber].buildingForCoord(coord)!.activate {
                            info_Building = maps[nowMapNumber].buildingForCoord(coord)
                            bottomLayer.pageInformation.changeInformation(info_Building.buildingData)
                            changeTouchTypeAndShowPage(.Information, duration: 0.1)
                        } else {
                            let building = bottomLayer.pageBuild.buildMenu[bottomLayer.pageBuild.selectNumber - 1]
                            let price = BuildingData.init(buildType: building).buildPrice
                            if money >= price {
                                maps[nowMapNumber].removeBuilding(coord)
                                maps[nowMapNumber].setTileMapElement(coord: coord, buildType: building)
                                money -= price
                            }
                        }
                        
                    case .Sell:
                        if maps[nowMapNumber].buildingForCoord(coord)!.activate {
                            let price = maps[nowMapNumber].buildingForCoord(coord)!.buildingData.buildPrice
                            let canotSellBuildings: [BuildingType] = [.WindTurbine, .SolarCell, .CoalBurner, .WaveCell, .GasBurner, .NuclearCell, .FusionCell]
                            if !canotSellBuildings.contains(maps[nowMapNumber].buildingForCoord(coord)!.buildingData.buildType) {
                                money += price
                            }
                            maps[nowMapNumber].removeBuilding(coord)
                            maps[nowMapNumber].setTileMapElement(coord: coord, buildType: .Land)
                        }
                    }
                    
                // Build Select Page
                case buildingSelectLayer:
                    let nodes = nodesAtPoint(location)
                    for node in nodes {
                        if node.hidden { return }
                        if node.name == "BuildingSelectElementBackground" {
                            let buildType = (node.parent as! BuildingSelectElement).buildType
                            bottomLayer.pageBuild.changeSelectBuildType(buildType)
                        }
                    }
                    
                default:
                    break
                }
            }
        }
    }
    
    override func update(currentTime: CFTimeInterval) {
        // Updata text imformation
        topLayer.moneyLabel.text = "Money: \(money) + \(maps[nowMapNumber].money_TickAdd)"
        topLayer.researchLabel.text = "Research: \(research) + \(maps[nowMapNumber].research_TickAdd)"
        let percent = CGFloat(maps[nowMapNumber].energy) / CGFloat(maps[nowMapNumber].energyMax)
        bottomLayer.pageEnergy.progressPercent(percent)
        bottomLayer.pageEnergy.energyLabel.text = "\(maps[nowMapNumber].energy) / \(maps[nowMapNumber].energyMax)"
    }
    
    func tickUpdata() {
        
        for i in 0...1 {
            // Update map data
            maps[i].Update()
            // Calculate money and research
            money += maps[i].money_TickAdd
            research += maps[i].research_TickAdd
        }
        
        // Update information
        bottomLayer.pageInformation.changeInformation(info_Building.buildingData)
        // draw energy circle
        let percent = CGFloat(maps[nowMapNumber].energy) / CGFloat(maps[nowMapNumber].energyMax)
        buttonLayer.drawEnergyCircle(percent)
        
        
        
//        print((maps[0].buildings[0][0]! as Building).buildingData.timeSystem?.rebuild)
        //        save()
    }
    //    func save() {
    //        defaults.setInteger(money, forKey: "Money")
    //    }
}