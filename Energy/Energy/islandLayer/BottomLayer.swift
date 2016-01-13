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

    var infoImage: SKSpriteNode!
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
        self.name = "PageInformation"
        self.anchorPoint = CGPoint(x: 0, y: 0)
        
        infoImage = BuildingData(buildType: .Land).image("infoImage")
        infoImage.position = CGPoint(x: infoImage.size.width, y: size.height / 2)
        addChild(infoImage)
    
        let infogap: CGFloat = size.height * 0.08
        let infoSize = (size.height - 5 * infogap) / 4
        for i in 1...4 {
            positions.append(CGPoint(x: infoImage.size.width * 2, y: infogap * CGFloat(5 - i) + infoSize * CGFloat(4 - i)))
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
        infoImage.runAction(SKAction.setTexture(SKTexture(imageNamed: buildingData.imageName)))

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
}

class PageBuild: SKSpriteNode {
    
    var selectNumber: Int = 1
    var imagePosition = [CGPoint]()
    var buildMenu: [BuildingType] = [BuildingType.WindTurbine, BuildingType.CoalBurner, BuildingType.SmallGenerator, BuildingType.SmallOffice]
    var images = [SKSpriteNode]()
    var selectBox: SKSpriteNode!
    var selectBoxArrow: SKSpriteNode!
    var selectInfo = PageInformation()
    var rebuildButton: SKShapeNode!
    
    func configureAtPosition(position: CGPoint, size: CGSize) {
        self.position = position
        self.size = size
        self.name = "PageBuild"
        self.anchorPoint = CGPoint(x: 0, y: 0)
        
        let gap = (size.width - 5 * tilesScaleSize.width) / 6
        for i in 1...5 {
            imagePosition.append(CGPoint(x: gap * CGFloat(i) + tilesScaleSize.width * (0.5 + CGFloat(i - 1)), y: size.height / 2))
        }
        for i in 1...4 {
            let image = BuildingData(buildType: buildMenu[i - 1]).image("SelectImage\(i)")
            image.position = imagePosition[i - 1]
            image.zPosition = 10
            images.append(image)
            addChild(image)
        }
        let rect = CGRect(x: -32 * framescale, y: -32 * framescale, width: 64 * framescale, height: 64 * framescale)
        rebuildButton = SKShapeNode(rect: rect, cornerRadius: 10 * framescale)
        rebuildButton.name = "SelectImage5"
        rebuildButton.position = imagePosition[4]
        let buildingiImage = SKSpriteNode(imageNamed: "Button_build")
        buildingiImage.name = "buildingImage"
        buildingiImage.setScale(0.4 * framescale)
        rebuildButton.addChild(buildingiImage)
        let refreshImage = SKSpriteNode(imageNamed: "refresh")
        refreshImage.name = "refreshImage"
        refreshImage.setScale(framescale)
        rebuildButton.addChild(refreshImage)
        addChild(rebuildButton)

        selectBox = SKSpriteNode(color: SKColor.redColor(), size: tilesScaleSize)
        selectBox.name = "selectBox"
        selectBox.setScale(1.1)
        selectBox.position = imagePosition[0]
        selectBox.zPosition = 1
        addChild(selectBox)
        
        selectBoxArrow = SKSpriteNode(imageNamed: "up arrow")
        selectBoxArrow.name = "selectBoxArrow"
        selectBoxArrow.position = CGPoint(x: selectBox.position.x, y: selectBox.position.y + 50)
        let upAction = SKAction.sequence([SKAction.moveByX(0, y: 5, duration: 0.5), SKAction.moveByX(0, y: -5, duration: 0.5)])
        selectBoxArrow.runAction(SKAction.repeatActionForever(upAction))
        addChild(selectBoxArrow)
        
        selectInfo.configureAtPosition(CGPoint(x: 0, y: 0), size: size)
        selectInfo.name = "SelectInformation"
        selectInfo.changeInformation(BuildingData(buildType: buildMenu[selectNumber - 1]))
        selectInfo.alpha = 1
        selectInfo.hidden = true
        addChild(selectInfo)
    }
    
    func rebuildOn() {
        rebuildButton.fillColor = colorBlue2
        rebuildButton.strokeColor = colorBlue2
        let action = SKAction.rotateByAngle(CGFloat(M_PI), duration: 2)
        rebuildButton.childNodeWithName("refreshImage")!.runAction(SKAction.repeatActionForever(action))
    }
    
    func rebuildOff() {
        rebuildButton.fillColor = SKColor.grayColor()
        rebuildButton.strokeColor = SKColor.grayColor()
        rebuildButton.childNodeWithName("refreshImage")!.removeAllActions()
    }
    
    func changeSelectNumber(selectNumber: Int) {
        self.selectNumber = selectNumber
        selectBox.position = imagePosition[selectNumber - 1]
        selectBoxArrow.position = CGPoint(x: selectBox.position.x, y: selectBox.position.y + 50)
        selectInfo.changeInformation(BuildingData(buildType: buildMenu[selectNumber - 1]))
    }
    
    func changeSelectBuildType(buildType: BuildingType) {
        buildMenu[selectNumber - 1] = buildType
        selectInfo.changeInformation(BuildingData(buildType: buildType))
        images[selectNumber - 1].runAction(SKAction.setTexture(SKTexture(imageNamed: BuildingData(buildType: buildType).imageName)))
    }
    
    func openSelectInformation() {
        if selectNumber > 4 || selectNumber < 1 { return }
        let pos = CGPoint(x: tilesScaleSize.width, y: size.height / 2)
        
        // Remove Action
        childNodeWithName("SelectImage\(selectNumber)")?.removeAllActions()
        // Hide
        selectBox.runAction(SKAction.sequence([SKAction.hide(), SKAction.fadeAlphaTo(0, duration: 0)]))
        selectBoxArrow.runAction(SKAction.sequence([SKAction.hide(), SKAction.fadeAlphaTo(0, duration: 0)]))
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
        selectInfo.runAction(SKAction.sequence([SKAction.unhide(), SKAction.waitForDuration(0.2), SKAction.fadeInWithDuration(0.2)]))
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
        let seq = SKAction.sequence([SKAction.unhide(), SKAction.waitForDuration(0.2), SKAction.fadeInWithDuration(0.2)])
        selectBox.runAction(seq)
        selectBoxArrow.runAction(seq)
        for i in 1...5 {
            if i != selectNumber {
                childNodeWithName("SelectImage\(i)")?.runAction(seq)
            }
        }
    }
}

class PageSell: SKSpriteNode {
    
    var sellLabel: SKMultilineLabel!
    
    func configureAtPosition(position: CGPoint, size: CGSize) {
        self.position = position
        self.size = size
        self.name = "PageSell"
        self.anchorPoint = CGPoint(x: 0, y: 0)
        
        let gap = Int(20 * framescale)
        
        sellLabel = SKMultilineLabel(text: "Touch buildings on the map to sell it. \n Notice: Produce energy building can not be recycled money.", labelWidth: Int(size.width) - Int(80 * framescale), pos: CGPoint(x: size.width / 2, y: size.height - CGFloat(gap)), fontName: "SanFranciscoText-BoldItalic", fontSize: (size.height - CGFloat(gap) * 2 - CGFloat(gap)) / 3, fontColor: colorMoney, leading: Int((size.height - CGFloat(gap) * 2) / 3),  shouldShowBorder: false)
        addChild(sellLabel)
    }
}

class PageEnergy: SKSpriteNode {
    
    var energyLabel: SKLabelNode!
    var energy_ProgressBack: SKSpriteNode!
    var energy_ProgressFront: SKSpriteNode!
    
    func configureAtPosition(position: CGPoint, size: CGSize) {
        self.position = position
        self.size = size
        self.name = "PageEnergy"
        self.anchorPoint = CGPoint(x: 0, y: 0)
        
        energy_ProgressBack = SKSpriteNode(color: colorEnergy, size: size)
        energy_ProgressBack.name = "Energy_ProgressBack"
        energy_ProgressBack.alpha = 0.3
        energy_ProgressBack.anchorPoint = CGPoint(x: 0, y: 0.5)
        energy_ProgressBack.position = CGPoint(x: 0, y: size.height / 2)
        addChild(energy_ProgressBack)
        energy_ProgressFront = SKSpriteNode(color: colorEnergy, size: size)
        energy_ProgressFront.name = "Energy_ProgressFront"
        energy_ProgressFront.alpha = 0.7
        energy_ProgressFront.anchorPoint = CGPoint(x: 0, y: 0.5)
        energy_ProgressFront.position = CGPoint(x: 0, y: size.height / 2)
        addChild(energy_ProgressFront)
        
        let labelsize = size.height / 8
        energyLabel = SKLabelNode(fontNamed: "Verdana-Bold")
        energyLabel.name = "EnergyLabel"
        energyLabel.fontColor = SKColor.whiteColor()
        energyLabel.fontSize = labelsize
        energyLabel.horizontalAlignmentMode = .Left
        energyLabel.position = CGPoint(x: size.width / 8, y: size.height * 3 / 4 + 10)
        addChild(energyLabel)
    }
    
    func progressPercent(percent: CGFloat) {
        energy_ProgressFront.xScale = percent
    }
}

class BottomLayer: SKSpriteNode {

    enum PageType {
        case PageInformation, PageBuild, PageEnergy, PageSell
    }
    var pageInformation: PageInformation!
    var pageBuild: PageBuild!
    var pageEnergy: PageEnergy!
    var pageSell: PageSell!
    
    func configureAtPosition(position: CGPoint, size: CGSize) {
        
        self.position = position
        self.size = size
        self.color = colorBlue4
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
        
        showPage(.PageEnergy)
    }
    
    func showPage(pageType: PageType, duration: Double = 0.0) {
        let moveDown = SKAction.moveToY(-50, duration: duration)
        let fadeOut = SKAction.fadeOutWithDuration(duration)
        let group1 = SKAction.group([moveDown, fadeOut])
        let seq1 = SKAction.sequence([group1, SKAction.hide()])
        let moveUp = SKAction.moveToY(0, duration: duration)
        let fadeIn = SKAction.fadeInWithDuration(duration)
        let group2 = SKAction.group([moveUp, fadeIn])
        let seq2 = SKAction.sequence([SKAction.unhide(), group2])
        switch pageType {
        case .PageBuild:
            pageInformation.runAction(seq1)
            pageSell.runAction(seq1)
            pageEnergy.runAction(seq1)
            RunAfterDelay(duration) { [unowned self] in
                self.pageBuild.runAction(seq2)
            }
        case .PageEnergy:
            pageInformation.runAction(seq1)
            pageBuild.runAction(seq1)
            pageSell.runAction(seq1)
            RunAfterDelay(duration) { [unowned self] in
                self.pageEnergy.runAction(seq2)
            }
        case .PageInformation:
            pageBuild.runAction(seq1)
            pageSell.runAction(seq1)
            pageEnergy.runAction(seq1)
            RunAfterDelay(duration) { [unowned self] in
                self.pageInformation.runAction(seq2)
            }
        case .PageSell:
            pageInformation.runAction(seq1)
            pageBuild.runAction(seq1)
            pageEnergy.runAction(seq1)
            RunAfterDelay(duration) { [unowned self] in
                self.pageSell.runAction(seq2)
            }
        }
    }
}