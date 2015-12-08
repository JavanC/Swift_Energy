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
    var upgrade: Int = 0
    var snum: Int = 0
    var sellButton: SKButton!
    
    // MID
    var midArea: SKSpriteNode!
    var tileset: Tileset!
    var tilemap: TileMap!
    let mapsize = CGPoint(x: 9, y: 11)
    
    // BOTTOM
    var bottomArea: SKSpriteNode!
    var choiceshow: SKSpriteNode!
    var choicename: String = "s"


    override func didMoveToView(view: SKView) {

        // OTHER
        let tick = 0.5
        gameTimer = NSTimer.scheduledTimerWithTimeInterval(tick, target: self, selector: "tickUpdata", userInfo: nil, repeats: true)
        defaults = NSUserDefaults.standardUserDefaults()
        framescale = frame.size.width / (mapsize.x * 64)
        
        
        // TOP
        topArea = SKSpriteNode()
        topArea.name = "topArea"
        topArea.color = UIColor.blackColor()
        topArea.size = CGSizeMake(frame.size.width, 64 * 2 * framescale)
        topArea.anchorPoint = CGPoint(x: 0, y: 0)
        topArea.position = CGPoint(x: 0, y: frame.size.height - 64 * 2 * framescale)
        topArea.zPosition = 2
        addChild(topArea)
        
        moneyLabel = SKLabelNode(fontNamed: "San Francisco")
        moneyLabel.fontColor = UIColor.yellowColor()
        moneyLabel.fontSize = 20
        moneyLabel.position = CGPoint(x: 16, y: 0)
        moneyLabel.horizontalAlignmentMode = .Left
        moneyLabel.zPosition = 3
        topArea.addChild(moneyLabel)
        money = defaults.integerForKey("Money")

        energyLabel = SKLabelNode(fontNamed: "San Francisco")
        energyLabel.fontColor = UIColor.blueColor()
        energyLabel.fontSize = 20
        energyLabel.position = CGPoint(x: 16, y: topArea.size.height - 60)
        energyLabel.horizontalAlignmentMode = .Left
        energyLabel.zPosition = 3
        topArea.addChild(energyLabel)
        
        sellButton = SKButton(defaultButtonImage: "button", activeButtonImage: "button_active", buttonAction: sellEnergy)
        sellButton.name = "sellButton"
        sellButton.setScale(2)
        sellButton.position = CGPoint(x: frame.size.width - 100, y: frame.size.height - 50)
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
        
        let a1 = SKSpriteNode(imageNamed: "block")
        a1.name = "a1"
        a1.position = CGPoint(x: bottomArea.size.width / 4.0, y: bottomArea.size.height / 2.0)
        a1.zPosition = 3
        bottomArea.addChild(a1)
        
        let b1 = SKSpriteNode(imageNamed: "風力")
        b1.name = "b1"
        b1.position = CGPoint(x: bottomArea.size.width * 3 / 4.0, y: bottomArea.size.height / 2.0)
        b1.zPosition = 3
        bottomArea.addChild(b1)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.locationInNode(self)
            print(location)
            
            for node in nodesAtPoint(location) {
                print(node)
                
                if node.name == "Building" {
                    let tilemaplocation = touch.locationInNode(tilemap)
                    print(tilemaplocation)
                    let coord = tilemap.Position2Coord(tilemaplocation)
                    print(coord)
                    
                    //building
                    let price = 1
                    if money >= price {
                        money -= price
                        tilemap.SetTileMapElement(coord: coord, word: choicename)
                    }
                    
                    
                }
            
                if node.name == "a1" {
                    choicename = "x"
                    choiceshow.alpha = 0.6
                    choiceshow.position = node.position
                }
                if node.name == "b1" {
                    choicename = "s"
                    choiceshow.alpha = 0.6
                    choiceshow.position = node.position
                }
                
                if node.name == "sellButton" {
                    sellButton.action()
                }
                
            }
        }
    }
   
    override func update(currentTime: CFTimeInterval) {
        snum = tilemap.checkBuildNumber("s")
    }
    
    func tickUpdata() {
        energy += snum
        moneyLabel.text = "Money: \(money)"
        energyLabel.text = "Energy: \(energy) +\(snum)"
        save()
    }
    func save() {
        defaults.setInteger(money, forKey: "Money")
    }
    
    func tile_initial() {
        
        tileset = Tileset(name: "BuildingSet", tileSize: CGSize(width: 64, height: 64))
        tileset.addTileData(word: "x", imageName: "block", produceEnergySpeed: 0)
        tileset.addTileData(word: "s", imageName: "風力", produceEnergySpeed: 1)
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
    
    func sellEnergy() {
        print("sell!")
        money += energy
        energy = 0
    }
}
