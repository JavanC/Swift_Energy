//
//  BottomLayer.swift
//  Energy
//
//  Created by javan.chen on 2015/12/21.
//  Copyright © 2015年 Javan chen. All rights reserved.
//

import SpriteKit

class PageInformation: SKSpriteNode {
    
    var info = [SKLabelNode]()
    
    func configureAtPosition(position: CGPoint, size: CGSize) {
        
        self.position = position
        self.size = size
        self.color = SKColor.redColor()
        self.name = "PageInformation"
        self.anchorPoint = CGPoint(x: 0, y: 0)
        
        let infoImage = BuildingData(buildType: .Nil).buildingImage("infoImage", buildType: .Nil)
        infoImage.position = CGPoint(x: 40 + infoImage.size.width / 2, y: size.height / 2)
        addChild(infoImage)
        
        let infogap: CGFloat = 13
        let infoSize = (size.height - 6 * infogap) / 5
        for i in 1...5 {
            let label = SKLabelNode(fontNamed: "Verdana-Bold")
            label.name = "info\(i)"
            label.fontSize = infoSize
            label.horizontalAlignmentMode = .Left
            label.position = CGPoint(x: infoImage.size.width + 80, y: infogap * CGFloat(6 - i) + infoSize * CGFloat(5 - i))
            label.text = "123"
            addChild(label)
            info.append(label)
        }
    }
    
    func changeInformation(building: Building) {
        
        let infoImagePosition = childNodeWithName("infoImage")?.position
        childNodeWithName("infoImage")?.removeFromParent()
        let infobuildType = building.buildingData.buildType
        let infoImage = BuildingData(buildType: infobuildType).buildingImage("infoImage", buildType: infobuildType)
        infoImage.position = infoImagePosition!
        addChild(infoImage)
        
        let labels = building.buildingData.buildingInfo(infobuildType)
        for i in 0..<5 {
            info[i].text = (i < labels.count ? labels[i] : "")
        }
    }
}


class BottomLayer: SKSpriteNode {

    var pageInformation = PageInformation()
    var pageBuild: SKSpriteNode!
    var pageEnergy: SKSpriteNode!
    var pageReserch: SKSpriteNode!
    
    func configureAtPosition(position: CGPoint, size: CGSize) {
        
        self.position = position
        self.size = size
        self.color = SKColor.blackColor()
        self.name = "BottomLayer"
        self.anchorPoint = CGPoint(x: 0, y: 0)
        
        pageInformation.configureAtPosition(CGPoint(x: 0, y: 0), size: size)
        addChild(pageInformation)
        
        
            }
}