//
//  GameScene.swift
//  Energy
//
//  Created by javan.chen on 2015/12/1.
//  Copyright (c) 2015年 Javan chen. All rights reserved.
//

import SpriteKit

enum TouchType: Int {
    case Nil, Sell, Build, Reserch
}

class GameScene: SKScene {
    var colorEnergy = UIColor(red: 0.519, green: 0.982, blue: 1.000, alpha: 1.000)
    var colorReserch = UIColor(red: 0.231, green: 0.705, blue: 0.275, alpha: 1.000)
    
    var framescale: CGFloat!
    let tilesize = CGSizeMake(64, 64)
    let topsize = CGSizeMake(9, 2)
    let midsize = CGSizeMake(9, 11)
    var topArea: SKSpriteNode!
    var midArea: SKSpriteNode!
    var botArea: SKSpriteNode!
    var touchType: TouchType = .Nil
    
    var gameTimer: NSTimer!
    var buildingMap: BuildingMap!
    
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
    
    var energy_maxLabel: SKLabelNode!
    var energy_Progress: SKSpriteNode!
    var energy_ProgressBack: SKSpriteNode!
    
    // OTHER
//    var defaults: NSUserDefaults!
    
    override func didMoveToView(view: SKView) {
        
        framescale = frame.size.width / (midsize.width * 64)
        
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
        addChild(botArea)
        
        gameTimer = NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector: "tickUpdata", userInfo: nil, repeats: true)
        
        buildingMap = BuildingMap()
        buildingMap.configureAtPosition(CGPoint(x: 0, y: 0), level: .One)
        buildingMap.setScale(framescale)
        midArea.addChild(buildingMap)
        buildingMap.setTileMapElement(coord: CGPoint(x: 0, y: 0), build: .Wind)
//        buildingMap.setTileMapElement(coord: CGPoint(x: 1, y: 0), build: .Fire)
//        buildingMap.setTileMapElement(coord: CGPoint(x: 2, y: 0), build: .Generator)
//        buildingMap.setTileMapElement(coord: CGPoint(x: 3, y: 0), build: .Generator)
        
        
        let gap: CGFloat = 15
        let labelsize = (topArea.size.height - gap * 4) / 3
        moneyLabel = SKLabelNode(fontNamed: "Verdana-Bold")
        moneyLabel.text = "Money: \(money) + \(money_add)"
        moneyLabel.fontColor = SKColor.yellowColor()
        moneyLabel.fontSize = labelsize
        moneyLabel.horizontalAlignmentMode = .Left
        moneyLabel.position = CGPoint(x: 16, y: gap * 3 + labelsize * 2)
        topArea.addChild(moneyLabel)
        reserchLabel = SKLabelNode(fontNamed: "Verdana-Bold")
        reserchLabel.text = "Reserch: \(reserch) + \(reserch_add)"
        reserchLabel.fontColor = colorReserch
        reserchLabel.fontSize = labelsize
        reserchLabel.horizontalAlignmentMode = .Left
        reserchLabel.position = CGPoint(x: 16, y: gap * 2 + labelsize * 1)
        topArea.addChild(reserchLabel)
        let persent = CGFloat(energy) / CGFloat(energy_max) * 100
        energyLabel = SKLabelNode(fontNamed: "Verdana-Bold")
        energyLabel.text = "Energy: \(persent)%"
        energyLabel.fontColor = colorEnergy
        energyLabel.fontSize = labelsize
        energyLabel.horizontalAlignmentMode = .Left
        energyLabel.position = CGPoint(x: 16, y: gap * 1 + labelsize * 0)
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
        
        let energy_ProgressSize = CGSize(width: botArea.size.width * 3 / 4, height: botArea.size.height / 2)
        energy_ProgressBack = SKSpriteNode(color: colorEnergy, size: energy_ProgressSize)
        energy_ProgressBack.alpha = 0.3
        energy_ProgressBack.anchorPoint = CGPoint(x: 0, y: 0.5)
        energy_ProgressBack.position = CGPoint(x: botArea.size.width / 8, y: botArea.size.height / 2)
        botArea.addChild(energy_ProgressBack)
        energy_Progress = SKSpriteNode(color: colorEnergy, size: energy_ProgressSize)
        energy_Progress.alpha = 0.7
        energy_Progress.anchorPoint = CGPoint(x: 0, y: 0.5)
        energy_Progress.position = CGPoint(x: botArea.size.width / 8, y: botArea.size.height / 2)
        botArea.addChild(energy_Progress)
        
        energy_maxLabel = SKLabelNode(fontNamed: "Verdana-Bold")
        energy_maxLabel.text = "Energy: \(energy) (Max:\(energy_max))"
        energy_maxLabel.fontColor = colorEnergy
        energy_maxLabel.fontSize = labelsize
        energy_maxLabel.horizontalAlignmentMode = .Left
        energy_maxLabel.position = CGPoint(x: botArea.size.width / 8, y: botArea.size.height * 3 / 4 + 10)
        botArea.addChild(energy_maxLabel)
        
        
        // OTHER
//        defaults = NSUserDefaults.standardUserDefaults()

    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.locationInNode(self)
            
            // touch Top Area
            if topArea.containsPoint(location) {
                let topAreaLocation = touch.locationInNode(topArea)
                
                // reset touch type
                touchType = .Nil
                buttonSell.alpha = 1
                buttonBuile.alpha = 1
                // touch build Button
                if buttonBuile.containsPoint(topAreaLocation) {
                    touchType = .Build
                    buttonBuile.alpha = 0.3
                }
                // touch SELL Button
                if buttonSell.containsPoint(topAreaLocation) {
                    touchType = .Sell
                    buttonSell.alpha = 0.3
                }
            }
            
            // touch Map Area
            if midArea.containsPoint(location) {
                let buildingmaplocation = touch.locationInNode(buildingMap)
                let coord = buildingMap.position2Coord(buildingmaplocation)
                print(coord)
                
                if touchType == .Sell {
                    if buildingMap.buildingForCoord(coord)!.activate{
                        let price = buildingMap.buildingForCoord(coord)!.buildingData.price
                        money += price
                        buildingMap.removeBuilding(coord)
                        buildingMap.setTileMapElement(coord: coord, build: .Nil)
                    }
                }

                if touchType == .Build {
                    buildingMap.setTileMapElement(coord: coord, build: .Generator)
                }
            }
            // touch Bottom Area
            if botArea.containsPoint(location) {
                let bottomLocation = touch.locationInNode(botArea)
                if touchType == .Sell {
                    if energy_ProgressBack.containsPoint(bottomLocation) {
                        money += energy
                        energy = 0
                    }
                }
                
            }
        }
    }
    
    override func update(currentTime: CFTimeInterval) {
        let persent = CGFloat(energy) / CGFloat(energy_max)
        energy_Progress.xScale = persent
    }
   
    func tickUpdata() {
        
        // 1. update map data
        buildingMap.Update()
        print(buildingMap.buildingForCoord(CGPoint(x: 0, y: 0))?.buildingData.hot_Current)
        print(buildingMap.buildingForCoord(CGPoint(x: 1, y: 0))?.buildingData.hot_Max)
        print(buildingMap.buildingForCoord(CGPoint(x: 2, y: 0))?.buildingData.hot_Current)
        print(buildingMap.buildingForCoord(CGPoint(x: 3, y: 0))?.buildingData.hot_Max)
        
        // 2. calculate reserch
        reserch += reserch_add
        
        // 3. calculate energy
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
        
        // 4. calculate money
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
        
        // 5. calculate energy max
        if energy > energy_max {
            energy = energy_max
        }
        
        // 6. updata imformation
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
