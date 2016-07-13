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
        titleLabel                         = SKLabelNode(fontNamed: "ArialMT".localized)
        titleLabel.name                    = "title"
        titleLabel.text                    = "\(title) :"
        titleLabel.fontSize                = fontSize
        titleLabel.fontColor               = SKColor.whiteColor()
        titleLabel.horizontalAlignmentMode = .Left
        addChild(titleLabel)
        valueLabel                         = SKLabelNode(fontNamed: "SanFranciscoRounded-Black".localized)
        valueLabel.name                    = "value"
        valueLabel.text                    = ""
        valueLabel.fontSize                = fontSize
        valueLabel.fontColor               = valueColor
        valueLabel.horizontalAlignmentMode = .Left
        valueLabel.position                = CGPoint(x: titleLabel.frame.size.width + 5, y: 0)
        addChild(valueLabel)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class PageInformation: SKSpriteNode {

    var infoImage: SKSpriteNode!
    var info = [SKLabelNode]()
    var infoLine: SKSpriteNode!
    
    var positions = [CGPoint]()
    
    var infoGarbageNode: InformationLabel!
    var infoTicksNode: InformationLabel!
    var infoHeatNode: InformationLabel!
    var infoWaterNode: InformationLabel!
    var infoProduceEnergyNode: InformationLabel!
    var infoProduceHeatNode: InformationLabel!
    var infoSellsMoneyNode: InformationLabel!
    var infoConvertedEnergyNode: InformationLabel!
    var infoSellHeatNode: InformationLabel!
    var infoIsolationNode: InformationLabel!
    var infoBatteryNode: InformationLabel!
    var infoHeatSinkNode: InformationLabel!
    var infoHeatInletNode: InformationLabel!
    var infoProduceWaterNode: InformationLabel!
    var infoBankNode: InformationLabel!
    var infoProduceResearchNode: InformationLabel!
    var infoLibraryNode: InformationLabel!
    var infoPriceNode: InformationLabel!
    var allLabels = [InformationLabel]()
    var isSellInfo: Bool!
    
    func configureAtPosition(position: CGPoint, size: CGSize, isSellInfo: Bool = true) {
        
        self.position = position
        self.size = size
        self.name = "PageInformation"
        self.anchorPoint = CGPoint(x: 0, y: 0)
        self.isSellInfo = isSellInfo

        infoLine = SKSpriteNode(color: colorBlue1, size: CGSizeMake(size.width, 8 * framescale))
        infoLine.alpha = 0.8
        infoLine.anchorPoint = CGPoint(x: 0.5, y: 0)
        infoLine.position = CGPoint(x: size.width / 2, y: 0)
        addChild(infoLine)
        
        infoImage = BuildingData(buildType: .Land).image("infoImage")
        infoImage.position = CGPoint(x: size.width / 10, y: size.height / 2)
        addChild(infoImage)
        
        let infogap: CGFloat = size.height * 0.08
        let infoSize = (size.height - 5 * infogap - 8 * framescale) / 4
        for i in 1...4 {
            positions.append(CGPoint(x: size.width / 5 , y: 8 * framescale + infogap * CGFloat(5 - i) + infoSize * CGFloat(4 - i)))
        }
        
        infoGarbageNode         = InformationLabel(title: "Garbage".localized, fontSize: infoSize, valueColor: SKColor.whiteColor())
        addChild(infoGarbageNode)
        infoTicksNode           = InformationLabel(title: "Ticks".localized, fontSize: infoSize, valueColor: SKColor.whiteColor())
        addChild(infoTicksNode)
        infoHeatNode            = InformationLabel(title: "Heat".localized, fontSize: infoSize, valueColor: SKColor.redColor())
        addChild(infoHeatNode)
        infoWaterNode           = InformationLabel(title: "Water".localized, fontSize: infoSize, valueColor: colorEnergy)
        addChild(infoWaterNode)
        infoProduceEnergyNode   = InformationLabel(title: "Produce Energy".localized, fontSize: infoSize, valueColor: colorEnergy)
        addChild(infoProduceEnergyNode)
        infoProduceHeatNode     = InformationLabel(title: "Produce Heat".localized, fontSize: infoSize, valueColor: SKColor.redColor())
        addChild(infoProduceHeatNode)
        infoSellsMoneyNode      = InformationLabel(title: "Sells Energy".localized, fontSize: infoSize, valueColor: colorEnergy)
        addChild(infoSellsMoneyNode)
        infoConvertedEnergyNode = InformationLabel(title: "Converted Energy".localized, fontSize: infoSize, valueColor: SKColor.redColor())
        addChild(infoConvertedEnergyNode)
        infoSellHeatNode        = InformationLabel(title: "Sells Heat".localized, fontSize: infoSize, valueColor: SKColor.redColor())
        addChild(infoSellHeatNode)
        infoIsolationNode       = InformationLabel(title: "Increases Heat Produce".localized, fontSize: infoSize, valueColor: SKColor.whiteColor())
        addChild(infoIsolationNode)
        infoBatteryNode         = InformationLabel(title: "Increases Energy Max".localized, fontSize: infoSize, valueColor: colorEnergy)
        addChild(infoBatteryNode)
        infoHeatInletNode       = InformationLabel(title: "Heat transfer amount".localized, fontSize: infoSize, valueColor: SKColor.redColor())
        addChild(infoHeatInletNode)
        infoHeatSinkNode        = InformationLabel(title: "Cooling Heat".localized, fontSize: infoSize, valueColor: SKColor.whiteColor())
        addChild(infoHeatSinkNode)
        infoProduceWaterNode    = InformationLabel(title: "Produce Water".localized, fontSize: infoSize, valueColor: colorEnergy)
        addChild(infoProduceWaterNode)
        infoBankNode            = InformationLabel(title: "Increases Energy Sells".localized, fontSize: infoSize, valueColor: SKColor.whiteColor())
        addChild(infoBankNode)
        infoProduceResearchNode = InformationLabel(title: "Produce Research".localized, fontSize: infoSize, valueColor: colorResearch)
        addChild(infoProduceResearchNode)
        infoLibraryNode         = InformationLabel(title: "Increases Research Produce".localized, fontSize: infoSize, valueColor: SKColor.whiteColor())
        addChild(infoLibraryNode)
        infoPriceNode           = InformationLabel(title: "Price".localized, fontSize: infoSize, valueColor: colorMoney)
        addChild(infoPriceNode)

        allLabels = [infoGarbageNode, infoTicksNode, infoHeatNode, infoWaterNode, infoProduceEnergyNode, infoProduceHeatNode, infoSellsMoneyNode, infoConvertedEnergyNode, infoSellHeatNode, infoIsolationNode, infoBatteryNode, infoHeatInletNode, infoHeatSinkNode, infoProduceWaterNode, infoBankNode, infoProduceResearchNode, infoLibraryNode, infoPriceNode]
    }
    
    func changeInformation(buildingData: BuildingData) {
        
        // change color
        let colors = [colorBlue1, colorCancel, SKColor.orangeColor(), colorMoney, SKColor.lightGrayColor()]
        let buildKind = buildingData.buildType.hashValue / 7
        infoLine.color = colors[buildKind]
        
        // Image
        infoImage.runAction(SKAction.setTexture(buildingAtlas.textureNamed(buildingData.imageName)))

        // Label
        for label in allLabels {
            label.hidden = true
        }
        var informationLabels = [InformationLabel]()
        if buildingData.buildType == .Garbage {
            infoGarbageNode.hidden = false
            infoGarbageNode.valueLabel.text = "Just a garbage. It can be burned!".localized
            informationLabels.append(infoGarbageNode)
        }
        if buildingData.timeSystem != nil {
            infoTicksNode.hidden = false
            infoTicksNode.valueLabel.text = "\(numberToString(buildingData.timeSystem.inAmount)) / \(numberToString(buildingData.timeSystem.size))"
            informationLabels.append(infoTicksNode)
        }
        if buildingData.heatSystem != nil {
            infoHeatNode.hidden = false
            infoHeatNode.valueLabel.text = "\(numberToString(buildingData.heatSystem.inAmount)) / \(numberToString(buildingData.heatSystem.size))"
            informationLabels.append(infoHeatNode)
        }
        if buildingData.waterSystem != nil && researchLevel[.WaterPumpResearch] != 0 {
            infoWaterNode.hidden = false
            infoWaterNode.valueLabel.text = "\(numberToString(buildingData.waterSystem.inAmount)) / \(numberToString(buildingData.waterSystem.size))"
            informationLabels.append(infoWaterNode)
        }
        if ([.WindTurbine, .WaveCell]).contains(buildingData.buildType) {
            infoProduceEnergyNode.hidden = false
            infoProduceEnergyNode.valueLabel.text = "\(numberToString(buildingData.energySystem.produce, isInt: false))"
            informationLabels.append(infoProduceEnergyNode)
        }
        if ([.SolarCell, .CoalBurner, .GasBurner, .NuclearCell, .FusionCell]).contains(buildingData.buildType) {
            infoProduceHeatNode.hidden = false
            infoProduceHeatNode.valueLabel.text = "\(numberToString(buildingData.heatSystem.produceHeatValue()))"
            informationLabels.append(infoProduceHeatNode)
        }
        if ([.SmallGenerator, .MediumGenerator, .LargeGenerator]).contains(buildingData.buildType) {
            infoConvertedEnergyNode.hidden = false
            infoConvertedEnergyNode.valueLabel.text = "\(numberToString(buildingData.energySystem.heat2EnergyAmount))"
            informationLabels.append(infoConvertedEnergyNode)
        }
        if ([.BoilerHouse, .LargeBoilerHouse]).contains(buildingData.buildType) {
            infoSellHeatNode.hidden = false
            infoSellHeatNode.valueLabel.text = "\(numberToString(buildingData.moneySystem.heat2MoneyAmount))"
            informationLabels.append(infoSellHeatNode)
        }
        if buildingData.buildType == .Isolation {
            infoIsolationNode.hidden = false
            infoIsolationNode.valueLabel.text = "\(Int(buildingData.isolationPercent * 100))%"
            informationLabels.append(infoIsolationNode)
        }
        if buildingData.buildType == .Battery {
            infoBatteryNode.hidden = false
            infoBatteryNode.valueLabel.text = "\(numberToString(buildingData.batteryEnergySize))"
            informationLabels.append(infoBatteryNode)
        }
        if buildingData.buildType == .HeatSink {
            infoHeatSinkNode.hidden = false
            infoHeatSinkNode.valueLabel.text = "\(Int(buildingData.heatSystem.coolingRate * 100))%"
            informationLabels.append(infoHeatSinkNode)
        }
        if buildingData.buildType == .HeatInlet {
            infoHeatInletNode.hidden = false
            infoHeatInletNode.valueLabel.text = "\(numberToString(buildingData.heatSystem.inletTransfer))"
            informationLabels.append(infoHeatInletNode)
        }
        if ([.WaterPump, .GroundwaterPump]).contains(buildingData.buildType) {
            infoProduceWaterNode.hidden = false
            infoProduceWaterNode.valueLabel.text = "\(numberToString(buildingData.waterSystem.produce))"
            informationLabels.append(infoProduceWaterNode)
        }
        if ([.SmallOffice, .MediumOffice, .LargeOffice]).contains(buildingData.buildType) {
            infoSellsMoneyNode.hidden = false
            infoSellsMoneyNode.valueLabel.text = "\(numberToString(buildingData.moneySystem.energy2MoneyAmount))"
            informationLabels.append(infoSellsMoneyNode)
        }
        if buildingData.buildType == .Bank {
            infoBankNode.hidden = false
            infoBankNode.valueLabel.text = "\(Int(buildingData.bankAddPercent * 100))%"
            informationLabels.append(infoBankNode)
        }
        if ([.ResearchCenter, .AdvancedResearchCenter]).contains(buildingData.buildType) {
            infoProduceResearchNode.hidden = false
            infoProduceResearchNode.valueLabel.text = "\(numberToString(buildingData.researchSystem.addAmount))"
            informationLabels.append(infoProduceResearchNode)
        }
        if buildingData.buildType == .Library {
            infoLibraryNode.hidden = false
            infoLibraryNode.valueLabel.text = "\(Int(buildingData.libraryAddPercent * 100))%"
            informationLabels.append(infoLibraryNode)
        }
        if ([.WindTurbine, .SolarCell, .CoalBurner, .WaveCell, .GasBurner, .NuclearCell, .FusionCell]).contains(buildingData.buildType) && isSellInfo == true {
            infoPriceNode.hidden = false
            infoPriceNode.valueLabel.text = "0"
            informationLabels.append(infoPriceNode)
        } else if buildingData.buildType != .Garbage {
            infoPriceNode.hidden = false
            infoPriceNode.valueLabel.text = numberToString(buildingData.buildPrice)
            informationLabels.append(infoPriceNode)
        }
        
        for count in 0..<informationLabels.count {
            informationLabels[count].position = positions[count]
        }
    }
}

class PageBuild: SKSpriteNode {
    
    var selectNumber: Int = 0
    var imagePosition = [CGPoint]()
    var buildLine: SKNode!
    var buildMenu: [BuildingType] = [BuildingType.WindTurbine, BuildingType.SmallGenerator, BuildingType.HeatExchanger, BuildingType.SmallOffice]
    var images = [SKSpriteNode]()
    var priceLabels = [SKLabelNode]()
    var selectBox: SKShapeNode!
    var selectBoxArrow: SKSpriteNode!
    var selectInfo = PageInformation()
    var rebuildButton: SKNode!
    var checkButton: SKShapeNode!
    
    func configureAtPosition(position: CGPoint, size: CGSize) {
        self.position    = position
        self.size        = size
        self.name        = "PageBuild"
        self.anchorPoint = CGPoint(x: 0, y: 0)

        for i in 1...5 {
            let odd = CGFloat(i - 1) * 2 + 1
            imagePosition.append(CGPoint(x: size.width * odd / 10, y: size.height / 2))
        }
        
        buildLine = SKNode()
        let colors = [colorBlue1, colorCancel, SKColor.orangeColor(), colorMoney, SKColor.lightGrayColor()]
        for i in 0...4 {
            let bg = SKSpriteNode(color: colors[i], size: CGSizeMake(size.width / 5, 8 * framescale))
            bg.anchorPoint = CGPoint(x: 0.5, y: 0)
            bg.alpha = 0.8
            bg.position = CGPoint(x: imagePosition[i].x, y: 0)
            bg.zPosition = 3
            buildLine.addChild(bg)
        }
        addChild(buildLine)
        
        for i in 0...3 {
            let image        = BuildingData(buildType: buildMenu[i]).image("SelectImage\(i)")
            image.position   = imagePosition[i]
            image.zPosition  = 10
            images.append(image)
            addChild(image)
            
            let price = BuildingData.init(buildType: buildMenu[i]).buildPrice
            let priceLabel = SKLabelNode(fontNamed: "SanFranciscoRounded-Black".localized)
            priceLabel.name = "price label \(i)"
            priceLabel.text = numberToString(price) 
            priceLabel.hidden = i == selectNumber ? false : true
            priceLabel.fontSize = 16 * framescale
            priceLabel.fontColor = colorMoney
            priceLabel.position = CGPoint(x: imagePosition[i].x, y: 12 * framescale)
            priceLabel.zPosition = 10
            priceLabels.append(priceLabel)
            addChild(priceLabel)
        }
        
        rebuildButton = SKNode()
        rebuildButton.name = "SelectImage4"
        rebuildButton.position = imagePosition[4]
        rebuildButton.zPosition = 1
        addChild(rebuildButton)
        let rebuildBG           = SKShapeNode(rectOfSize: CGSizeMake(size.width / 5, size.height))
        rebuildBG.name = "rebuildBG"
        rebuildBG.lineWidth = 0
        rebuildBG.alpha = 0.7
        rebuildButton.addChild(rebuildBG)
        let buildingiImage      = SKSpriteNode(texture: iconAtlas.textureNamed("building"))
        buildingiImage.name     = "buildingImage"
        buildingiImage.setScale(0.4 * framescale)
        rebuildButton.addChild(buildingiImage)
        let refreshImage        = SKSpriteNode(texture: iconAtlas.textureNamed("refresh"))
        refreshImage.name       = "refreshImage"
        refreshImage.setScale(framescale)
        rebuildButton.addChild(refreshImage)
        let rebuildLabel        = SKLabelNode(fontNamed: "SanFranciscoRounded-Black".localized)
        rebuildLabel.name = "rebuildLabel"
        rebuildLabel.text = "Rebuild:ON".localized
        rebuildLabel.fontSize = 16 * framescale
        rebuildLabel.position = CGPoint(x: 0, y: -size.height / 2 + 12 * framescale)
        rebuildLabel.zPosition = 10
        rebuildButton.addChild(rebuildLabel)
        rebuildOn(isRebuild)
        
        updateImageShow()

        selectBox               = SKShapeNode(rectOfSize: CGSizeMake(size.width / 5, size.height))
        selectBox.name          = "selectBox"
        selectBox.fillColor     = colorBlue2
        selectBox.lineWidth     = 0
        selectBox.position      = imagePosition[0]
        selectBox.zPosition     = 1
        addChild(selectBox)
        
        selectBoxArrow          = SKSpriteNode(texture: iconAtlas.textureNamed("arrow_up"))
        selectBoxArrow.name     = "selectBoxArrow"
        selectBoxArrow.position = CGPoint(x: selectBox.position.x, y: selectBox.position.y + 50)
        selectBoxArrow.zPosition = 2
        let upAction            = SKAction.sequence([SKAction.moveByX(0, y: 5, duration: 0.5), SKAction.moveByX(0, y: -5, duration: 0.5)])
        selectBoxArrow.runAction(SKAction.repeatActionForever(upAction))
        addChild(selectBoxArrow)

        selectInfo.configureAtPosition(CGPoint(x: 0, y: 0), size: size, isSellInfo: false)
        selectInfo.name         = "SelectInformation"
        selectInfo.changeInformation(BuildingData(buildType: buildMenu[selectNumber]))
        selectInfo.alpha        = 1
        selectInfo.hidden       = true
        addChild(selectInfo)

        checkButton = SKShapeNode(circleOfRadius: 30 * framescale)
        checkButton.name = "checkButton"
        checkButton.fillColor = SKColor.clearColor()
        checkButton.strokeColor = SKColor.whiteColor()
        checkButton.lineWidth = 2 * framescale
        checkButton.hidden      = true
        checkButton.alpha       = 0
        checkButton.position = imagePosition[4]
        let checkImg = SKSpriteNode(texture: iconAtlas.textureNamed("check"))
        checkImg.size = CGSizeMake(30 * framescale, 30 * framescale)
        checkButton.addChild(checkImg)
        addChild(checkButton)
    }
    
    func rebuildOn(isRebuild: Bool) {
        if isRebuild {
            (rebuildButton.childNodeWithName("rebuildBG") as! SKShapeNode).fillColor   = colorBlue2
            let action                = SKAction.rotateByAngle(CGFloat(M_PI), duration: 2)
            rebuildButton.childNodeWithName("refreshImage")!.removeAllActions()
            rebuildButton.childNodeWithName("refreshImage")!.runAction(SKAction.repeatActionForever(action))
            (rebuildButton.childNodeWithName("rebuildLabel") as! SKLabelNode).text = "Rebuild:ON".localized
        } else {
            (rebuildButton.childNodeWithName("rebuildBG") as! SKShapeNode).fillColor   = SKColor.grayColor()
            rebuildButton.childNodeWithName("refreshImage")!.removeAllActions()
            (rebuildButton.childNodeWithName("rebuildLabel") as! SKLabelNode).text = "Rebuild:OFF".localized
        }
    }
    
    func changeSelectNumber(selectNumber: Int) {
        self.selectNumber       = selectNumber
        selectBox.position      = imagePosition[selectNumber]
        selectBoxArrow.position = CGPoint(x: selectBox.position.x, y: selectBox.position.y + 50)
        selectInfo.changeInformation(BuildingData(buildType: buildMenu[selectNumber]))
        for i in 0...3 {
            priceLabels[i].hidden = i == selectNumber ? false : true
        }
    }
    
    func changeSelectBuildType(buildType: BuildingType) {
        buildMenu[selectNumber] = buildType
        selectInfo.changeInformation(BuildingData(buildType: buildType))
        images[selectNumber].runAction(SKAction.setTexture(buildingAtlas.textureNamed(BuildingData(buildType: buildType).imageName)))
        priceLabels[selectNumber].text = numberToString(BuildingData.init(buildType: buildType).buildPrice) 
    }
    
    func openSelectInformation() {
        if selectNumber > 3 || selectNumber < 0 { return }
        
        // Remove Action
        buildLine.removeAllActions()
        selectBox.removeAllActions()
        for i in 0...4 {
            childNodeWithName("SelectImage\(i)")?.removeAllActions()
        }
        // Hide
        buildLine.runAction(SKAction.sequence([SKAction.waitForDuration(0.3), SKAction.fadeOutWithDuration(0.2), SKAction.hide()]))
        selectBox.runAction(SKAction.sequence([SKAction.hide(), SKAction.fadeAlphaTo(0, duration: 0)]))
        selectBoxArrow.runAction(SKAction.sequence([SKAction.hide(), SKAction.fadeAlphaTo(0, duration: 0)]))
        for i in 0...4 {
            if i != selectNumber {
                childNodeWithName("SelectImage\(i)")?.runAction(SKAction.sequence([SKAction.fadeOutWithDuration(0.2), SKAction.hide()]))
            }
        }
        for priceLabel in priceLabels {
            priceLabel.runAction(SKAction.sequence([SKAction.fadeOutWithDuration(0.2)]))
        }
            
        // Move
        let move = SKAction.moveTo(imagePosition[0], duration: 0.2)
        let seq = SKAction.sequence([move, SKAction.waitForDuration(0.2), SKAction.hide()])
        childNodeWithName("SelectImage\(selectNumber)")?.runAction(seq)
        // Show
        selectInfo.runAction(SKAction.sequence([SKAction.unhide(), SKAction.waitForDuration(0.2), SKAction.fadeInWithDuration(0.2)]))
        checkButton.runAction(SKAction.sequence([SKAction.unhide(), SKAction.waitForDuration(0.2), SKAction.fadeInWithDuration(0.2)]))
    }
    
    func closeSelectInformation() {
        if selectNumber > 3 || selectNumber < 0 { return }
        let pos = imagePosition[selectNumber]
        
        // Remove Action
        buildLine.removeAllActions()
        selectBox.removeAllActions()
        for i in 0...4 {
            childNodeWithName("SelectImage\(i)")?.removeAllActions()
        }
        // Hide
        selectInfo.childNodeWithName("infoImage")?.runAction(SKAction.sequence([SKAction.hide(), SKAction.waitForDuration(0.2), SKAction.unhide()]))
        selectInfo.runAction(SKAction.sequence([SKAction.fadeAlphaTo(0, duration: 0.2), SKAction.hide()]))
        checkButton.runAction(SKAction.sequence([SKAction.fadeAlphaTo(0, duration: 0.2), SKAction.hide()]))
        // Move
        childNodeWithName("SelectImage\(selectNumber)")?.runAction(SKAction.unhide())
        childNodeWithName("SelectImage\(selectNumber)")?.runAction(SKAction.moveTo(pos, duration: 0.2))
        // Show
        let seq = SKAction.sequence([SKAction.unhide(), SKAction.waitForDuration(0.2), SKAction.fadeInWithDuration(0.2)])
        buildLine.runAction(SKAction.sequence([SKAction.unhide(), SKAction.fadeInWithDuration(0.4)]))
        selectBox.runAction(seq)
        selectBoxArrow.runAction(seq)
        for i in 0...4 {
            if i != selectNumber {
                childNodeWithName("SelectImage\(i)")?.runAction(seq)
            }
        }
        for priceLabel in priceLabels {
            priceLabel.runAction(SKAction.sequence([SKAction.waitForDuration(0.2), SKAction.fadeInWithDuration(0.2)]))
        }
    }
    
    func updateImageShow() {
        for i in 1...3 {
            let pos = CGPoint(x: imagePosition[i].x, y: 12 * framescale)
            priceLabels[i].position = pos
        }
        for i in 1...4 {
            let pos = imagePosition[i]
            childNodeWithName("SelectImage\(i)")?.position = pos
            if i == 1 && researchLevel[.BatteryResearch] == 0 && researchLevel[.SmallGeneratorResearch] == 0 {
                childNodeWithName("SelectImage\(i)")?.position = CGPoint(x: -tilesScaleSize.width, y: pos.y)
                priceLabels[i].position = CGPoint(x: -tilesScaleSize.width, y: pos.y)
            }
            if i == 2 && researchLevel[.HeatExchangerResearch] == 0 {
                childNodeWithName("SelectImage\(i)")?.position = CGPoint(x: -tilesScaleSize.width, y: pos.y)
                priceLabels[i].position = CGPoint(x: -tilesScaleSize.width, y: pos.y)
            }
            if i == 3 && researchLevel[.ResearchCenterResearch] == 0 {
                childNodeWithName("SelectImage\(i)")?.position = CGPoint(x: -tilesScaleSize.width, y: pos.y)
                priceLabels[i].position = CGPoint(x: -tilesScaleSize.width, y: pos.y)
            }
            if i == 4 && researchLevel[.WindTurbineRebuild] == 0 {
                childNodeWithName("SelectImage\(i)")?.position = CGPoint(x: -tilesScaleSize.width, y: pos.y)
            }
        }
        if researchLevel[.SmallGeneratorResearch] == 0 {
            buildMenu[1] = .Battery
            images[1].runAction(SKAction.setTexture(buildingAtlas.textureNamed("Battery")))
            priceLabels[1].text = numberToString(BuildingData.init(buildType: buildMenu[1]).buildPrice) 
            childNodeWithName("SelectImage\(2)")?.runAction(SKAction.setTexture(buildingAtlas.textureNamed("Battery")))
        }
        if researchLevel[.SmallOfficeResearch] == 0 {
            buildMenu[3] = .ResearchCenter
            images[3].runAction(SKAction.setTexture(buildingAtlas.textureNamed("ResearchCenter")))
            priceLabels[3].text = numberToString(BuildingData.init(buildType: buildMenu[3]).buildPrice) 
            childNodeWithName("SelectImage\(4)")?.runAction(SKAction.setTexture(buildingAtlas.textureNamed("ResearchCenter")))
        }
        
        rebuildOn(isRebuild)
    }
    
    func resetBuildMenu() {
        changeSelectNumber(0)
        buildMenu = [BuildingType.WindTurbine, BuildingType.SmallGenerator, BuildingType.HeatExchanger, BuildingType.SmallOffice]
        for i in 0..<4 {
            images[i].runAction(SKAction.setTexture(buildingAtlas.textureNamed(BuildingData(buildType: buildMenu[i]).imageName)))
            priceLabels[i].text = numberToString(BuildingData.init(buildType: buildMenu[i]).buildPrice) 
        }
        
        updateImageShow()
    }
}

class PageSell: SKSpriteNode {
    
    func configureAtPosition(position: CGPoint, size: CGSize) {
        self.position    = position
        self.size        = size
        self.name        = "PageSell"
        self.anchorPoint = CGPoint(x: 0, y: 0)
        let gap          = size.height * 3 / 6 / 8

        let Label1 = SKLabelNode(fontNamed: "ArialMT".localized)
        Label1.text = "Touch buildings on the map to sell it.".localized
        Label1.fontColor = colorMoney
        Label1.fontSize = size.height / 6
        Label1.position = CGPoint(x: size.width / 2, y: size.height * 2 / 6 + gap * 5)
        addChild(Label1)
        
        let Label2 = SKLabelNode(fontNamed: "ArialMT".localized)
        Label2.text = "Notice: Produce energy building can not be".localized
        Label2.fontColor = colorMoney
        Label2.fontSize = size.height / 6
        Label2.position = CGPoint(x: size.width / 2, y: size.height * 1 / 6 + gap * 4)
        addChild(Label2)
        
        let Label3 = SKLabelNode(fontNamed: "ArialMT".localized)
        Label3.text = "recycled money.".localized
        Label3.fontColor = colorMoney
        Label3.fontSize = size.height / 6
        Label3.position = CGPoint(x: size.width / 2, y: gap * 3)
        addChild(Label3)
        
        let line = SKShapeNode(rectOfSize: CGSizeMake(size.width, 2 * framescale))
        line.fillColor = SKColor.lightGrayColor()
        line.lineWidth = 0
        line.position = CGPoint(x: size.width / 2, y: 0)
        addChild(line)
    }
}

class PageEnergy: SKSpriteNode {
    
    var energyLabel: SKLabelNode!
    var energyTickAddLabel: SKLabelNode!
    var energy_ProgressBack: SKSpriteNode!
    var energy_ProgressFront: SKSpriteNode!
    
    func configureAtPosition(position: CGPoint, size: CGSize) {
        self.position                              = position
        self.size                                  = size
        self.name                                  = "PageEnergy"
        self.anchorPoint                           = CGPoint(x: 0, y: 0)

        energy_ProgressBack                        = SKSpriteNode(color: colorBlue2, size: size)
        energy_ProgressBack.name                   = "Energy_ProgressBack"
        energy_ProgressBack.anchorPoint            = CGPoint(x: 0, y: 0.5)
        energy_ProgressBack.position               = CGPoint(x: 0, y: size.height / 2)
        addChild(energy_ProgressBack)
        energy_ProgressFront                       = SKSpriteNode(color: colorEnergy, size: size)
        energy_ProgressFront.name                  = "Energy_ProgressFront"
        energy_ProgressFront.anchorPoint           = CGPoint(x: 0, y: 0.5)
        energy_ProgressFront.position              = CGPoint(x: 0, y: size.height / 2)
        addChild(energy_ProgressFront)

        energyLabel                                = SKLabelNode(fontNamed: "SanFranciscoRounded-Black".localized)
        energyLabel.name                           = "EnergyLabel"
        energyLabel.fontColor                      = SKColor.whiteColor()
        energyLabel.fontSize                       = size.height / 5
        energyLabel.horizontalAlignmentMode        = .Right
        energyLabel.position                       = CGPoint(x: size.width - 5 * framescale, y: 5 * framescale)
        addChild(energyLabel)

        energyTickAddLabel                         = SKLabelNode(fontNamed: "SanFranciscoRounded-Black".localized)
        energyTickAddLabel.name                    = "energyTickAddLabel"
        energyTickAddLabel.fontColor               = colorEnergy
        energyTickAddLabel.fontSize                = size.height / 5
        energyTickAddLabel.horizontalAlignmentMode = .Right
        energyTickAddLabel.position                = CGPoint(x: size.width - 5 * framescale, y: size.height / 5 + 10 * framescale)
        addChild(energyTickAddLabel)

        let label                                  = SKLabelNode(fontNamed: "SanFranciscoRounded-Black".localized)
        label.name                                 = "ExplanationLabel"
        label.text                                 = "TOUCH  TO  SELL  ENERGY".localized
        label.fontColor                            = colorBlue2
        label.fontSize                             = size.height / 4
        label.verticalAlignmentMode                = .Center
        label.position                             = CGPoint(x: size.width / 2, y: size.height / 2)
        let fadeInFadeOut                          = SKAction.sequence([SKAction.fadeInWithDuration(1), SKAction.fadeOutWithDuration(1)])
        label.runAction(SKAction.repeatActionForever(fadeInFadeOut))
        addChild(label)
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
        
        self.position    = position
        self.size        = size
        self.color       = colorBlue4
        self.name        = "BottomLayer"
        self.anchorPoint = CGPoint(x: 0, y: 0)
    
        pageBuild        = PageBuild()
        pageBuild.configureAtPosition(CGPoint(x: 0, y: -size.height * 2), size: size)
        addChild(pageBuild)
        // update rebuild button
        pageBuild.rebuildOn(isRebuild)
        
        pageInformation  = PageInformation()
        pageInformation.configureAtPosition(CGPoint(x: 0, y: -size.height * 2), size: size)
        addChild(pageInformation)

        pageEnergy       = PageEnergy()
        pageEnergy.configureAtPosition(CGPoint(x: 0, y: 0), size: size)
        addChild(pageEnergy)

        pageSell         = PageSell()
        pageSell.configureAtPosition(CGPoint(x: 0, y: -size.height * 2), size: size)
        addChild(pageSell)
        
        let lineShadow = SKSpriteNode(color: SKColor.grayColor(), size: CGSizeMake(size.width, 3 * framescale))
        lineShadow.alpha = 0.7
        lineShadow.anchorPoint = CGPoint(x: 0, y: 0)
        lineShadow.position = CGPoint(x: 0, y: size.height)
        lineShadow.zPosition = -60
        addChild(lineShadow)

        showPage(.PageEnergy)
    }
    
    func showPage(pageType: PageType, duration: Double = 0.0) {
        pageInformation.removeAllActions()
        pageBuild.removeAllActions()
        pageSell.removeAllActions()
        pageEnergy.removeAllActions()
        let moveDown = SKAction.moveToY(-50, duration: duration)
        let fadeOut  = SKAction.fadeOutWithDuration(duration)
        let group1   = SKAction.group([moveDown, fadeOut])
        let seq1     = SKAction.sequence([group1, SKAction.hide()])
        let moveUp   = SKAction.moveToY(0, duration: duration)
        let fadeIn   = SKAction.fadeInWithDuration(duration)
        let group2   = SKAction.group([moveUp, fadeIn])
        let seq2     = SKAction.sequence([SKAction.unhide(), group2])
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