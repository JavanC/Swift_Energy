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
        
        let infoImage = BuildingData(buildType: .Nil).buildingImage("infoImage")
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
        let infoImage = BuildingData(buildType: infobuildType).buildingImage("infoImage")
        infoImage.position = infoImagePosition!
        addChild(infoImage)
        
        let labels = building.buildingData.buildingInfo(infobuildType)
        for i in 0..<5 {
            info[i].text = (i < labels.count ? labels[i] : "")
        }
    }
}

class PageBuild: SKSpriteNode {
    
    var selectNumber: Int = 1
    var imagePosition = [CGPoint]()
    var buildMenu: [BuildType] = [.Wind, .Fire, .Generator, .Office]
    var selectBox: SKSpriteNode!
    
    func configureAtPosition(position: CGPoint, size: CGSize) {
        self.position = position
        self.size = size
        self.color = SKColor.brownColor()
        self.name = "PageBuild"
        self.anchorPoint = CGPoint(x: 0, y: 0)
        
        let gap = (size.width - 5 * tilesScaleSize.width) / 6
        for i in 1...5 {
            imagePosition.append(CGPoint(x: gap * CGFloat(i) + tilesScaleSize.width * (0.5 + CGFloat(i - 1)), y: size.height / 2))
        }
        for i in 1...4 {
            let image = BuildingData(buildType: buildMenu[i - 1]).buildingImage("SelectImage\(i)")
            image.position = imagePosition[i - 1]
            addChild(image)
        }
        let image = SKSpriteNode(color: SKColor.yellowColor(), size: tilesScaleSize)
        image.name = "buildingSell"
        image.position = imagePosition[4]
        addChild(image)

        selectBox = SKSpriteNode(color: SKColor.redColor(), size: tilesScaleSize)
        selectBox.name = "selectBox"
        selectBox.setScale(1.1)
        selectBox.position = imagePosition[0]
        addChild(selectBox)
    }
    
    func changeSelectImage(buildType: BuildType) {
        buildMenu[selectNumber - 1] = buildType
        let imgPosition = childNodeWithName("SelectImage\(selectNumber)")?.position
        childNodeWithName("SelectImage\(selectNumber)")?.removeFromParent()
        let image = BuildingData(buildType: buildType).buildingImage("SelectImage\(selectNumber)")
        image.position = imgPosition!
        addChild(image)
    }
    
    func changeSelectNumber(selectNumber: Int) {
        self.selectNumber = selectNumber
        selectBox.position = imagePosition[selectNumber - 1]
    }
}


class BottomLayer: SKSpriteNode {

    var pageInformation = PageInformation()
    var pageBuild = PageBuild()
    var pageEnergy: SKSpriteNode!
    var pageReserch: SKSpriteNode!
    
    func configureAtPosition(position: CGPoint, size: CGSize) {
        
        self.position = position
        self.size = size
        self.color = SKColor.blackColor()
        self.name = "BottomLayer"
        self.anchorPoint = CGPoint(x: 0, y: 0)
        
        pageInformation.configureAtPosition(CGPoint(x: size.width, y: 0), size: size)
        addChild(pageInformation)
        pageBuild.configureAtPosition(CGPoint(x: 0, y: 0), size: size)
        addChild(pageBuild)
        
    }
}