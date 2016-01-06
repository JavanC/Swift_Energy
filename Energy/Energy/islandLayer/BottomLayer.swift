//
//  BottomLayer.swift
//  Energy
//
//  Created by javan.chen on 2015/12/21.
//  Copyright © 2015年 Javan chen. All rights reserved.
//

import SpriteKit

class InformationLabel: SKNode {
    var titleLabel: SKLabelNode!
    var valueLabel: SKLabelNode!
    
    init(title: String, fontSize: CGFloat, valueColor: SKColor) {
        super.init()
        titleLabel = SKLabelNode(fontNamed: "SanFranciscoText-BoldItalic")
        titleLabel.name = "title"
        titleLabel.text = "\(title) :"
        titleLabel.fontSize = fontSize
        titleLabel.fontColor = SKColor.whiteColor()
        titleLabel.horizontalAlignmentMode = .Left
        addChild(titleLabel)
        valueLabel = SKLabelNode(fontNamed: "SanFranciscoText-BoldItalic")
        valueLabel.name = "value"
        valueLabel.text = ""
        valueLabel.fontSize = fontSize
        valueLabel.fontColor = valueColor
        valueLabel.horizontalAlignmentMode = .Left
        valueLabel.position = CGPoint(x: titleLabel.frame.size.width + 5, y: 0)
        addChild(valueLabel)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class PageInformation: SKSpriteNode {

    var info = [SKLabelNode]()
    
    var positions = [CGPoint]()
    
    var infoTicksNode: InformationLabel!
    var infoHeatNode: InformationLabel!
    var infoWaterNode: InformationLabel!
    var infoProduceEnergyNode: InformationLabel!
    var infoProduceHeatNode: InformationLabel!
    var infoSellsMoneyNode: InformationLabel!
    var infoConvertedEnergyNode: InformationLabel!
    var infoPriceNode: InformationLabel!
    var allLabels = [InformationLabel]()
    
    func configureAtPosition(position: CGPoint, size: CGSize) {
        
        self.position = position
        self.size = size
        self.color = SKColor.blackColor()
        self.name = "PageInformation"
        self.anchorPoint = CGPoint(x: 0, y: 0)
        
        let infoImage = BuildingData(buildType: .Land).image("infoImage")
        infoImage.position = CGPoint(x: 40 + infoImage.size.width / 2, y: size.height / 2)
        addChild(infoImage)
    
        let infogap: CGFloat = 5
        let infoSize = (size.height - 6 * infogap) / 5
        for i in 1...5 {
            positions.append(CGPoint(x: infoImage.size.width + 80, y: infogap * CGFloat(6 - i) + infoSize * CGFloat(5 - i)))
        }

        infoTicksNode = InformationLabel(title: "Ticks", fontSize: infoSize, valueColor: SKColor.whiteColor())
        addChild(infoTicksNode)
        infoHeatNode = InformationLabel(title: "Heat", fontSize: infoSize, valueColor: SKColor.redColor())
        addChild(infoHeatNode)
        infoWaterNode = InformationLabel(title: "Water", fontSize: infoSize, valueColor: colorEnergy)
        addChild(infoWaterNode)
        infoProduceEnergyNode = InformationLabel(title: "Produce Energy", fontSize: infoSize, valueColor: colorEnergy)
        addChild(infoProduceEnergyNode)
        infoProduceHeatNode = InformationLabel(title: "Produce Heat", fontSize: infoSize, valueColor: SKColor.redColor())
        addChild(infoProduceHeatNode)
        infoSellsMoneyNode = InformationLabel(title: "Sells Money", fontSize: infoSize, valueColor: colorMoney)
        addChild(infoSellsMoneyNode)
        infoConvertedEnergyNode = InformationLabel(title: "Converted Energy", fontSize: infoSize, valueColor: SKColor.redColor())
        addChild(infoConvertedEnergyNode)
        infoPriceNode = InformationLabel(title: "Price", fontSize: infoSize, valueColor: colorMoney)
        addChild(infoPriceNode)
        
        allLabels = [infoTicksNode, infoHeatNode, infoWaterNode, infoProduceEnergyNode, infoProduceHeatNode, infoSellsMoneyNode, infoConvertedEnergyNode, infoPriceNode]
    }
    
    func changeInformation(buildingData: BuildingData) {
        
        // Image
        
        let infoImagePosition = childNodeWithName("infoImage")?.position
        childNodeWithName("infoImage")?.removeFromParent()
        let infoImage = buildingData.image("infoImage")
        infoImage.position = infoImagePosition!
        addChild(infoImage)
        
        // Label
        
        for label in allLabels {
            label.hidden = true
        }
        var informationLabels = [InformationLabel]()
        if buildingData.timeSystem != nil {
            infoTicksNode.hidden = false
            infoTicksNode.valueLabel.text = "\(buildingData.timeSystem.inAmount) / \(buildingData.timeSystem.size)"
            informationLabels.append(infoTicksNode)
        }
        if buildingData.heatSystem != nil {
            infoHeatNode.hidden = false
            infoHeatNode.valueLabel.text = "\(buildingData.heatSystem.inAmount) / \(buildingData.heatSystem.size)"
            informationLabels.append(infoHeatNode)
        }
        if buildingData.waterSystem != nil {
            infoWaterNode.hidden = false
            infoWaterNode.valueLabel.text = "\(buildingData.waterSystem.inAmount) / \(buildingData.waterSystem.size)"
            informationLabels.append(infoWaterNode)
        }
        if ([.WindTurbine, .WaveCell]).contains(buildingData.buildType) {
            infoProduceEnergyNode.hidden = false
            infoProduceEnergyNode.valueLabel.text = "\(buildingData.energySystem.produce)"
            informationLabels.append(infoProduceEnergyNode)
        }
        if ([.SolarCell, .CoalBurner, .GasBurner, .NuclearCell, .FusionCell]).contains(buildingData.buildType) {
            infoProduceHeatNode.hidden = false
            infoProduceHeatNode.valueLabel.text = "\(buildingData.heatSystem.produceHeatValue())"
            informationLabels.append(infoProduceHeatNode)
        }
        if ([.SmallGenerator, .MediumGenerator, .LargeGenerator]).contains(buildingData.buildType) {
            infoConvertedEnergyNode.hidden = false
            infoConvertedEnergyNode.valueLabel.text = "\(buildingData.energySystem.heat2EnergyAmount)"
            informationLabels.append(infoConvertedEnergyNode)
        }
        if ([.SmallOffice, .MediumOffice, .LargeOffice]).contains(buildingData.buildType) {
            infoSellsMoneyNode.hidden = false
            infoSellsMoneyNode.valueLabel.text = "\(buildingData.moneySystem.heat2MoneyAmount)"
            informationLabels.append(infoSellsMoneyNode)
        }
        if ([.WindTurbine, .SolarCell, .CoalBurner, .WaveCell, .GasBurner, .NuclearCell, .FusionCell]).contains(buildingData.buildType) {
            infoPriceNode.hidden = false
            infoPriceNode.valueLabel.text = "0"
            informationLabels.append(infoPriceNode)
        } else {
            infoPriceNode.hidden = false
            infoPriceNode.valueLabel.text = "\(buildingData.buildPrice)"
            informationLabels.append(infoPriceNode)
        }
        
        for count in 0..<informationLabels.count {
            informationLabels[count].position = positions[count]
        }
        
    }

    func nowLevelImformation(buildType: BuildingType) {

    }
}

class PageBuild: SKSpriteNode {
    
    var selectNumber: Int = 1
    var imagePosition = [CGPoint]()
    var buildMenu: [BuildingType] = [BuildingType.WindTurbine, BuildingType.CoalBurner, BuildingType.SmallGenerator, BuildingType.SmallOffice]
    var images = [SKSpriteNode]()
    var selectBox: SKSpriteNode!
    var selectInfo = PageInformation()
    var rebuildButton: SKSpriteNode!
    
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
            let image = BuildingData(buildType: buildMenu[i - 1]).image("SelectImage\(i)")
            image.position = imagePosition[i - 1]
            images.append(image)
            addChild(image)
        }
        rebuildButton = SKSpriteNode(color: SKColor.greenColor(), size: tilesScaleSize)
        rebuildButton.name = "SelectImage5"
        rebuildButton.position = imagePosition[4]
        addChild(rebuildButton)

        selectBox = SKSpriteNode(color: SKColor.redColor(), size: tilesScaleSize)
        selectBox.name = "selectBox"
        selectBox.setScale(1.1)
        selectBox.position = imagePosition[0]
        addChild(selectBox)
        
        selectInfo.configureAtPosition(CGPoint(x: 0, y: 0), size: size)
        selectInfo.name = "SelectInformation"
        selectInfo.nowLevelImformation(buildMenu[selectNumber - 1])
        selectInfo.alpha = 1
        selectInfo.hidden = true
        addChild(selectInfo)
    }
    
    func changeSelectBuildType(buildType: BuildingType) {
        buildMenu[selectNumber - 1] = buildType
        selectInfo.nowLevelImformation(buildType)
        
        let imgPosition = childNodeWithName("SelectImage\(selectNumber)")?.position
        childNodeWithName("SelectImage\(selectNumber)")?.removeFromParent()
        let image = BuildingData(buildType: buildType).image("SelectImage\(selectNumber)")
        image.position = imgPosition!
        images[selectNumber - 1] = image
        addChild(image)
    }
    
    func changeSelectNumber(selectNumber: Int) {
        self.selectNumber = selectNumber
        selectBox.position = imagePosition[selectNumber - 1]
        selectInfo.nowLevelImformation(buildMenu[selectNumber - 1])
    }
    
    func openSelectInformation() {
        if selectNumber > 4 || selectNumber < 1 { return }
        let pos = CGPoint(x: 40 + tilesScaleSize.width / 2, y: size.height / 2)
        
        // Remove Action
        childNodeWithName("SelectImage\(selectNumber)")?.removeAllActions()
        // Hide
        childNodeWithName("selectBox")?.runAction(SKAction.sequence([SKAction.hide(), SKAction.fadeAlphaTo(0, duration: 0)]))
        for i in 1...5 {
            if i != selectNumber {
                childNodeWithName("SelectImage\(i)")?.runAction(SKAction.sequence([SKAction.fadeOutWithDuration(0.2), SKAction.hide()]))
            }
        }
        // Move
        let move = SKAction.moveTo(pos, duration: 0.2)
        let seq = SKAction.sequence([move, SKAction.waitForDuration(0.2), SKAction.hide()])
        childNodeWithName("SelectImage\(selectNumber)")?.runAction(seq)
        // Show
        selectInfo.runAction(SKAction.sequence([SKAction.unhide(), SKAction.waitForDuration(0.2), SKAction.fadeAlphaTo(1, duration: 0.2)]))
    }
    
    func closeSelectInformation() {
        if selectNumber > 4 || selectNumber < 1 { return }
        let pos = imagePosition[selectNumber - 1]
        
        // Remove Action
        childNodeWithName("SelectImage\(selectNumber)")?.removeAllActions()
        // Hide
        selectInfo.childNodeWithName("infoImage")?.runAction(SKAction.sequence([SKAction.hide(), SKAction.waitForDuration(0.2), SKAction.unhide()]))
        selectInfo.runAction(SKAction.sequence([SKAction.fadeAlphaTo(0, duration: 0.2), SKAction.hide()]))
        // Move
        childNodeWithName("SelectImage\(selectNumber)")?.runAction(SKAction.unhide())
        childNodeWithName("SelectImage\(selectNumber)")?.runAction(SKAction.moveTo(pos, duration: 0.2))
        // Show
        let seq = SKAction.sequence([SKAction.unhide(), SKAction.waitForDuration(0.2), SKAction.fadeAlphaTo(1, duration: 0.2)])
        self.childNodeWithName("selectBox")?.runAction(seq)
        for i in 1...5 {
            if i != selectNumber {
                childNodeWithName("SelectImage\(i)")?.runAction(seq)
            }
        }
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

class PageSell: SKSpriteNode {
    
    var sellLabel: SKLabelNode!
    
    func configureAtPosition(position: CGPoint, size: CGSize) {
        self.position = position
        self.size = size
        self.color = SKColor.yellowColor()
        self.name = "PageSell"
        self.anchorPoint = CGPoint(x: 0, y: 0)
        
        sellLabel = SKLabelNode(fontNamed: "Verdana-Bold")
        sellLabel.name = "SellLabel"
        sellLabel.fontSize = size.height / 6
        sellLabel.fontColor = SKColor.blackColor()
        sellLabel.position = CGPoint(x: size.width / 2, y: size.height / 2)
        sellLabel.text = "Touch building to sell."
        addChild(sellLabel)
    }
}

class BottomLayer: SKSpriteNode {

    var pageInformation: PageInformation!
    var pageBuild: PageBuild!
    var pageEnergy: PageEnergy!
    var pageSell: PageSell!
    
    func configureAtPosition(position: CGPoint, size: CGSize) {
        
        self.position = position
        self.size = size
        self.color = SKColor.blackColor()
        self.name = "BottomLayer"
        self.anchorPoint = CGPoint(x: 0, y: 0)
        
        pageInformation = PageInformation()
        pageInformation.configureAtPosition(CGPoint(x: 0, y: -size.height * 2), size: size)
        addChild(pageInformation)
        pageBuild = PageBuild()
        pageBuild.configureAtPosition(CGPoint(x: 0, y: -size.height * 2), size: size)
        addChild(pageBuild)
        pageEnergy = PageEnergy()
        pageEnergy.configureAtPosition(CGPoint(x: 0, y: 0), size: size)
        addChild(pageEnergy)
        pageSell = PageSell()
        pageSell.configureAtPosition(CGPoint(x: 0, y: -size.height * 2), size: size)
        addChild(pageSell)
        
        showPageEnergy()
    }
    
    func ShowPageInformation(duration: Double = 0.0) {
        pageBuild.runAction(SKAction.moveToY(-size.height * 2, duration: duration))
        pageEnergy.runAction(SKAction.moveToY(-size.height * 2, duration: duration))
        pageSell.runAction(SKAction.moveToY(-size.height * 2, duration: duration)) { [unowned self] in
            self.pageInformation.runAction(SKAction.moveToY(0, duration: duration))
        }
    }
    func ShowPageBuild(duration: Double = 0.0) {
        pageInformation.runAction(SKAction.moveToY(-size.height * 2, duration: duration))
        pageEnergy.runAction(SKAction.moveToY(-size.height * 2, duration: duration))
        pageSell.runAction(SKAction.moveToY(-size.height * 2, duration: duration)) { [unowned self] in
            self.pageBuild.runAction(SKAction.moveToY(0, duration: duration))
        }
    }
    func showPageEnergy(duration: Double = 0.0) {
        pageInformation.runAction(SKAction.moveToY(-size.height * 2, duration: duration))
        pageBuild.runAction(SKAction.moveToY(-size.height * 2, duration: duration))
        pageSell.runAction(SKAction.moveToY(-size.height * 2, duration: duration)) { [unowned self] in
            self.pageEnergy.runAction(SKAction.moveToY(0, duration: duration))
        }
    }
    func showPageSell(duration: Double = 0.0) {
        pageInformation.runAction(SKAction.moveToY(-size.height * 2, duration: duration))
        pageBuild.runAction(SKAction.moveToY(-size.height * 2, duration: duration))
        pageEnergy.runAction(SKAction.moveToY(-size.height * 2, duration: duration)) { [unowned self] in
            self.pageSell.runAction(SKAction.moveToY(0, duration: duration))
        }
    }
}