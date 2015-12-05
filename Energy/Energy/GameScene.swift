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
    
    var tilemap: TileMap!
    // tileMap
//    var tileMapType: Array<Array<String>> = []
    
    override func didMoveToView(view: SKView) {
        
        let tileset = Tileset(name: "level1", tileSize: CGSize(width: 64, height: 64))
        tileset.addTileData("x", imageName: "block")
        tilemap = TileMap(name: "level1", mapSize: CGSize(width: 3, height: 3), maxMapSize: 3, tileset: tileset)
        
        tilemap.position = CGPoint(x: 200, y: 200)
        addChild(tilemap)
        
        tilemap.creatBlankMap()
        
        print(frame.size.width)
        print(frame.size.height)
        
        
        
        // MARK: tileMap
//        for _ in 0 ..< 3 {
//            let test = Array(count: 4, repeatedValue: "x")
//            tileMapType.append(test)
//        }
//        
//        let W: CGFloat = 4
//        let H: CGFloat = 3
//        let scale: CGFloat = 2
//        let Map = SKSpriteNode()
//        Map.position = CGPoint(x: frame.size.width / 2.0, y: frame.size.height / 2.0)
//        
//        for (row, line) in tileMapType.enumerate() {
//            for (column, letter) in line.enumerate() {
//                let position = CGPoint(x: 64 * column + 32, y: 64 * row + 32)
//                if letter == "x" {
//                    let node = SKSpriteNode(imageNamed: "block")
//                    node.position = position
//                    Map.addChild(node)
//                }
//            }
//        }
//        
//        Map.size = CGSizeMake(64 * W * scale, 64 * H * scale)
//        addChild(Map)
        
        
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
        
        
        
        // MARK: Load Map
//        backgroundColor = UIColor.grayColor()
//        let groundTexture = SKTexture(imageNamed: "land")
//        let i: CGFloat = self.frame.size.width / (groundTexture.size().width * 2.0)
//        print(frame.size.width)
//        print(frame.size.height)
        
//        loadLevel()

    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.locationInNode(self)
            print(location)
            
            let tilemaplocation = touch.locationInNode(tilemap)
            let coord = tilemap.Position2Coord(tilemaplocation)
            print(coord)
            
            if let tile = tilemap.tileForCoord(coord) {
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
        
//        defaults.setObject(tileMapType, forKey: "TileMap")
    }
//    
//    func loadLevel() {
//        if let levelPath = NSBundle.mainBundle().pathForResource("level1", ofType: "txt") {
//            if let levelString = try? String(contentsOfFile: levelPath, usedEncoding: nil) {
//                let lines = levelString.componentsSeparatedByString("\n")
//                
//                for (row, line) in lines.reverse().enumerate() {
//                    for (column, letter) in line.characters.enumerate() {
//                        let position = CGPoint(x: (64 * column) + 32, y: (64 * row) + 64)
//                        
//                        if letter == "x" {
//                            let node = SKSpriteNode(imageNamed: "block")
//                            node.position = position
//                            
//                            node.physicsBody = SKPhysicsBody(rectangleOfSize: node.size)
//                            node.physicsBody!.dynamic = false
//                            addChild(node)
//                        } else if letter == "v"  {
//                            let node = SKSpriteNode(imageNamed: "vortex")
//                            node.name = "vortex"
//                            node.position = position
//                            node.runAction(SKAction.repeatActionForever(SKAction.rotateByAngle(CGFloat(M_PI), duration: 1)))
//                            node.physicsBody = SKPhysicsBody(circleOfRadius: node.size.width / 2)
//                            node.physicsBody!.dynamic = false
//                            
//                            node.physicsBody!.collisionBitMask = 0
//                            addChild(node)
//                        } else if letter == "s"  {
//                            let node = SKSpriteNode(imageNamed: "star")
//                            node.name = "star"
//                            node.physicsBody = SKPhysicsBody(circleOfRadius: node.size.width / 2)
//                            node.physicsBody!.dynamic = false
//                            
//                            node.physicsBody!.collisionBitMask = 0
//                            node.position = position
//                            addChild(node)
//                        } else if letter == "f"  {
//                            let node = SKSpriteNode(imageNamed: "finish")
//                            node.name = "finish"
//                            node.physicsBody = SKPhysicsBody(circleOfRadius: node.size.width / 2)
//                            node.physicsBody!.dynamic = false
//                            
//                            node.physicsBody!.collisionBitMask = 0
//                            node.position = position
//                            addChild(node)
//                        }
//                        
//                    }
//                }
//            }
//        }
//    }
}
