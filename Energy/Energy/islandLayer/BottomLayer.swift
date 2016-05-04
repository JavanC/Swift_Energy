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
        titleLabel                         = SKLabelNode(fontNamed: "ArialMT")
        titleLabel.name                    = "title"
        titleLabel.text                    = "\(title) :"
        titleLabel.fontSize                = fontSize
        titleLabel.fontColor               = SKColor.whiteColor()
        titleLabel.horizontalAlignmentMode = .Left
        addChild(titleLabel)
        valueLabel                         = SKLabelNode(fontNamed: "SanFranciscoRounded-Black")
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

        infoTicksNode           = InformationLabel(title: "Ticks", fontSize: infoSize, valueColor: SKColor.whiteColor())
        addChild(infoTicksNode)
        infoHeatNode            = InformationLabel(title: "Heat", fontSize: infoSize, valueColor: SKColor.redColor())
        addChild(infoHeatNode)
        infoWaterNode           = InformationLabel(title: "Water", fontSize: infoSize, valueColor: colorEnergy)
        addChild(infoWaterNode)
        infoProduceEnergyNode   = InformationLabel(title: "Produce Energy", fontSize: infoSize, valueColor: colorEnergy)
        addChild(infoProduceEnergyNode)
        infoProduceHeatNode     = InformationLabel(title: "Produce Heat", fontSize: infoSize, valueColor: SKColor.redColor())
        addChild(infoProduceHeatNode)
        infoSellsMoneyNode      = InformationLabel(title: "Sells Energy", fontSize: infoSize, valueColor: colorEnergy)
        addChild(infoSellsMoneyNode)
        infoConvertedEnergyNode = InformationLabel(title: "Converted Energy", fontSize: infoSize, valueColor: SKColor.redColor())
        addChild(infoConvertedEnergyNode)
        infoSellHeatNode        = InformationLabel(title: "Sells Heat", fontSize: infoSize, valueColor: SKColor.redColor())
        addChild(infoSellHeatNode)
        infoIsolationNode       = InformationLabel(title: "Increases Heat Produce", fontSize: infoSize, valueColor: SKColor.whiteColor())
        addChild(infoIsolationNode)
        infoBatteryNode         = InformationLabel(title: "Increases Energy Max", fontSize: infoSize, valueColor: colorEnergy)
        addChild(infoBatteryNode)
        infoHeatInletNode       = InformationLabel(title: "Heat transfer amount", fontSize: infoSize, valueColor: SKColor.redColor())
        addChild(infoHeatInletNode)
        infoHeatSinkNode        = InformationLabel(title: "Cooling Heat", fontSize: infoSize, valueColor: SKColor.whiteColor())
        addChild(infoHeatSinkNode)
        infoProduceWaterNode    = InformationLabel(title: "Produce Water", fontSize: infoSize, valueColor: colorEnergy)
        addChild(infoProduceWaterNode)
        infoBankNode            = InformationLabel(title: "Increases Energy Sells", fontSize: infoSize, valueColor: SKColor.whiteColor())
        addChild(infoBankNode)
        infoProduceResearchNode = InformationLabel(title: "Produce Research", fontSize: infoSize, valueColor: colorResearch)
        addChild(infoProduceResearchNode)
        infoLibraryNode         = InformationLabel(title: "Increases Research Produce", fontSize: infoSize, valueColor: SKColor.whiteColor())
        addChild(infoLibraryNode)
        infoPriceNode           = InformationLabel(title: "Price", fontSize: infoSize, valueColor: colorMoney)
        addChild(infoPriceNode)

        allLabels = [infoTicksNode, infoHeatNode, infoWaterNode, infoProduceEnergyNode, infoProduceHeatNode, infoSellsMoneyNode, infoConvertedEnergyNode, infoSellHeatNode, infoIsolationNode, infoBatteryNode, infoHeatInletNode, infoHeatSinkNode, infoProduceWaterNode, infoBankNode, infoProduceResearchNode, infoLibraryNode, infoPriceNode]
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
            infoHeatInletNode.valueLabel.text = "\(Int(buildingData.bankAddPercent * 100))%"
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
        } else {
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
    
    var selectNumber: Int = 1
    var imagePosition = [CGPoint]()
    var buildLine: SKNode!
    var buildMenu: [BuildingType] = [BuildingType.WindTurbine, BuildingType.SmallGenerator, BuildingType.HeatExchanger, BuildingType.SmallOffice]
    var images = [SKSpriteNode]()
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
        for i in 1...5 {
            let bg = SKSpriteNode(color: colors[i-1], size: CGSizeMake(size.width / 5, 8 * framescale))
            bg.anchorPoint = CGPoint(x: 0.5, y: 0)
            bg.alpha = 0.8
            bg.position = CGPoint(x: imagePosition[i - 1].x, y: 0)
            bg.zPosition = 2
            buildLine.addChild(bg)
        }
        addChild(buildLine)
        
        for i in 1...4 {
        let image        = BuildingData(buildType: buildMenu[i - 1]).image("SelectImage\(i)")
        image.position   = imagePosition[i - 1]
        image.zPosition  = 10
            images.append(image)
            addChild(image)
        }
        
        updateImageShow()
        
        rebuildButton = SKNode()
        rebuildButton.name = "SelectImage5"
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
        rebuildOn(isRebuild)

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
        selectInfo.changeInformation(BuildingData(buildType: buildMenu[selectNumber - 1]))
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
        } else {
            (rebuildButton.childNodeWithName("rebuildBG") as! SKShapeNode).fillColor   = SKColor.grayColor()
            rebuildButton.childNodeWithName("refreshImage")!.removeAllActions()
        }
    }
    
    func changeSelectNumber(selectNumber: Int) {
        self.selectNumber       = selectNumber
        selectBox.position      = imagePosition[selectNumber - 1]
        selectBoxArrow.position = CGPoint(x: selectBox.position.x, y: selectBox.position.y + 50)
        selectInfo.changeInformation(BuildingData(buildType: buildMenu[selectNumber - 1]))
    }
    
    func changeSelectBuildType(buildType: BuildingType) {
        buildMenu[selectNumber - 1] = buildType
        selectInfo.changeInformation(BuildingData(buildType: buildType))
        images[selectNumber - 1].runAction(SKAction.setTexture(buildingAtlas.textureNamed(BuildingData(buildType: buildType).imageName)))
    }
    
    func resetBuildMenu() {
        changeSelectNumber(1)
        buildMenu = [BuildingType.WindTurbine, BuildingType.SmallGenerator, BuildingType.HeatExchanger, BuildingType.SmallOffice]
        for i in 0..<4 {
            images[i].runAction(SKAction.setTexture(buildingAtlas.textureNamed(BuildingData(buildType: buildMenu[i]).imageName)))
        }
    }
    
    func openSelectInformation() {
        if selectNumber > 4 || selectNumber < 1 { return }
        
        // Remove Action
        childNodeWithName("SelectImage\(selectNumber)")?.removeAllActions()
        // Hide
        buildLine.runAction(SKAction.sequence([SKAction.waitForDuration(0.3), SKAction.fadeOutWithDuration(0.2), SKAction.hide()]))
        selectBox.runAction(SKAction.sequence([SKAction.hide(), SKAction.fadeAlphaTo(0, duration: 0)]))
        selectBoxArrow.runAction(SKAction.sequence([SKAction.hide(), SKAction.fadeAlphaTo(0, duration: 0)]))
        for i in 1...5 {
            if i != selectNumber {
                childNodeWithName("SelectImage\(i)")?.runAction(SKAction.sequence([SKAction.fadeOutWithDuration(0.2), SKAction.hide()]))
            }
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
        if selectNumber > 4 || selectNumber < 1 { return }
        let pos = imagePosition[selectNumber - 1]
        
        // Remove Action
        childNodeWithName("SelectImage\(selectNumber)")?.removeAllActions()
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
        for i in 1...5 {
            if i != selectNumber {
                childNodeWithName("SelectImage\(i)")?.runAction(seq)
            }
        }
    }
    
    func updateImageShow() {
        for i in 2...5 {
            let pos = imagePosition[i - 1]
            childNodeWithName("SelectImage\(i)")?.position = pos
            if i == 2 && researchLevel[.BatteryResearch] == 0 && researchLevel[.SmallGeneratorResearch] == 0 {
                childNodeWithName("SelectImage\(i)")?.position = CGPoint(x: -tilesScaleSize.width, y: pos.y)
            }
            if i == 3 && researchLevel[.HeatExchangerResearch] == 0 {
                childNodeWithName("SelectImage\(i)")?.position = CGPoint(x: -tilesScaleSize.width, y: pos.y)
            }
            if i == 4 && researchLevel[.ResearchCenterResearch] == 0 {
                childNodeWithName("SelectImage\(i)")?.position = CGPoint(x: -tilesScaleSize.width, y: pos.y)
            }
            if i == 5 && researchLevel[.WindTurbineRebuild] == 0 {
                childNodeWithName("SelectImage\(i)")?.position = CGPoint(x: -tilesScaleSize.width, y: pos.y)
            }
        }
        if researchLevel[.SmallGeneratorResearch] == 0 {
            buildMenu[1] = .Battery
            childNodeWithName("SelectImage\(2)")?.runAction(SKAction.setTexture(buildingAtlas.textureNamed("Battery")))
        }
        if researchLevel[.SmallOfficeResearch] == 0 {
            buildMenu[3] = .ResearchCenter
            childNodeWithName("SelectImage\(4)")?.runAction(SKAction.setTexture(buildingAtlas.textureNamed("ResearchCenter")))
        }
    }
}

class PageSell: SKSpriteNode {
    
    var sellLabel: SKMultilineLabel!
    
    func configureAtPosition(position: CGPoint, size: CGSize) {
        self.position    = position
        self.size        = size
        self.name        = "PageSell"
        self.anchorPoint = CGPoint(x: 0, y: 0)
        let gap          = Int(20 * framescale)
        sellLabel        = SKMultilineLabel(text: "Touch buildings on the map to sell it. \n Notice: Produce energy building can not be recycled money.", labelWidth: Int(size.width) - Int(80 * framescale), pos: CGPoint(x: size.width / 2, y: size.height - CGFloat(gap)), fontName: "ArialMT", fontSize: (size.height - CGFloat(gap) * 2 - CGFloat(gap)) / 3, fontColor: colorMoney, leading: Int((size.height - CGFloat(gap) * 2) / 3),  shouldShowBorder: false)
        addChild(sellLabel)
        
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

        energyLabel                                = SKLabelNode(fontNamed: "SanFranciscoRounded-Black")
        energyLabel.name                           = "EnergyLabel"
        energyLabel.fontColor                      = SKColor.whiteColor()
        energyLabel.fontSize                       = size.height / 6
        energyLabel.horizontalAlignmentMode        = .Right
        energyLabel.position                       = CGPoint(x: size.width - 5 * framescale, y: 5 * framescale)
        addChild(energyLabel)

        energyTickAddLabel                         = SKLabelNode(fontNamed: "SanFranciscoRounded-Black")
        energyTickAddLabel.name                    = "energyTickAddLabel"
        energyTickAddLabel.fontColor               = colorEnergy
        energyTickAddLabel.fontSize                = size.height / 6
        energyTickAddLabel.horizontalAlignmentMode = .Right
        energyTickAddLabel.position                = CGPoint(x: size.width - 5 * framescale, y: size.height / 6 + 10 * framescale)
        addChild(energyTickAddLabel)

        let label                                  = SKLabelNode(fontNamed: "SanFranciscoRounded-Black")
        label.name                                 = "ExplanationLabel"
        label.text                                 = "TOUCH  TO  SELL  ENERGY"
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

        showPage(.PageEnergy)
    }
    
    func showPage(pageType: PageType, duration: Double = 0.0) {
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