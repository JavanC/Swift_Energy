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
    
    var contentCreated: Bool = false
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
        
        // First initial
        if !contentCreated {
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
            let mapLayerSize = CGSizeMake(tilesScaleSize.width * midTileSize.width, tilesScaleSize.height * midTileSize.height)
            for count in 0..<8 {
                maps[count].position = CGPoint(x: 0, y: frame.size.height - topLayer.size.height)
                maps[count].setScale(framescale)
                maps[count].zPosition = 1
                addChild(maps[count])
            }
            maps[0].setTileMapElement(coord: CGPoint(x: 1, y: 0), buildType: BuildingType.WindTurbine)
            maps[0].setTileMapElement(coord: CGPoint(x: 0, y: 1), buildType: BuildingType.SmallGenerator)
            maps[0].setTileMapElement(coord: CGPoint(x: 1, y: 1), buildType: BuildingType.CoalBurner)
            maps[0].setTileMapElement(coord: CGPoint(x: 2, y: 1), buildType: BuildingType.SmallGenerator)
            maps[0].setTileMapElement(coord: CGPoint(x: 0, y: 0), buildType: BuildingType.SmallOffice)
            maps[1].setTileMapElement(coord: CGPoint(x: 1, y: 0), buildType: BuildingType.WindTurbine)
            info_Building = maps[nowMapNumber].buildingForCoord(CGPoint(x: 0, y: 0))!
            
            // Button Layer
            let buttonLayerSize = CGSizeMake(frame.size.width, 100)
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
            
            contentCreated = true
        }
        
        // Only show now map
        for count in 0..<8 { maps[count].hidden = true }
        maps[nowMapNumber].hidden = false
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
            buttonLayer.tapButtonBuild()
            bottomLayer.ShowPageBuild()
            
        case .Sell:
            buttonLayer.tapButtonSell()
            bottomLayer.showPageSell()
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
                    let doors = SKTransition.moveInWithDirection(SKTransitionDirection.Left, duration: 0.3)
                    self.view?.presentScene(islandsScene, transition: doors)
                    
                case topLayer.buttonPause:
                    print("Pause: \(isPause)")
                    isPause = !isPause
                    if isPause { gameTimer.invalidate() }
                    else { gameTimer = NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector: "tickUpdata", userInfo: nil, repeats: true) }
                    
                case buttonLayer.buttonBuild:
                    print("Build Button")
                    changeTouchTypeAndShowPage(.Builded)
                    
                case buttonLayer.buttonSell:
                    print("Sell Button")
                    changeTouchTypeAndShowPage(.Sell)
                    
                case buttonLayer.buttonEnergy:
                    print("Energy Button")
                    changeTouchTypeAndShowPage(.Energy)
                    
                case buttonLayer.buttonUpgrade:
                    print("Upgrade Button")
                    let doors = SKTransition.moveInWithDirection(SKTransitionDirection.Down, duration: 0.3)
                    self.view?.presentScene(upgradeScene, transition: doors)
                    
                case buttonLayer.buttonReserch:
                    print("Reserch Button")
                    let doors = SKTransition.moveInWithDirection(SKTransitionDirection.Down, duration: 0.3)
                    self.view?.presentScene(reserchScene, transition: doors)
                
                // Energy Page
                case bottomLayer.pageEnergy.energy_ProgressBack:
                    print("Energy Preogree")
                    money += maps[nowMapNumber].energy
                    maps[nowMapNumber].energy = 0
                    
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
                    for count in 0..<8 { maps[count].autoRebuild = !maps[count].autoRebuild }
                    bottomLayer.pageBuild.rebuildButton.color = (maps[nowMapNumber].autoRebuild ? SKColor.greenColor() : SKColor.redColor())
                    
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
        
        buildingSelectLayer.updateSelectLayer()
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