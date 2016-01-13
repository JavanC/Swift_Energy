//
//  ResearchScene.swift
//  Energy
//
//  Created by javan.chen on 2015/12/28.
//  Copyright © 2015年 Javan chen. All rights reserved.
//

import SpriteKit

class ResearchElement: SKNode {
    var background: SKSpriteNode!
    var buttonUpgrade: SKSpriteNode!
    var researchType: ResearchType!
    var researchPrice: Int!
    var researchDone: Bool = false
    
    init(researchType: ResearchType, size: CGSize) {
        super.init()
        self.researchType = researchType
        
        // background
        background = SKSpriteNode(color: colorBlue4, size: size)
        background.name = "UpgradeElementBackground"
        background.anchorPoint = CGPoint(x: 0, y: 0)
        addChild(background)
        
        // Find information
        var imageType: BuildingType!
        var text1: String!
        var text2: String!
        let level = Int(researchLevel[researchType]!)
        switch researchType {
        case .WindTurbineRebuild:
            imageType = BuildingType.WindTurbine
            text1 = "Wind Turbine Rebuild"
            text2 = "test123123"
            researchPrice = 1
            if level >= 1 { researchDone = true }
            
        case .CoalBurnerResearch:
            imageType = BuildingType.CoalBurner
            text1 = "Coal Burner"
            text2 = "test123123"
            researchPrice = 10
            if level >= 1 { researchDone = true }
            
        case .CoalBurnerRebuild:
            imageType = BuildingType.CoalBurner
            text1 = "Coal Burner Rebuild"
            text2 = "test123123"
            researchPrice = 1
            if level >= 1 { researchDone = true }
            
        case .SmallGeneratorResearch:
            imageType = BuildingType.SmallGenerator
            text1 = "Small Generator"
            text2 = "test123123"
            researchPrice = 1
            if level >= 1 { researchDone = true }
            
        case .SmallOfficeResearch:
            imageType = BuildingType.SmallOffice
            text1 = "Small Office"
            text2 = "test123123"
            researchPrice = 1
            if level >= 1 { researchDone = true }
            
        default:
            imageType = BuildingType.WindTurbine
            text1 = "\(researchType)"
            text2 = "test123123"
            researchPrice = 1
            if level >= 1 { researchDone = true }
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
        label3.text = "Need Research : \(researchPrice)"
        label3.fontSize = labelsize
        label3.horizontalAlignmentMode = .Left
        label3.position = CGPoint(x: gap * 2 + image.size.width, y: gap)
        addChild(label3)
        // Upgrade Button
        if !researchDone {
            let color = (money > researchPrice ? SKColor.greenColor() : SKColor.redColor())
            buttonUpgrade = SKSpriteNode(color: color, size: tilesScaleSize)
            buttonUpgrade.name = (money > researchPrice ? "Upgrade" : "NoMoney")
            buttonUpgrade.position = CGPoint(x: size.width - gap - tilesScaleSize.width / 2, y: size.height / 2)
            addChild(buttonUpgrade)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class ResearchScene: SKScene {
    
    var contentCreated: Bool = false
    var backButton: SKLabelNode!
    var nowPage: Int = 1
    var maxPage: Int = 1
    var nextPage: SKSpriteNode!
    var prevPage: SKSpriteNode!
    var topLabel: SKLabelNode!
    
    var researchdeLayer: SKSpriteNode!
    
    override func didMoveToView(view: SKView) {
        if !contentCreated {
            
            self.backgroundColor = colorBlue4
            
            
            
            topLabel = SKLabelNode(fontNamed: "Verdana-Bold")
            topLabel.fontSize = 30
            topLabel.text = "You have \(research) research can be used!"
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
            researchdeLayer = SKSpriteNode(color: colorBlue4, size: CGSizeMake(frame.size.width * 4, frame.size.height - 200))
            researchdeLayer.name = "ResearchLayer"
            researchdeLayer.anchorPoint = CGPoint(x: 0, y: 0)
            researchdeLayer.position = CGPoint(x: 0, y: 100)
            addChild(researchdeLayer)
            updateElement()
            
            contentCreated = true
        }
    }
    
    func updateElement() {
        researchdeLayer.removeAllChildren()
        // Caculae Position
        var positions = [CGPoint]()
        let gap:CGFloat = 20
        let num:CGFloat = 8
        let elementsize = CGSizeMake(frame.size.width - gap * 2, (researchdeLayer.size.height - gap) / num - gap)
        for x in 0..<5 {
            for y in 0..<Int(num) {
                positions.append(CGPoint(x: gap + frame.size.width * CGFloat(x), y: researchdeLayer.size.height - (elementsize.height + gap) * CGFloat(y + 1)))
            }
        }
        
        // Check Eleents
        var elements = [ResearchType]()
        elements += [.WindTurbineResearch, .ResearchCenterResearch]
        if researchLevel[.ResearchCenterResearch] == 1   { elements += [.WindTurbineRebuild, .SmallOfficeResearch] }
        if researchLevel[.SmallOfficeResearch] == 1      { elements += [.BatteryResearch, .SolarCellResearch] }
        if researchLevel[.SolarCellResearch] == 1        { elements += [.SolarCellRebuild, .SmallGeneratorResearch] }
        if researchLevel[.SmallGeneratorResearch] == 1   { elements += [.IsolationResearch, .CoalBurnerResearch] }
        if researchLevel[.CoalBurnerResearch] == 1       { elements += [.CoalBurnerRebuild, .HeatExchangerResearch, .BoilerHouseResearch] }
        if researchLevel[.BoilerHouseResearch] == 1      { elements += [.WaveCellResearch] }
        if researchLevel[.WaveCellResearch] == 1         { elements += [.WaveCellRebuild, .AdvancedResearchCenterResearch,
                                                                       .MediumOfficeResearch, .GasBurnerResearch] }
        if researchLevel[.GasBurnerResearch] == 1        { elements += [.GasBurnerRebuild, .HeatSinkResearch,
                                                                       .MediumGeneratorResearch, .LargeBoilerHouseResearch] }
        if researchLevel[.LargeBoilerHouseResearch] == 1 { elements += [.NuclearCellResearch] }
        if researchLevel[.NuclearCellResearch] == 1      { elements += [.NuclearCellRebuild, .WaterPumpResearch, .WaterPipeResearch, .LargeOfficeResearch] }
        if researchLevel[.LargeOfficeResearch] == 1      { elements += [.LibraryResearch, .GroundwaterPumpResearch, .FusionCellResearch] }
        if researchLevel[.FusionCellResearch] == 1       { elements += [.FusionCellRebuild, .LargeGeneratorResearch] }
        if researchLevel[.LargeGeneratorResearch] == 1   { elements += [.BankResearch, .HeatInletResearch, .HeatOutletResearch] }
        
        // Add Element
        for count in 0..<elements.count {
            let element = ResearchElement(researchType: elements[count], size: elementsize)
            element.position = positions[count]
            researchdeLayer.addChild(element)
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
                    researchdeLayer.runAction((SKAction.moveToX(-frame.size.width * CGFloat(nowPage - 1), duration: 0.2)))
                }
                if prevPage.containsPoint(location) {
                    nowPage--
                    researchdeLayer.runAction((SKAction.moveToX(-frame.size.width * CGFloat(nowPage - 1), duration: 0.2)))
                }
                if node.name == "Upgrade" {
                    let element = (node.parent as! ResearchElement)
                    let price = element.researchPrice
                    let type = element.researchType
                    research -= price
                    researchLevel[type]!++
                    for count in 0..<maps.count {
                        maps[count].reloadMap()
                    }
                }
            }
        }
    }
    
    override func update(currentTime: CFTimeInterval) {
        prevPage.hidden = (nowPage == 1 ? true : false)
        nextPage.hidden = (nowPage == maxPage ? true : false)
        topLabel.text = "You have \(research) research can be used!"
        updateElement()
    }
}
