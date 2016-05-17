//
//  TrachLayer.swift
//  Energy
//
//  Created by javan.chen on 2016/5/5.
//  Copyright © 2016年 Javan chen. All rights reserved.
//

import SpriteKit

class TeachLayer: SKSpriteNode {
    
    var background: SKSpriteNode!
    var OKButton: SKShapeNode!
    var backgroundMask: SKShapeNode!
    var labels = [SKLabelNode]()
    
    func configureAtPosition(position: CGPoint, size: CGSize) {
        
        self.position = position
        self.size     = size
        self.name     = "TeachLayer"
        
        background = SKSpriteNode(color: SKColor.blackColor(), size: size)
        background.name = "teachLayerBackground"
        background.alpha = 0.7
        addChild(background)
        
        for i in 0...3 {
            let label = SKLabelNode(fontNamed: "SanFranciscoRounded-Black")
            label.fontSize = 30 * framescale
            label.fontColor = SKColor.whiteColor()
            label.position = CGPoint(x: 0, y: 60 - i * 60)
            label.zPosition = 950
            addChild(label)
            labels.append(label)
        }

        OKButton = SKShapeNode(rectOfSize: CGSizeMake(80 * framescale, 50 * framescale), cornerRadius: 10 * framescale)
        OKButton.name = "OKButton"
        OKButton.position = CGPoint(x: 0, y: -size.height / 6)
        OKButton.lineWidth = 3 * framescale
        let OKLabel = SKLabelNode(fontNamed: "SanFranciscoRounded-Black")
        OKLabel.name = "OKLabel"
        OKLabel.text = "OK"
        OKLabel.fontSize = 30 * framescale
        OKLabel.verticalAlignmentMode = .Center
        OKButton.addChild(OKLabel)
        addChild(OKButton)
    }
    
    func changeTeachStep(step: Int) {
        labels[0].text = ""
        labels[1].text = ""
        labels[2].text = ""
        switch step {
        case 1:
            labels[0].text = "Welcome to the first play!"
            labels[1].text = "Let me teach you how to play."
        case 2:
            labels[1].text = "Tap to switch to page construction."
        case 3:
            labels[1].text = "Tap to open the building menu."
        case 4:
            labels[0].text = "At this stage,"
            labels[1].text = "you can only select Wind Turbine."
            labels[2].text = "Click OK to close the building menu."
        case 5:
            labels[1].text = "Now tap on the map to build buildings."
        case 6:
            labels[0].text = "Congratulations!"
            labels[1].text = "You built the first building."
            labels[2].text = "Now tap the building to see information."
        case 7:
            labels[0].text = "Currently Wind Turbine can be produced"
            labels[1].text = "20 times and each produce 0.1 Energy."
            labels[2].text = "Now please switch to energy page."
        case 8:
            labels[0].text = "Total energy you have."
            labels[1].text = "Increase energy per second."
            labels[2].text = "Tap energy area to sell energy."
        case 9:
            labels[1].text = "Continue to sell the energy to make money."
            labels[2].text = "Then upgrade and research buildings."
        case 10:
            labels[0].text = "maps   pause"
            labels[1].text = "Building Sales"
            labels[2].text = "Upgrade building   Research building"
            
        default: break
        }
    }
}
