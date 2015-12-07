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
    // Data
    var money: Int = 0
    var energy: Int = 0
    var upgrade: Int = 0
    // tilemap
    var tileset: Tileset!
    var tilemap: TileMap!
    let mapsize = CGPoint(x: 13, y: 9)
    var mapscale: CGFloat!
    // Show
    var moneyLabel: SKLabelNode!

    override func didMoveToView(view: SKView) {
        
        mapscale = frame.size.height / (mapsize.y * 64)
        // MARK: Load Score
        defaults = NSUserDefaults.standardUserDefaults()
        money = defaults.integerForKey("Money")
        
        // tile initial
        tileset = Tileset(name: "BuildingSet", tileSize: CGSize(width: 64, height: 64))
        tileset.addTileData(word: "x", imageName: "block")
        tileset.addTileData(word: "s", imageName: "star")
        
        // tileMap
        loadLevelMap("level1")
        // left Area
        let left = SKSpriteNode(imageNamed: "background.jpg")
        left.size = CGSizeMake(frame.size.width - 64 * mapsize.x * mapscale, frame.size.height)
        left.anchorPoint = CGPoint(x: 0, y: 0)
        left.position = CGPoint(x: 0, y: 0)
        addChild(left)
        
        
        

        
        
        // MARK: Setting Money Label
        moneyLabel = SKLabelNode(fontNamed: "Chalkduster")
        moneyLabel.position = CGPoint(x: left.size.width / 2.0, y: frame.size.height / 2.0)
        moneyLabel.horizontalAlignmentMode = .Left
        moneyLabel.fontSize = 20
        left.addChild(moneyLabel)
        
        // MARK: Tick Updata Data
        let tick = 0.5
        gameTimer = NSTimer.scheduledTimerWithTimeInterval(tick, target: self, selector: "tickUpdata", userInfo: nil, repeats: true)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.locationInNode(self)
            print(location)
            let tilemaplocation = touch.locationInNode(tilemap)
            print(tilemaplocation)
            let coord = tilemap.Position2Coord(tilemaplocation)
            print(coord)
            tilemap.SetTileMapElement(coord: coord, word: "s")
        }
    }
   
    override func update(currentTime: CFTimeInterval) {
        
    }
    
    func tickUpdata() {
        money += 10
        moneyLabel.text = "Money: \(money)"
        save()
    }
    
    func save() {
        defaults.setInteger(money, forKey: "Money")
    }
    
    func loadLevelMap(level: String) {
        tilemap = TileMap(name: "Building", mapSize: CGSize(width: mapsize.x, height: mapsize.y), tileset: tileset)
        tilemap.position = CGPoint(x: frame.size.width - 64 * mapsize.x * mapscale, y: frame.size.height)
        tilemap.setScale(mapscale)
        addChild(tilemap)
        // tilemap load data
        let array = Array(count: Int(mapsize.y), repeatedValue: Array(count: Int(mapsize.x), repeatedValue: "x"))
        tilemap.LoadTileMap(array: array)
    }
}
