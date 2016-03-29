//
//  UpgradeScene.swift
//  Energy
//
//  Created by javan.chen on 2015/12/28.
//  Copyright © 2015年 Javan chen. All rights reserved.
//

import SpriteKit

class UpgradeElement: SKNode {
    
    var background:    SKSpriteNode!
    var buttonUpgrade: SKShapeNode!
    var buttonDegrade: SKShapeNode!
    var upgradeType:   UpgradeType!
    var upgradePrice:  Double!
    
    init(upgradeType: UpgradeType, size: CGSize) {
        super.init()
        self.upgradeType = upgradeType
        
        // background
        background = SKSpriteNode(color: colorBlue4, size: size)
        background.name = "UpgradeElementBackground"
        background.anchorPoint = CGPoint(x: 0, y: 0)
        addChild(background)
        
        // Find information
        var imageType: BuildingType!
        var name: String!
        var comment: String!
        let level = Int(upgradeLevel[upgradeType]!)
        switch upgradeType {
        case .WindTurbineEffectiveness:
            imageType = BuildingType.WindTurbine
            name = "Wind Turbine"
            comment = "Increases energy producetion by 50%"
            upgradePrice = baseToPower(10, base: 3, power: upgradeLevel[UpgradeType.WindTurbineEffectiveness]!)
            
        case .WindTurbineLifetime:
            imageType = BuildingType.WindTurbine
            name = "Wind Turbine Lifetime"
            comment = "Increases lifetime producetion by 50%"
            upgradePrice = baseToPower(30, base: 6, power: upgradeLevel[UpgradeType.WindTurbineLifetime]!)
            
        case .SolarCellEffectiveness:
            imageType = BuildingType.SolarCell
            name = "Solar Plant"
            comment = "Increases heat producetion by 25%"
            upgradePrice = baseToPower(100, base: 1.8, power: upgradeLevel[UpgradeType.SolarCellEffectiveness]!)
            
        case .SolarCellLifetime:
            imageType = BuildingType.SolarCell
            name = "Solar Lifetime"
            comment = "Increases lifetime producetion by 50%"
            upgradePrice = baseToPower(300, base: 6, power: upgradeLevel[UpgradeType.SolarCellLifetime]!)
            
        case .CoalBurnerEffectiveness:
            imageType = BuildingType.CoalBurner
            name = "Coal-Fired Plant"
            comment = "Increases heat producetion by 25%"
            upgradePrice = baseToPower(10000, base: 1.8, power: upgradeLevel[UpgradeType.CoalBurnerEffectiveness]!)
            
        case .CoalBurnerLifetime:
            imageType = BuildingType.CoalBurner
            name = "Coal-Fired Lifetime"
            comment = "Increases lifetime producetion by 50%"
            upgradePrice = baseToPower(30000, base: 6, power: upgradeLevel[UpgradeType.CoalBurnerLifetime]!)
            
        case .WaveCellEffectiveness:
            imageType = BuildingType.WaveCell
            name = "Wave Energy"
            comment = "Increases energy producetion by 25%"
            upgradePrice = baseToPower(1000000, base: 1.8, power: upgradeLevel[UpgradeType.WaveCellEffectiveness]!)
            
        case .WaveCellLifetime:
            imageType = BuildingType.WaveCell
            name = "Wave Energy Lifetime"
            comment = "Increases lifetime producetion by 50%"
            upgradePrice = baseToPower(3000000, base: 6, power: upgradeLevel[UpgradeType.WaveCellLifetime]!)
            
        case .GasBurnerEffectiveness:
            imageType = BuildingType.GasBurner
            name = "Gas-Fired Plant"
            comment = "Increases heat producetion by 25%"
            upgradePrice = baseToPower(100000000, base: 1.8, power: upgradeLevel[UpgradeType.GasBurnerEffectiveness]!)
            
        case .GasBurnerLifetime:
            imageType = BuildingType.GasBurner
            name = "Gas-Fired Lifetime"
            comment = "Increases lifetime producetion by 50%"
            upgradePrice = baseToPower(300000000, base: 6, power: upgradeLevel[UpgradeType.GasBurnerLifetime]!)
            
        case .NuclearCellEffectiveness:
            imageType = BuildingType.NuclearCell
            name = "Nuclear Plant"
            comment = "Increases heat producetion by 25%"
            upgradePrice = baseToPower(10000000000, base: 1.8, power: upgradeLevel[UpgradeType.NuclearCellEffectiveness]!)
            
        case .NuclearCellLifetime:
            imageType = BuildingType.NuclearCell
            name = "Nuclear Lifetime"
            comment = "Increases lifetime producetion by 50%"
            upgradePrice = baseToPower(30000000000, base: 6, power: upgradeLevel[UpgradeType.NuclearCellLifetime]!)
            
        case .FusionCellEffectiveness:
            imageType = BuildingType.FusionCell
            name = "Fusion Plant"
            comment = "Increases heat producetion by 25%"
            upgradePrice = baseToPower(1000000000000, base: 1.8, power: upgradeLevel[UpgradeType.FusionCellEffectiveness]!)
            
        case .FusionCellLifetime:
            imageType = BuildingType.FusionCell
            name = "Fusion Lifetime"
            comment = "Increases lifetime producetion by 50%"
            upgradePrice = baseToPower(3000000000000, base: 6, power: upgradeLevel[UpgradeType.FusionCellLifetime]!)
            
        case .GeneratorEffectiveness:
            imageType = BuildingType.SmallGenerator
            name = "Generator Effectiveness"
            comment = "Increases heat to energy rate by 25%"
            upgradePrice = baseToPower(300, base: 1.5, power: upgradeLevel[UpgradeType.GeneratorEffectiveness]!)
            
        case .GeneratorMaxHeat:
            imageType = BuildingType.SmallGenerator
            name = "Generator Max Heat"
            comment = "Increases max heat by 50%"
            upgradePrice = baseToPower(1000, base: 2.3, power: upgradeLevel[UpgradeType.GeneratorMaxHeat]!)
            
        case .BoilerHouseSellAmount:
            imageType = BuildingType.BoilerHouse
            name = "Boiler House"
            comment = "Increases energy sell amount by 20%"
            upgradePrice = baseToPower(30000, base: 4, power: upgradeLevel[UpgradeType.BoilerHouseSellAmount]!)
            
        case .BoilerHouseMaxHeat:
            imageType = BuildingType.BoilerHouse
            name = "Boiler House Max Heat"
            comment = "Increases max heat by 50%"
            upgradePrice = baseToPower(80000, base: 3.7, power: upgradeLevel[UpgradeType.BoilerHouseMaxHeat]!)
            
        case .IsolationEffectiveness:
            imageType = BuildingType.Isolation
            name = "Isolation Effectiveness"
            comment = "Increases isolation effectiveness by 10%"
            upgradePrice = baseToPower(1000, base: 10, power: upgradeLevel[UpgradeType.BoilerHouseMaxHeat]!)
            
        case .EnergyBatterySize:
            imageType = BuildingType.Battery
            name = "Battery Size"
            comment = "Increases max energy storage by 50%"
            upgradePrice = baseToPower(50, base: 1.5, power: upgradeLevel[UpgradeType.EnergyBatterySize]!)
            
        case .HeatExchangerMaxHeat:
            imageType = BuildingType.HeatExchanger
            name = "Heat Exchanger Max Heat"
            comment = "Increases max heat by 50%"
            upgradePrice = baseToPower(50000, base: 2.1, power: upgradeLevel[UpgradeType.HeatExchangerMaxHeat]!)
            
        case .HeatSinkMaxHeat:
            imageType = BuildingType.HeatSink
            name = "Heat Sink Max Heat"
            comment = "Increases max heat by 50%"
            upgradePrice = baseToPower(50000000, base: 1.9, power: upgradeLevel[UpgradeType.HeatSinkMaxHeat]!)
            
        case .HeatInletOutletMaxHeat:
            imageType = BuildingType.HeatInlet
            name = "Heat Inlet,Outlet Max Heat"
            comment = "Increases max heat by 50%"
            upgradePrice = baseToPower(50000000000000, base: 1.9, power: upgradeLevel[UpgradeType.HeatInletOutletMaxHeat]!)
            
        case .HeatInletMaxTransfer:
            imageType = BuildingType.HeatInlet
            name = "Heat Inlet Max Transfer"
            comment = "Increases heat inlet transfer by 50%"
            upgradePrice = baseToPower(100000000000000, base: 1.9, power: upgradeLevel[UpgradeType.HeatInletMaxTransfer]!)
            
        case .WaterPumpProduction:
            imageType = BuildingType.WaterPump
            name = "Water Pump"
            comment = "Increases water producetion by 25%"
            upgradePrice = baseToPower(40000000000, base: 1.5, power: upgradeLevel[UpgradeType.WaterPumpProduction]!)
            
        case .GroundwaterPumpProduction:
            imageType = BuildingType.GroundwaterPump
            name = "Groundwater Pump"
            comment = "Increases water producetion by 20%"
            upgradePrice = baseToPower(10000000000000, base: 1.9, power: upgradeLevel[UpgradeType.GroundwaterPumpProduction]!)
            
        case .WaterElementMaxWater:
            imageType = BuildingType.WaterPipe
            name = "Water Element Max Water"
            comment = "Increases max water by 50%"
            upgradePrice = baseToPower(20000000000, base: 1.9, power: upgradeLevel[UpgradeType.WaterElementMaxWater]!)
            
        case .GeneratorMaxWater:
            imageType = BuildingType.SmallGenerator
            name = "Generator Max Water"
            comment = "Increases max water by 25%"
            upgradePrice = baseToPower(10000000000, base: 1.45, power: upgradeLevel[UpgradeType.GeneratorMaxWater]!)
            
        case .OfficeSellEnergy:
            imageType = BuildingType.SmallOffice
            name = "Office Sell Amount"
            comment = "Increases energy sell amount by 50%"
            upgradePrice = baseToPower(100, base: 1.9, power: upgradeLevel[UpgradeType.OfficeSellEnergy]!)
            
        case .BankEffectiveness:
            imageType = BuildingType.Bank
            name = "Bank Effectiveness"
            comment = "Increases bank effectiveness by 10%"
            upgradePrice = baseToPower(10000000000000, base: 2, power: upgradeLevel[UpgradeType.BankEffectiveness]!)
            
        case .ResearchCenterEffectiveness:
            imageType = BuildingType.ResearchCenter
            name = "Research Center"
            comment = "Increases research producetion by 25%"
            upgradePrice = baseToPower(100, base: 1.8, power: upgradeLevel[UpgradeType.ResearchCenterEffectiveness]!)
            
        case .LibraryEffectiveness:
            imageType = BuildingType.Library
            name = "Library Effectiveness"
            comment = "Increases library effectiveness by 10%"
            upgradePrice = baseToPower(400000000000, base: 2, power: upgradeLevel[UpgradeType.LibraryEffectiveness]!)
        
        default:
            imageType = BuildingType.WindTurbine
            name = "\(upgradeType)"
            comment = "test123123"
            upgradePrice = 1000
        }
    
        // image
        let gap = (size.height - tilesScaleSize.height) / 2
        let image = BuildingData(buildType: imageType).image("image")
        image.position = CGPoint(x: size.height / 2, y: gap + image.size.width / 2)
        addChild(image)
        
        // name
        let upgradeName = SKLabelNode(fontNamed: "SanFranciscoRounded-Black")
        upgradeName.name = "upgradeName"
        upgradeName.text = name
        upgradeName.fontColor = SKColor.whiteColor()
        upgradeName.fontSize = image.size.height * 2 / 5
        
        upgradeName.horizontalAlignmentMode = .Left
        upgradeName.verticalAlignmentMode = .Top
        upgradeName.position = CGPoint(x: image.size.width + gap * 2, y: size.height - gap)
        addChild(upgradeName)

        // comment
        let commentLabel = SKLabelNode(fontNamed: "SanFranciscoRounded-Black")
        commentLabel.name = "commentLabel"
        commentLabel.text = comment
        commentLabel.fontColor = SKColor.lightGrayColor()
        commentLabel.fontSize = (image.size.height - upgradeName.fontSize * 1.2) / 2
        commentLabel.horizontalAlignmentMode = .Left
        commentLabel.verticalAlignmentMode = .Bottom
        commentLabel.position = CGPoint(x: image.size.width + gap * 2, y: (image.size.height - upgradeName.fontSize) / 2 + gap)
        addChild(commentLabel)

        // level and money label
        let infoLabel = SKLabelNode(fontNamed: "SanFranciscoRounded-Black")
        infoLabel.name = "levelLabel"
        infoLabel.text = "Lv.     Price:"
        infoLabel.fontColor = SKColor.lightGrayColor()
        infoLabel.fontSize = (image.size.height - upgradeName.fontSize * 1.2) / 2
        infoLabel.horizontalAlignmentMode = .Left
        infoLabel.verticalAlignmentMode = .Bottom
        infoLabel.position = CGPoint(x: image.size.width + gap * 2, y: gap)
        addChild(infoLabel)

        // level
        let levelLabel = SKLabelNode(fontNamed: "SanFranciscoRounded-Black")
        levelLabel.name = "levelValue"
        levelLabel.text = "\(level)"
        levelLabel.fontColor = colorBlue1
        levelLabel.fontSize = infoLabel.fontSize
        levelLabel.horizontalAlignmentMode = .Left
        levelLabel.verticalAlignmentMode = .Bottom
        levelLabel.position = CGPoint(x: image.size.width + gap * 2 + 22 * framescale, y: gap)
        addChild(levelLabel)
    
        // price
        let priceLabel = SKLabelNode(fontNamed: "SanFranciscoRounded-Black")
        priceLabel.name = "priceLabel"
        priceLabel.text = numberToString(upgradePrice)
        priceLabel.fontColor = colorMoney
        priceLabel.fontSize = infoLabel.fontSize
        priceLabel.horizontalAlignmentMode = .Left
        priceLabel.verticalAlignmentMode = .Bottom
        priceLabel.position = CGPoint(x: infoLabel.position.x + infoLabel.frame.width, y: gap)
        addChild(priceLabel)
  
        // Upgrade Button
        let color = (money > upgradePrice ? colorBlue2 : SKColor.lightGrayColor())
        buttonUpgrade = SKShapeNode(rectOfSize: CGSizeMake(tilesScaleSize.width, tilesScaleSize.height), cornerRadius: 10 * framescale)
        buttonUpgrade.name = (money > upgradePrice ? "Upgrade" : "NoMoney")
        buttonUpgrade.fillColor = color
        buttonUpgrade.strokeColor = color
        buttonUpgrade.position = CGPoint(x: size.width - gap - tilesScaleSize.width / 2, y: size.height / 2)
        let levelupImage = SKSpriteNode(texture: iconAtlas.textureNamed("levelup"))
        levelupImage.setScale(0.6 * framescale)
        buttonUpgrade.addChild(levelupImage)
        addChild(buttonUpgrade)

        // Degrade Button
        buttonDegrade = SKShapeNode(rectOfSize: CGSizeMake(tilesScaleSize.width, tilesScaleSize.height), cornerRadius: 10 * framescale)
        buttonDegrade.name = "Degrade"
        buttonDegrade.fillColor = colorBlue2
        buttonDegrade.strokeColor = colorBlue2
        buttonDegrade.position = CGPoint(x: size.width - gap * 2 - tilesScaleSize.width * 3 / 2, y: size.height / 2)
        let leveldownImage = SKSpriteNode(texture: iconAtlas.textureNamed("levelup"))
        leveldownImage.setScale(0.6 * framescale)
        leveldownImage.zRotation = CGFloat(M_PI)
        buttonDegrade.addChild(leveldownImage)
        buttonDegrade.hidden = (level > 0 ? false : true)
        addChild(buttonDegrade)
    }
    
    func checkUpgradeAndDegrade() {
        buttonUpgrade.name = (money > upgradePrice ? "Upgrade" : "NoMoney")
        buttonUpgrade.fillColor = (money > upgradePrice ? colorBlue2 : SKColor.lightGrayColor())
        buttonUpgrade.strokeColor = (money > upgradePrice ? colorBlue2 : SKColor.lightGrayColor())
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class UpgradeScene: SKScene {
    
    var contentCreated: Bool = false
    var backButton: SKSpriteNode!
    var nowPage: Int = 1
    var maxPage: Int = 1
    var nextPage: SKSpriteNode!
    var prevPage: SKSpriteNode!
    var moneyLabel: SKLabelNode!
    var itemLabel: SKLabelNode!
    
    var upgradeLayer: SKSpriteNode!
    var upgradeElements = [UpgradeElement]()
    
    override func didMoveToView(view: SKView) {
        if !contentCreated {
            
            self.backgroundColor = colorBlue4
            
            let unitHeight = size.height / 10
            let topCenter = CGPoint(x: size.width / 2, y: frame.size.height - unitHeight / 2)
            
            let line = SKShapeNode(rectOfSize: CGSizeMake(frame.size.width * 0.9, 3 * framescale))
            line.name = "line"
            line.lineWidth = 0
            line.fillColor = SKColor.whiteColor()
            line.position = CGPoint(x: size.width / 2, y: frame.size.height - unitHeight)
            addChild(line)
            
            let upgradeImage = SKSpriteNode(texture: iconAtlas.textureNamed("upgrade"))
            upgradeImage.name = "upgradeImage"
            upgradeImage.setScale(0.9 * framescale)
            upgradeImage.position = topCenter
            addChild(upgradeImage)
            
            moneyLabel = SKLabelNode(fontNamed: "SanFranciscoRounded-Black")
            moneyLabel.name = "top label"
            moneyLabel.fontSize = unitHeight * 0.2
            moneyLabel.fontColor = colorMoney
            moneyLabel.text = numberToString(money)
            moneyLabel.horizontalAlignmentMode = .Left
            moneyLabel.verticalAlignmentMode = .Bottom
            moneyLabel.position = CGPoint(x: frame.size.width * 0.05, y: frame.size.height - unitHeight * 0.9)
            addChild(moneyLabel)
            
            itemLabel = SKLabelNode(fontNamed: "SanFranciscoRounded-Black")
            itemLabel.name = "item label"
            itemLabel.fontSize = unitHeight * 0.2
            itemLabel.fontColor = colorMoney
            itemLabel.text = "1 / 32"
            itemLabel.horizontalAlignmentMode = .Right
            itemLabel.verticalAlignmentMode = .Bottom
            itemLabel.position = CGPoint(x: frame.size.width * 0.95, y: frame.size.height - unitHeight * 0.9)
            addChild(itemLabel)
            
            backButton = SKSpriteNode(texture: iconAtlas.textureNamed("arrow_down"))
            backButton.name = "back button"
            backButton.setScale(framescale)
            backButton.position = CGPoint(x: frame.size.width / 2, y: unitHeight / 2)
            let downAction = SKAction.sequence([SKAction.moveByX(0, y: -5, duration: 0.5), SKAction.moveByX(0, y: 5, duration: 0.5)])
            backButton.runAction(SKAction.repeatActionForever(downAction))
            addChild(backButton)
            
            nextPage = SKSpriteNode(texture: iconAtlas.textureNamed("arrow_right"))
            nextPage.name = "NextPage"
            nextPage.setScale(0.8 * framescale)
            nextPage.position = CGPoint(x: frame.size.width * 0.9, y: unitHeight  / 2)
            addChild(nextPage)
            prevPage = SKSpriteNode(texture: iconAtlas.textureNamed("arrow_right"))
            prevPage.name = "PrevPage"
            prevPage.setScale(0.8 * framescale)
            prevPage.position = CGPoint(x: frame.size.width * 0.1, y: unitHeight  / 2)
            prevPage.zRotation = CGFloat(M_PI)
            addChild(prevPage)
            upgradeLayer = SKSpriteNode(color: colorBlue4, size: CGSizeMake(frame.size.width * 4, frame.size.height - unitHeight * 2))
            upgradeLayer.name = "upgradeLayer"
            upgradeLayer.anchorPoint = CGPoint(x: 0, y: 0)
            upgradeLayer.position = CGPoint(x: 0, y: unitHeight)
            addChild(upgradeLayer)
            
            contentCreated = true
            
            // remove first load delay
            print("load 3")
            self.view?.presentScene(islandScene)
        }
        
        updateElement()
        print("load 7")
    }

    func updateElement() {
        upgradeLayer.removeAllChildren()
        // Caculae Position
        var positions = [CGPoint]()
        let num:CGFloat = 8
        let elementsize = CGSizeMake(frame.size.width, upgradeLayer.size.height / num)
        for x in 0..<4 {
            for y in 0..<Int(num) {
                positions.append(CGPoint(x: frame.size.width * CGFloat(x), y: upgradeLayer.size.height - elementsize.height * CGFloat(y + 1)))
            }
        }
        
        // Check element
        upgradeElements.removeAll()
        var elements = [UpgradeType]()
        if researchLevel[.WindTurbineResearch] > 0       { elements += [.WindTurbineEffectiveness, .WindTurbineLifetime] }
        if researchLevel[.SolarCellResearch] > 0         { elements += [.SolarCellEffectiveness, .SolarCellLifetime] }
        if researchLevel[.CoalBurnerResearch] > 0        { elements += [.CoalBurnerEffectiveness, .CoalBurnerLifetime] }
        if researchLevel[.WaveCellResearch] > 0          { elements += [.WaveCellEffectiveness, .WaveCellLifetime] }
        if researchLevel[.GasBurnerResearch] > 0         { elements += [.GasBurnerEffectiveness, .GasBurnerLifetime] }
        if researchLevel[.NuclearCellResearch] > 0       { elements += [.NuclearCellEffectiveness, .NuclearCellLifetime] }
        if researchLevel[.FusionCellResearch] > 0        { elements += [.FusionCellEffectiveness, .FusionCellLifetime] }
        if researchLevel[.SmallGeneratorResearch] > 0    { elements += [.GeneratorMaxHeat, .GeneratorEffectiveness] }
        if researchLevel[.BoilerHouseResearch] > 0       { elements += [.BoilerHouseSellAmount, .BoilerHouseMaxHeat] }
        if researchLevel[.IsolationResearch] > 0         { elements += [.IsolationEffectiveness] }
        if researchLevel[.BatteryResearch] > 0           { elements += [.EnergyBatterySize] }
        if researchLevel[.HeatExchangerResearch] > 0     { elements += [.HeatExchangerMaxHeat] }
        if researchLevel[.HeatSinkResearch] > 0          { elements += [.HeatSinkMaxHeat] }
        if researchLevel[.HeatInletResearch] > 0         { elements += [.HeatInletOutletMaxHeat, .HeatInletMaxTransfer] }
        if researchLevel[.WaterPumpResearch] > 0         { elements += [.WaterPumpProduction, .WaterElementMaxWater, .GeneratorMaxWater] }
        if researchLevel[.GroundwaterPumpResearch] > 0   { elements += [.GroundwaterPumpProduction] }
        if researchLevel[.SmallOfficeResearch] > 0       { elements += [.OfficeSellEnergy] }
        if researchLevel[.BankResearch] > 0              { elements += [.BankEffectiveness] }
        if researchLevel[.ResearchCenterResearch] > 0    { elements += [.ResearchCenterEffectiveness] }
        if researchLevel[.LibraryResearch] > 0           { elements += [.LibraryEffectiveness] }

        // Add Element
        for count in 0..<elements.count {
            let upgradeElement = UpgradeElement(upgradeType: elements[count], size: elementsize)
            upgradeElement.position = positions[count]
            upgradeElement.background.color = (count % 2 == 0 ? colorBlue4 : colorBlue3)
            upgradeElements.append(upgradeElement)
            upgradeLayer.addChild(upgradeElement)
        }
        
        // Caculate MaxPage
        maxPage = (elements.count - 1) / 8 + 1
        
        // update item count
        itemLabel.text = "\(upgradeElements.count) / 32"
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch in touches {
            let location = touch.locationInNode(self)
            let nodes = nodesAtPoint(location)
            for node in nodes {
                if node.hidden { return }
                if backButton.containsPoint(location) {
                    if !isSoundMute{ runAction(soundTap) }
                    let doors = SKTransition.revealWithDirection(SKTransitionDirection.Down, duration: 0.3)
                    self.view?.presentScene(islandScene, transition: doors)
                }
                if nextPage.containsPoint(location) {
                    nowPage += 1
                    upgradeLayer.runAction((SKAction.moveToX(-frame.size.width * CGFloat(nowPage - 1), duration: 0.2)))
                    if !isSoundMute{ runAction(soundSlide) }
                }
                if prevPage.containsPoint(location) {
                    nowPage -= 1
                    upgradeLayer.runAction((SKAction.moveToX(-frame.size.width * CGFloat(nowPage - 1), duration: 0.2)))
                    if !isSoundMute{ runAction(soundSlide) }
                }
                if node.name == "Upgrade" {
                    let element = (node.parent as! UpgradeElement)
                    let price = element.upgradePrice
                    let type = element.upgradeType
                    money -= price
                    upgradeLevel[type]! += 1
                    for count in 0..<maps.count {
                        maps[count].reloadMap()
                    }
                    updateElement()
                    if !isSoundMute{ runAction(soundLevelup) }
                }
                if node.name == "Degrade" {
                    let element = (node.parent as! UpgradeElement)
                    let price = element.upgradePrice
                    let type = element.upgradeType
                    money += price
                    upgradeLevel[type]! -= 1
                    for count in 0..<maps.count {
                        maps[count].reloadMap()
                    }
                    updateElement()
                    if !isSoundMute{ runAction(soundTap) }
                }
            }
        }
    }
    
    override func update(currentTime: CFTimeInterval) {
        prevPage.hidden = (nowPage == 1 ? true : false)
        nextPage.hidden = (nowPage == maxPage ? true : false)
        moneyLabel.text = numberToString(money)
        for upgradeElement in upgradeElements {
            upgradeElement.checkUpgradeAndDegrade()
        }
    }
}
