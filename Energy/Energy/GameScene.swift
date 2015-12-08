//
//  GameScene.swift
//  Energy
//
//  Created by javan.chen on 2015/12/1.
//  Copyright (c) 2015年 Javan chen. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    // OTHER
    var gameTimer: NSTimer!
    var defaults: NSUserDefaults!
    var framescale: CGFloat!
    
    // TOP
    var topArea: SKSpriteNode!
    var moneyLabel: SKLabelNode!
    var money: Int = 10
    var money_add: Int = 0
    var energyLabel: SKLabelNode!
    var energy: Int = 0
    var energy_max: Int = 0
    var upgrade: Int = 0
    var snum: Int = 0
    var sellButton: SKLabelNode!
    var autoSellValue: Int = 0
    
    // MID
    var midArea: SKSpriteNode!
    var tileset: Tileset!
    var tilemap: TileMap!
    let mapsize = CGPoint(x: 9, y: 11)
    
    // BOTTOM
    var bottomArea: SKSpriteNode!
    var choiceshow: SKSpriteNode!
    var choicename: String = "s"
    var test: SKSpriteNode!
    
    var component = [String: SKSpriteNode]()
    
    var a1: SKSpriteNode!
    var b1: SKSpriteNode!
    var f1: SKSpriteNode!
    
    
    override func didMoveToView(view: SKView) {
        
        // OTHER
        let tick = 0.5
        gameTimer = NSTimer.scheduledTimerWithTimeInterval(tick, target: self, selector: "tickUpdata", userInfo: nil, repeats: true)
        defaults = NSUserDefaults.standardUserDefaults()
        framescale = frame.size.width / (mapsize.x * 64)
        
        
        // TOP
        topArea = SKSpriteNode()
        topArea.name = "topArea"
        topArea.color = UIColor.grayColor()
        topArea.size = CGSizeMake(frame.size.width, 64 * 2 * framescale)
        topArea.anchorPoint = CGPoint(x: 0, y: 0)
        topArea.position = CGPoint(x: 0, y: frame.size.height - 64 * 2 * framescale)
        topArea.zPosition = 2
        addChild(topArea)
        
        moneyLabel = SKLabelNode(fontNamed: "San Francisco")
        moneyLabel.fontColor = UIColor.yellowColor()
        moneyLabel.fontSize = 20
        moneyLabel.position = CGPoint(x: 16, y: topArea.size.height * 2 / 3)
        moneyLabel.horizontalAlignmentMode = .Left
        moneyLabel.zPosition = 3
        topArea.addChild(moneyLabel)
        money = defaults.integerForKey("Money")
        
        energyLabel = SKLabelNode(fontNamed: "San Francisco")
        energyLabel.fontColor = UIColor.blueColor()
        energyLabel.fontSize = 20
        energyLabel.position = CGPoint(x: 16, y: topArea.size.height * 1 / 3)
        energyLabel.horizontalAlignmentMode = .Left
        energyLabel.zPosition = 3
        topArea.addChild(energyLabel)
        energy_max = 100
        
        sellButton = SKLabelNode(text: "SELL")
        sellButton.fontName = "San Francisco"
        sellButton.name = "sellButton"
        sellButton.fontSize = 40
        sellButton.fontColor = UIColor.blueColor()
        sellButton.position = CGPoint(x: topArea.size.width - 100, y: topArea.size.height * 1 / 3)
        sellButton.zPosition = 3
        topArea.addChild(sellButton)
        
        // MID
        midArea = SKSpriteNode()
        midArea.name = "midArea"
        midArea.size = CGSizeMake(frame.size.width, 64 * mapsize.y * framescale)
        midArea.anchorPoint = CGPoint(x: 0, y: 1)
        midArea.position = CGPoint(x: 0, y: frame.size.height - 64 * 2 * framescale)
        midArea.zPosition = 1
        addChild(midArea)
        tile_initial()
        loadLevelMap("level1")
        
        
        // BOTTOM
        bottomArea = SKSpriteNode(imageNamed: "background.jpg")
        bottomArea.name = "bottomArea"
        bottomArea.size = CGSizeMake(frame.size.width, frame.size.height - 64 * (mapsize.y + 2) * framescale)
        bottomArea.anchorPoint = CGPoint(x: 0, y: 0)
        bottomArea.position = CGPoint(x: 0, y: 0)
        bottomArea.zPosition = 2
        addChild(bottomArea)
        
        
        choiceshow = SKSpriteNode(color: UIColor.redColor(), size: CGSize(width: 74, height: 74))
        choiceshow.alpha = 0
        choiceshow.zPosition = 4
        addChild(choiceshow)

        
        a1 = SKSpriteNode(imageNamed: "block")
        a1.name = "x"
        a1.position = CGPoint(x: bottomArea.size.width / 4.0, y: bottomArea.size.height / 2.0)
        a1.zPosition = 3
        bottomArea.addChild(a1)
        
        b1 = SKSpriteNode(imageNamed: "風力")
        b1.name = "s"
        b1.position = CGPoint(x: bottomArea.size.width * 2 / 4.0, y: bottomArea.size.height / 2.0)
        b1.zPosition = 3
        bottomArea.addChild(b1)
        
        f1 = SKSpriteNode(imageNamed: "辦公室1")
        f1.name = "o"
        f1.position = CGPoint(x: bottomArea.size.width * 3 / 4.0, y: bottomArea.size.height / 2.0)
        f1.zPosition = 3
        bottomArea.addChild(f1)
    }
    
    
    
    func choice(sprite: SKSpriteNode) {
        choicename = sprite.name!
        choiceshow.alpha = 0.6
        choiceshow.position = sprite.position
    }
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.locationInNode(self)
            print(location)
            
            if bottomArea.containsPoint(location) {
                if a1.containsPoint(location) { choice(a1) }
                if b1.containsPoint(location) { choice(b1) }
                if f1.containsPoint(location) { choice(f1) }
            }
    
            for node in nodesAtPoint(location) {
                print(node)
                
                if node.name == "Building" {
                    let tilemaplocation = touch.locationInNode(tilemap)
                    print(tilemaplocation)
                    let coord = tilemap.Position2Coord(tilemaplocation)
                    print(coord)
                    
                    //building
                    let price = tileset.tileData["s"]?.price
                    if money >= price {
                        money -= price!
                        tilemap.SetTileMapElement(coord: coord, word: choicename)
                    }
                }
                
                if node.name == "sellButton" {
                    sellEnergy("all")
                }
            }
        }
    }
    
    override func update(currentTime: CFTimeInterval) {
        moneyLabel.text = "Money: \(money)"
        energyLabel.text = "Energy: \(energy) +\(snum)"
    }
    
    func tickUpdata() {
        // count
        tilemap.tickProduce()
        
        // produce
        snum = tilemap.checkBuildNumber("s")
        energy += snum
        if energy >= energy_max {
            energy = energy_max
        }
        
        // sell
        let onum = tilemap.checkBuildNumber("o")
        autoSellValue = onum * tileset.tileData["o"]!.sales
        sellEnergy("auto")
        
        save()
    }
    func save() {
        defaults.setInteger(money, forKey: "Money")
    }
    
    func tile_initial() {
        
        tileset = Tileset(name: "BuildingSet", tileSize: CGSize(width: 64, height: 64))
        
        let blockData = TileData(imageNamed: "block", price: 0)
        blockData.addOutputData(-1, produceEnergySpeed: 0)
        tileset.addTileData(word: "x", data: blockData)
        component["x"] = SKSpriteNode(imageNamed: "block")
        
        let WData = TileData(imageNamed: "風力", price: 1)
        WData.addOutputData(4, produceEnergySpeed: 1)
        tileset.addTileData(word: "s", data: WData)
        component["s"] = SKSpriteNode(imageNamed: "風力")
        
        let oData = TileData(imageNamed: "辦公室1", price: 10)
        oData.addOfficeData(5)
        tileset.addTileData(word: "o", data: oData)
        component["o"] = SKSpriteNode(imageNamed: "辦公室1")
    }
    
    func loadLevelMap(level: String) {
        tilemap = TileMap(name: "Building", mapSize: CGSize(width: mapsize.x, height: mapsize.y), tileset: tileset)
        tilemap.setScale(framescale)
        tilemap.zPosition = 1
        midArea.addChild(tilemap)
        // tilemap load data
        let array = Array(count: Int(mapsize.y), repeatedValue: Array(count: Int(mapsize.x), repeatedValue: "x"))
        tilemap.LoadTileMap(array: array)
    }
    
    func sellEnergy(method: String) {
        if method == "all" {
            print("sell all!")
            money += energy
            energy = 0
        } else if method == "auto" {
            if energy >= autoSellValue {
                money += autoSellValue
                energy -= autoSellValue
            } else {
                money += energy
                energy = 0
            }
        }
    }
}
