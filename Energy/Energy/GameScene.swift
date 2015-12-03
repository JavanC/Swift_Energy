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
    
    override func didMoveToView(view: SKView) {
        // MARK: Tick Updata Data
        gameTimer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "dataUpdate", userInfo: nil, repeats: true)
        
        // MARK: Setting Money Label
        moneyLabel = SKLabelNode(fontNamed: "Chalkduster")
        moneyLabel.position = CGPoint(x: frame.size.width / 20.0, y: frame.size.height / 2.0)
        moneyLabel.horizontalAlignmentMode = .Left
        moneyLabel.fontSize = 20
        addChild(moneyLabel)
        
        // MARK: Load Score
        defaults = NSUserDefaults.standardUserDefaults()
        money = defaults.integerForKey("Money")
        print(money)
        
        
        // MARK: Load Map
//        backgroundColor = UIColor.grayColor()
//        let groundTexture = SKTexture(imageNamed: "land")
//        let i: CGFloat = self.frame.size.width / (groundTexture.size().width * 2.0)
//        print(frame.size.width)
//        print(frame.size.height)
        
//        loadLevel()

    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
    }
   
    override func update(currentTime: CFTimeInterval) {
    }
    func dataUpdate() {
        money += 100
        save()
    }
    func save() {
        defaults.setInteger(money, forKey: "Money")
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
