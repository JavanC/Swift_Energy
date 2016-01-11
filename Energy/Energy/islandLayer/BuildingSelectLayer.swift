//
//  BuildingSelectLayer.swift
//  Energy
//
//  Created by javan.chen on 2015/12/18.
//  Copyright © 2015年 Javan chen. All rights reserved.
//

import SpriteKit

class BuildingSelectElement: SKNode {

    var background: SKSpriteNode!
    var buildType: BuildingType!
    
    init(buildType: BuildingType, size: CGSize) {
        self.buildType = buildType
        super.init()
        
        // background
        background = SKSpriteNode(color: SKColor.grayColor(), size: size)
        background.name = "BuildingSelectElementBackground"
        background.anchorPoint = CGPoint(x: 0, y: 0)
        addChild(background)
        // image
        let gap = (size.height - tilesScaleSize.height) / 2
        let image = BuildingData(buildType: buildType).image("image")
        image.position = CGPoint(x: gap + image.size.width / 2, y: size.height / 2)
        addChild(image)
        // label 1
        let text = [String(buildType), "12312312312"]
        let labelgap: CGFloat = 10
        let labelsize = (image.size.height - labelgap) / 2
        let label1 = SKLabelNode(fontNamed: "Verdana-Bold")
        label1.name = "label1"
        label1.text = text[0]
        label1.horizontalAlignmentMode = .Left
        label1.position = CGPoint(x: gap * 2 + image.size.width, y: gap + labelsize + labelgap)
        addChild(label1)
        // label 2
        let label2 = SKLabelNode(fontNamed: "Verdana-Bold")
        label2.name = "label2"
        label2.text = text[1]
        label2.horizontalAlignmentMode = .Left
        label2.position = CGPoint(x: gap * 2 + image.size.width, y: gap)
        addChild(label2)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class BuildingSelectLayer: SKNode {
    
    var show: Bool = false
    var selectLayer: SKSpriteNode!
    var positions = [CGPoint]()
    var buildingSelectElements = [BuildingSelectElement]()
    
    init(position: CGPoint, midSize: CGSize) {
        super.init()
        self.position = position
        selectLayer = SKSpriteNode(color: SKColor.brownColor(), size: CGSizeMake(midSize.width * 4, midSize.height))
        selectLayer.name = "buildingSelectLayer"
        selectLayer.anchorPoint = CGPoint(x: 0, y: 0)
        selectLayer.position = CGPoint(x: 0, y: -2 * selectLayer.size.height)
        addChild(selectLayer)
        
        // Caculae Position
        let gap: CGFloat = 20
        let num: CGFloat = 7
        let elementsize = CGSizeMake(selectLayer.size.width / 4 - gap * 2, (selectLayer.size.height - gap) / num - gap)
        for x in 0..<4 {
            for y in 0..<Int(num) {
                positions.append(CGPoint(x: gap + selectLayer.size.width / 4 * CGFloat(x), y: selectLayer.size.height - (elementsize.height + gap) * CGFloat(y + 1)))
            }
        }
        
        buildingSelectElements = [BuildingSelectElement]()
        for count in 0..<28 {
            let element = BuildingSelectElement(buildType: BuildingType(rawValue: count)!, size: elementsize)
            element.hidden = true
            selectLayer.addChild(element)
            buildingSelectElements.append(element)
        }
        
        updateSelectLayer()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Update building select page
    func updateSelectLayer() {
        // page 1
        let page1ShowTypesCheck: [ResearchType] = [.WindTurbineResearch, .SolarCellResearch, .CoalBurnerResearch, .WaveCellResearch, .GasBurnerResearch, .NuclearCellResearch, .FusionCellResearch, .SmallGeneratorResearch, .MediumGeneratorResearch, .LargeGeneratorResearch, .BoilerHouseResearch, .LargeBoilerHouseResearch, .IsolationResearch, .BatteryResearch, .HeatExchangerResearch, .HeatSinkResearch, .HeatInletResearch, .HeatOutletResearch, .WaterPumpResearch, .GroundwaterPumpResearch, .WaterPipeResearch, .SmallOfficeResearch, .MediumOfficeResearch, .LargeOfficeResearch, .BankResearch, .ResearchCenterResearch, .AdvancedResearchCenterResearch, .LibraryResearch]
        for page in 0..<4 {
            var pageFirstPositionNumber = page * 7
            for count in 0..<7 {
                if researchLevel[page1ShowTypesCheck[page * 7 + count]] > 0 {
                    buildingSelectElements[page * 7 + count].hidden = false
                    buildingSelectElements[page * 7 + count].position = positions[pageFirstPositionNumber]
                    ++pageFirstPositionNumber
                }
            }
        }
    }
    
    // Show page
    func showPage(show: Bool) {
        self.show = show
        selectLayer.runAction(SKAction.moveToY((show ? 0 : -2 * selectLayer.size.height), duration: 0.2))
    }
    func changePage(page: Int) {
        let frameWidth = selectLayer.size.width / 4
        selectLayer.runAction(SKAction.moveToX(-CGFloat(page - 1) * frameWidth, duration: 0))
    }
}
