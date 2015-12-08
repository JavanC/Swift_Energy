//
//  SKButton.swift
//  Energy
//
//  Created by javan.chen on 2015/12/8.
//  Copyright © 2015年 Javan chen. All rights reserved.
//

import SpriteKit

class SKButton: SKNode {
    var defaultButton: SKSpriteNode
    var activeButton: SKSpriteNode
    var action: () -> Void
    
    init(defaultButtonImage: String, activeButtonImage: String, buttonAction: () -> Void) {
        defaultButton = SKSpriteNode(imageNamed: defaultButtonImage)
        activeButton = SKSpriteNode(imageNamed: activeButtonImage)
        activeButton.hidden = true
        action = buttonAction
        
        super.init()
        
        userInteractionEnabled = true
        addChild(defaultButton)
        addChild(activeButton)
    }
    
    /**
     Required so XCode doesn't throw warnings
     */
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func notPress() {
        activeButton.hidden = true
        defaultButton.hidden = false
    }
    func press() {
        activeButton.hidden = false
        defaultButton.hidden = true
    }
}
