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
    var buttonUpgrade: SKShapeNode!
    var researchType: ResearchType!
    var researchPrice: Double!
    var researchDone: Bool = false
    
    init(researchType: ResearchType, size: CGSize) {
        super.init()
        self.researchType = researchType
        
        // background
        background = SKSpriteNode(color: colorBlue4, size: size)
        background.name = "researchElementBackground"
        background.anchorPoint = CGPoint(x: 0, y: 0)
        addChild(background)
        
        // Find information
        var imageType: BuildingType!
        var name: String!
        var comment: String!
        let level = Int(researchLevel[researchType]!)
        if level >= 1 { researchDone = true }
        switch researchType {
        case .WindTurbineResearch:
            imageType = BuildingType.WindTurbine
            name = "Wind Turbine"
            comment = "Open Wind turbine technology."
            researchPrice = 100
            
        case .WindTurbineRebuild:
            imageType = BuildingType.WindTurbine
            name = "Wind Turbine Manager"
            comment = "Wind Turbine are automatically replaced."
            researchPrice = 500
            
        case .SolarCellResearch:
            imageType = BuildingType.SolarCell
            name = "Solar Plant"
            comment = "Open Solar Plant technology."
            researchPrice = 2000

        case .SolarCellRebuild:
            imageType = BuildingType.SolarCell
            name = "Solar Manager"
            comment = "Solar Plant are automatically replaced."
            researchPrice = 4000
            
        case .CoalBurnerResearch:
            imageType = BuildingType.CoalBurner
            name = "Coal-Fired Plant"
            comment = "Open Coal-Fired technology."
            researchPrice = 50000
            
        case .CoalBurnerRebuild:
            imageType = BuildingType.CoalBurner
            name = "Coal-Fired Manager"
            comment = "Coal Coal-Fired are automatically replaced."
            researchPrice = 100000
            
        case .WaveCellResearch:
            imageType = BuildingType.WaveCell
            name = "Wave Energy"
            comment = "Open Wave Energy technology."
            researchPrice = 500000
            
        case .WaveCellRebuild:
            imageType = BuildingType.WaveCell
            name = "Wave Energy Manager"
            comment = "Wave Energy are automatically replaced."
            researchPrice = 1000000
            
        case .GasBurnerResearch:
            imageType = BuildingType.GasBurner
            name = "Gas-Fired Plant"
            comment = "Open Gas-Fired Plant technology."
            researchPrice = 3000000
            
        case .GasBurnerRebuild:
            imageType = BuildingType.GasBurner
            name = "Gas-Fired Manager"
            comment = "Gas-Fired are automatically replaced."
            researchPrice = 6000000
            
        case .NuclearCellResearch:
            imageType = BuildingType.NuclearCell
            name = "Nuclear Plant"
            comment = "Open Nuclear Plant technology."
            researchPrice = 100000000
            
        case .NuclearCellRebuild:
            imageType = BuildingType.NuclearCell
            name = "Nuclear Manager"
            comment = "Nuclear are automatically replaced."
            researchPrice = 200000000
            
        case .FusionCellResearch:
            imageType = BuildingType.FusionCell
            name = "Fusion Plant"
            comment = "Open Fusion Plant technology."
            researchPrice = 2000000000
            
        case .FusionCellRebuild:
            imageType = BuildingType.FusionCell
            name = "Fusion Manager"
            comment = "Fusion are automatically replaced."
            researchPrice = 4000000000
            
        case .SmallGeneratorResearch:
            imageType = BuildingType.SmallGenerator
            name = "Small Generator"
            comment = "Open Small Generator technology."
            researchPrice = 2000
            
        case .MediumGeneratorResearch:
            imageType = BuildingType.MediumGenerator
            name = "Medium Generator"
            comment = "Open Medium Generator technology."
            researchPrice = 4000000
            
        case .LargeGeneratorResearch:
            imageType = BuildingType.LargeGenerator
            name = "Large Generator"
            comment = "Open Large Generator technology."
            researchPrice = 4000000000
            
        case .BoilerHouseResearch:
            imageType = BuildingType.BoilerHouse
            name = "Boiler House"
            comment = "Open Boiler House technology."
            researchPrice = 80000
            
        case .LargeBoilerHouseResearch:
            imageType = BuildingType.LargeBoilerHouse
            name = "Large Boiler House"
            comment = "Open Large Boiler House technology."
            researchPrice = 10000000
            
        case .IsolationResearch:
            imageType = BuildingType.Isolation
            name = "Isolation"
            comment = "Open Isolation technology."
            researchPrice = 1000
            
        case .BatteryResearch:
            imageType = BuildingType.Battery
            name = "Battery"
            comment = "Open Battery technology."
            researchPrice = 800
            
        case .HeatExchangerResearch:
            imageType = BuildingType.HeatExchanger
            name = "Heat Exchanger"
            comment = "Open Heat Exchanger technology."
            researchPrice = 20000
            
        case .HeatSinkResearch:
            imageType = BuildingType.HeatSink
            name = "Heat Sink"
            comment = "Open Heat Sink technology."
            researchPrice = 2000000
            
        case .HeatInletResearch:
            imageType = BuildingType.HeatInlet
            name = "Heat Inlet"
            comment = "Open Heat Inlet technology."
            researchPrice = 5000000000
            
        case .HeatOutletResearch:
            imageType = BuildingType.HeatOutlet
            name = "Heat Outlet"
            comment = "Open Heat Outlet technology."
            researchPrice = 5000000000

        case .WaterPumpResearch:
            imageType = BuildingType.WaterPump
            name = "Water Pump"
            comment = "Open Water Pump technology."
            researchPrice = 50000000
            
        case .GroundwaterPumpResearch:
            imageType = BuildingType.GroundwaterPump
            name = "Groundwater Pump"
            comment = "Open Groundwater Pump technology."
            researchPrice = 500000000
            
        case .WaterPipeResearch:
            imageType = BuildingType.WaterPipe
            name = "Water Pipe"
            comment = "Open Water Pipe technology."
            researchPrice = 20000000
            
        case .SmallOfficeResearch:
            imageType = BuildingType.SmallOffice
            name = "Small Office"
            comment = "Open Small Office technology."
            researchPrice = 500
            
        case .MediumOfficeResearch:
            imageType = BuildingType.MediumOffice
            name = "Medium Office"
            comment = "Open Medium Office technology."
            researchPrice = 150000
            
        case .LargeOfficeResearch:
            imageType = BuildingType.LargeOffice
            name = "Large Office"
            comment = "Open Large Office technology."
            researchPrice = 40000000
            
        case .BankResearch:
            imageType = BuildingType.Bank
            name = "Bank"
            comment = "Open Bank technology."
            researchPrice = 8000000000
            
        case .ResearchCenterResearch:
            imageType = BuildingType.ResearchCenter
            name = "Research Center"
            comment = "Open Research Center technology."
            researchPrice = 100
            
        case .AdvancedResearchCenterResearch:
            imageType = BuildingType.AdvancedResearchCenter
            name = "Advanced Research Center"
            comment = "Open Advanced Research Center technology."
            researchPrice = 150000
            
        case .LibraryResearch:
            imageType = BuildingType.Library
            name = "Library"
            comment = "Open Library technology."
            researchPrice = 100000000
            
        default:
            imageType = BuildingType.WindTurbine
            name = "\(researchType)"
            comment = "error comment"
            researchPrice = 1
        }
        
        // image
        let gap = (size.height - tilesScaleSize.height) / 2
        let image = BuildingData(buildType: imageType).image("image")
        image.position = CGPoint(x: size.height / 2, y: gap + image.size.width / 2)
        addChild(image)
        
        // name
        let researchName = SKLabelNode(fontNamed: "SanFranciscoRounded-Black")
        researchName.name = "researchName"
        researchName.text = name
        researchName.fontColor = SKColor.whiteColor()
        researchName.fontSize = image.size.height * 2 / 5
        researchName.horizontalAlignmentMode = .Left
        researchName.verticalAlignmentMode = .Top
        researchName.position = CGPoint(x: image.size.width + gap * 2, y: size.height - gap)
        addChild(researchName)
        
        // comment
        let commentLabel = SKLabelNode(fontNamed: "SanFranciscoRounded-Black")
        commentLabel.name = "commentLabel"
        commentLabel.text = comment
        commentLabel.fontColor = SKColor.lightGrayColor()
        commentLabel.fontSize = (image.size.height - researchName.fontSize * 1.2) / 2
        commentLabel.horizontalAlignmentMode = .Left
        commentLabel.verticalAlignmentMode = .Bottom
        commentLabel.position = CGPoint(x: image.size.width + gap * 2, y: (image.size.height - researchName.fontSize) / 2 + gap)
        addChild(commentLabel)
        
        // research
        let researchLabel = SKLabelNode(fontNamed: "SanFranciscoRounded-Black")
        researchLabel.name = "researchLabel"
        researchLabel.text = "Research:"
        researchLabel.fontColor = SKColor.lightGrayColor()
        researchLabel.fontSize = (image.size.height - researchName.fontSize * 1.2) / 2
        researchLabel.horizontalAlignmentMode = .Left
        researchLabel.verticalAlignmentMode = .Bottom
        researchLabel.position = CGPoint(x: image.size.width + gap * 2, y: gap)
        addChild(researchLabel)
        
        // price
        let priceLabel = SKLabelNode(fontNamed: "SanFranciscoRounded-Black")
        priceLabel.name = "priceLabel"
        priceLabel.text = numberToString(researchPrice)
        priceLabel.fontColor = colorResearch
        if researchType == .ResearchCenterResearch {
            priceLabel.fontColor = colorMoney
        }
        priceLabel.fontSize = (image.size.height - researchName.fontSize * 1.2) / 2
        priceLabel.horizontalAlignmentMode = .Left
        priceLabel.verticalAlignmentMode = .Bottom
        priceLabel.position = CGPoint(x: image.size.width + gap * 2 + researchLabel.frame.width, y: gap)
        addChild(priceLabel)
        
        // Upgrade Button
        if !researchDone {
            let color = (research > researchPrice ? colorBlue2 : SKColor.lightGrayColor())
            buttonUpgrade = SKShapeNode(rectOfSize: CGSizeMake(tilesScaleSize.width, tilesScaleSize.height), cornerRadius: 10 * framescale)
            buttonUpgrade.name = (research > researchPrice ? "Upgrade" : "NoMoney")
            buttonUpgrade.fillColor = color
            buttonUpgrade.strokeColor = color
            buttonUpgrade.position = CGPoint(x: size.width - gap - tilesScaleSize.width / 2, y: size.height / 2)
            let levelupImage = SKSpriteNode(texture: iconAtlas.textureNamed("levelup"))
            levelupImage.setScale(0.6 * framescale)
            buttonUpgrade.addChild(levelupImage)
            addChild(buttonUpgrade)
        }
    }
    
    func checkUpgradeButton() {
        if !researchDone {
            if researchType == ResearchType.ResearchCenterResearch {
                buttonUpgrade.name = (money > researchPrice ? "Upgrade" : "NoMoney")
                buttonUpgrade.fillColor = (money > researchPrice ? colorBlue2 : SKColor.lightGrayColor())
                buttonUpgrade.strokeColor = (money > researchPrice ? colorBlue2 : SKColor.lightGrayColor())
            } else {
                buttonUpgrade.name = (research > researchPrice ? "Upgrade" : "NoMoney")
                buttonUpgrade.fillColor = (research > researchPrice ? colorBlue2 : SKColor.lightGrayColor())
                buttonUpgrade.strokeColor = (research > researchPrice ? colorBlue2 : SKColor.lightGrayColor())
            }
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
    var researchElements = [ResearchElement]()
    
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
            
            let researchImage = SKSpriteNode(texture: iconAtlas.textureNamed("atoms"))
            researchImage.name = "researchImage"
            researchImage.setScale(0.9 * framescale)
            researchImage.position = topCenter
            researchImage.runAction(SKAction.repeatActionForever(SKAction.rotateByAngle(CGFloat(M_PI_2), duration: 5)))
            addChild(researchImage)
            
            researchLabel = SKLabelNode(fontNamed: "SanFranciscoRounded-Black")
            researchLabel.name = "top label"
            researchLabel.fontSize = unitHeight * 0.2
            researchLabel.fontColor = colorResearch
            researchLabel.text = numberToString(research)
            researchLabel.horizontalAlignmentMode = .Left
            researchLabel.verticalAlignmentMode = .Bottom
            researchLabel.position = CGPoint(x: frame.size.width * 0.05, y: frame.size.height - unitHeight * 0.9)
            addChild(researchLabel)
            
            itemLabel = SKLabelNode(fontNamed: "SanFranciscoRounded-Black")
            itemLabel.name = "item label"
            itemLabel.fontSize = unitHeight * 0.2
            itemLabel.fontColor = colorResearch
            itemLabel.text = "1 / 35"
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
            researchdeLayer = SKSpriteNode(color: colorBlue4, size: CGSizeMake(frame.size.width * 4, frame.size.height - unitHeight * 2))
            researchdeLayer.name = "ResearchLayer"
            researchdeLayer.anchorPoint = CGPoint(x: 0, y: 0)
            researchdeLayer.position = CGPoint(x: 0, y: unitHeight)
            addChild(researchdeLayer)
            
            contentCreated = true
            
            // remove first load delay
            print("load 2")
            self.view?.presentScene(upgradeScene)
        }
        
        // update element
        updateElement()
        // hide AD
        NSNotificationCenter.defaultCenter().postNotificationName("hideAd", object: nil)
        print("load 8")
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
        researchElements.removeAll()
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
            let researchElement = ResearchElement(researchType: elements[count], size: elementsize)
            if researchElement.researchDone {
                researchDoneNumber += 1
                researchElement.childNodeWithName("researchLabel")?.hidden = true
                researchElement.childNodeWithName("priceLabel")?.hidden = true
            }
            researchElement.position = positions[count]
            researchElement.background.color = (count % 2 == 0 ? colorBlue4 : colorBlue3)
            researchElements.append(researchElement)
            researchdeLayer.addChild(researchElement)
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
                    if !isSoundMute{ runAction(soundTap) }
                    let doors = SKTransition.revealWithDirection(SKTransitionDirection.Down, duration: 0.3)
                    self.view?.presentScene(islandScene, transition: doors)
                }
                if nextPage.containsPoint(location) {
                    nowPage += 1
                    researchdeLayer.runAction((SKAction.moveToX(-frame.size.width * CGFloat(nowPage - 1), duration: 0.2)))
                    if !isSoundMute{ runAction(soundSlide) }
                }
                if prevPage.containsPoint(location) {
                    nowPage -= 1
                    researchdeLayer.runAction((SKAction.moveToX(-frame.size.width * CGFloat(nowPage - 1), duration: 0.2)))
                    if !isSoundMute{ runAction(soundSlide) }
                }
                if node.name == "Upgrade" {
                    let element = (node.parent as! ResearchElement)
                    let price = element.researchPrice
                    let type = element.researchType
                    if type == ResearchType.ResearchCenterResearch {
                        money -= price
                        researchLevel[type]! += 1
                        updateElement()
                        if !isSoundMute{ runAction(soundLevelup) }
                    } else {
                        if type == ResearchType.WindTurbineRebuild {
                            isRebuild = true
                        }
                        research -= price
                        researchLevel[type]! += 1
                        for count in 0..<maps.count {
                            maps[count].reloadMap()
                        }
                        updateElement()
                        if !isSoundMute{ runAction(soundLevelup) }
                    }
                }
            }
        }
    }
    
    override func update(currentTime: CFTimeInterval) {
        prevPage.hidden = (nowPage == 1 ? true : false)
        nextPage.hidden = (nowPage == maxPage ? true : false)
        researchLabel.text = "\(numberToString(research))"
        for researchElement in researchElements {
            researchElement.checkUpgradeButton()
        }
    }
}
