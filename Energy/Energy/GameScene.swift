//
//  GameScene.swift
//  Energy
//
//  Created by javan.chen on 2015/12/1.
//  Copyright (c) 2015年 Javan chen. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    var framescale: CGFloat!
    let tilesize = CGSizeMake(64, 64)
    let topsize = CGSizeMake(9, 2)
    let midsize = CGSizeMake(9, 11)
    var topArea: SKSpriteNode!
    var midArea: SKSpriteNode!
    var botArea: SKSpriteNode!
    
    var gameTimer: NSTimer!
    var buildingMap: BuildingMap!
    
    var moneyLabel: SKLabelNode!
    var money: Int = 10
    var money_add: Int = 0
    var reserchLabel: SKLabelNode!
    var reserch: Int = 0
    var reserch_add: Int = 0
    var energyLabel: SKLabelNode!
    var energy: Int = 1000
    var energy_add: Int = 0
    var energy_maxLabel: SKLabelNode!
    var energy_max: Int = 100
    var energySellButton: SKLabelNode!
    var rebuildButton: SKLabelNode!
    
    // OTHER
//    var defaults: NSUserDefaults!
    // BOTTOM
//    var choiceshow: SKSpriteNode!
//    var choicename: String = "s"
//    var test: SKSpriteNode!
    
//    var component = [String: SKSpriteNode]()
    
    override func didMoveToView(view: SKView) {
        
        framescale = frame.size.width / (midsize.width * 64)
        
        topArea = SKSpriteNode(color: UIColor.grayColor(), size: CGSizeMake(frame.size.width, topsize.height * tilesize.height * framescale))
        topArea.name = "topArea"
        topArea.anchorPoint = CGPoint(x: 0, y: 0)
        topArea.position = CGPoint(x: 0, y: frame.size.height - topArea.size.height)
        addChild(topArea)
        midArea = SKSpriteNode(color: UIColor.whiteColor(), size: CGSizeMake(frame.size.width, midsize.height * tilesize.height * framescale))
        midArea.name = "midArea"
        midArea.anchorPoint = CGPoint(x: 0, y: 1)
        midArea.position = CGPoint(x: 0, y: frame.size.height - topArea.size.height)
        addChild(midArea)
        botArea = SKSpriteNode(color: UIColor.blackColor(), size: CGSizeMake(frame.size.width, frame.size.height - (topsize.height + midsize.height) * tilesize.height * framescale))
        botArea.name = "botArea"
        botArea.anchorPoint = CGPoint(x: 0, y: 0)
        botArea.position = CGPoint(x: 0, y: 0)
        addChild(botArea)
        
        gameTimer = NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector: "tickUpdata", userInfo: nil, repeats: true)
        
        buildingMap = BuildingMap()
        buildingMap.configureAtPosition(CGPoint(x: 0, y: 0), level: .One)
        buildingMap.setScale(framescale)
        midArea.addChild(buildingMap)
        
        let gap: CGFloat = 12
        let labelsize = (topArea.size.height - gap * 5) / 4
        moneyLabel = SKLabelNode(fontNamed: "Verdana-Bold")
        moneyLabel.text = "Money: \(money) + \(money_add)"
        moneyLabel.fontColor = UIColor.yellowColor()
        moneyLabel.fontSize = labelsize
        moneyLabel.horizontalAlignmentMode = .Left
        moneyLabel.position = CGPoint(x: 16, y: gap * 4 + labelsize * 3)
        topArea.addChild(moneyLabel)
        reserchLabel = SKLabelNode(fontNamed: "Verdana-Bold")
        reserchLabel.text = "Reserch: \(reserch) + \(reserch_add)"
        reserchLabel.fontColor = UIColor.greenColor()
        reserchLabel.fontSize = labelsize
        reserchLabel.horizontalAlignmentMode = .Left
        reserchLabel.position = CGPoint(x: 16, y: gap * 3 + labelsize * 2)
        topArea.addChild(reserchLabel)
        energyLabel = SKLabelNode(fontNamed: "Verdana-Bold")
        energyLabel.text = "Energy: \(energy) + \(energy_add)"
        energyLabel.fontColor = UIColor.blueColor()
        energyLabel.fontSize = labelsize
        energyLabel.horizontalAlignmentMode = .Left
        energyLabel.position = CGPoint(x: 16, y: gap * 2 + labelsize * 1)
        topArea.addChild(energyLabel)
        energy_maxLabel = SKLabelNode(fontNamed: "Verdana-Bold")
        energy_maxLabel.text = "EnergyMax: \(energy_max)"
        energy_maxLabel.fontColor = UIColor.blueColor()
        energy_maxLabel.fontSize = labelsize
        energy_maxLabel.horizontalAlignmentMode = .Left
        energy_maxLabel.position = CGPoint(x: 16, y: gap * 1)
        topArea.addChild(energy_maxLabel)
        energySellButton = SKLabelNode(fontNamed: "Verdana-Bold")
        energySellButton.text = "SELL"
        energySellButton.fontColor = UIColor.blueColor()
        energySellButton.fontSize = labelsize * 2
        energySellButton.horizontalAlignmentMode = .Right
        energySellButton.position = CGPoint(x: topArea.size.width - 16, y: gap * 1)
        topArea.addChild(energySellButton)
        
        // OTHER
//        defaults = NSUserDefaults.standardUserDefaults()
        
        // BOTTOM
//        choiceshow = SKSpriteNode(color: UIColor.redColor(), size: CGSize(width: 74, height: 74))
//        choiceshow.alpha = 0
//        choiceshow.zPosition = 4
//        addChild(choiceshow)
//
//        
//        a1 = SKSpriteNode(imageNamed: "block")
//        a1.name = "x"
//        a1.position = CGPoint(x: bottomArea.size.width / 4.0, y: bottomArea.size.height / 2.0)
//        a1.zPosition = 3
//        bottomArea.addChild(a1)
//        
//        b1 = SKSpriteNode(imageNamed: "風力")
//        b1.name = "s"
//        b1.position = CGPoint(x: bottomArea.size.width * 2 / 4.0, y: bottomArea.size.height / 2.0)
//        b1.zPosition = 3
//        bottomArea.addChild(b1)
//        
//        f1 = SKSpriteNode(imageNamed: "辦公室1")
//        f1.name = "o"
//        f1.position = CGPoint(x: bottomArea.size.width * 3 / 4.0, y: bottomArea.size.height / 2.0)
//        f1.zPosition = 3
//        bottomArea.addChild(f1)
//        
//        
//        
//        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.locationInNode(self)
            
            // touch Map Area
            if midArea.containsPoint(location) {
                let buildingmaplocation = touch.locationInNode(buildingMap)
                let coord = buildingMap.Position2Coord(buildingmaplocation)
                print(coord)
                
                buildingMap.SetTileMapElement(coord: coord, build: .Fire)
                // updata imformation
            }
            
            // touch SELL Button
            if energySellButton.containsPoint(touch.locationInNode(topArea)) {
                money += energy
                energy = 0
            }
        }
    }
    
    override func update(currentTime: CFTimeInterval) {

    }
   
    func tickUpdata() {
        
        buildingMap.Update()
        print("Wind:" + String(buildingMap.GetBuildingNumber(.Wind)))
        print("Fire:" + String(buildingMap.GetBuildingNumber(.Fire)))
        print("Office:" + String(buildingMap.GetBuildingNumber(.Office)))
        
        //計算研究生產量
        reserch += reserch_add
        //計算能源生產量
        let WindNum = buildingMap.GetBuildingNumber(.Wind)
        energy_add = WindNum * BuildinfData(building: .Wind, level: 1).produceEnergy
        energy += energy_add
        //計算金錢生產量
        let OfficeNum = buildingMap.GetBuildingNumber(.Office)
        money_add = OfficeNum * BuildinfData(building: .Office, level: 1).ProduceMoney
        if energy >= money_add {
            money += money_add
            energy -= money_add
        } else {
            money_add = energy
            money += money_add
            energy = 0
        }
        //計算能源上限
        if energy > energy_max {
            energy = energy_max
        }
        
        // updata imformation
        moneyLabel.text = "Money: \(money) + \(money_add)"
        reserchLabel.text = "Reserch: \(reserch) + \(reserch_add)"
        energyLabel.text = "Energy: \(energy) + \(energy_add)"
        energy_maxLabel.text = "EnergyMax: \(energy_max)"
        
        //        save()
    }
//    func save() {
//        defaults.setInteger(money, forKey: "Money")
//    }
}
