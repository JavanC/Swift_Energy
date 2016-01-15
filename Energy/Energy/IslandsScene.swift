//
//  IslandsScene.swift
//  Energy
//
//  Created by javan.chen on 2015/12/25.
//  Copyright © 2015年 Javan chen. All rights reserved.
//

import SpriteKit


class IslandsScene: SKScene {
    
    var contentCreated: Bool = false
    var leftarrow: SKSpriteNode!
    var backButton: SKLabelNode!
    
    var map1Button: SKLabelNode!
    var map2Button: SKLabelNode!
    
    override func didMoveToView(view: SKView) {
        
        if !contentCreated {
            
            leftarrow = SKSpriteNode(texture: iconAtlas.textureNamed("arrow_left"))
            leftarrow.size = CGSizeMake(44, 44)
            leftarrow.anchorPoint = CGPoint(x: 0, y: 1)
            leftarrow.position = CGPoint(x: 10, y: frame.size.height - 30)
            self.addChild(leftarrow)
            backButton = SKLabelNode(fontNamed: "SanFranciscoText-BoldItalic")
            backButton.text = "Menu"
            backButton.horizontalAlignmentMode = .Left
            backButton.verticalAlignmentMode = .Center
            backButton.fontColor = SKColor.whiteColor()
            backButton.fontSize = 35
            backButton.position = CGPoint(x: 15 + 44, y: Int(frame.size.height) - (30 + 22))
            self.addChild(backButton)
            
            map1Button = SKLabelNode(fontNamed:"SanFranciscoText-BoldItalic")
            map1Button.text = "Select Map1"
            map1Button.fontSize = 45
            map1Button.position = CGPoint(x:frame.size.width / 2, y:frame.size.height / 2 + 100)
            self.addChild(map1Button)
            
            map2Button = SKLabelNode(fontNamed:"SanFranciscoText-BoldItalic")
            map2Button.text = "Select Map2"
            map2Button.fontSize = 45
            map2Button.position = CGPoint(x:frame.size.width / 2, y:frame.size.height / 2 - 100)
            self.addChild(map2Button)
            
            contentCreated = true
        }
    }
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch in touches {
            let location = touch.locationInNode(self)
            if leftarrow.containsPoint(location) || backButton.containsPoint(location) {
                let doors = SKTransition.moveInWithDirection(SKTransitionDirection.Left, duration: 0.3)
                self.view?.presentScene(menuScene, transition: doors)
            }
            if map1Button.containsPoint(location) {
                print("tap Map1")
                nowMapNumber = 0
                let doors = SKTransition.revealWithDirection(SKTransitionDirection.Left, duration: 0.3)
                self.view?.presentScene(islandScene, transition: doors)
            }
            if map2Button.containsPoint(location) {
                print("tap Map2")
                nowMapNumber = 1
                let doors = SKTransition.revealWithDirection(SKTransitionDirection.Left, duration: 0.3)
                self.view?.presentScene(islandScene, transition: doors)
            }
        }
    }
    
    override func update(currentTime: CFTimeInterval) {
        
    }
}
