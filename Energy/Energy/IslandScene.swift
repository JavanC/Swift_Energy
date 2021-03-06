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
    var firstLoad: Bool = true
    enum TouchType: Int {
        case Information, Energy, Builded, Sell
    }
    let tilesize = CGSizeMake(64, 64)
    var gameTimer: NSTimer!
    
    var boostLayer:          BoostLayer!
    var boostArc:            SKShapeNode!
    var touchType:           TouchType = .Energy
    var topLayer:            TopLayer!
    var buttonLayer:         ButtonLayer!
    var bottomLayer:         BottomLayer!
    var buildingSelectLayer: BuildingSelectLayer!
    var teachLayer:          TeachLayer!
    var tipsLayer:           TipsLayer!
    var isShowSelectLayer:   Bool = false
    var isShowTips:          Bool = false
    var teachStep:           Int = 1
    
    var info_Building: Building!
    
    override func didMoveToView(view: SKView) {
        
        // First initial
        if !contentCreated {
            
            // Add hide ad notification
            let notificationCenter = NSNotificationCenter.defaultCenter()
            notificationCenter.addObserver(self, selector: #selector(IslandScene.hideAdSpace), name: "hideAdSpace", object: nil)
            
            // Game Timer
            gameTimer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(IslandScene.tickUpdata), userInfo: nil, repeats: true)
            
            // Top Layer (1.5/16)
            let topLayerSize = CGSizeMake(frame.width, frame.height * 1.5 / 16)
            let topLayerPosition = CGPoint(x: 0, y: frame.size.height - topLayerSize.height)
            topLayer = TopLayer()
            topLayer.configureAtPosition(topLayerPosition, size: topLayerSize)
            topLayer.zPosition = 100
            addChild(topLayer)
            
            // Map Layer (11/16)
            for map in maps {
                map.position = CGPoint(x: 0, y: frame.size.height - topLayer.size.height)
                map.xScale = frame.width / (64 * 9)
                map.yScale = frame.height / (64 * 16)
                map.hidden = true
                map.zPosition = 1
                addChild(map)
            }
            info_Building = maps[nowMapNumber].buildingForCoord(CGPoint(x: 0, y: 0))!

            // Button Layer (1.5/16)
            let buttonLayerSize = CGSizeMake(frame.width, frame.height * 1.5 / 16)
            buttonLayer = ButtonLayer()
            buttonLayer.configureAtPosition(CGPoint(x: 0, y: 0), size: buttonLayerSize)
            buttonLayer.zPosition = 200
            addChild(buttonLayer)

            // Bottom Layer (2/16)
            let bottomLayerSize = CGSizeMake(frame.width, frame.height * 2 / 16)
            let bottomLayerPosition = CGPoint(x: 0, y: buttonLayer.size.height)
            bottomLayer = BottomLayer()
            
            bottomLayer.configureAtPosition(bottomLayerPosition, size: bottomLayerSize)
            bottomLayer.zPosition = 100
            addChild(bottomLayer)
            
            // Building Select Layer
            let buildingSelectLayerSize = maps[0].size
            let buildingSelectLayerPosition = CGPoint(x: 0, y: frame.size.height - topLayer.size.height)
            buildingSelectLayer = BuildingSelectLayer(position: buildingSelectLayerPosition, midSize: buildingSelectLayerSize)
            buildingSelectLayer.zPosition = 50
            addChild(buildingSelectLayer)
            
            // Boost Layer
            boostLayer = BoostLayer(size: frame.size)
            boostLayer.name = "BoostLayer"
            boostLayer.hidden = !isBoost
            boostLayer.position = CGPoint(x: frame.width / 2, y: frame.height / 2)
            boostLayer.zPosition = 300
            addChild(boostLayer)
            
            // Tips Layer
            tipsLayer = TipsLayer(size: frame.size)
            tipsLayer.name = "tips layer"
            tipsLayer.hidden = true
            tipsLayer.position = CGPoint(x: frame.width / 2, y: frame.height / 2)
            tipsLayer.zPosition = 700
            addChild(tipsLayer)
            
            // Teach Layer
            teachLayer = TeachLayer()
            teachLayer.configureAtPosition(CGPoint(x: frame.width / 2, y: frame.height / 2), size: frame.size)
            teachLayer.zPosition = 800
            addChild(teachLayer)
            teachStep = 1
            teachLayer.changeTeachStep(teachStep)
            if !isHaveTeach {
                hasTouchAd = true
            } else {
                teachLayer.hidden = true
            }
            
            contentCreated = true
            // remove first load delay
            print("load 4")
            self.view?.presentScene(islandsScene)
        }
        
        // Only show now map
        for count in 0..<6 { maps[count].hidden = count == nowMapNumber ? false : true }

        // back to Energy type
        changeTouchTypeAndShowPage(.Energy, duration: 0)

        // reset bottom build page build menu
        bottomLayer.pageBuild.resetBuildMenu()
        
        // update boostLayer hidden
        boostLayer.hidden = !isBoost
        
        // update teach layer hidden when reset data
        if !isHaveTeach {
            teachLayer.hidden = false
            teachStep = 1
            teachLayer.changeTeachStep(teachStep)
        }

        // if not first load and is connect network, show AD
        if firstLoad {
            firstLoad = false
        } else {
            if isHaveTeach && Reachability.isConnectedToNetwork() && !hasTouchAd {
                showAdSpace()
            } else {
                hideAdSpace()
            }
        }
        
        NSNotificationCenter.defaultCenter().postNotificationName("playMusic", object: nowMapNumber + 1)
        print("load 6")
    }
    
    func showAdSpace() {
        let scale = UIScreen.mainScreen().scale
        let midheight = frame.height * 11 / 16
        let midscale = (midheight - 50 * scale) / midheight
        for map in maps {
            map.runAction(SKAction.scaleYTo(framescale * midscale, duration: 0))
        }
        buildingSelectLayer.runAction(SKAction.scaleYTo(midscale, duration: 0))
        bottomLayer.runAction(SKAction.moveToY(buttonLayer.size.height + 50 * scale, duration: 0))
        buttonLayer.runAction(SKAction.moveToY(50 * scale, duration: 0))
        RunAfterDelay(1) {
            print("show AD")
            NSNotificationCenter.defaultCenter().postNotificationName("showAd", object: nil)
        }
    }
    func hideAdSpace() {
        NSNotificationCenter.defaultCenter().postNotificationName("hideAd", object: nil)
        for map in maps {
            map.runAction(SKAction.scaleYTo(framescale, duration: 0.5))
        }
        buildingSelectLayer.runAction(SKAction.scaleYTo(1, duration: 0.5))
        bottomLayer.runAction(SKAction.moveToY(buttonLayer.size.height, duration: 0.5))
        buttonLayer.runAction(SKAction.moveToY(0, duration: 0.5))
    }
    
    func drawBoostTimeCircle(percent: Double) {
        if boostArc != nil {
            boostArc.removeFromParent()
        }
        let path = CGPathCreateMutable()
        CGPathAddArc(path, nil, 0, 0, framescale * 200, CGFloat(M_PI_2), CGFloat(M_PI_2 - M_PI * 2 * Double(percent)), true)
        boostArc = SKShapeNode(path: path)
        boostArc.lineWidth = framescale * 10
        boostLayer.addChild(boostArc)
    }
    
    func showBuildSelectPage() {
        // update and change now select building color
        buildingSelectLayer.updateSelectLayer()
        buildingSelectLayer.changePage(bottomLayer.pageBuild.selectNumber)
        let buildType = bottomLayer.pageBuild.buildMenu[bottomLayer.pageBuild.selectNumber]
        buildingSelectLayer.changeSelectBox(buildType)
        
        // hide map and show building select page
        maps[nowMapNumber].runAction(SKAction.sequence([SKAction.waitForDuration(0.2), SKAction.hide()]))
        bottomLayer.pageBuild.openSelectInformation()
        buildingSelectLayer.showPage(true)
    }
    
    func changeTouchTypeAndShowPage(touchType: TouchType, duration: Double = 0.0) {
        self.touchType = touchType
        maps[nowMapNumber].removeAllActions()
        maps[nowMapNumber].hidden = false
        maps[nowMapNumber].selectInfoBox.hidden = true
        bottomLayer.pageBuild.closeSelectInformation()
        if duration == 0 {
            buildingSelectLayer.showPage(false, duration: 0)
        } else {
            buildingSelectLayer.showPage(false)
        }
        switch touchType {
        case .Information:
            maps[nowMapNumber].selectInfoBox.hidden = false
            buttonLayer.tapButtonNil(duration)
            bottomLayer.showPage(BottomLayer.PageType.PageInformation, duration: duration)
            
        case .Energy:
            bottomLayer.showPage(BottomLayer.PageType.PageEnergy, duration: duration)
            if duration == 0 {
                buttonLayer.beginButtonEnergy()
            } else {
                buttonLayer.tapButtonEnergy(duration)
            }
            
        case .Builded:
            buttonLayer.tapButtonBuild(duration)
            bottomLayer.showPage(BottomLayer.PageType.PageBuild, duration: duration)
            
        case .Sell:
            buttonLayer.tapButtonSell(duration)
            bottomLayer.showPage(BottomLayer.PageType.PageSell, duration: duration)
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.locationInNode(self)
        let nodes = nodesAtPoint(location)
        
        if !isHaveTeach {
            for node in nodes {
                if node.hidden { return }
                if teachStep == 1 && node == teachLayer.OKButton {
                    teachStep = 2
                    teachLayer.changeTeachStep(teachStep)
                    if !isSoundMute{ runAction(soundClick) }
                    teachLayer.OKButton.hidden = true
                }
                if teachStep == 2 && node == buttonLayer.buttonBuild {
                    teachStep = 3
                    teachLayer.changeTeachStep(teachStep)
                    if !isSoundMute{ runAction(soundClick) }
                    changeTouchTypeAndShowPage(.Builded, duration: 0.1)
                }
                if teachStep == 3 && node == bottomLayer.pageBuild.images[0] {
                    teachStep = 4
                    teachLayer.changeTeachStep(teachStep)
                    if !isSoundMute{ runAction(soundSelect) }
                    showBuildSelectPage()
                }
                if teachStep == 4 && node == bottomLayer.pageBuild.selectInfo {
                    teachStep = 5
                    teachLayer.changeTeachStep(teachStep)
                    if !isSoundMute{ runAction(soundSelect) }
                    changeTouchTypeAndShowPage(.Builded, duration: 0.1)
                }
                if teachStep == 5 && node == maps[0].buildingForCoord(CGPoint(x: 5, y: 8))!.buildingNode {
                    teachStep = 6
                    teachLayer.changeTeachStep(teachStep)
                    if !isSoundMute{ runAction(soundPlacing) }
                    maps[nowMapNumber].setTileMapElement(coord: CGPoint(x: 5, y: 8), buildType: .WindTurbine)
                    money -= 1
                    return
                }
                if teachStep == 6 && node == maps[0].buildingForCoord(CGPoint(x: 5, y: 8))!.buildingNode {
                    teachStep = 7
                    teachLayer.changeTeachStep(teachStep)
                    if !isSoundMute{ runAction(soundClick) }
                    info_Building = maps[nowMapNumber].buildingForCoord(CGPoint(x: 5, y: 8))
                    bottomLayer.pageInformation.changeInformation(info_Building.buildingData)
                    changeTouchTypeAndShowPage(.Information, duration: 0.1)
                }
                if teachStep == 7 && node == buttonLayer.buttonEnergy {
                    teachStep = 8
                    teachLayer.changeTeachStep(teachStep)
                    if !isSoundMute{ runAction(soundClick) }
                    changeTouchTypeAndShowPage(.Energy, duration: 0.1)
                }
                if teachStep == 8 && node == bottomLayer.pageEnergy.energy_ProgressBack {
                    teachStep = 9
                    teachLayer.changeTeachStep(teachStep)
                    if !isSoundMute{ runAction(soundSell) }
                    money += maps[nowMapNumber].energy
                    maps[nowMapNumber].energy = 0
                    // draw energy circle
                    let percent = Double(maps[nowMapNumber].energy) / Double(maps[nowMapNumber].energyMax)
                    buttonLayer.drawEnergyCircle(percent)
                    teachLayer.OKButton.hidden = false
                }
                if teachStep == 9 && node == teachLayer.OKButton {
                    teachStep = 10
                    teachLayer.changeTeachStep(teachStep)
                    if !isSoundMute{ runAction(soundClick) }
                    return
                }
                if teachStep == 10 && node == teachLayer.OKButton {
                    teachStep = 11
                    teachLayer.changeTeachStep(teachStep)
                    if !isSoundMute{ runAction(soundClick) }
                    return
                }
                if teachStep == 11 && node == teachLayer.OKButton {
                    teachStep = 12
                    teachLayer.changeTeachStep(teachStep)
                    if !isSoundMute{ runAction(soundClick) }
                    return
                }
                if teachStep == 12 && node == teachLayer.OKButton {
                    teachStep = 13
                    teachLayer.changeTeachStep(teachStep)
                    if !isSoundMute{ runAction(soundClick) }
                    return
                }
                if teachStep == 13 && node == teachLayer.OKButton {
                    if !isSoundMute{ runAction(soundClick) }
                    teachLayer.hidden = true
                    isHaveTeach = true
                }
            }
            return
        }
        
        if isBoost {
            for node in nodes {
                if node.hidden { return }
                if node == topLayer.buttonMenu {
                    print("Menu Button")
                    self.view?.presentScene(islandsScene, transition: door_Fade)
                }
            }
            return
        }
        
        if isShowTips {
            for node in nodes {
                if node.hidden { return }
                if node == tipsLayer.OKButton {
                    print("tips ok button")
                    isShowTips = false
                    tipsLayer.showLayer(isShowTips)
                    if !isSoundMute{ runAction(soundClick) }
                }
            }
            return
        }
        
        for node in nodes {
            if node.hidden { return }
            switch node {
            // Button
            case topLayer.buttonMenu:
                print("Menu Button")
                if !isSoundMute{ runAction(soundTap) }
                self.view?.presentScene(islandsScene, transition: door_Fade)
                
            case topLayer.buttonTips:
                print("Tips Button")
                if !isSoundMute{ runAction(soundTap) }
                isShowTips = true
                tipsLayer.showLayer(isShowTips)
                
            case topLayer.buttonPlayPause:
                print("Pause: \(isPause)")
                if !isSoundMute{ runAction(soundTap) }
                isPause = !isPause
                topLayer.isPauseChange()
 
                /////// GM Test
                // hideAdSpace()
                // money = money * 10
                // research = research * 10
                
            case buttonLayer.buttonBuild:
                print("Build Button")
                if !isSoundMute{ runAction(soundClick) }
                changeTouchTypeAndShowPage(.Builded, duration: 0.1)
                
            case buttonLayer.buttonSell:
                print("Sell Button")
                if !isSoundMute{ runAction(soundClick) }
                changeTouchTypeAndShowPage(.Sell, duration: 0.1)
                
            case buttonLayer.buttonEnergy:
                print("Energy Button")
                if !isSoundMute{ runAction(soundClick) }
                changeTouchTypeAndShowPage(.Energy, duration: 0.1)
                
            case buttonLayer.buttonUpgrade:
                print("Upgrade Button")
                if !isSoundMute{ runAction(soundClick) }
                buttonLayer.tapButtonUpgrade()
                RunAfterDelay(0.8) {
                    self.view?.presentScene(upgradeScene, transition: door_Float)
                }
                
            case buttonLayer.buttonResearch:
                print("Research Button")
                if !isSoundMute{ runAction(soundClick) }
                buttonLayer.tapButtonResearch()
                RunAfterDelay(0.8) {
                    self.view?.presentScene(researchScene, transition: door_Float)
                }
                
            /////// GM Test 2
            // case bottomLayer.pageSell:
            //     isBoost = true
            //     spendTime += 600
            //     for _ in 1...600 {
            //         for i in 0..<6 {
            //             if maps[i].isSold {
            //                 // Update map data
            //                 maps[i].Update()
            //                 // Calculate money and research
            //                 money       += maps[i].money_TickAdd
            //                 research    += maps[i].research_TickAdd
            //             }
            //         }
            //     }
            //     isBoost = false
                
            // Energy Page
            case bottomLayer.pageEnergy.energy_ProgressBack:
                print("Energy Preogree")
                if !isSoundMute{ runAction(soundSell) }
                money += maps[nowMapNumber].energy
                maps[nowMapNumber].energy = 0
                // draw energy circle
                let percent = Double(maps[nowMapNumber].energy) / Double(maps[nowMapNumber].energyMax)
                buttonLayer.drawEnergyCircle(percent)
                
            // Builded Page
            case bottomLayer.pageBuild.images[0]:
                print("Builded image1")
                if !isSoundMute{ runAction(soundSelect) }
                if bottomLayer.pageBuild.selectNumber == 0 { showBuildSelectPage() }
                bottomLayer.pageBuild.changeSelectNumber(0)
                
            case bottomLayer.pageBuild.images[1]:
                print("Builded image2")
                if !isSoundMute{ runAction(soundSelect) }
                if bottomLayer.pageBuild.selectNumber == 1 { showBuildSelectPage() }
                bottomLayer.pageBuild.changeSelectNumber(1)
                
            case bottomLayer.pageBuild.images[2]:
                print("Builded image3")
                if !isSoundMute{ runAction(soundSelect) }
                if bottomLayer.pageBuild.selectNumber == 2 { showBuildSelectPage() }
                bottomLayer.pageBuild.changeSelectNumber(2)
                
            case bottomLayer.pageBuild.images[3]:
                print("Builded image4")
                if !isSoundMute{ runAction(soundSelect) }
                if bottomLayer.pageBuild.selectNumber == 3 { showBuildSelectPage() }
                bottomLayer.pageBuild.changeSelectNumber(3)
                
            case bottomLayer.pageBuild.rebuildButton:
                print("rebuild button")
                if !isSoundMute{ runAction(soundSelect) }
                isRebuild = !isRebuild
                bottomLayer.pageBuild.rebuildOn(isRebuild)
                
            case bottomLayer.pageBuild.selectInfo:
                print("Builded select info")
                if !isSoundMute{ runAction(soundSelect) }
                changeTouchTypeAndShowPage(.Builded, duration: 0.1)
                
            // Build Select Page
            case buildingSelectLayer:
                let nodes = nodesAtPoint(location)
                for node in nodes {
                    if node.hidden { return }
                    if node.name == "BuildingSelectElementBackground" {
                        if !isSoundMute{ runAction(soundSelect) }
                        let buildType = (node as! BuildingSelectElement).buildType
                        bottomLayer.pageBuild.changeSelectBuildType(buildType)
                        buildingSelectLayer.changeSelectBox(buildType)
                    }
                }
                
            // Building Map
            case maps[nowMapNumber]:
                print("Building Map Layer")
                let buildingmaplocation = touch.locationInNode(maps[nowMapNumber])
                let coord = maps[nowMapNumber].position2Coord(buildingmaplocation)
                switch touchType {
                case .Information, .Energy:
                    if maps[nowMapNumber].buildingForCoord(coord)!.activate {
                        if !isSoundMute{ runAction(soundClick) }
                        maps[nowMapNumber].selectBoxChange(coord)
                        info_Building = maps[nowMapNumber].buildingForCoord(coord)
                        bottomLayer.pageInformation.changeInformation(info_Building.buildingData)
                        changeTouchTypeAndShowPage(.Information, duration: 0.1)
                    }
                    
                case .Builded:
                    if maps[nowMapNumber].buildingForCoord(coord)!.activate {
                        if !isSoundMute{ runAction(soundClick) }
                        maps[nowMapNumber].selectBoxChange(coord)
                        info_Building = maps[nowMapNumber].buildingForCoord(coord)
                        bottomLayer.pageInformation.changeInformation(info_Building.buildingData)
                        changeTouchTypeAndShowPage(.Information, duration: 0.1)
                    } else {
                        let building = bottomLayer.pageBuild.buildMenu[bottomLayer.pageBuild.selectNumber]
                        let price = BuildingData.init(buildType: building).buildPrice
                        let coordType = maps[nowMapNumber].buildingForCoord(coord)?.buildingData.buildType
                        func construct() {
                            if money >= price {
                                if !isSoundMute{ runAction(soundPlacing) }
                                maps[nowMapNumber].setTileMapElement(coord: coord, buildType: building)
                                money -= price
                                if !isFinishTarget {
                                    finishBuilding += 1
                                }
                            } else {
                                if !isSoundMute{ runAction(soundTap) }
                                let noMoneyLabel = SKLabelNode(fontNamed: "SanFranciscoRounded-Black".localized)
                                noMoneyLabel.name = "noMoneyLabel"
                                noMoneyLabel.text = "You don't have enough money.".localized
                                noMoneyLabel.fontSize = 30 * framescale
                                noMoneyLabel.verticalAlignmentMode = .Center
                                noMoneyLabel.position = CGPoint(x: frame.width / 2, y: frame.height / 2)
                                noMoneyLabel.zPosition = 250
                                let float = SKAction.moveByX(0, y: 30 * framescale, duration: 1)
                                let group = SKAction.group([float, SKAction.fadeOutWithDuration(1.5)])
                                let action = SKAction.sequence([group, SKAction.removeFromParent()])
                                noMoneyLabel.runAction(action)
                                addChild(noMoneyLabel)
                            }
                        }
                        if building == BuildingType.WaveCell {
                            if coordType == .Ocean || coordType == .WaveCell {
                                construct()
                            }
                        } else if building == BuildingType.WaterPump {
                            func isWaterside(coord: CGPoint) -> Bool {
                                if let left = maps[nowMapNumber].buildingForCoord(CGPoint(x: coord.x - 1, y: coord.y))?.buildingData.buildType {
                                    if left == .Ocean || left == .WaveCell { return true }
                                }
                                if let right = maps[nowMapNumber].buildingForCoord(CGPoint(x: coord.x + 1, y: coord.y))?.buildingData.buildType {
                                    if right == .Ocean || right == .WaveCell { return true }
                                }
                                if let down = maps[nowMapNumber].buildingForCoord(CGPoint(x: coord.x, y: coord.y - 1))?.buildingData.buildType {
                                    if down == .Ocean || down == .WaveCell { return true }
                                }
                                if let up = maps[nowMapNumber].buildingForCoord(CGPoint(x: coord.x, y: coord.y + 1))?.buildingData.buildType {
                                    if up == .Ocean || up == .WaveCell { return true }
                                }
                                return false
                            }
                            if coordType != .Ocean && coordType != .WaveCell && coordType != .Rock && isWaterside(coord) {
                                construct()
                            }
                        } else {
                            if coordType != .Ocean && coordType != .WaveCell && coordType != .Rock {
                                construct()
                            }
                        }
                    }
                    
                case .Sell:
                    let coordType = maps[nowMapNumber].buildingForCoord(coord)!.buildingData.buildType
                    if maps[nowMapNumber].buildingForCoord(coord)!.activate {
                        if coordType == .Garbage { return }
                        if !isSoundMute{ runAction(soundSell) }
                        let price = maps[nowMapNumber].buildingForCoord(coord)!.buildingData.buildPrice
                        let canotSellBuildings: [BuildingType] = [.WindTurbine, .SolarCell, .CoalBurner, .WaveCell, .GasBurner, .NuclearCell, .FusionCell]
                        if !canotSellBuildings.contains(coordType) {
                            money += price
                        }
                        maps[nowMapNumber].removeBuilding(coord)
                        if coordType == .WaveCell {
                            maps[nowMapNumber].setTileMapElement(coord: coord, buildType: .Ocean)
                        } else {
                            maps[nowMapNumber].setTileMapElement(coord: coord, buildType: .Land)
                        }
                    } else {
                        if coordType != .Land && coordType != .Ocean && coordType != .Rock {
                            if coordType == .WaveCell {
                                maps[nowMapNumber].setTileMapElement(coord: coord, buildType: .Ocean)
                            } else {
                                maps[nowMapNumber].setTileMapElement(coord: coord, buildType: .Land)
                            }
                        }
                    }
                }
                
            default:
                break
            }
        }
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if !isHaveTeach || isShowTips || isBoost { return }
        guard let touch = touches.first else { return }
        let location = touch.locationInNode(self)
        let nodes = nodesAtPoint(location)
        
        for node in nodes {
            if node.hidden { return }
            
            // Move builded and sell building
            if node == maps[nowMapNumber] {
                let buildingmaplocation = touch.locationInNode(maps[nowMapNumber])
                let coord = maps[nowMapNumber].position2Coord(buildingmaplocation)
                switch touchType {
                case .Builded:
                    if !maps[nowMapNumber].buildingForCoord(coord)!.activate {
                        let building = bottomLayer.pageBuild.buildMenu[bottomLayer.pageBuild.selectNumber]
                        let price = BuildingData.init(buildType: building).buildPrice
                        let coordType = maps[nowMapNumber].buildingForCoord(coord)?.buildingData.buildType
                        func construct() {
                            if money >= price {
                                if !isSoundMute{ runAction(soundPlacing) }
                                maps[nowMapNumber].setTileMapElement(coord: coord, buildType: building)
                                money -= price
                                if !isFinishTarget {
                                    finishBuilding += 1
                                }
                            }
                        }
                        if building == BuildingType.WaveCell {
                            if coordType == .Ocean || coordType == .WaveCell {
                                construct()
                            }
                        } else if building == BuildingType.WaterPump {
                            func isWaterside(coord: CGPoint) -> Bool {
                                if let left = maps[nowMapNumber].buildingForCoord(CGPoint(x: coord.x - 1, y: coord.y))?.buildingData.buildType {
                                    if left == .Ocean || left == .WaveCell { return true }
                                }
                                if let right = maps[nowMapNumber].buildingForCoord(CGPoint(x: coord.x + 1, y: coord.y))?.buildingData.buildType {
                                    if right == .Ocean || right == .WaveCell { return true }
                                }
                                if let down = maps[nowMapNumber].buildingForCoord(CGPoint(x: coord.x, y: coord.y - 1))?.buildingData.buildType {
                                    if down == .Ocean || down == .WaveCell { return true }
                                }
                                if let up = maps[nowMapNumber].buildingForCoord(CGPoint(x: coord.x, y: coord.y + 1))?.buildingData.buildType {
                                    if up == .Ocean || up == .WaveCell { return true }
                                }
                                return false
                            }
                            if coordType != .Ocean && coordType != .WaveCell && coordType != .Rock && isWaterside(coord) {
                                construct()
                            }
                        } else {
                            if coordType != .Ocean && coordType != .WaveCell && coordType != .Rock {
                                construct()
                            }
                        }
                    }
                    
                case .Sell:
                    let coordType = maps[nowMapNumber].buildingForCoord(coord)!.buildingData.buildType
                    if maps[nowMapNumber].buildingForCoord(coord)!.activate {
                        if coordType == .Garbage { return }
                        if !isSoundMute{ runAction(soundSell) }
                        let price = maps[nowMapNumber].buildingForCoord(coord)!.buildingData.buildPrice
                        let canotSellBuildings: [BuildingType] = [.WindTurbine, .SolarCell, .CoalBurner, .WaveCell, .GasBurner, .NuclearCell, .FusionCell]
                        if !canotSellBuildings.contains(maps[nowMapNumber].buildingForCoord(coord)!.buildingData.buildType) {
                            money += price
                        }
                        if coordType == .WaveCell {
                            maps[nowMapNumber].setTileMapElement(coord: coord, buildType: .Ocean)
                        } else {
                            maps[nowMapNumber].setTileMapElement(coord: coord, buildType: .Land)
                        }
                    } else {
                        if coordType != .Land && coordType != .Ocean && coordType != .Rock {
                            if coordType == .WaveCell {
                                maps[nowMapNumber].setTileMapElement(coord: coord, buildType: .Ocean)
                            } else {
                                maps[nowMapNumber].setTileMapElement(coord: coord, buildType: .Land)
                            }
                        }
                    }
                
                default : break
                }
            }
        }
    }
    
    override func update(currentTime: CFTimeInterval) {
        // Boost Layer
        if isBoost {
            NSThread.sleepForTimeInterval(0.1)
            boostLayer.alpha = 1
            boostLayer.hidden = false
            let percent = boostTimeLess / boostTime
            drawBoostTimeCircle(percent)
        } else {
            boostLayer.runAction(SKAction.sequence([SKAction.fadeOutWithDuration(0.2), SKAction.waitForDuration(0.2), SKAction.hide()]))
        }

        // Updata text imformation
        topLayer.moneyLabel.text = "\(numberToString(money)) + \(numberToString(maps[nowMapNumber].money_TickAdd))"
        topLayer.researchLabel.text = "\(numberToString(research)) + \(numberToString(maps[nowMapNumber].research_TickAdd))"
        let percent = CGFloat(maps[nowMapNumber].energy) / CGFloat(maps[nowMapNumber].energyMax)
        bottomLayer.pageEnergy.progressPercent(percent)
        bottomLayer.pageEnergy.energyLabel.text = "\(numberToString(maps[nowMapNumber].energy)) / \(numberToString(maps[nowMapNumber].energyMax, isInt: true))"
        bottomLayer.pageEnergy.energyTickAddLabel.text = "+\(numberToString(maps[nowMapNumber].energy_TickAdd))"
    }
    
    func tickUpdata() {
        
        if isBoost || isPause { return }
        
        spendTime += 1
        
        for i in 0..<6 {
            if maps[i].isSold {
                // Update map data
                maps[i].Update()
                // Calculate money and research
                money       += maps[i].money_TickAdd
                research    += maps[i].research_TickAdd
            }
        }
        
        // Update information
        self.bottomLayer.pageInformation.changeInformation(self.info_Building.buildingData)
        // draw energy circle
        let percent = Double(maps[nowMapNumber].energy) / Double(maps[nowMapNumber].energyMax)
        self.buttonLayer.drawEnergyCircle(percent)
    }
}