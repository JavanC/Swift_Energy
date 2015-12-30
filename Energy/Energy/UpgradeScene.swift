//
//  UpgradeScene.swift
//  Energy
//
//  Created by javan.chen on 2015/12/28.
//  Copyright © 2015年 Javan chen. All rights reserved.
//

import SpriteKit

class UpgradeElement: SKNode {
    
    var background: SKSpriteNode!
    var buttonUpgrade: SKSpriteNode!
    var buttonDegrade: SKSpriteNode!
    var upgradeType: UpgradeType!
    var upgradePrice: Int!
    
    init(upgradeType: UpgradeType, size: CGSize) {
        super.init()
        self.upgradeType = upgradeType
        
        // background
        background = SKSpriteNode(color: SKColor.grayColor(), size: size)
        background.name = "UpgradeElementBackground"
        background.anchorPoint = CGPoint(x: 0, y: 0)
        addChild(background)
        
        // Find information
        var imageType: BuildingType!
        var text1: String!
        var text2: String!
        let level = Int(upgradeLevel[upgradeType]!)
        switch upgradeType {
        case .WindTurbineEffectiveness:
            imageType = BuildingType.WindTurbine
            text1 = "Wind Lv.\(level)"
            text2 = "test123123"
            upgradePrice = 1
            
        case .CoalBurnerEffectiveness:
            imageType = BuildingType.CoalBurner
            text1 = "Fire Lv.\(level)"
            text2 = "test123123"
            upgradePrice = 10
            
        case .CoalBurnerLifetime:
            imageType = BuildingType.CoalBurner
            text1 = "Fire Lv.\(level)"
            text2 = "test123123"
            upgradePrice = 100
            
        case .OfficeSellEnergy:
            imageType = BuildingType.SmallOffice
            text1 = "Office Lv.\(level)"
            text2 = "test123123"
            upgradePrice = 1000
            
        default:
            imageType = BuildingType.WindTurbine
            text1 = "\(upgradeType) Lv.\(level)"
            text2 = "test123123"
            upgradePrice = 1000
        }
        
        // image
        let gap = (size.height - tilesScaleSize.height) / 2
        let image = BuildingData(buildType: imageType).image("image")
        image.position = CGPoint(x: size.height / 2, y: gap + image.size.width / 2)
        addChild(image)
        // label 1
        let labelgap: CGFloat = 5
        let labelsize = (image.size.height - labelgap * 2) / 3
        let label1 = SKLabelNode(fontNamed: "Verdana-Bold")
        label1.name = "label1"
        label1.text = text1
        label1.fontSize = labelsize
        label1.horizontalAlignmentMode = .Left
        label1.position = CGPoint(x: gap * 2 + image.size.width, y: gap + (labelsize + labelgap) * 2)
        addChild(label1)
        // label 2
        let label2 = SKLabelNode(fontNamed: "Verdana-Bold")
        label2.name = "label2"
        label2.text = text2
        label2.fontSize = labelsize
        label2.horizontalAlignmentMode = .Left
        label2.position = CGPoint(x: gap * 2 + image.size.width, y: gap + (labelsize + labelgap) * 1)
        addChild(label2)
        // label 3
        let label3 = SKLabelNode(fontNamed: "Verdana-Bold")
        label3.name = "label3"
        label3.text = "Need : \(upgradePrice)"
        label3.fontSize = labelsize
        label3.horizontalAlignmentMode = .Left
        label3.position = CGPoint(x: gap * 2 + image.size.width, y: gap)
        addChild(label3)
        // Upgrade Button
        buttonUpgrade = SKSpriteNode(color: (money > upgradePrice ? SKColor.greenColor() : SKColor.blackColor()), size: tilesScaleSize)
        buttonUpgrade.name = (money > upgradePrice ? "Upgrade" : "NoMoney")
        buttonUpgrade.position = CGPoint(x: size.width - gap - tilesScaleSize.width / 2, y: size.height / 2)
        addChild(buttonUpgrade)
        // Degrade Button
        if level > 1 {
            buttonDegrade = SKSpriteNode(color: SKColor.redColor(), size: tilesScaleSize)
            buttonDegrade.name = "Degrade"
            buttonDegrade.position = CGPoint(x: size.width - gap * 2 - tilesScaleSize.width * 3 / 2, y: size.height / 2)
            addChild(buttonDegrade)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class UpgradeScene: SKScene {
    
    var contentCreated: Bool = false
    var backButton: SKLabelNode!
    var nowPage: Int = 1
    var maxPage: Int = 1
    var nextPage: SKSpriteNode!
    var prevPage: SKSpriteNode!
    var topLabel: SKLabelNode!
    
    var upgradeLayer: SKSpriteNode!
    
    override func didMoveToView(view: SKView) {
        if !contentCreated {
            
            topLabel = SKLabelNode(fontNamed: "Verdana-Bold")
            topLabel.fontSize = 30
            topLabel.text = "You have \(money)$ can be used!"
            topLabel.position = CGPoint(x: frame.size.width / 2, y: frame.size.height - 50)
            addChild(topLabel)
            backButton = SKLabelNode(fontNamed: "Verdana-Bold")
            backButton.fontSize = 50
            backButton.text = "<Back>"
            backButton.position = CGPoint(x: frame.size.width / 2, y: 20)
            addChild(backButton)
            nextPage = SKSpriteNode(color: SKColor.whiteColor(), size: CGSizeMake(50, 50))
            nextPage.name = "NextPage"
            nextPage.position = CGPoint(x: size.width - nextPage.size.width / 2, y: 20 + nextPage.size.height / 2)
            addChild(nextPage)
            prevPage = SKSpriteNode(color: SKColor.whiteColor(), size: CGSizeMake(50, 50))
            prevPage.name = "PrevPage"
            prevPage.position = CGPoint(x: prevPage.size.width / 2, y: 20 + prevPage.size.height / 2)
            addChild(prevPage)
            upgradeLayer = SKSpriteNode(color: SKColor.blackColor(), size: CGSizeMake(frame.size.width * 4, frame.size.height - 200))
            upgradeLayer.name = "UpgradeLayer"
            upgradeLayer.anchorPoint = CGPoint(x: 0, y: 0)
            upgradeLayer.position = CGPoint(x: 0, y: 100)
            addChild(upgradeLayer)
            updateElement()
            
            contentCreated = true
        }
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
        var elements = [UpgradeType]()
        if reserchLevel[.SmallOfficeResearch] > 0       { elements += [.OfficeSellEnergy] }
        if reserchLevel[.BankResearch] > 0              { elements += [.BankEffectiveness] }
        if reserchLevel[.ResearchCenterResearch] > 0    { elements += [.ResearchCenter] }
        if reserchLevel[.LibraryResearch] > 0           { elements += [.LibraryEffectiveness] }
        if reserchLevel[.BoilerHouseResearch] > 0       { elements += [.BoilerHouseMaxHeat, .BoilerHouseSellAmount] }
        if reserchLevel[.SmallGeneratorResearch] > 0    { elements += [.GeneratorMaxHeat, .GeneratorEffectiveness] }
        if reserchLevel[.HeatExchangerResearch] > 0     { elements += [.HeatExchangerMaxHeat] }
        if reserchLevel[.HeatSinkResearch] > 0          { elements += [.HeatSinkMaxHeat] }
        if reserchLevel[.BatteryResearch] > 0           { elements += [.EnergyBatterySize] }
        if reserchLevel[.IsolationResearch] > 0         { elements += [.IsolationEffectiveness] }
        if reserchLevel[.WaterPumpResearch] > 0         { elements += [.WaterPumpProduction, .WaterElementMaxWater, .GeneratorMaxWater] }
        if reserchLevel[.GroundwaterPumpResearch] > 0   { elements += [.GroundwaterPumpProduction] }
        if reserchLevel[.HeatInletResearch] > 0         { elements += [.HeatInletOutletMaxHeat, .HeatInletOutletMaxHeat] }
        if reserchLevel[.FusionCellResearch] > 0        { elements += [.FusionCellEffectiveness, .FusionCellLifetime] }
        if reserchLevel[.NuclearCellResearch] > 0       { elements += [.NuclearCellEffectiveness, .NuclearCellLifetime] }
        if reserchLevel[.GasBurnerResearch] > 0         { elements += [.GasBurnerEffectiveness, .GasBurnerLifetime] }
        if reserchLevel[.WaveCellResearch] > 0          { elements += [.WaveCellEffectiveness, .WaveCellLifetime] }
        if reserchLevel[.CoalBurnerResearch] > 0        { elements += [.CoalBurnerEffectiveness, .CoalBurnerLifetime] }
        if reserchLevel[.SolarCellResearch] > 0         { elements += [.SolarCellEffectiveness, .SolarCellLifetime] }
        if reserchLevel[.WindTurbineResearch] > 0       { elements += [.WindTurbineEffectiveness, .WindTurbineLifetime] }
        
        // Add Element
        for count in 0..<elements.count {
            let element = UpgradeElement(upgradeType: elements[count], size: elementsize)
            element.position = positions[count]
            upgradeLayer.addChild(element)
        }
        
        // Caculate MaxPage
        maxPage = (elements.count - 1) / 8 + 1
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
                }
                if node.name == "Degrade" {
                    let element = (node.parent as! UpgradeElement)
                    let price = element.upgradePrice
                    let type = element.upgradeType
                    money += price
                    upgradeLevel[type]!--
                }
            }
        }
    }
    
    override func update(currentTime: CFTimeInterval) {
        prevPage.hidden = (nowPage == 1 ? true : false)
        nextPage.hidden = (nowPage == maxPage ? true : false)
        topLabel.text = "You have \(money)$ can be used!"
        updateElement()
    }
}