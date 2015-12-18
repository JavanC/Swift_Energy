//
//  GamePlay-Top.swift
//  Energy
//
//  Created by javan.chen on 2015/12/18.
//  Copyright © 2015年 Javan chen. All rights reserved.
//

import SpriteKit

class GamePlayTop: SKNode {
    
    let topSprite: SKSpriteNode
    
    init(size: CGSize){
        topSprite = SKSpriteNode(color: SKColor.grayColor(), size: size)
        super.init()
        
        topSprite.anchorPoint = CGPoint(x: 0, y: 0)
        
        
        
        

        
        
        
        addChild(topSprite)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }



}