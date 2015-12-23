//
//  ReserchLayer.swift
//  Energy
//
//  Created by javan.chen on 2015/12/23.
//  Copyright © 2015年 Javan chen. All rights reserved.
//
import SpriteKit

class ReserchElement: SKSpriteNode {

    var reserchDone: Bool = false
    var buildingUpgrade = SKSpriteNode()
    var reserchType : String!
    
    func configureAtPosition(position: CGPoint, size: CGSize, buildType: BuildType, reserchType: String) {
        self.name = "ReserchElement"
        self.position = position
        self.size = size
        self.reserchType = reserchType
        self.color = SKColor.grayColor()
        self.anchorPoint = CGPoint(x: 0, y: 0)
        
        let gap: CGFloat = 20
        let buildingImage = BuildingData(buildType: buildType).buildingImage("ReserchElementImage")
        buildingImage.anchorPoint = CGPoint(x: 0, y: 0.5)
        buildingImage.position = CGPoint(x: gap, y: size.height / 2)
        addChild(buildingImage)
        
        
        
        var labelArray = [String]()
        if buildType == .Wind {
            labelArray = ["qwerqwer", "qwerqwerqwer" ,"asfasdfasfd"]
        }
        if buildType == .Fire {
            labelArray = ["qwerqwer", "qwerqwerqwer" ,"asfasdfasfd"]
        }
        
        
        
        let infoGap: CGFloat = 8
        let infoSize = (size.height - infoGap * 4) / 3
        for i in 1...3 {
            let label = SKLabelNode(fontNamed: "Verdana-Bold")
            label.name = "info\(CGFloat(i))"
            label.text = labelArray[i - 1]
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
        
    }
}

class ReserchLayer: SKSpriteNode {
    
    var origin: CGPoint!
    let gap: CGFloat = 20
    var selectElementSize: CGSize!
    var elements = [ReserchElement]()
    var elementPosition = [CGPoint]()
    var reserchLevel: Int = 1
    
    func configureAtPosition(position: CGPoint, midSize: CGSize) {
        origin = position
        self.position = CGPoint(x: origin.x, y: origin.y - 2 * midSize.height)
        self.position = position
        self.size = CGSizeMake(midSize.width * 4, midSize.height)
        self.name = "ReserchLayer"
        self.color = colorReserch
        self.anchorPoint = CGPoint(x: 0, y: 0)
        
        let selectElementNumber: CGFloat = 6
        let selectElementHeight = (self.size.height - gap * (selectElementNumber + 1)) / selectElementNumber
        selectElementSize = CGSizeMake(self.size.width / 4 - 2 * gap, selectElementHeight)
        
        for x in 0..<4 {
            for y in 1...6 {
                let pos = CGPoint(x: gap + CGFloat(x) * midSize.width, y: self.size.height - (gap + selectElementSize.height) * CGFloat(y))
                elementPosition.append(pos)
            }
        }
        
        updateReserchPage()
    }
    // Update building select page
    func updateReserchPage() {
        
        if reserchLevel >= 1 {
            let element1 = ReserchElement()
            element1.configureAtPosition(CGPoint(x: 0, y: 0), size: selectElementSize, buildType: .Wind, reserchType: "Rebuild")
            elements.append(element1)
            let element2 = ReserchElement()
            element2.configureAtPosition(CGPoint(x: 0, y: 0), size: selectElementSize, buildType: .Fire, reserchType: "Update")
            elements.append(element2)
        }
        
        
        for (count, element) in elements.enumerate() {
            element.position = elementPosition[count]
            addChild(element)
        }
    }
    
    // Show page
    func showPage(show: Bool) {
        self.runAction(SKAction.moveToY(origin.y + (show ? 0 : -2 * self.size.height), duration: 0.2))
    }
    func changePage(page: Int) {
        let frameWidth = self.size.width / 4
        self.runAction(SKAction.moveToX(origin.x + -CGFloat(page - 1) * frameWidth, duration: 0.2))
    }
}
