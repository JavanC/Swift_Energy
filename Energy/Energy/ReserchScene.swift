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
        case .Wind_Rebuild:
            imageType = .Wind
            text1 = "Wind_Rebuild Lv.\(level)"
            text2 = "test123123"
            reserchPrice = 1
            if level == 1 { reserchDone = true }
            
        case .Fire_Develope:
            imageType = .Fire
            text1 = "Fire_Develope Lv.\(level)"
            text2 = "test123123"
            reserchPrice = 10
            if level == 1 { reserchDone = true }
            
        case .Fire_Rebuild:
            imageType = .Fire
            text1 = "Fire_Rebuild Lv.\(level)"
            text2 = "test123123"
            reserchPrice = 100
            if level == 2 { reserchDone = true }
            
        case .Office_Develope:
            imageType = .Wind
            text1 = "Office_Develope Lv.\(level)"
            text2 = "test123123"
            reserchPrice = 1000
            if level == 1 { reserchDone = true }
            
        default: break
        }
        
        // image
        let gap = (size.height - tilesScaleSize.height) / 2
        let image = BuildingData(buildType: imageType).image("image")
        image.position = CGPoint(x: size.height / 2, y: gap + image.size.width / 2)
        addChild(image)
        // label 1
        let labelgap: CGFloat = 10
        let labelsize = (image.size.height - labelgap) / 2
        let label1 = SKLabelNode(fontNamed: "Verdana-Bold")
        label1.name = "label1"
        label1.text = text1
        label1.horizontalAlignmentMode = .Left
        label1.position = CGPoint(x: gap * 2 + image.size.width, y: gap + labelsize + labelgap)
        addChild(label1)
        // label 2
        let label2 = SKLabelNode(fontNamed: "Verdana-Bold")
        label2.name = "label2"
        label2.text = text2
        label2.horizontalAlignmentMode = .Left
        label2.position = CGPoint(x: gap * 2 + image.size.width, y: gap)
        addChild(label2)
        // Upgrade Button
        if reserchDone {
            buttonUpgrade = SKSpriteNode(color: SKColor.blueColor(), size: tilesScaleSize)
        } else {
            buttonUpgrade = SKSpriteNode(color: (money > reserchPrice ? SKColor.greenColor() : SKColor.redColor()), size: tilesScaleSize)
            buttonUpgrade.name = (money > reserchPrice ? "Upgrade" : "NoMoney")
        }
        buttonUpgrade.position = CGPoint(x: size.width - gap - tilesScaleSize.width / 2, y: size.height / 2)
        addChild(buttonUpgrade)
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
        for x in 0..<4 {
            for y in 0..<Int(num) {
                positions.append(CGPoint(x: gap + frame.size.width * CGFloat(x), y: reserchdeLayer.size.height - (elementsize.height + gap) * CGFloat(y + 1)))
            }
        }
        // Add Element
        for count in 0...17 {
            let element = ReserchElement(reserchType: .Wind_Rebuild, size: elementsize)
            element.position = positions[count]
            reserchdeLayer.addChild(element)
        }
        // Caculate MaxPage
        maxPage = 17 / 8 + 1
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
        updateElement()
    }
}
