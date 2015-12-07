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
    
    
    // TOP
    var moneyLabel: SKLabelNode!
    var money: Int = 0
    var money_add: Int = 0
    var energy: Int = 0
    var upgrade: Int = 0
    var snum: Int = 0
    
    
    // MID
    var midArea: SKSpriteNode!
    var tileset: Tileset!
    var tilemap: TileMap!
    let mapsize = CGPoint(x: 9, y: 11)
    var mapscale: CGFloat!
    
    
    // BUTTON
    var buttonArea: SKSpriteNode!
    var choiceshow: SKSpriteNode!
    var choicename: String!


    override func didMoveToView(view: SKView) {
        
        // OTHER
        let tick = 0.5
        gameTimer = NSTimer.scheduledTimerWithTimeInterval(tick, target: self, selector: "tickUpdata", userInfo: nil, repeats: true)
        defaults = NSUserDefaults.standardUserDefaults()
        
        
        // TOP
        money = defaults.integerForKey("Money")
        moneyLabel = SKLabelNode(fontNamed: "San Francisco")
        moneyLabel.fontColor = UIColor.yellowColor()
        moneyLabel.fontSize = 20
        moneyLabel.position = CGPoint(x: 16, y: frame.size.height - 36)
        moneyLabel.horizontalAlignmentMode = .Left
        moneyLabel.zPosition = 3
        addChild(moneyLabel)

        
        // MID
        tile_initial()
        mapscale = frame.size.width / (mapsize.x * 64)
        midArea = SKSpriteNode()
        midArea.size = CGSizeMake(frame.size.width, 64 * mapsize.y * mapscale)
        midArea.position = CGPoint(x: 0, y: frame.size.height - 64 * 2 * mapscale)
        midArea.zPosition = 1
        addChild(midArea)
        loadLevelMap("level1")
    
        
        // BUTTON
        buttonArea = SKSpriteNode(imageNamed: "background.jpg")
        buttonArea.size = CGSizeMake(frame.size.width, frame.size.height - 64 * (mapsize.y + 2) * mapscale)
        buttonArea.anchorPoint = CGPoint(x: 0, y: 0)
        buttonArea.position = CGPoint(x: 0, y: 0)
        buttonArea.zPosition = 2
        addChild(buttonArea)
        
        choiceshow = SKSpriteNode(color: UIColor.redColor(), size: CGSize(width: 74, height: 74))
        choiceshow.alpha = 0.6
        choiceshow.zPosition = 4
        addChild(choiceshow)
        
        
        let a1 = SKSpriteNode(imageNamed: "block")
        a1.name = "a1"
        a1.position = CGPoint(x: buttonArea.size.width / 4.0, y: buttonArea.size.height / 2.0)
        a1.zPosition = 3
        buttonArea.addChild(a1)
        
        let b1 = SKSpriteNode(imageNamed: "star")
        b1.name = "b1"
        b1.position = CGPoint(x: buttonArea.size.width * 3 / 4.0, y: buttonArea.size.height / 2.0)
        b1.zPosition = 3
        buttonArea.addChild(b1)

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
                    tilemap.SetTileMapElement(coord: coord, word: choicename)
                }
                
                if node.name == "a1" {
                    choicename = "x"
                    choiceshow.position = node.position
                }
                if node.name == "b1" {
                    choicename = "s"
                    choiceshow.position = node.position
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
