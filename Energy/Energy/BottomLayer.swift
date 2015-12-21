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
        image.name = "SelectImage5"
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

class PageEnergy: SKSpriteNode {
    
    var energyLabel: SKLabelNode!
    var energy_ProgressBack: SKSpriteNode!
    var energy_ProgressFront: SKSpriteNode!
    
    func configureAtPosition(position: CGPoint, size: CGSize) {
        self.position = position
        self.size = size
        self.color = SKColor.blueColor()
        self.name = "PageEnergy"
        self.anchorPoint = CGPoint(x: 0, y: 0)
        
        let energy_ProgressSize = CGSize(width: size.width * 3 / 4, height: size.height / 2)
        energy_ProgressBack = SKSpriteNode(color: colorEnergy, size: energy_ProgressSize)
        energy_ProgressBack.name = "Energy_ProgressBack"
        energy_ProgressBack.alpha = 0.3
        energy_ProgressBack.anchorPoint = CGPoint(x: 0, y: 0.5)
        energy_ProgressBack.position = CGPoint(x: size.width / 8, y: size.height / 2)
        addChild(energy_ProgressBack)
        energy_ProgressFront = SKSpriteNode(color: colorEnergy, size: energy_ProgressSize)
        energy_ProgressFront.name = "Energy_ProgressFront"
        energy_ProgressFront.alpha = 0.7
        energy_ProgressFront.anchorPoint = CGPoint(x: 0, y: 0.5)
        energy_ProgressFront.position = CGPoint(x: size.width / 8, y: size.height / 2)
        addChild(energy_ProgressFront)
        let labelsize = size.height / 8
        energyLabel = SKLabelNode(fontNamed: "Verdana-Bold")
        energyLabel.name = "EnergyLabel"
        energyLabel.fontColor = colorEnergy
        energyLabel.fontSize = labelsize
        energyLabel.horizontalAlignmentMode = .Left
        energyLabel.position = CGPoint(x: size.width / 8, y: size.height * 3 / 4 + 10)
        addChild(energyLabel)
    }
    
    func progressPercent(percent: CGFloat) {
        energy_ProgressFront.xScale = percent
    }
}

class PageReserch: SKSpriteNode {
    
    func configureAtPosition(position: CGPoint, size: CGSize) {
        self.position = position
        self.size = size
        self.color = colorReserch
        self.name = "PageReserch"
        self.anchorPoint = CGPoint(x: 0, y: 0)
    }
}

class BottomLayer: SKSpriteNode {

    var pageInformation = PageInformation()
    var pageBuild = PageBuild()
    var pageEnergy = PageEnergy()
    var pageReserch = PageReserch()
    
    func configureAtPosition(position: CGPoint, size: CGSize) {
        
        self.position = position
        self.size = size
        self.color = SKColor.blackColor()
        self.name = "BottomLayer"
        self.anchorPoint = CGPoint(x: 0, y: 0)
        
        pageInformation.configureAtPosition(CGPoint(x: 0, y: -size.height * 2), size: size)
        addChild(pageInformation)
        pageBuild.configureAtPosition(CGPoint(x: 0, y: -size.height * 2), size: size)
        addChild(pageBuild)
        pageEnergy.configureAtPosition(CGPoint(x: 0, y: -size.height * 2), size: size)
        addChild(pageEnergy)
        pageReserch.configureAtPosition(CGPoint(x: 0, y: -size.height * 2), size: size)
        addChild(pageReserch)
        
        showPageEnergy()
    }
    
    func ShowPageInformation() {
        pageBuild.runAction(SKAction.moveToY(-size.height * 2, duration: 0.1))
        pageEnergy.runAction(SKAction.moveToY(-size.height * 2, duration: 0.1))
        pageReserch.runAction(SKAction.moveToY(-size.height * 2, duration: 0.1)) { [unowned self] in
            self.pageInformation.runAction(SKAction.moveToY(0, duration: 0.1))
        }
    }
    func ShowPageBuild() {
        pageInformation.runAction(SKAction.moveToY(-size.height * 2, duration: 0.1))
        pageEnergy.runAction(SKAction.moveToY(-size.height * 2, duration: 0.1))
        pageReserch.runAction(SKAction.moveToY(-size.height * 2, duration: 0.1)) { [unowned self] in
            self.pageBuild.runAction(SKAction.moveToY(0, duration: 0.1))
        }
    }
    func showPageEnergy() {
        pageInformation.runAction(SKAction.moveToY(-size.height * 2, duration: 0.1))
        pageBuild.runAction(SKAction.moveToY(-size.height * 2, duration: 0.1))
        pageReserch.runAction(SKAction.moveToY(-size.height * 2, duration: 0.1)) { [unowned self] in
            self.pageEnergy.runAction(SKAction.moveToY(0, duration: 0.1))
        }
    }
    func showPageReserch() {
        pageInformation.runAction(SKAction.moveToY(-size.height * 2, duration: 0.1))
        pageBuild.runAction(SKAction.moveToY(-size.height * 2, duration: 0.1))
        pageEnergy.runAction(SKAction.moveToY(-size.height * 2, duration: 0.1)) { [unowned self] in
            self.pageReserch.runAction(SKAction.moveToY(0, duration: 0.1))
        }
    }
}