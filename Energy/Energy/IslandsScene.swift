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
    
    var spentTimeLabel: SKLabelNode!
    
    override func didMoveToView(view: SKView) {
        
        if !contentCreated {
            
            leftarrow = SKSpriteNode(texture: iconAtlas.textureNamed("arrow_left"))
            leftarrow.size = CGSizeMake(44 * framescale, 44 * framescale)
            leftarrow.anchorPoint = CGPoint(x: 0, y: 1)
            leftarrow.position = CGPoint(x: 10 * framescale, y: frame.size.height - 30 * framescale)
            self.addChild(leftarrow)
            backButton = SKLabelNode(fontNamed: "SanFranciscoText-BoldItalic")
            backButton.text = "Menu"
            backButton.horizontalAlignmentMode = .Left
            backButton.verticalAlignmentMode = .Center
            backButton.fontColor = SKColor.whiteColor()
            backButton.fontSize = 35 * framescale
            backButton.position = CGPoint(x: (15 + 44) * framescale, y: frame.size.height - (30 + 22) * framescale)
            self.addChild(backButton)
            
            map1Button = SKLabelNode(fontNamed: "SanFranciscoText-BoldItalic")
            map1Button.text = "Select Map1"
            map1Button.fontSize = 45 * framescale
            map1Button.position = CGPoint(x:frame.size.width / 2, y:frame.size.height / 2 + 100 * framescale)
            self.addChild(map1Button)
            
            map2Button = SKLabelNode(fontNamed: "SanFranciscoText-BoldItalic")
            map2Button.text = "Select Map2"
            map2Button.fontSize = 45 * framescale
            map2Button.position = CGPoint(x:frame.size.width / 2, y:frame.size.height / 2 - 100 * framescale)
            self.addChild(map2Button)
            
            let label = SKLabelNode(fontNamed: "SanFranciscoText-BoldItalic")
            label.name = "spentTimeLabel"
            label.text = "SPEND  TIME"
            label.fontSize = 20 * framescale
            label.fontColor = SKColor.whiteColor()
            label.position = CGPoint(x: frame.width / 2, y: frame.height / 8)
            addChild(label)
            
            spentTimeLabel = SKLabelNode(fontNamed: "SanFranciscoText-BoldItalic")
            spentTimeLabel.name = "spentTimeLabel"
            spentTimeLabel.fontSize = 30 * framescale
            spentTimeLabel.fontColor = SKColor.whiteColor()
            spentTimeLabel.position = CGPoint(x: frame.width / 2, y: label.position.y - 50 * framescale)
            self.addChild(spentTimeLabel)
            
            contentCreated = true
        }
    }
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch in touches {
            let location = touch.locationInNode(self)
            if leftarrow.containsPoint(location) || backButton.containsPoint(location) {
                runAction(soundTap)
                let doors = SKTransition.moveInWithDirection(SKTransitionDirection.Left, duration: 0.3)
                self.view?.presentScene(menuScene, transition: doors)
            }
            if map1Button.containsPoint(location) {
                print("Map1")
                nowMapNumber = 0
                runAction(soundTap)
                let doors = SKTransition.revealWithDirection(SKTransitionDirection.Left, duration: 0.3)
                self.view?.presentScene(islandScene, transition: doors)
            }
            if map2Button.containsPoint(location) {
                print("Map2")
                nowMapNumber = 1
                runAction(soundTap)
                let doors = SKTransition.revealWithDirection(SKTransitionDirection.Left, duration: 0.3)
                self.view?.presentScene(islandScene, transition: doors)
            }
        }
    }

    func hourToString(value: Int) -> String {
        let day = value / 86400
        let hour = (value % 86400) / 3600
        let min = (value % 3600) / 60
        let sec = value % 60
        
        var timeString = ""
        if day > 0 {
            timeString += "\(day) days "
        }
        if hour < 10 { timeString += "0" }
        timeString += "\(hour):"
        if min < 10 { timeString += "0" }
        timeString += "\(min):"
        if sec < 10 { timeString += "0" }
        timeString += "\(sec)"
        return timeString
    }
    
    override func update(currentTime: CFTimeInterval) {
        spentTimeLabel.text = hourToString(spendTime)
    }
}
