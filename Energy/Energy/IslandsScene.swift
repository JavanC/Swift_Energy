//
//  IslandsScene.swift
//  Energy
//
//  Created by javan.chen on 2015/12/25.
//  Copyright © 2015年 Javan chen. All rights reserved.
//

import SpriteKit

class IslandsScene: SKScene {
    
    
    var map1Button: SKLabelNode!
    var map2Button: SKLabelNode!
    
    override func didMoveToView(view: SKView) {
        map1Button = SKLabelNode(fontNamed:"Verdana-Bold")
        map1Button.text = "Select Map1"
        map1Button.fontSize = 45
        map1Button.position = CGPoint(x:frame.size.width / 2, y:frame.size.height / 2 + 100)
        self.addChild(map1Button)
        
        map2Button = SKLabelNode(fontNamed:"Verdana-Bold")
        map2Button.text = "Select Map2"
        map2Button.fontSize = 45
        map2Button.position = CGPoint(x:frame.size.width / 2, y:frame.size.height / 2 - 100)
        self.addChild(map2Button)
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch in touches {
            let location = touch.locationInNode(self)
            if map1Button.containsPoint(location) {
                print("tap Map1")
                let nextScene = IslandScene(size: self.size)
                let doors = SKTransition.revealWithDirection(SKTransitionDirection.Left, duration: 0.3)
                self.view?.presentScene(nextScene, transition: doors)
            }
        }
    }
    
    override func update(currentTime: CFTimeInterval) {
        
    }
}
