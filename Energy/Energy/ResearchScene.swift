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
        var name: String!
        var comment: String!
        let level = Int(researchLevel[researchType]!)
        switch researchType {
        case .WindTurbineResearch:
            imageType = BuildingType.WindTurbine
            name = "Wind Turbine"
            comment = "Open wind turbine technology."
            researchPrice = 1
            if level >= 1 { researchDone = true }
            
        case .WindTurbineRebuild:
            imageType = BuildingType.WindTurbine
            name = "Wind Turbine Manager"
            comment = "Wind Turbine are automatically replaced."
            researchPrice = 1
            if level >= 1 { researchDone = true }
            
        case .SolarCellResearch: break
        case .SolarCellRebuild: break
            
            
        case .CoalBurnerResearch:
            imageType = BuildingType.CoalBurner
            name = "Coal Burner"
            comment = "test123123"
            researchPrice = 10
            if level >= 1 { researchDone = true }
            
        case .CoalBurnerRebuild:
            imageType = BuildingType.CoalBurner
            name = "Coal Burner Rebuild"
            comment = "test123123"
            researchPrice = 1
            if level >= 1 { researchDone = true }
            
        case .WaveCellResearch: break
        case .WaveCellRebuild: break
        case .FusionCellResearch: break
        case .FusionCellRebuild:break
        case .NuclearCellResearch:break
        case .NuclearCellRebuild:break
        case .GasBurnerResearch:break
        case .GasBurnerRebuild:break
            
            
        case .SmallGeneratorResearch:
            imageType = BuildingType.SmallGenerator
            name = "Small Generator"
            comment = "test123123"
            researchPrice = 1
            if level >= 1 { researchDone = true }
            
        case .MediumGeneratorResearch: break
        case .LargeGeneratorResearch: break
        case .BoilerHouseResearch: break
        case .LargeBoilerHouseResearch: break
        case .IsolationResearch: break
        case .BatteryResearch: break
        case .HeatExchangerResearch:break
        case .HeatSinkResearch:break
        case .HeatInletResearch:break
        case .HeatOutletResearch: break
        case .WaterPumpResearch:break
        case .GroundwaterPumpResearch:break
        case .WaterPipeResearch:break
            
        case .SmallOfficeResearch:
            imageType = BuildingType.SmallOffice
            name = "Small Office"
            comment = "test123123"
            researchPrice = 1
            if level >= 1 { researchDone = true }
            
        case .MediumOfficeResearch:break
        case .LargeOfficeResearch:break
        case .BankResearch:break
        case .ResearchCenterResearch: break
        case .AdvancedResearchCenterResearch: break
        case .LibraryResearch: break
            
        default:
            imageType = BuildingType.WindTurbine
            name = "\(researchType)"
            comment = "test123123"
            researchPrice = 1
            if level >= 1 { researchDone = true }
        }
        
        // image
        let gap = (size.height - tilesScaleSize.height) / 2
        let image = BuildingData(buildType: imageType).image("image")
        image.position = CGPoint(x: size.height / 2, y: gap + image.size.width / 2)
        addChild(image)
        
        // name
        let researchName = SKLabelNode(fontNamed: "SanFranciscoDisplay-Semibold")
        researchName.name = "researchName"
        researchName.text = name
        researchName.fontColor = SKColor.whiteColor()
        researchName.fontSize = image.size.height * 2 / 5
        researchName.horizontalAlignmentMode = .Left
        researchName.verticalAlignmentMode = .Top
        researchName.position = CGPoint(x: image.size.width + gap * 2, y: size.height - gap)
        addChild(researchName)
        
        // comment
        let commentLabel = SKLabelNode(fontNamed: "SanFranciscoDisplay-Semibold")
        commentLabel.name = "commentLabel"
        commentLabel.text = comment
        commentLabel.fontColor = SKColor.lightGrayColor()
        commentLabel.fontSize = (image.size.height - researchName.fontSize * 1.2) / 2
        commentLabel.horizontalAlignmentMode = .Left
        commentLabel.verticalAlignmentMode = .Bottom
        commentLabel.position = CGPoint(x: image.size.width + gap * 2, y: (image.size.height - researchName.fontSize) / 2 + gap)
        addChild(commentLabel)
        
        // research
        let researchLabel = SKLabelNode(fontNamed: "SanFranciscoDisplay-Semibold")
        researchLabel.name = "researchLabel"
        researchLabel.text = "Research:"
        researchLabel.fontColor = SKColor.lightGrayColor()
        researchLabel.fontSize = (image.size.height - researchName.fontSize * 1.2) / 2
        researchLabel.horizontalAlignmentMode = .Left
        researchLabel.verticalAlignmentMode = .Bottom
        researchLabel.position = CGPoint(x: image.size.width + gap * 2, y: gap)
        addChild(researchLabel)
        
        // price
        let priceLabel = SKLabelNode(fontNamed: "SanFranciscoDisplay-Semibold")
        priceLabel.name = "priceLabel"
        priceLabel.text = "\(researchPrice)"
        priceLabel.fontColor = colorResearch
        priceLabel.fontSize = (image.size.height - researchName.fontSize * 1.2) / 2
        priceLabel.horizontalAlignmentMode = .Left
        priceLabel.verticalAlignmentMode = .Bottom
        priceLabel.position = CGPoint(x: image.size.width + gap * 2 + researchLabel.frame.width, y: gap)
        addChild(priceLabel)
        
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
                element.childNodeWithName("researchLabel")?.hidden = true
                element.childNodeWithName("priceLabel")?.hidden = true
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
