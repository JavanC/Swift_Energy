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
    
    init(upgradeType: UpgradeType, size: CGSize) {
        super.init()
        self.upgradeType = upgradeType
        
        // background
        background = SKSpriteNode(color: SKColor.grayColor(), size: size)
        background.name = "UpgradeElement"
        background.anchorPoint = CGPoint(x: 0, y: 0)
        addChild(background)
        
        // Find information
        var imageType: BuildingType!
        var text1: String!
        var text2: String!
        var price: Int!
        let level = Int(upgradeLevel[upgradeType]!)
        switch upgradeType {
        case .Wind_Heat_Max:
            imageType = .Wind
            text1 = "Wind Lv.\(level)"
            text2 = "test123123"
            price = 1
            
        case .Fire_Heat_Max:
            imageType = .Fire
            text1 = "Fire Lv.\(level)"
            text2 = "test123123"
            price = 10
            
        case .Fire_Heat_Produce:
            imageType = .Fire
            text1 = "Fire Lv.\(level)"
            text2 = "test123123"
            price = 100
            
        case .Office_Sell:
            imageType = .Office
            text1 = "Office Lv.\(level)"
            text2 = "test123123"
            price = 1000
            
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
        // Upgrade and Degrade button
        buttonUpgrade = SKSpriteNode(color: (money > price ? SKColor.greenColor() : SKColor.blackColor()), size: tilesScaleSize)
        buttonUpgrade.name = (money > price ? "Upgrade" : "")
        buttonUpgrade.position = CGPoint(x: size.width - gap - tilesScaleSize.width / 2, y: size.height / 2)
        addChild(buttonUpgrade)
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

//        
//        let gap: CGFloat = 20
//        let buildingImage = BuildingData(buildType: buildType).image("\(self.name)_Image")
//        buildingImage.anchorPoint = CGPoint(x: 0, y: 0.5)
//        buildingImage.position = CGPoint(x: gap, y: size.height / 2)
//        addChild(buildingImage)
//        
//        let infoGap: CGFloat = 8
//        let infoSize = (size.height - infoGap * 4) / 3
//        let levelInfo = ["123123", "12312312", "123123123123"]
//        for i in 1...3 {
//            let label = SKLabelNode(fontNamed: "Verdana-Bold")
//            label.name = "info\(CGFloat(i))"
//            label.text = levelInfo[i - 1]
//            label.fontSize = infoSize
//            label.horizontalAlignmentMode = .Left
//            label.position = CGPoint(x: tilesScaleSize.width + gap * 2, y: infoGap * (4 - CGFloat(i)) + infoSize * (3 - CGFloat(i)))
//            addChild(label)
//        }
//        
//        buildingUpgrade = SKSpriteNode(color: SKColor.greenColor(), size: buildingImage.size)
//        buildingUpgrade.name = "Upgrade"
//        buildingUpgrade.anchorPoint = CGPoint(x: 1, y: 0.5)
//        buildingUpgrade.position = CGPoint(x: size.width - gap, y: size.height / 2)
//        addChild(buildingUpgrade)
    
        //        if money < BuildingData(buildType: buildType).nextLevelPrice {
        //            buildingUpgrade.color = SKColor.blackColor()
        //        }
        
        //        if nowLevel > 1 {
        //            buildingDegrade = SKSpriteNode(color: SKColor.redColor(), size: buildingImage.size)
        //            buildingDegrade.name = "Degrade"
        //            buildingDegrade.anchorPoint = CGPoint(x: 1, y: 0.5)
        //            buildingDegrade.position = CGPoint(x: size.width - gap * 2 - buildingImage.size.width, y: size.height / 2)
        //            addChild(buildingDegrade)
        //        }
    
//}
//
//class BuildingSelectLayer: SKSpriteNode {
//    
//    var show: Bool = false
//    var origin: CGPoint!
//    let gap: CGFloat = 20
//    var selectElementSize: CGSize!
//    var elements = [BuildingSelectElement]()
//    
//    func configureAtPosition(position: CGPoint, midSize: CGSize) {
//        origin = position
//        self.position = CGPoint(x: origin.x, y: origin.y - 2 * midSize.height)
//        self.size = CGSizeMake(midSize.width * 4, midSize.height)
//        self.name = "BuildingSelectLayer"
//        self.color = SKColor.blackColor()
//        self.anchorPoint = CGPoint(x: 0, y: 0)
//        
//        let selectElementNumber: CGFloat = 6
//        let selectElementHeight = (self.size.height - gap * (selectElementNumber + 1)) / selectElementNumber
//        selectElementSize = CGSizeMake(self.size.width / 4 - 2 * gap, selectElementHeight)
//        
//        updateBuildingSelectPage()
//    }
//    
//    // Update building select page
//    func updateBuildingSelectPage() {
//        elements.removeAll()
//        removeAllChildren()
//        let page1:[BuildingType] = [.Wind, .Fire, .Office]
//        for (count, buildType) in page1.enumerate() {
//            //            let buildlevel = getBuildLevel(buildType)
//            //            if buildlevel > 0 {
//            let position = CGPoint(x: gap, y: self.size.height - (gap + selectElementSize.height) * CGFloat(count + 1))
//            let sptireNode = BuildingSelectElement()
//            sptireNode.configureAtPosition(buildType, position: position, size: selectElementSize)
//            elements.append(sptireNode)
//            addChild(sptireNode)
//            //            }
//        }
//        let page2:[BuildingType] = [.Wind, .Wind, .Wind, .Fire, .Office]
//        for (count, buildType) in page2.enumerate() {
//            //            let buildlevel = getBuildLevel(buildType)
//            //            if buildlevel > 0 {
//            let position = CGPoint(x: gap + size.width / 4, y: self.size.height - (gap + selectElementSize.height) * CGFloat(count + 1))
//            let sptireNode = BuildingSelectElement()
//            sptireNode.configureAtPosition(buildType, position: position, size: selectElementSize)
//            elements.append(sptireNode)
//            addChild(sptireNode)
//            //            }
//        }
//    }

class UpgradeScene: SKScene {
    
    var contentCreated: Bool = false
    var backButton: SKLabelNode!
    var elements = [UpgradeElement]()
    var positions = [CGPoint]()
    var upgradeLayer: SKSpriteNode!

    var nowPage: Int = 1
    var maxPage: Int = 1
    var nextPage: SKSpriteNode!
    var prevPage: SKSpriteNode!
    
    override func didMoveToView(view: SKView) {
        if !contentCreated {
            let label = SKLabelNode(fontNamed: "Verdana-Bold")
            label.fontSize = 30
            label.text = "You have \(money)$ can be used!"
            label.position = CGPoint(x: frame.size.width / 2, y: frame.size.height - 50)
            addChild(label)
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
            let gap:CGFloat = 20
            let num:CGFloat = 8
            let elementsize = CGSizeMake(frame.size.width - gap * 2, (upgradeLayer.size.height - gap) / num - gap)
            for x in 0..<4 {
                for y in 0..<Int(num) {
                    positions.append(CGPoint(x: gap + frame.size.width * CGFloat(x), y: upgradeLayer.size.height - (elementsize.height + gap) * CGFloat(y + 1)))
                }
            }
            for count in 0...17 {
                let element = UpgradeElement(upgradeType: .Wind_Heat_Max, size: elementsize)
                element.position = positions[count]
                upgradeLayer.addChild(element)
            }
            
            maxPage = 17 / 8 + 1
            
            contentCreated = true
        }
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
                    print(nowPage)
                }
                if prevPage.containsPoint(location) {
                    nowPage--
                    upgradeLayer.runAction((SKAction.moveToX(-frame.size.width * CGFloat(nowPage - 1), duration: 0.2)))
                    print(nowPage)
                }
            }
        }
    }
    
    override func update(currentTime: CFTimeInterval) {
        prevPage.hidden = (nowPage == 1 ? true : false)
        nextPage.hidden = (nowPage == maxPage ? true : false)
    }
}
