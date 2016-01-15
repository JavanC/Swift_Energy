//
//  UpgradeScene.swift
//  Energy
//
//  Created by javan.chen on 2015/12/28.
//  Copyright © 2015年 Javan chen. All rights reserved.
//

import SpriteKit
//
//        case .WindTurbineResearch:
//            imageType = BuildingType.WindTurbine
//            name = "Wind Turbine"
//            comment = "Open Wind turbine technology."
//            researchPrice = 1
//            
//        case .WindTurbineRebuild:
//            imageType = BuildingType.WindTurbine
//            name = "Wind Turbine Manager"
//            comment = "Wind Turbine are automatically replaced."
//            researchPrice = 1
//            
//        case .SolarCellResearch:
//            imageType = BuildingType.SolarCell
//            name = "Solar Plant"
//            comment = "Open Solar Plant technology."
//            researchPrice = 1
//            
//        case .SolarCellRebuild:
//            imageType = BuildingType.SolarCell
//            name = "Solar Manager"
//            comment = "Solar Plant are automatically replaced."
//            researchPrice = 1
//            
//        case .CoalBurnerResearch:
//            imageType = BuildingType.CoalBurner
//            name = "Coal-Fired Plant"
//            comment = "Open Coal-Fired technology."
//            researchPrice = 10
//            
//        case .CoalBurnerRebuild:
//            imageType = BuildingType.CoalBurner
//            name = "Coal-Fired Manager"
//            comment = "Coal Coal-Fired are automatically replaced."
//            researchPrice = 1
//            
//        case .WaveCellResearch:
//            imageType = BuildingType.WaveCell
//            name = "Wave Energy"
//            comment = "Open Wave Energy technology."
//            researchPrice = 1
//            
//        case .WaveCellRebuild:
//            imageType = BuildingType.WaveCell
//            name = "Wave Energy Manager"
//            comment = "Wave Energy are automatically replaced."
//            researchPrice = 1
//            
//        case .GasBurnerResearch:
//            imageType = BuildingType.GasBurner
//            name = "Gas-Fired Plant"
//            comment = "Open Gas-Fired Plant technology."
//            researchPrice = 1
//            
//        case .GasBurnerRebuild:
//            imageType = BuildingType.GasBurner
//            name = "Gas-Fired Manager"
//            comment = "Gas-Fired are automatically replaced."
//            researchPrice = 1
//            
//        case .NuclearCellResearch:
//            imageType = BuildingType.NuclearCell
//            name = "Nuclear Plant"
//            comment = "Open Nuclear Plant technology."
//            researchPrice = 1
//            
//        case .NuclearCellRebuild:
//            imageType = BuildingType.NuclearCell
//            name = "Nuclear Manager"
//            comment = "Nuclear are automatically replaced."
//            researchPrice = 1
//            
//        case .FusionCellResearch:
//            imageType = BuildingType.FusionCell
//            name = "Fusion Plant"
//            comment = "Open Fusion Plant technology."
//            researchPrice = 1
//            
//        case .FusionCellRebuild:
//            imageType = BuildingType.FusionCell
//            name = "Fusion Manager"
//            comment = "Fusion are automatically replaced."
//            researchPrice = 1
//            
//        case .SmallGeneratorResearch:
//            imageType = BuildingType.SmallGenerator
//            name = "Small Generator"
//            comment = "Open Small Generator technology."
//            researchPrice = 1
//            
//        case .MediumGeneratorResearch:
//            imageType = BuildingType.MediumGenerator
//            name = "Medium Generator"
//            comment = "Open Medium Generator technology."
//            researchPrice = 1
//            
//        case .LargeGeneratorResearch:
//            imageType = BuildingType.LargeGenerator
//            name = "Large Generator"
//            comment = "Open Large Generator technology."
//            researchPrice = 1
//            
//        case .BoilerHouseResearch:
//            imageType = BuildingType.BoilerHouse
//            name = "Boiler House"
//            comment = "Open Boiler House technology."
//            researchPrice = 1
//            
//        case .LargeBoilerHouseResearch:
//            imageType = BuildingType.LargeBoilerHouse
//            name = "Large Boiler House"
//            comment = "Open Large Boiler House technology."
//            researchPrice = 1
//            
//        case .IsolationResearch:
//            imageType = BuildingType.Isolation
//            name = "Isolation"
//            comment = "Open Isolation technology."
//            researchPrice = 1
//            
//        case .BatteryResearch:
//            imageType = BuildingType.Battery
//            name = "Battery"
//            comment = "Open Battery technology."
//            researchPrice = 1
//            
//        case .HeatExchangerResearch:
//            imageType = BuildingType.HeatExchanger
//            name = "Heat Exchanger"
//            comment = "Open Heat Exchanger technology."
//            researchPrice = 1
//            
//        case .HeatSinkResearch:
//            imageType = BuildingType.HeatSink
//            name = "Heat Sink"
//            comment = "Open Heat Sink technology."
//            researchPrice = 1
//            
//            // HeatInletResearch , HeatOutletResearch:
//            
//        case .WaterPumpResearch:
//            imageType = BuildingType.WaterPump
//            name = "Water Pump"
//            comment = "Open Water Pump technology."
//            researchPrice = 1
//            
//        case .GroundwaterPumpResearch:
//            imageType = BuildingType.GroundwaterPump
//            name = "Groundwater Pump"
//            comment = "Open Groundwater Pump technology."
//            researchPrice = 1
//            
//        case .WaterPipeResearch:
//            imageType = BuildingType.WaterPipe
//            name = "Water Pipe"
//            comment = "Open Water Pipe technology."
//            researchPrice = 1
//            
//        case .SmallOfficeResearch:
//            imageType = BuildingType.SmallOffice
//            name = "Small Office"
//            comment = "Open Small Office technology."
//            researchPrice = 1
//            
//        case .MediumOfficeResearch:
//            imageType = BuildingType.MediumOffice
//            name = "Medium Office"
//            comment = "Open Medium Office technology."
//            researchPrice = 1
//            
//        case .LargeOfficeResearch:
//            imageType = BuildingType.LargeOffice
//            name = "Large Office"
//            comment = "Open Large Office technology."
//            researchPrice = 1
//            
//        case .BankResearch:
//            imageType = BuildingType.Bank
//            name = "Bank"
//            comment = "Open Bank technology."
//            researchPrice = 1
//            
//        case .ResearchCenterResearch:
//            imageType = BuildingType.ResearchCenter
//            name = "Research Center"
//            comment = "Open Research Center technology."
//            researchPrice = 1
//            
//        case .AdvancedResearchCenterResearch:
//            imageType = BuildingType.AdvancedResearchCenter
//            name = "Advanced Research Center"
//            comment = "Open Advanced Research Center technology."
//            researchPrice = 1
//        case .LibraryResearch:
//            imageType = BuildingType.Library
//            name = "Library"
//            comment = "Open Library technology."
//            researchPrice = 1
//            
//        default:
//            imageType = BuildingType.WindTurbine
//            name = "\(researchType)"
//            comment = "test123123"
//            researchPrice = 1
//        }

class UpgradeElement: SKNode {
    
    var background: SKSpriteNode!
    var buttonUpgrade: SKShapeNode!
    var buttonDegrade: SKShapeNode!
    var upgradeType: UpgradeType!
    var upgradePrice: Int!
    
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
            name = "Wind Lv.\(level)"
            comment = "test123123"
            upgradePrice = 1
            
        case .CoalBurnerEffectiveness:
            imageType = BuildingType.CoalBurner
            name = "Fire Lv.\(level)"
            comment = "test123123"
            upgradePrice = 10
            
        case .CoalBurnerLifetime:
            imageType = BuildingType.CoalBurner
            name = "Fire Lv.\(level)"
            comment = "test123123"
            upgradePrice = 100
            
        case .OfficeSellEnergy:
            imageType = BuildingType.SmallOffice
            name = "Office Lv.\(level)"
            comment = "test123123"
            upgradePrice = 1000
            
        default:
            imageType = BuildingType.WindTurbine
            name = "\(upgradeType) Lv.\(level)"
            comment = "test123123"
            upgradePrice = 1000
        }
        
        
        // image
        let gap = (size.height - tilesScaleSize.height) / 2
        let image = BuildingData(buildType: imageType).image("image")
        image.position = CGPoint(x: size.height / 2, y: gap + image.size.width / 2)
        addChild(image)
        
        // name
        let upgradeName = SKLabelNode(fontNamed: "SanFranciscoDisplay-Semibold")
        upgradeName.name = "upgradeName"
        upgradeName.text = name
        upgradeName.fontColor = SKColor.whiteColor()
        upgradeName.fontSize = image.size.height * 2 / 5
        upgradeName.horizontalAlignmentMode = .Left
        upgradeName.verticalAlignmentMode = .Top
        upgradeName.position = CGPoint(x: image.size.width + gap * 2, y: size.height - gap)
        addChild(upgradeName)
        
        // comment
        let commentLabel = SKLabelNode(fontNamed: "SanFranciscoDisplay-Semibold")
        commentLabel.name = "commentLabel"
        commentLabel.text = comment
        commentLabel.fontColor = SKColor.lightGrayColor()
        commentLabel.fontSize = (image.size.height - upgradeName.fontSize * 1.2) / 2
        commentLabel.horizontalAlignmentMode = .Left
        commentLabel.verticalAlignmentMode = .Bottom
        commentLabel.position = CGPoint(x: image.size.width + gap * 2, y: (image.size.height - upgradeName.fontSize) / 2 + gap)
        addChild(commentLabel)
        
        // money
        let moneyLabel = SKLabelNode(fontNamed: "SanFranciscoDisplay-Semibold")
        moneyLabel.name = "researchLabel"
        moneyLabel.text = "Price:"
        moneyLabel.fontColor = SKColor.lightGrayColor()
        moneyLabel.fontSize = (image.size.height - upgradeName.fontSize * 1.2) / 2
        moneyLabel.horizontalAlignmentMode = .Left
        moneyLabel.verticalAlignmentMode = .Bottom
        moneyLabel.position = CGPoint(x: image.size.width + gap * 2, y: gap)
        addChild(moneyLabel)
        
        // price
        let priceLabel = SKLabelNode(fontNamed: "SanFranciscoDisplay-Semibold")
        priceLabel.name = "priceLabel"
        priceLabel.text = "\(upgradePrice)"
        priceLabel.fontColor = colorMoney
        priceLabel.fontSize = (image.size.height - upgradeName.fontSize * 1.2) / 2
        priceLabel.horizontalAlignmentMode = .Left
        priceLabel.verticalAlignmentMode = .Bottom
        priceLabel.position = CGPoint(x: image.size.width + gap * 2 + moneyLabel.frame.width, y: gap)
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
        buttonDegrade.hidden = (level > 1 ? false : true)
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
            
            let line = SKShapeNode(rectOfSize: CGSizeMake(frame.size.width * 0.9, 2 * framescale))
            line.name = "line"
            line.position = CGPoint(x: size.width / 2, y: frame.size.height - unitHeight)
            addChild(line)
            
            let upgradeImage = SKSpriteNode(texture: iconAtlas.textureNamed("upgrade"))
            upgradeImage.name = "upgradeImage"
            upgradeImage.setScale(0.9 * framescale)
            upgradeImage.position = topCenter
            addChild(upgradeImage)
            
            moneyLabel = SKLabelNode(fontNamed: "SanFranciscoText-BoldItalic")
            moneyLabel.name = "top label"
            moneyLabel.fontSize = unitHeight * 0.2
            moneyLabel.fontColor = colorMoney
            moneyLabel.text = "\(research)"
            moneyLabel.horizontalAlignmentMode = .Left
            moneyLabel.verticalAlignmentMode = .Bottom
            moneyLabel.position = CGPoint(x: frame.size.width * 0.05, y: frame.size.height - unitHeight * 0.9)
            addChild(moneyLabel)
            
            itemLabel = SKLabelNode(fontNamed: "SanFranciscoText-BoldItalic")
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
        }
        updateElement()
    }

    func updateElement() {
        upgradeLayer.removeAllChildren()
        // Caculae Position
        var positions = [CGPoint]()
        let gap:CGFloat = 20
        let num:CGFloat = 8
        let elementsize = CGSizeMake(frame.size.width - gap * 2, (upgradeLayer.size.height - gap) / num - gap)
        for x in 0..<4 {
            for y in 0..<Int(num) {
                positions.append(CGPoint(x: gap + frame.size.width * CGFloat(x), y: upgradeLayer.size.height - (elementsize.height + gap) * CGFloat(y + 1)))
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
        if researchLevel[.BoilerHouseResearch] > 0       { elements += [.BoilerHouseMaxHeat, .BoilerHouseSellAmount] }
        if researchLevel[.IsolationResearch] > 0         { elements += [.IsolationEffectiveness] }
        if researchLevel[.BatteryResearch] > 0           { elements += [.EnergyBatterySize] }
        if researchLevel[.HeatExchangerResearch] > 0     { elements += [.HeatExchangerMaxHeat] }
        if researchLevel[.HeatSinkResearch] > 0          { elements += [.HeatSinkMaxHeat] }
        if researchLevel[.HeatInletResearch] > 0         { elements += [.HeatInletOutletMaxHeat, .HeatInletOutletMaxHeat] }
        if researchLevel[.WaterPumpResearch] > 0         { elements += [.WaterPumpProduction, .WaterElementMaxWater, .GeneratorMaxWater] }
        if researchLevel[.GroundwaterPumpResearch] > 0   { elements += [.GroundwaterPumpProduction] }
        if researchLevel[.SmallOfficeResearch] > 0       { elements += [.OfficeSellEnergy] }
        if researchLevel[.BankResearch] > 0              { elements += [.BankEffectiveness] }
        if researchLevel[.ResearchCenterResearch] > 0    { elements += [.ResearchCenter] }
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
                    let doors = SKTransition.revealWithDirection(SKTransitionDirection.Down, duration: 0.3)
                    self.view?.presentScene(islandScene, transition: doors)
                }
                if nextPage.containsPoint(location) {
                    nowPage++
                    upgradeLayer.runAction((SKAction.moveToX(-frame.size.width * CGFloat(nowPage - 1), duration: 0.2)))
                }
                if prevPage.containsPoint(location) {
                    nowPage--
                    upgradeLayer.runAction((SKAction.moveToX(-frame.size.width * CGFloat(nowPage - 1), duration: 0.2)))
                }
                if node.name == "Upgrade" {
                    let element = (node.parent as! UpgradeElement)
                    let price = element.upgradePrice
                    let type = element.upgradeType
                    money -= price
                    upgradeLevel[type]!++
                    for count in 0..<maps.count {
                        maps[count].reloadMap()
                    }
                    updateElement()
                }
                if node.name == "Degrade" {
                    let element = (node.parent as! UpgradeElement)
                    let price = element.upgradePrice
                    let type = element.upgradeType
                    money += price
                    upgradeLevel[type]!--
                    for count in 0..<maps.count {
                        maps[count].reloadMap()
                    }
                    updateElement()
                }
            }
        }
    }
    
    override func update(currentTime: CFTimeInterval) {
        prevPage.hidden = (nowPage == 1 ? true : false)
        nextPage.hidden = (nowPage == maxPage ? true : false)
        moneyLabel.text = "\(money)"
        for upgradeElement in upgradeElements {
            upgradeElement.checkUpgradeAndDegrade()
        }
    }
}
