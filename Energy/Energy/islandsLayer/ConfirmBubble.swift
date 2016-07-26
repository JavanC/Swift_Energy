//
//  confirmBubble.swift
//  Energy
//
//  Created by javan.chen on 2016/2/19.
//  Copyright © 2016年 Javan chen. All rights reserved.
//

import SpriteKit

class ConfirmBubble: SKNode {
    var islandName: SKLabelNode!
    var islandNum: Int = 1
    var buyPrice: Double = 0
    var priceLabel: SKLabelNode!
    var buyInfoLabel: SKLabelNode!
    var OKButton: SKShapeNode!
    var cancelButton: SKShapeNode!
    var buyButton: SKShapeNode!
    
    init(bubbleSize: CGSize) {
        super.init()
        
        let gap = bubbleSize.height / 10
        
        let bg = SKShapeNode(rectOfSize: bubbleSize, cornerRadius: 10 * framescale)
        bg.name = "background"
        bg.fillColor = colorBlue4
        bg.strokeColor = colorBlue2
        bg.lineWidth = 5 * framescale
        bg.alpha = 0.9
        addChild(bg)

        islandName = SKLabelNode(fontNamed: "SanFranciscoRounded-Black".localized)
        islandName.name = "islaneName"
        islandName.text = "Small island"
        islandName.fontSize = 35 * framescale
        islandName.verticalAlignmentMode = .Center
        islandName.position = CGPoint(x: 0, y: gap * 3.7)
        addChild(islandName)
        
        let line1 = SKShapeNode(rectOfSize: CGSizeMake(bubbleSize.width - 40, 0.5 * framescale))
        line1.name = "line1"
        line1.alpha = 0.5
        line1.fillColor = SKColor.whiteColor()
        line1.position = CGPoint(x: 0, y: gap * 2.8)
        addChild(line1)
        
        priceLabel = SKLabelNode(fontNamed: "SanFranciscoRounded-Black")
        priceLabel.name = "priceLabel"
        priceLabel.text = "10000"
        priceLabel.fontColor = colorMoney
        priceLabel.fontSize = 35 * framescale
        priceLabel.verticalAlignmentMode = .Center
        priceLabel.position = CGPoint(x: 0, y: gap * 1.2)
        addChild(priceLabel)
        
        buyInfoLabel = SKLabelNode(fontNamed: "SanFranciscoRounded-Black".localized)
        buyInfoLabel.name = "buyLabel"
        buyInfoLabel.text = "You don't have enough money.".localized
        buyInfoLabel.fontSize = 25 * framescale
        buyInfoLabel.verticalAlignmentMode = .Center
        buyInfoLabel.position = CGPoint(x: 0, y: gap * -0.6)
        addChild(buyInfoLabel)
        
        OKButton = SKShapeNode(rectOfSize: CGSizeMake(bubbleSize.width - 40 * framescale, gap * 4 - 40 * framescale), cornerRadius: 5 * framescale)
        OKButton.name = "OKButton"
        OKButton.fillColor = colorBlue2
        OKButton.lineWidth = 0
        OKButton.position = CGPoint(x: 0, y: gap * -3)
        let OKLabel = SKLabelNode(fontNamed: "SanFranciscoRounded-Black".localized)
        OKLabel.name = "OKLabel"
        OKLabel.text = "OK".localized
        OKLabel.fontSize = 40 * framescale
        OKLabel.verticalAlignmentMode = .Center
        OKButton.addChild(OKLabel)
        addChild(OKButton)
        
        cancelButton = SKShapeNode(rectOfSize: CGSizeMake(bubbleSize.width / 2 - 30 * framescale, gap * 4 - 40 * framescale), cornerRadius: 5 * framescale)
        cancelButton.name = "cancelButton"
        cancelButton.fillColor = colorCancel
        cancelButton.lineWidth = 0
        cancelButton.position = CGPoint(x: -bubbleSize.width / 4 + 5 * framescale, y: gap * -3)
        let cancelLabel = SKLabelNode(fontNamed: "SanFranciscoRounded-Black".localized)
        cancelLabel.name = "cancelLabel"
        cancelLabel.text = "Cancel".localized
        cancelLabel.fontSize = 40 * framescale
        cancelLabel.verticalAlignmentMode = .Center
        cancelButton.addChild(cancelLabel)
        addChild(cancelButton)
        
        buyButton = SKShapeNode(rectOfSize: CGSizeMake(bubbleSize.width / 2 - 30 * framescale, gap * 4 - 40 * framescale), cornerRadius: 5 * framescale)
        buyButton.name = "buyButton"
        buyButton.fillColor = colorResearch
        buyButton.lineWidth = 0
        buyButton.position = CGPoint(x: bubbleSize.width / 4 - 5 * framescale, y: gap * -3)
        let buyLabel = SKLabelNode(fontNamed: "SanFranciscoRounded-Black".localized)
        buyLabel.name = "buyLabel"
        buyLabel.text = "Buy".localized
        buyLabel.fontSize = 40 * framescale
        buyLabel.verticalAlignmentMode = .Center
        buyButton.addChild(buyLabel)
        addChild(buyButton)
    }
    
    func showBubble(islandNum: Int) {
        self.islandNum = islandNum
        switch islandNum {
        case 0:
            buyPrice = 1
            islandName.text = "Small Island".localized
        case 1:
            buyPrice = 5000
            islandName.text = "Tree Island".localized
        case 2:
            buyPrice = 3000000
            islandName.text = "Canyon Island".localized
        case 3:
            buyPrice = 5000000000
            islandName.text = "Coconut Island".localized
        case 4:
            buyPrice = 400000000000
            islandName.text = "Sand Island".localized
        case 5:
            buyPrice = 20000000000000
            islandName.text = "Mainland".localized
        case 6:
            buyPrice = 10000000000000000
            islandName.text = "Alien Technology".localized
        default: break
        }
        priceLabel.text = "\(numberToString(buyPrice, isInt: true))"

        self.runAction(SKAction.sequence([SKAction.unhide(), SKAction.fadeInWithDuration(0.3)]))
    }
    func hideBubble(duration duration: Double = 0.3) {
        OKButton.alpha     = 1
        cancelButton.alpha = 1
        buyButton.alpha    = 1
        self.runAction(SKAction.sequence([SKAction.fadeOutWithDuration(duration), SKAction.hide()]))
    }
    func update() {
        if money < buyPrice {
            buyInfoLabel.text = "You don't have enough money.".localized
            OKButton.hidden = false
            cancelButton.hidden = true
            buyButton.hidden = true
        } else {
            if islandNum == 6 {
                buyInfoLabel.text = "Buy a mysterious alien technology.".localized
            } else {
                buyInfoLabel.text = "Buy the island to building.".localized
            }
            OKButton.hidden = true
            cancelButton.hidden = false
            buyButton.hidden = false
        }
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}