//
//  BuildingSelectLayer.swift
//  Energy
//
//  Created by javan.chen on 2015/12/18.
//  Copyright © 2015年 Javan chen. All rights reserved.
//

import SpriteKit

class BuildingSelectElement: SKSpriteNode {
    
    var buildType: BuildingType!
    
    func configureAtPosition(buildType: BuildingType, size: CGSize) {
        self.name = "BuildingSelectElementBackground"
        self.buildType = buildType
        self.size = size
        self.anchorPoint = CGPoint(x: 0, y: 0)
        
        // image
        let gap: CGFloat                     = (size.height - tilesScaleSize.height) / 2
        let image                            = BuildingData(buildType: buildType).image("image")
        image.position                       = CGPoint(x: gap + image.size.width / 2, y: size.height / 2)
        addChild(image)
        
        let buildingName                     = SKLabelNode(fontNamed: "SanFranciscoRounded-Black".localized)
        buildingName.name                    = "buildingName"
        buildingName.text                    = "\(BuildingData(buildType: buildType).name)"
        buildingName.fontColor               = SKColor.whiteColor()
        buildingName.fontSize                = image.size.height * 2 / 5
        buildingName.horizontalAlignmentMode = .Left
        buildingName.verticalAlignmentMode   = .Top
        buildingName.position                = CGPoint(x: image.size.width + gap * 2, y: size.height - gap)
        addChild(buildingName)
        let multilineLabel                   = SKMultilineLabel(text: "\(BuildingData(buildType: buildType).comment)", labelWidth: Int(size.width - image.size.width - gap * 3), pos: CGPoint(x: (size.width + image.size.width + gap * 1) / 2 , y: size.height - gap - buildingName.fontSize), fontName: "ArialMT", fontSize: (image.size.height - buildingName.fontSize * 1.2) / 2, fontColor: SKColor.lightGrayColor(), leading: Int((image.size.height - buildingName.fontSize) / 2), alignment: .Left, shouldShowBorder: false)
        addChild(multilineLabel)
    }
}

class BuildingSelectLayer: SKNode {
    
    var selectLayer: SKSpriteNode!
    var positions = [CGPoint]()
    var buildingSelectElements = [BuildingSelectElement]()
    var selectBox: SKSpriteNode!
    
    init(position: CGPoint, midSize: CGSize) {
        super.init()
        self.position           = position
        selectLayer             = SKSpriteNode(color: colorBlue4, size: CGSizeMake(midSize.width * 4, midSize.height))
        selectLayer.name        = "buildingSelectLayer"
        selectLayer.anchorPoint = CGPoint(x: 0, y: 1)
        selectLayer.hidden      = true
        addChild(selectLayer)
        
        // add Field
        for x in 0..<4 {
            let field = SKSpriteNode(color: colorBlue3, size: CGSizeMake(midSize.width * 4, midSize.height / 7))
            field.name = "field\(x)"
            field.anchorPoint = CGPoint(x: 0, y: 1)
            field.position = CGPoint(x: 0, y: -(CGFloat(x) * midSize.height * 2 + 1) / 7)
            selectLayer.addChild(field)
        }

        // Caculae 28 Position
        let num: CGFloat        = 7
        let elementsize         = CGSizeMake(midSize.width , midSize.height / num )
        for x in 0..<4 {
            for y in 0..<Int(num) {
                positions.append(CGPoint(x: selectLayer.size.width / 4 * CGFloat(x), y: -elementsize.height * CGFloat(y + 1)))
            }
        }
        
        // add select box
        selectBox = SKSpriteNode(color: colorBlue1, size: elementsize)
        selectBox.alpha = 0.3
        selectBox.name = "selectBox"
        selectBox.position = positions[0]
        selectBox.anchorPoint = CGPoint(x: 0, y: 0)
        let fadeInFadeOut = SKAction.sequence([SKAction.fadeAlphaTo(0.1, duration: 1), SKAction.fadeAlphaTo(0.5, duration: 1)])
        selectBox.runAction(SKAction.repeatActionForever(fadeInFadeOut))
        selectLayer.addChild(selectBox)
        
        // add building select elements
        buildingSelectElements  = [BuildingSelectElement]()
        for count in 0..<28 {
            let element         = BuildingSelectElement()
            element.configureAtPosition(BuildingType(rawValue: count)!, size: elementsize)
            element.hidden      = true
            selectLayer.addChild(element)
            buildingSelectElements.append(element)
        }
        
        // add top and down line
        let lineTop = SKShapeNode(rectOfSize: CGSizeMake(midSize.width * 4, 2 * framescale))
        lineTop.fillColor = SKColor.lightGrayColor()
        lineTop.lineWidth = 0
        lineTop.position = CGPoint(x: midSize.width * 2, y: 0)
        selectLayer.addChild(lineTop)
        let lineDown = SKShapeNode(rectOfSize: CGSizeMake(midSize.width * 4, 2 * framescale))
        lineDown.fillColor = SKColor.lightGrayColor()
        lineDown.lineWidth = 0
        lineDown.position = CGPoint(x: midSize.width * 2, y: -midSize.height)
        selectLayer.addChild(lineDown)
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Update building select page
    func updateSelectLayer() {
        let page1ShowTypesCheck: [ResearchType] = [.WindTurbineResearch, .SolarCellResearch, .CoalBurnerResearch, .WaveCellResearch, .GasBurnerResearch, .NuclearCellResearch, .FusionCellResearch, .SmallGeneratorResearch, .MediumGeneratorResearch, .LargeGeneratorResearch, .BoilerHouseResearch, .LargeBoilerHouseResearch, .IsolationResearch, .BatteryResearch, .HeatExchangerResearch, .HeatSinkResearch, .HeatInletResearch, .HeatOutletResearch, .WaterPumpResearch, .GroundwaterPumpResearch, .WaterPipeResearch, .SmallOfficeResearch, .MediumOfficeResearch, .LargeOfficeResearch, .BankResearch, .ResearchCenterResearch, .AdvancedResearchCenterResearch, .LibraryResearch]
        var pageFirstPositionNumber = 0
        for count in 0..<28 {
            if count % 7 == 0 {
                pageFirstPositionNumber = count
            }
            if researchLevel[page1ShowTypesCheck[count]] > 0 {
                buildingSelectElements[count].position = positions[pageFirstPositionNumber]
                buildingSelectElements[count].hidden = false
                pageFirstPositionNumber += 1
            } else {
                buildingSelectElements[count].hidden = true
            }
        }
    }
    
    // Change select box position
    func changeSelectBox(buildType: BuildingType) {
        selectBox.runAction(SKAction.moveTo(buildingSelectElements[buildType.hashValue].position, duration: 0))
    }
    
    // Show page
    func showPage(show: Bool, duration: Double = 0.2) {
        if show {
            let moveUp   = SKAction.moveToY(0, duration: duration)
            moveUp.timingMode = SKActionTimingMode.EaseOut
            selectLayer.runAction(SKAction.sequence([SKAction.unhide(), moveUp]))
        } else {
            let moveDown = SKAction.moveToY(-selectLayer.size.height, duration: duration)
            moveDown.timingMode = SKActionTimingMode.EaseIn
            selectLayer.runAction(SKAction.sequence([moveDown, SKAction.hide()]))
        }
    }
    func changePage(page: Int) {
        let frameWidth = selectLayer.size.width / 4
        selectLayer.runAction(SKAction.moveToX(-CGFloat(page) * frameWidth, duration: 0))
    }
}
