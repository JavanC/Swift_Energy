//
//  ReserchScene.swift
//  Energy
//
//  Created by javan.chen on 2015/12/28.
//  Copyright © 2015年 Javan chen. All rights reserved.
//

import SpriteKit

class ReserchElement: SKNode {
    
    var background: SKSpriteNode!
    var buttonUpgrade: SKSpriteNode!
    var reserchType: ReserchType!
    var reserchPrice: Int!
    var reserchDone: Bool = false
    
    init(reserchType: ReserchType, size: CGSize) {
        super.init()
        self.reserchType = reserchType
        
        // background
        background = SKSpriteNode(color: SKColor.grayColor(), size: size)
        background.name = "UpgradeElementBackground"
        background.anchorPoint = CGPoint(x: 0, y: 0)
        addChild(background)
        
        // Find information
        var imageType: BuildingType!
        var text1: String!
        var text2: String!
        let level = Int(reserchLevel[reserchType]!)
        switch reserchType {
        case .WindTurbineRebuild:
            imageType = BuildingType.WindTurbine
            text1 = "Wind Turbine Rebuild Lv.\(level)"
            text2 = "test123123"
            reserchPrice = 1
            if level >= 1 { reserchDone = true }
            
        case .CoalBurnerResearch:
            imageType = BuildingType.CoalBurner
            text1 = "Coal Burner Lv.\(level)"
            text2 = "test123123"
            reserchPrice = 10
            if level >= 1 { reserchDone = true }
            
        case .CoalBurnerRebuild:
            imageType = BuildingType.CoalBurner
            text1 = "Coal Burner Rebuild Lv.\(level)"
            text2 = "test123123"
            reserchPrice = 1
            if level >= 1 { reserchDone = true }
            
        case .SmallGeneratorResearch:
            imageType = BuildingType.SmallOffice
            text1 = "Small Generator Lv.\(level)"
            text2 = "test123123"
            reserchPrice = 1
            if level >= 1 { reserchDone = true }
            
        default:
            imageType = BuildingType.WindTurbine
            text1 = "\(reserchType) Lv.\(level)"
            text2 = "test123123"
            reserchPrice = 1
            if level >= 1 { reserchDone = true }
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
        label3.text = "Need Research : \(reserchPrice)"
        label3.fontSize = labelsize
        label3.horizontalAlignmentMode = .Left
        label3.position = CGPoint(x: gap * 2 + image.size.width, y: gap)
        addChild(label3)
        // Upgrade Button
        if !reserchDone {
            let color = (money > reserchPrice ? SKColor.greenColor() : SKColor.redColor())
            buttonUpgrade = SKSpriteNode(color: color, size: tilesScaleSize)
            buttonUpgrade.name = (money > reserchPrice ? "Upgrade" : "NoMoney")
            buttonUpgrade.position = CGPoint(x: size.width - gap - tilesScaleSize.width / 2, y: size.height / 2)
            addChild(buttonUpgrade)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


class ReserchScene: SKScene {
    
    var contentCreated: Bool = false
    var backButton: SKLabelNode!
    var nowPage: Int = 1
    var maxPage: Int = 1
    var nextPage: SKSpriteNode!
    var prevPage: SKSpriteNode!
    var topLabel: SKLabelNode!
    
    var reserchdeLayer: SKSpriteNode!
    
    override func didMoveToView(view: SKView) {
        if !contentCreated {
            
            topLabel = SKLabelNode(fontNamed: "Verdana-Bold")
            topLabel.fontSize = 30
            topLabel.text = "You have \(reserch) reserch can be used!"
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
            reserchdeLayer = SKSpriteNode(color: SKColor.blackColor(), size: CGSizeMake(frame.size.width * 4, frame.size.height - 200))
            reserchdeLayer.name = "ReserchLayer"
            reserchdeLayer.anchorPoint = CGPoint(x: 0, y: 0)
            reserchdeLayer.position = CGPoint(x: 0, y: 100)
            addChild(reserchdeLayer)
            updateElement()
            
            contentCreated = true
        }
    }
    
    func updateElement() {
        reserchdeLayer.removeAllChildren()
        // Caculae Position
        var positions = [CGPoint]()
        let gap:CGFloat = 20
        let num:CGFloat = 8
        let elementsize = CGSizeMake(frame.size.width - gap * 2, (reserchdeLayer.size.height - gap) / num - gap)
        for x in 0..<5 {
            for y in 0..<Int(num) {
                positions.append(CGPoint(x: gap + frame.size.width * CGFloat(x), y: reserchdeLayer.size.height - (elementsize.height + gap) * CGFloat(y + 1)))
            }
        }
        // Add Element
        var number = 0
        for count in 0..<ReserchType.ReserchTypeLength.hashValue {
            if reserchLevel[ReserchType(rawValue: count)!] == 0 {
                let element = ReserchElement(reserchType: ReserchType(rawValue: count)!, size: elementsize)
                element.position = positions[number]
                reserchdeLayer.addChild(element)
                number++
            }
        }
        for count in 0..<ReserchType.ReserchTypeLength.hashValue {
            if reserchLevel[ReserchType(rawValue: count)!] > 0 {
                let element = ReserchElement(reserchType: ReserchType(rawValue: count)!, size: elementsize)
                element.position = positions[number]
                reserchdeLayer.addChild(element)
                number++
            }
        }
        // Caculate MaxPage
        maxPage = (number - 1) / 8 + 1
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
                    reserchdeLayer.runAction((SKAction.moveToX(-frame.size.width * CGFloat(nowPage - 1), duration: 0.2)))
                }
                if prevPage.containsPoint(location) {
                    nowPage--
                    reserchdeLayer.runAction((SKAction.moveToX(-frame.size.width * CGFloat(nowPage - 1), duration: 0.2)))
                }
                if node.name == "Upgrade" {
                    let element = (node.parent as! ReserchElement)
                    let price = element.reserchPrice
                    let type = element.reserchType
                    print(type)
                    reserch -= price
                    reserchLevel[type]!++
                }
            }
        }
    }
    
    override func update(currentTime: CFTimeInterval) {
        prevPage.hidden = (nowPage == 1 ? true : false)
        nextPage.hidden = (nowPage == maxPage ? true : false)
        topLabel.text = "You have \(reserch) reserch can be used!"
        checkResearchLevel()
        updateElement()
    }
    
    func checkResearchLevel() {
        if reserchLevel[ReserchType.ResearchCenterResearch] == 1 {
            reserchLevel[ReserchType.ResearchCenterResearch] = 2
            reserchLevel[ReserchType.WindTurbineRebuild] = 0
            reserchLevel[ReserchType.SmallOfficeResearch] = 0
        }
        if reserchLevel[ReserchType.SmallOfficeResearch] == 1 {
            reserchLevel[ReserchType.SmallOfficeResearch] = 2
            reserchLevel[ReserchType.BatteryResearch] = 0
            reserchLevel[ReserchType.SolarCellResearch] = 0
        }
        if reserchLevel[ReserchType.SolarCellResearch] == 1 {
            reserchLevel[ReserchType.SolarCellResearch] = 2
            reserchLevel[ReserchType.SolarCellRebuild] = 0
            reserchLevel[ReserchType.SmallGeneratorResearch] = 0
        }
        if reserchLevel[ReserchType.SmallGeneratorResearch] == 1 {
            reserchLevel[ReserchType.SmallGeneratorResearch] = 2
            reserchLevel[ReserchType.IsolationResearch] = 0
            reserchLevel[ReserchType.CoalBurnerResearch] = 0
        }
        if reserchLevel[ReserchType.CoalBurnerResearch] == 1 {
            reserchLevel[ReserchType.CoalBurnerResearch] = 2
            reserchLevel[ReserchType.CoalBurnerRebuild] = 0
            reserchLevel[ReserchType.HeatExchangerResearch] = 0
            reserchLevel[ReserchType.BoilerHouseResearch] = 0
        }
        if reserchLevel[ReserchType.BoilerHouseResearch] == 1 {
            reserchLevel[ReserchType.BoilerHouseResearch] = 2
            reserchLevel[ReserchType.WaveCellResearch] = 0
        }
        if reserchLevel[ReserchType.WaveCellResearch] == 1 {
            reserchLevel[ReserchType.WaveCellResearch] = 2
            reserchLevel[ReserchType.WaveCellRebuild] = 0
            reserchLevel[ReserchType.AdvancedResearchCenterResearch] = 0
            reserchLevel[ReserchType.MediumOfficeResearch] = 0
            reserchLevel[ReserchType.GasBurnerResearch] = 0
        }
        if reserchLevel[ReserchType.GasBurnerResearch] == 1 {
            reserchLevel[ReserchType.GasBurnerResearch] = 2
            reserchLevel[ReserchType.GasBurnerRebuild] = 0
            reserchLevel[ReserchType.HeatSinkResearch] = 0
            reserchLevel[ReserchType.MediumGeneratorResearch] = 0
            reserchLevel[ReserchType.LargeBoilerHouseResearch] = 0
        }
        if reserchLevel[ReserchType.LargeBoilerHouseResearch] == 1 {
            reserchLevel[ReserchType.LargeBoilerHouseResearch] = 2
            reserchLevel[ReserchType.NuclearCellResearch] = 0
        }
        if reserchLevel[ReserchType.NuclearCellResearch] == 1 {
            reserchLevel[ReserchType.NuclearCellResearch] = 2
            reserchLevel[ReserchType.NuclearCellRebuild] = 0
            reserchLevel[ReserchType.WaterPumpResearch] = 0
            reserchLevel[ReserchType.WaterPipeResearch] = 0
            reserchLevel[ReserchType.LargeOfficeResearch] = 0
        }
        if reserchLevel[ReserchType.WaterPumpResearch] == 1 {
            reserchLevel[ReserchType.WaterPumpResearch] = 2
            reserchLevel[ReserchType.LibraryResearch] = 0
            reserchLevel[ReserchType.GroundwaterPumpResearch] = 0
            reserchLevel[ReserchType.FusionCellResearch] = 0
        }
        if reserchLevel[ReserchType.FusionCellResearch] == 1 {
            reserchLevel[ReserchType.FusionCellResearch] = 2
            reserchLevel[ReserchType.FusionCellRebuild] = 0
            reserchLevel[ReserchType.LargeGeneratorResearch] = 0
        }
        if reserchLevel[ReserchType.LargeGeneratorResearch] == 1 {
            reserchLevel[ReserchType.LargeGeneratorResearch] = 2
            reserchLevel[ReserchType.BankResearch] = 0
            reserchLevel[ReserchType.HeatInletResearch] = 0
            reserchLevel[ReserchType.HeatOutletResearch] = 0
        }
    }
}
