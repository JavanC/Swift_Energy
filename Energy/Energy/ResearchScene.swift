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
    var backButton: SKSpriteNode!
    var nowPage: Int = 1
    var maxPage: Int = 1
    var nextPage: SKSpriteNode!
    var prevPage: SKSpriteNode!
    var researchLabel: SKLabelNode!
    var itemLabel: SKLabelNode!
    
    var researchdeLayer: SKSpriteNode!
    
    override func didMoveToView(view: SKView) {
        if !contentCreated {
            
            self.backgroundColor = colorBlue4
            
            let unitHeight = size.height / 10
            let topCenter = CGPoint(x: size.width / 2, y: frame.size.height - unitHeight / 2)
            
            let line = SKShapeNode(rectOfSize: CGSizeMake(frame.size.width * 0.9, 2 * framescale))
            line.name = "line"
            line.position = CGPoint(x: size.width / 2, y: frame.size.height - unitHeight)
            addChild(line)
            
            let researchImage = SKSpriteNode(imageNamed: "Button_research")
            researchImage.name = "researchImage"
            researchImage.setScale(0.9 * framescale)
            researchImage.position = topCenter
            researchImage.runAction(SKAction.repeatActionForever(SKAction.rotateByAngle(CGFloat(M_PI_2), duration: 5)))
            addChild(researchImage)
            
            researchLabel = SKLabelNode(fontNamed: "SanFranciscoText-BoldItalic")
            researchLabel.name = "top label"
            researchLabel.fontSize = unitHeight * 0.2
            researchLabel.fontColor = colorResearch
            researchLabel.text = "\(research)"
            researchLabel.horizontalAlignmentMode = .Left
            researchLabel.verticalAlignmentMode = .Bottom
            researchLabel.position = CGPoint(x: frame.size.width * 0.05, y: frame.size.height - unitHeight * 0.9)
            addChild(researchLabel)
            
            itemLabel = SKLabelNode(fontNamed: "SanFranciscoText-BoldItalic")
            itemLabel.name = "item label"
            itemLabel.fontSize = unitHeight * 0.2
            itemLabel.fontColor = colorResearch
            itemLabel.text = "1 / 35"
            itemLabel.horizontalAlignmentMode = .Right
            itemLabel.verticalAlignmentMode = .Bottom
            itemLabel.position = CGPoint(x: frame.size.width * 0.95, y: frame.size.height - unitHeight * 0.9)
            addChild(itemLabel)
            
            backButton = SKSpriteNode(imageNamed: "down arrow")
            backButton.name = "back button"
            backButton.setScale(framescale)
            backButton.position = CGPoint(x: frame.size.width / 2, y: unitHeight / 2)
            let downAction = SKAction.sequence([SKAction.moveByX(0, y: -5, duration: 0.5), SKAction.moveByX(0, y: 5, duration: 0.5)])
            backButton.runAction(SKAction.repeatActionForever(downAction))
            addChild(backButton)
            
            nextPage = SKSpriteNode(imageNamed: "next page")
            nextPage.name = "NextPage"
            nextPage.setScale(0.8 * framescale)
            nextPage.position = CGPoint(x: frame.size.width * 0.9, y: unitHeight  / 2)
            addChild(nextPage)
            prevPage = SKSpriteNode(imageNamed: "next page")
            prevPage.name = "PrevPage"
            prevPage.setScale(0.8 * framescale)
            prevPage.position = CGPoint(x: frame.size.width * 0.1, y: unitHeight  / 2)
            prevPage.zRotation = CGFloat(M_PI)
            addChild(prevPage)
            researchdeLayer = SKSpriteNode(color: colorBlue4, size: CGSizeMake(frame.size.width * 4, frame.size.height - unitHeight * 2))
            researchdeLayer.name = "ResearchLayer"
            researchdeLayer.anchorPoint = CGPoint(x: 0, y: 0)
            researchdeLayer.position = CGPoint(x: 0, y: unitHeight)
            addChild(researchdeLayer)
            updateElement()
            
            contentCreated = true
        }
    }
    
    func updateElement() {
        researchdeLayer.removeAllChildren()
        // Caculae Position
        var positions = [CGPoint]()
        let num:CGFloat = 8
        let elementsize = CGSizeMake(frame.size.width, researchdeLayer.size.height / num)
        for x in 0..<5 {
            for y in 0..<Int(num) {
                positions.append(CGPoint(x: frame.size.width * CGFloat(x), y: researchdeLayer.size.height - elementsize.height * CGFloat(y + 1)))
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
        var researchDoneNumber = 0
        for count in 0..<elements.count {
            let element = ResearchElement(researchType: elements[count], size: elementsize)
            element.position = positions[count]
            element.background.color = (count % 2 == 0 ? colorBlue4 : colorBlue3)
            researchdeLayer.addChild(element)
            if element.researchDone {
                ++researchDoneNumber
            }
        }

        // Caculate MaxPage
        maxPage = (elements.count - 1) / 8 + 1
        
        // update item count
        itemLabel.text = "\(researchDoneNumber) / 35"
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
                    updateElement()
                }
            }
        }
    }
    
    override func update(currentTime: CFTimeInterval) {
        prevPage.hidden = (nowPage == 1 ? true : false)
        nextPage.hidden = (nowPage == maxPage ? true : false)
        researchLabel.text = "\(research)"
    }
}
