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
    // Money Label
    var moneyLabel: SKLabelNode!
    var money: Int = 0 {
        didSet {
            moneyLabel.text = "Money: \(money)"
        }
    }
    // tilemap
    var tilemap: TileMap!
    
    override func didMoveToView(view: SKView) {
        
        // tile initial
        let tileset = Tileset(name: "level1", tileSize: CGSize(width: 64, height: 64))
        tileset.addTileData(word: "x", imageName: "block")
        tileset.addTileData(word: "s", imageName: "star")
        
        // tilemap initial
        let mapsize = CGPoint(x: 4, y: 3)
        let mapscale: CGFloat = frame.size.height / (mapsize.y * 64)
        
        tilemap = TileMap(name: "level1", mapSize: CGSize(width: mapsize.x, height: mapsize.y), tileset: tileset)
        tilemap.position = CGPoint(x: frame.size.width - 64 * mapsize.x * mapscale, y: frame.size.height)
        tilemap.setScale(mapscale)
        addChild(tilemap)
        
        // tilemap set tile
        let array = [["x","x","x","x"],["x","x","x","x"],["x","x","s","s"]]
        tilemap.LoadTileMap(array: array)
        tilemap.SetTileMapElement(coord: CGPoint(x: 1, y: 1), word: "s")
        

        // MARK: Setting Money Label
        moneyLabel = SKLabelNode(fontNamed: "Chalkduster")
        moneyLabel.position = CGPoint(x: frame.size.width / 20.0, y: frame.size.height / 2.0)
        moneyLabel.horizontalAlignmentMode = .Left
        moneyLabel.fontSize = 20
        addChild(moneyLabel)
        
        // MARK: Load Score
        defaults = NSUserDefaults.standardUserDefaults()
        money = defaults.integerForKey("Money")
        
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
            
            if let tile = tilemap.TileForCoord(coord) {
                tile.sprite.alpha = 0.5
            }
        }
    }
   
    override func update(currentTime: CFTimeInterval) {
    }
    
    func tickUpdata() {
        money += 10
        save()
    }
    
    func save() {
        defaults.setInteger(money, forKey: "Money")
    }
}
