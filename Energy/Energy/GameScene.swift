//
//  GameScene.swift
//  Energy
//
//  Created by javan.chen on 2015/12/1.
//  Copyright (c) 2015年 Javan chen. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    // Timer
    var gameTimer: NSTimer!
    // Load
    var defaults: NSUserDefaults!
    // Show
    var moneyLabel: SKLabelNode!
    // Data
    var money: Int = 0
    var money_add: Int = 0
    var energy: Int = 0
    var upgrade: Int = 0
    var snum: Int = 0
    
    var midArea: SKSpriteNode!
    var buttomArea: SKSpriteNode!
    
    
    // tilemap
    var tileset: Tileset!
    var tilemap: TileMap!
    let mapsize = CGPoint(x: 9, y: 11)
    var mapscale: CGFloat!


    override func didMoveToView(view: SKView) {
        
        mapscale = frame.size.width / (mapsize.x * 64)
        tile_initial()

        // mid Area
        midArea = SKSpriteNode()
        midArea.size = CGSizeMake(frame.size.width, 64 * mapsize.y * mapscale)
        midArea.position = CGPoint(x: 0, y: frame.size.height - 64 * 2 * mapscale)
        midArea.zPosition = 1
        addChild(midArea)
    
        // button Area
        buttomArea = SKSpriteNode(imageNamed: "background.jpg")
        buttomArea.size = CGSizeMake(frame.size.width, frame.size.height - 64 * (mapsize.y + 2) * mapscale)
        buttomArea.anchorPoint = CGPoint(x: 0, y: 0)
        buttomArea.position = CGPoint(x: 0, y: 0)
        buttomArea.zPosition = 2
        addChild(buttomArea)
        
        let a1 = SKSpriteNode(imageNamed: "block")
        a1.name = "a1"
        a1.position = CGPoint(x: buttomArea.size.width / 4.0, y: buttomArea.size.height / 2.0)
        buttomArea.addChild(a1)
        
        let b1 = SKSpriteNode(imageNamed: "star")
        b1.name = "b1"
        b1.position = CGPoint(x: buttomArea.size.width * 3 / 4.0, y: buttomArea.size.height / 2.0)
        buttomArea.addChild(b1)
        
        
        // tileMap
        loadLevelMap("level1")
        
        
        
        
        
        // MARK: Load Score
        defaults = NSUserDefaults.standardUserDefaults()
        money = defaults.integerForKey("Money")
        // MARK: Setting Money Label
        moneyLabel = SKLabelNode(fontNamed: "San Francisco")
        moneyLabel.fontColor = UIColor.yellowColor()
        moneyLabel.fontSize = 20
        moneyLabel.position = CGPoint(x: 16, y: frame.size.height - 36)
        moneyLabel.horizontalAlignmentMode = .Left
        moneyLabel.zPosition = 3
        addChild(moneyLabel)

        
        

        
        // MARK: Tick Updata Data
        let tick = 0.5
        gameTimer = NSTimer.scheduledTimerWithTimeInterval(tick, target: self, selector: "tickUpdata", userInfo: nil, repeats: true)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.locationInNode(self)
            print(location)
            for node in nodesAtPoint(location) {
                
                if node.name == "Building" {
                    let tilemaplocation = touch.locationInNode(tilemap)
                    print(tilemaplocation)
                    let coord = tilemap.Position2Coord(tilemaplocation)
                    print(coord)
                    tilemap.SetTileMapElement(coord: coord, word: "s")
                }
                
                if node.name == "a1" {
                    node.alpha = 0.4
                }
                
                
            }
        }
    }
   
    override func update(currentTime: CFTimeInterval) {
        snum = tilemap.checkBuildNumber("s")
    }
    
    func tickUpdata() {
        money += snum * 10
        moneyLabel.text = "Money: \(money) +\(snum * 10)"
        save()
    }
    func save() {
        defaults.setInteger(money, forKey: "Money")
    }
    
    func tile_initial() {
        tileset = Tileset(name: "BuildingSet", tileSize: CGSize(width: 64, height: 64))
        tileset.addTileData(word: "x", imageName: "block")
        tileset.addTileData(word: "s", imageName: "star")
    }
    
    func loadLevelMap(level: String) {
        tilemap = TileMap(name: "Building", mapSize: CGSize(width: mapsize.x, height: mapsize.y), tileset: tileset)
        tilemap.setScale(mapscale)
        tilemap.zPosition = 1
        midArea.addChild(tilemap)
        // tilemap load data
        let array = Array(count: Int(mapsize.y), repeatedValue: Array(count: Int(mapsize.x), repeatedValue: "x"))
        tilemap.LoadTileMap(array: array)
    }
}
