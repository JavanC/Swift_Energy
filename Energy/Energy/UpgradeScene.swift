//
//  UpgradeScene.swift
//  Energy
//
//  Created by javan.chen on 2015/12/28.
//  Copyright © 2015年 Javan chen. All rights reserved.
//

import SpriteKit

class UpgradeElement: SKNode {
    
    var buttonUpgrade: SKShapeNode!
    var buttonDegrade: SKShapeNode!
    var upgradeType:   UpgradeType!
    var upgradePrice:  Double!
    var degradePrice:  Double!
    
    init(upgradeType: UpgradeType, size: CGSize) {
        super.init()
        self.upgradeType = upgradeType
        
        // Find information
        var imageType: BuildingType!
        var name: String!
        var comment: String!
        let level = Int(upgradeLevel[upgradeType]!)
        switch upgradeType {
        case .WindTurbineEffectiveness:
            imageType = BuildingType.WindTurbine
            name = "Wind Turbine".localized
            comment = "Increases energy producetion by 50%".localized
            upgradePrice = baseToPower(10, base: 3, power: level)
            degradePrice = baseToPower(10, base: 3, power: level - 1)
            
        case .WindTurbineLifetime:
            imageType = BuildingType.WindTurbine
            name = "Wind Turbine Lifetime".localized
            comment = "Increases lifetime producetion by 50%".localized
            upgradePrice = baseToPower(30, base: 6, power: level)
            degradePrice = baseToPower(30, base: 6, power: level - 1)
            
        case .SolarCellEffectiveness:
            imageType = BuildingType.SolarCell
            name = "Solar Plant".localized
            comment = "Increases heat producetion by 25%".localized
            upgradePrice = baseToPower(100, base: 1.8, power: level)
            degradePrice = baseToPower(100, base: 1.8, power: level - 1)
            
        case .SolarCellLifetime:
            imageType = BuildingType.SolarCell
            name = "Solar Lifetime".localized
            comment = "Increases lifetime producetion by 50%".localized
            upgradePrice = baseToPower(300, base: 6, power: level)
            degradePrice = baseToPower(300, base: 6, power: level - 1)
            
        case .CoalBurnerEffectiveness:
            imageType = BuildingType.CoalBurner
            name = "Coal-Fired Plant".localized
            comment = "Increases heat producetion by 25%".localized
            upgradePrice = baseToPower(10000, base: 1.8, power: level)
            degradePrice = baseToPower(10000, base: 1.8, power: level - 1)
            
        case .CoalBurnerLifetime:
            imageType = BuildingType.CoalBurner
            name = "Coal-Fired Lifetime".localized
            comment = "Increases lifetime producetion by 50%".localized
            upgradePrice = baseToPower(30000, base: 6, power: level)
            degradePrice = baseToPower(30000, base: 6, power: level - 1)
            
        case .WaveCellEffectiveness:
            imageType = BuildingType.WaveCell
            name = "Wave Energy".localized
            comment = "Increases energy producetion by 25%".localized
            upgradePrice = baseToPower(1000000, base: 3, power: level)
            degradePrice = baseToPower(1000000, base: 3, power: level - 1)
            
        case .WaveCellLifetime:
            imageType = BuildingType.WaveCell
            name = "Wave Energy Lifetime".localized
            comment = "Increases lifetime producetion by 50%".localized
            upgradePrice = baseToPower(3000000, base: 6, power: level)
            degradePrice = baseToPower(3000000, base: 6, power: level - 1)
            
        case .GasBurnerEffectiveness:
            imageType = BuildingType.GasBurner
            name = "Gas-Fired Plant".localized
            comment = "Increases heat producetion by 25%".localized
            upgradePrice = baseToPower(100000000, base: 1.8, power: level)
            degradePrice = baseToPower(100000000, base: 1.8, power: level - 1)
            
        case .GasBurnerLifetime:
            imageType = BuildingType.GasBurner
            name = "Gas-Fired Lifetime".localized
            comment = "Increases lifetime producetion by 50%".localized
            upgradePrice = baseToPower(300000000, base: 6, power: level)
            degradePrice = baseToPower(300000000, base: 6, power: level - 1)
            
        case .NuclearCellEffectiveness:
            imageType = BuildingType.NuclearCell
            name = "Nuclear Plant".localized
            comment = "Increases heat producetion by 25%".localized
            upgradePrice = baseToPower(10000000000, base: 1.8, power: level)
            degradePrice = baseToPower(10000000000, base: 1.8, power: level - 1)
            
        case .NuclearCellLifetime:
            imageType = BuildingType.NuclearCell
            name = "Nuclear Lifetime".localized
            comment = "Increases lifetime producetion by 50%".localized
            upgradePrice = baseToPower(30000000000, base: 6, power: level)
            degradePrice = baseToPower(30000000000, base: 6, power: level - 1)
            
        case .FusionCellEffectiveness:
            imageType = BuildingType.FusionCell
            name = "Fusion Plant".localized
            comment = "Increases heat producetion by 25%".localized
            upgradePrice = baseToPower(1000000000000, base: 1.8, power: level)
            degradePrice = baseToPower(1000000000000, base: 1.8, power: level - 1)
            
        case .FusionCellLifetime:
            imageType = BuildingType.FusionCell
            name = "Fusion Lifetime".localized
            comment = "Increases lifetime producetion by 50%".localized
            upgradePrice = baseToPower(3000000000000, base: 6, power: level)
            degradePrice = baseToPower(3000000000000, base: 6, power: level - 1)
            
        case .GeneratorEffectiveness:
            imageType = BuildingType.SmallGenerator
            name = "Generator Effectiveness".localized
            comment = "Increases heat to energy rate by 25%".localized
            upgradePrice = baseToPower(300, base: 1.5, power: level)
            degradePrice = baseToPower(300, base: 1.5, power: level - 1)
            
        case .GeneratorMaxHeat:
            imageType = BuildingType.SmallGenerator
            name = "Generator Max Heat".localized
            comment = "Increases max heat by 50%".localized
            upgradePrice = baseToPower(1000, base: 1.9, power: level)
            degradePrice = baseToPower(1000, base: 1.9, power: level - 1)
            
        case .BoilerHouseSellAmount:
            imageType = BuildingType.BoilerHouse
            name = "Boiler House Effectiveness".localized
            comment = "Increases heat sell amount by 20%".localized
            upgradePrice = baseToPower(30000, base: 4, power: level)
            degradePrice = baseToPower(30000, base: 4, power: level - 1)
            
        case .BoilerHouseMaxHeat:
            imageType = BuildingType.BoilerHouse
            name = "Boiler House Max Heat".localized
            comment = "Increases max heat by 50%".localized
            upgradePrice = baseToPower(80000, base: 3.7, power: level)
            degradePrice = baseToPower(80000, base: 3.7, power: level - 1)
            
        case .IsolationEffectiveness:
            imageType = BuildingType.Isolation
            name = "Isolation Effectiveness".localized
            comment = "Increases isolation effectiveness by 10%".localized
            upgradePrice = baseToPower(1000, base: 10, power: level)
            degradePrice = baseToPower(1000, base: 10, power: level - 1)
            
        case .EnergyBatterySize:
            imageType = BuildingType.Battery
            name = "Battery Size".localized
            comment = "Increases max energy storage by 50%".localized
            upgradePrice = baseToPower(50, base: 2.3, power: level)
            degradePrice = baseToPower(50, base: 2.3, power: level - 1)
            
        case .HeatExchangerMaxHeat:
            imageType = BuildingType.HeatExchanger
            name = "Heat Exchanger Max Heat".localized
            comment = "Increases max heat by 50%".localized
            upgradePrice = baseToPower(50000, base: 1.8, power: level)
            degradePrice = baseToPower(50000, base: 1.8, power: level - 1)
            
        case .HeatSinkMaxHeat:
            imageType = BuildingType.HeatSink
            name = "Heat Sink Max Heat".localized
            comment = "Increases max heat by 50%".localized
            upgradePrice = baseToPower(50000000, base: 1.9, power: level)
            degradePrice = baseToPower(50000000, base: 1.9, power: level - 1)
            
        case .HeatInletOutletMaxHeat:
            imageType = BuildingType.HeatInlet
            name = "Heat Inlet,Outlet Max Heat".localized
            comment = "Increases max heat by 50%".localized
            upgradePrice = baseToPower(10000000000000, base: 1.9, power: level)
            degradePrice = baseToPower(10000000000000, base: 1.9, power: level - 1)
            
        case .HeatInletMaxTransfer:
            imageType = BuildingType.HeatInlet
            name = "Heat Inlet Max Transfer".localized
            comment = "Increases heat inlet transfer by 50%".localized
            upgradePrice = baseToPower(8000000000000, base: 1.9, power: level)
            degradePrice = baseToPower(8000000000000, base: 1.9, power: level - 1)
            
        case .WaterPumpProduction:
            imageType = BuildingType.WaterPump
            name = "Water Pump".localized
            comment = "Increases water producetion by 25%".localized
            upgradePrice = baseToPower(40000000000, base: 1.5, power: level)
            degradePrice = baseToPower(40000000000, base: 1.5, power: level - 1)
            
        case .GroundwaterPumpProduction:
            imageType = BuildingType.GroundwaterPump
            name = "Groundwater Pump".localized
            comment = "Increases water producetion by 25%".localized
            upgradePrice = baseToPower(4000000000000, base: 1.6, power: level)
            degradePrice = baseToPower(4000000000000, base: 1.6, power: level - 1)
            
        case .WaterElementMaxWater:
            imageType = BuildingType.WaterPipe
            name = "Water Element Max Water".localized
            comment = "Increases max water by 50%".localized
            upgradePrice = baseToPower(20000000000, base: 1.9, power: level)
            degradePrice = baseToPower(20000000000, base: 1.9, power: level - 1)
            
        case .GeneratorMaxWater:
            imageType = BuildingType.SmallGenerator
            name = "Generator Max Water".localized
            comment = "Increases max water by 25%".localized
            upgradePrice = baseToPower(10000000000, base: 1.45, power: level)
            degradePrice = baseToPower(10000000000, base: 1.45, power: level - 1)
            
        case .OfficeSellEnergy:
            imageType = BuildingType.SmallOffice
            name = "Office Sell Amount".localized
            comment = "Increases energy sell amount by 50%".localized
            upgradePrice = baseToPower(100, base: 2.1, power: level)
            degradePrice = baseToPower(100, base: 2.1, power: level - 1)
            
        case .BankEffectiveness:
            imageType = BuildingType.Bank
            name = "Bank Effectiveness".localized
            comment = "Increases bank effectiveness by 10%".localized
            upgradePrice = baseToPower(10000000000000, base: 2, power: level)
            degradePrice = baseToPower(10000000000000, base: 2, power: level - 1)
            
        case .ResearchCenterEffectiveness:
            imageType = BuildingType.ResearchCenter
            name = "Research Center Effectiveness".localized
            comment = "Increases research producetion by 25%".localized
            upgradePrice = baseToPower(100, base: 2.5, power: level)
            degradePrice = baseToPower(100, base: 2.5, power: level - 1)
            
        case .LibraryEffectiveness:
            imageType = BuildingType.Library
            name = "Library Effectiveness".localized
            comment = "Increases library effectiveness by 10%".localized
            upgradePrice = baseToPower(400000000000, base: 2, power: level)
            degradePrice = baseToPower(400000000000, base: 2, power: level - 1)
        
        default:
            imageType = BuildingType.WindTurbine
            name = "\(upgradeType)"
            comment = "error"
            upgradePrice = 1
            degradePrice = 1
        }
    
        // image
        let gap = (size.height - tilesScaleSize.height) / 2
        let image = BuildingData(buildType: imageType).image("image")
        image.position = CGPoint(x: size.height / 2, y: gap + image.size.width / 2)
        addChild(image)
        
        // name
        let upgradeName = SKLabelNode(fontNamed: "SanFranciscoRounded-Black".localized)
        upgradeName.name = "upgradeName"
        upgradeName.text = name
        upgradeName.fontColor = SKColor.whiteColor()
        upgradeName.fontSize = image.size.height * 2 / 5
        upgradeName.horizontalAlignmentMode = .Left
        upgradeName.verticalAlignmentMode = .Top
        upgradeName.position = CGPoint(x: image.size.width + gap * 2, y: size.height - gap)
        addChild(upgradeName)

        // comment
        let commentLabel = SKLabelNode(fontNamed: "SanFranciscoRounded-Black".localized)
        commentLabel.name = "commentLabel"
        commentLabel.text = comment
        commentLabel.fontColor = SKColor.lightGrayColor()
        commentLabel.fontSize = (image.size.height - upgradeName.fontSize * 1.2) / 2
        commentLabel.horizontalAlignmentMode = .Left
        commentLabel.verticalAlignmentMode = .Bottom
        commentLabel.position = CGPoint(x: image.size.width + gap * 2, y: (image.size.height - upgradeName.fontSize) / 2 + gap)
        addChild(commentLabel)

        // level and money label
        let infoLabel = SKLabelNode(fontNamed: "SanFranciscoRounded-Black".localized)
        infoLabel.name = "levelLabel"
        infoLabel.text = "Lv.     Upgrade Price:".localized
        infoLabel.fontColor = SKColor.lightGrayColor()
        infoLabel.fontSize = (image.size.height - upgradeName.fontSize * 1.2) / 2
        infoLabel.horizontalAlignmentMode = .Left
        infoLabel.verticalAlignmentMode = .Bottom
        infoLabel.position = CGPoint(x: image.size.width + gap * 2, y: gap)
        addChild(infoLabel)

        // level
        let levelLabel = SKLabelNode(fontNamed: "SanFranciscoRounded-Black".localized)
        levelLabel.name = "levelValue"
        levelLabel.text = "\(level + 1)"
        levelLabel.fontColor = colorBlue1
        levelLabel.fontSize = infoLabel.fontSize
        levelLabel.horizontalAlignmentMode = .Left
        levelLabel.verticalAlignmentMode = .Bottom
        levelLabel.position = CGPoint(x: 22 * framescale, y: 3 * framescale)
        infoLabel.addChild(levelLabel)
    
        // price
        let priceLabel = SKLabelNode(fontNamed: "SanFranciscoRounded-Black".localized)
        priceLabel.name = "priceLabel"
        priceLabel.text = "\(numberToString(upgradePrice, isInt: true)) $"
        priceLabel.fontColor = colorMoney
        priceLabel.fontSize = infoLabel.fontSize
        priceLabel.horizontalAlignmentMode = .Left
        priceLabel.verticalAlignmentMode = .Bottom
        priceLabel.position = CGPoint(x: infoLabel.frame.width, y: 0)
        infoLabel.addChild(priceLabel)
  
        // Upgrade Button
        let color = (money > upgradePrice ? colorBlue2 : SKColor.lightGrayColor())
        buttonUpgrade = SKShapeNode(rectOfSize: CGSizeMake(tilesScaleSize.width, tilesScaleSize.height), cornerRadius: 10 * framescale)
        buttonUpgrade.name = (money > upgradePrice ? "Upgrade" : "NoMoney")
        buttonUpgrade.fillColor = color
        buttonUpgrade.strokeColor = color
        buttonUpgrade.position = CGPoint(x: size.width - gap - tilesScaleSize.width / 2, y: size.height / 2)
        let levelupImage = SKSpriteNode(texture: iconAtlas.textureNamed("levelup"))
        levelupImage.setScale(0.7 * framescale)
        buttonUpgrade.addChild(levelupImage)
        addChild(buttonUpgrade)

        // Degrade Button
        buttonDegrade = SKShapeNode(rectOfSize: CGSizeMake(tilesScaleSize.width, tilesScaleSize.height), cornerRadius: 10 * framescale)
        buttonDegrade.name = "Degrade"
        buttonDegrade.fillColor = colorBlue2
        buttonDegrade.strokeColor = colorBlue2
        buttonDegrade.position = CGPoint(x: size.width - gap * 2 - tilesScaleSize.width * 3 / 2, y: size.height / 2)
        let leveldownImage = SKSpriteNode(texture: iconAtlas.textureNamed("levelup"))
        leveldownImage.setScale(0.7 * framescale)
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
            
            // Top
            let line = SKShapeNode(rectOfSize: CGSizeMake(frame.size.width * 0.9, 3 * framescale))
            line.name = "line"
            line.lineWidth = 0
            line.fillColor = SKColor.whiteColor()
            line.position = CGPoint(x: size.width / 2, y: frame.size.height - unitHeight)
            addChild(line)

            let TitleBackground = SKSpriteNode(texture: iconAtlas.textureNamed("upgrade"))
            TitleBackground.name = "title background"
            TitleBackground.setScale(framescale)
            TitleBackground.alpha = 0.3
            TitleBackground.position = CGPoint(x: frame.width / 2, y: frame.height - unitHeight * 0.5)
            addChild(TitleBackground)

            let upgradeTitle = SKLabelNode(fontNamed: "SanFranciscoRounded-Black".localized)
            upgradeTitle.name = "upgrade title"
            upgradeTitle.text = "Upgrade".localized
            upgradeTitle.fontSize = 40 * framescale
            upgradeTitle.position = CGPoint(x: frame.width / 2, y: frame.height - unitHeight * 0.8)
            addChild(upgradeTitle)

            let moneyIcon = SKSpriteNode(texture: iconAtlas.textureNamed("coint"))
            moneyIcon.name = "research icon"
            moneyIcon.size = CGSizeMake(unitHeight * 0.2, unitHeight * 0.2)
            moneyIcon.position = CGPoint(x: frame.size.width * 0.05, y: frame.height - unitHeight * 0.9)
            moneyIcon.anchorPoint = CGPoint(x: 0, y: 0)
            addChild(moneyIcon)
            
            moneyLabel = SKLabelNode(fontNamed: "SanFranciscoRounded-Black".localized)
            moneyLabel.name = "top label"
            moneyLabel.fontSize = unitHeight * 0.2
            moneyLabel.fontColor = colorMoney
            moneyLabel.text = numberToString(money, isInt: true)
            moneyLabel.horizontalAlignmentMode = .Left
            moneyLabel.verticalAlignmentMode = .Bottom
            moneyLabel.position = CGPoint(x: moneyIcon.position.x + unitHeight * 0.2, y: frame.height - unitHeight * 0.9)
            addChild(moneyLabel)
            
            itemLabel = SKLabelNode(fontNamed: "SanFranciscoRounded-Black".localized)
            itemLabel.name = "item label"
            itemLabel.fontSize = unitHeight * 0.2
            itemLabel.fontColor = colorMoney
            itemLabel.text = "1 / 32"
            itemLabel.horizontalAlignmentMode = .Right
            itemLabel.verticalAlignmentMode = .Bottom
            itemLabel.position = CGPoint(x: frame.size.width * 0.95, y: frame.size.height - unitHeight * 0.9)
            addChild(itemLabel)
            
            // Center
            for x in 0..<4 {
                let field = SKSpriteNode(color: colorBlue3, size: CGSizeMake(frame.width, unitHeight))
                field.name = "field\(x)"
                field.anchorPoint = CGPoint(x: 0, y: 0)
                field.position = CGPoint(x: 0, y: (2 * CGFloat(x) + 1) * unitHeight)
                addChild(field)
            }
            upgradeLayer = SKSpriteNode(color: SKColor.clearColor(), size: CGSizeMake(frame.size.width * 4, frame.size.height - unitHeight * 2))
            upgradeLayer.name = "upgradeLayer"
            upgradeLayer.anchorPoint = CGPoint(x: 0, y: 0)
            upgradeLayer.position = CGPoint(x: 0, y: unitHeight)
            addChild(upgradeLayer)
            
            // Bottom
            let bottomNode = SKSpriteNode(color: colorBlue4, size: CGSizeMake(frame.width, unitHeight))
            bottomNode.name = "bottomNode"
            bottomNode.position = CGPoint(x: frame.width / 2, y: unitHeight / 2)
            let bottomLine = SKShapeNode(rectOfSize: CGSizeMake(frame.width, 1 * framescale))
            bottomLine.name = "line"
            bottomLine.lineWidth = 0
            bottomLine.fillColor = SKColor.whiteColor()
            bottomLine.position = CGPoint(x: 0, y: unitHeight / 2)
            bottomNode.addChild(bottomLine)
            addChild(bottomNode)
            
            backButton = SKSpriteNode(color: SKColor.clearColor(), size: CGSizeMake(frame.width / 3, unitHeight))
            backButton.name = "back button"
            backButton.anchorPoint = CGPoint(x: 0.5, y: 0)
            backButton.position = CGPoint(x: frame.size.width / 2, y: 0)
            let backLabel = SKLabelNode(fontNamed: "SanFranciscoRounded-Black".localized)
            backLabel.name = "backLabel"
            backLabel.text = "Back".localized
            backLabel.fontSize = 40 * framescale
            backLabel.verticalAlignmentMode = .Center
            backLabel.position = CGPoint(x: 0, y: unitHeight / 2)
            backButton.addChild(backLabel)
            let arrow_down = SKSpriteNode(texture: iconAtlas.textureNamed("arrow_down"))
            arrow_down.name = "arrow_down"
            arrow_down.size = CGSizeMake(unitHeight * 0.22, unitHeight * 0.22)
            arrow_down.anchorPoint = CGPoint(x: 0.5, y: 1)
            arrow_down.position = CGPoint(x: 0, y: unitHeight * 0.3)
            backButton.addChild(arrow_down)
            addChild(backButton)
            
            nextPage = SKSpriteNode(color: SKColor.clearColor(), size: CGSizeMake(frame.width / 3, unitHeight))
            nextPage.name = "NextPage"
            nextPage.anchorPoint = CGPoint(x: 1, y: 0.5)
            nextPage.position = CGPoint(x: frame.width, y: unitHeight / 2)
            let arrow_right = SKSpriteNode(texture: iconAtlas.textureNamed("arrow_right"))
            arrow_right.name = "arrow_right"
            arrow_right.setScale(0.6 * framescale)
            arrow_right.anchorPoint = CGPoint(x: 1, y: 0.5)
            arrow_right.position = CGPoint(x: -20 * framescale, y: 0)
            nextPage.addChild(arrow_right)
            let nextLabel = SKLabelNode(fontNamed: "SanFranciscoRounded-Black".localized)
            nextLabel.name = "nextLabel"
            nextLabel.text = "Next".localized
            nextLabel.fontSize = 30 * framescale
            nextLabel.verticalAlignmentMode = .Center
            nextLabel.horizontalAlignmentMode = .Right
            nextLabel.position = CGPoint(x: -18 * framescale - arrow_right.frame.width, y: 0)
            nextPage.addChild(nextLabel)
            addChild(nextPage)
            
            prevPage = SKSpriteNode(color: SKColor.clearColor(), size: CGSizeMake(frame.width / 3, unitHeight))
            prevPage.name = "PreviousPage"
            prevPage.anchorPoint = CGPoint(x: 0, y: 0.5)
            prevPage.position = CGPoint(x: 0, y: unitHeight / 2)
            let arrow_left = SKSpriteNode(texture: iconAtlas.textureNamed("arrow_left"))
            arrow_left.name = "arrow_left"
            arrow_left.setScale(0.6 * framescale)
            arrow_left.anchorPoint = CGPoint(x: 0, y: 0.5)
            arrow_left.position = CGPoint(x: 20 * framescale, y: 0)
            prevPage.addChild(arrow_left)
            let prevLabel = SKLabelNode(fontNamed: "SanFranciscoRounded-Black".localized)
            prevLabel.name = "PreviousLabel"
            prevLabel.text = "Previous".localized
            prevLabel.fontSize = 30 * framescale
            prevLabel.verticalAlignmentMode = .Center
            prevLabel.horizontalAlignmentMode = .Left
            prevLabel.position = CGPoint(x: 18 * framescale + arrow_right.frame.width, y: 0)
            prevPage.addChild(prevLabel)
            addChild(prevPage)
            
            contentCreated = true
            
            // remove first load delay
            print("load 3")
            self.view?.presentScene(islandScene)
        }
        
        // update element
        updateElement()
        // hide AD
        NSNotificationCenter.defaultCenter().postNotificationName("hideAd", object: nil)
        
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
            upgradeElements.append(upgradeElement)
            upgradeLayer.addChild(upgradeElement)
        }
        
        // Calculate NowPage and MaxPage
        if elements.count <= 8 {
            nowPage = 1
            upgradeLayer.runAction((SKAction.moveToX(0, duration: 0)))
        }
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
                if node == backButton {
                    if !isSoundMute{ runAction(soundTap) }
                    self.view?.presentScene(islandScene, transition: door_reveal)
                }
                if node == nextPage {
                    nowPage += 1
                    upgradeLayer.runAction((SKAction.moveToX(-frame.size.width * CGFloat(nowPage - 1), duration: 0.2)))
                    if !isSoundMute{ runAction(soundSlide) }
                }
                if node == prevPage {
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
                    let price = element.degradePrice
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
        moneyLabel.text = numberToString(money, isInt: true)
        for upgradeElement in upgradeElements {
            upgradeElement.checkUpgradeAndDegrade()
        }
    }
}
