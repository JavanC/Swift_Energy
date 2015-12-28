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
        background.name = "BuildingSelectElement"
        background.size = size
        background.anchorPoint = CGPoint(x: 0, y: 0)
        addChild(background)
        // image
        let gap = (size.height - tilesScaleSize.height) / 2
        let image = BuildingData(buildType: buildType).image("image")
        image.position = CGPoint(x: gap + image.size.width / 2, y: size.height / 2)
        addChild(image)
        // label 1
        let text = ["ewrer", "12312312312"]
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

class BuildingSelectLayer: SKSpriteNode {
    
    var origin: CGPoint!
    var show: Bool = false
    var selectLayer: SKSpriteNode!
    
    func configureAtPosition(position: CGPoint, midSize: CGSize) {
        self.origin = position
        self.position = CGPoint(x: origin.x, y: origin.y - midSize.height * 2)
        self.size = CGSizeMake(midSize.width * 4, midSize.height)
        self.name = "BuildingSelectLayer"
        self.color = SKColor.blackColor()
        self.anchorPoint = CGPoint(x: 0, y: 0)
        
        updateBuildingSelectPage()
    }
    
    // Update building select page
    func updateBuildingSelectPage() {
        removeAllChildren()
        // Caculae Position
        var positions = [CGPoint]()
        let gap:CGFloat = 20
        let num:CGFloat = 6
        let elementsize = CGSizeMake(frame.size.width - gap * 2, (self.size.height - gap) / num - gap)
        for x in 0..<4 {
            for y in 0..<Int(num) {
                positions.append(CGPoint(x: gap + frame.size.width * CGFloat(x), y: self.size.height - (elementsize.height + gap) * CGFloat(y + 1)))
            }
        }

        let selects:[BuildingType] = [.Wind, .Fire, .Office]
        
        // page 1
        for count in 0...2 {
            let sptireNode = BuildingSelectElement(buildType: .Fire, size: elementsize)
            sptireNode.position = positions[count]
            addChild(sptireNode)
        }
    }
    
    // Show page
    func showPage(show: Bool) {
        self.show = show
        self.runAction(SKAction.moveToY(origin.y + (show ? 0 : -2 * self.size.height), duration: 0.2))
    }
    func changePage(page: Int) {
        let frameWidth = self.size.width / 4
        self.runAction(SKAction.moveToX(origin.x + -CGFloat(page - 1) * frameWidth, duration: 0.2))
    }
}
