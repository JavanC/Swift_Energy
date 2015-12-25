//
//  BuildingSelectLayer.swift
//  Energy
//
//  Created by javan.chen on 2015/12/18.
//  Copyright © 2015年 Javan chen. All rights reserved.
//

import SpriteKit

class BuildingSelectElement: SKSpriteNode {

    var buildingUpgrade = SKSpriteNode()
    var buildingDegrade = SKSpriteNode()
    var buildType: BuildingType!
    
    func configureAtPosition(buildType: BuildingType, position: CGPoint, size: CGSize) {
        self.name = "BuildingSelectElement"
        self.buildType = buildType
        self.position = position
        self.size = size
        self.color = SKColor.grayColor()
        self.anchorPoint = CGPoint(x: 0, y: 0)
        
        let gap: CGFloat = 20
        let buildingImage = BuildingData(buildType: buildType).image("\(self.name)_Image")
        buildingImage.anchorPoint = CGPoint(x: 0, y: 0.5)
        buildingImage.position = CGPoint(x: gap, y: size.height / 2)
        addChild(buildingImage)
        
        let infoGap: CGFloat = 8
        let infoSize = (size.height - infoGap * 4) / 3
        let levelInfo = ["123123", "12312312", "123123123123"]
        for i in 1...3 {
            let label = SKLabelNode(fontNamed: "Verdana-Bold")
            label.name = "info\(CGFloat(i))"
            label.text = levelInfo[i - 1]
            label.fontSize = infoSize
            label.horizontalAlignmentMode = .Left
            label.position = CGPoint(x: tilesScaleSize.width + gap * 2, y: infoGap * (4 - CGFloat(i)) + infoSize * (3 - CGFloat(i)))
            addChild(label)
        }
        
        buildingUpgrade = SKSpriteNode(color: SKColor.greenColor(), size: buildingImage.size)
        buildingUpgrade.name = "Upgrade"
        buildingUpgrade.anchorPoint = CGPoint(x: 1, y: 0.5)
        buildingUpgrade.position = CGPoint(x: size.width - gap, y: size.height / 2)
        addChild(buildingUpgrade)
        
//        if money < BuildingData(buildType: buildType).nextLevelPrice {
//            buildingUpgrade.color = SKColor.blackColor()
//        }
        
//        if nowLevel > 1 {
//            buildingDegrade = SKSpriteNode(color: SKColor.redColor(), size: buildingImage.size)
//            buildingDegrade.name = "Degrade"
//            buildingDegrade.anchorPoint = CGPoint(x: 1, y: 0.5)
//            buildingDegrade.position = CGPoint(x: size.width - gap * 2 - buildingImage.size.width, y: size.height / 2)
//            addChild(buildingDegrade)
//        }
    }
}

class BuildingSelectLayer: SKSpriteNode {
    
    var show: Bool = false
    var origin: CGPoint!
    let gap: CGFloat = 20
    var selectElementSize: CGSize!
    var elements = [BuildingSelectElement]()
    
    func configureAtPosition(position: CGPoint, midSize: CGSize) {
        origin = position
        self.position = CGPoint(x: origin.x, y: origin.y - 2 * midSize.height)
        self.size = CGSizeMake(midSize.width * 4, midSize.height)
        self.name = "BuildingSelectLayer"
        self.color = SKColor.blackColor()
        self.anchorPoint = CGPoint(x: 0, y: 0)
        
        let selectElementNumber: CGFloat = 6
        let selectElementHeight = (self.size.height - gap * (selectElementNumber + 1)) / selectElementNumber
        selectElementSize = CGSizeMake(self.size.width / 4 - 2 * gap, selectElementHeight)
        
        updateBuildingSelectPage()
    }
    
    // Update building select page
    func updateBuildingSelectPage() {
        elements.removeAll()
        removeAllChildren()
        let page1:[BuildingType] = [.Wind, .Fire, .Office]
        for (count, buildType) in page1.enumerate() {
//            let buildlevel = getBuildLevel(buildType)
//            if buildlevel > 0 {
                let position = CGPoint(x: gap, y: self.size.height - (gap + selectElementSize.height) * CGFloat(count + 1))
                let sptireNode = BuildingSelectElement()
                sptireNode.configureAtPosition(buildType, position: position, size: selectElementSize)
                elements.append(sptireNode)
                addChild(sptireNode)
//            }
        }
        let page2:[BuildingType] = [.Wind, .Wind, .Wind, .Fire, .Office]
        for (count, buildType) in page2.enumerate() {
//            let buildlevel = getBuildLevel(buildType)
//            if buildlevel > 0 {
                let position = CGPoint(x: gap + size.width / 4, y: self.size.height - (gap + selectElementSize.height) * CGFloat(count + 1))
                let sptireNode = BuildingSelectElement()
                sptireNode.configureAtPosition(buildType, position: position, size: selectElementSize)
                elements.append(sptireNode)
                addChild(sptireNode)
//            }
        }
    }
    
    // Show page
    func showPage(show: Bool) {
        self.show = show
        self.runAction(SKAction.moveToY(origin.y + (show ? 0 : -2 * self.size.height), duration: 0.2))
    }
    func changePage(page: Int) {
        let frameWidth = self.size.width / 4
        self.runAction(SKAction.moveToX(origin.x + -CGFloat(page - 1) * frameWidth, duration: 0.2))
    }
}
