//
//  GameViewController.swift
//  Energy
//
//  Created by javan.chen on 2015/12/25.
//  Copyright (c) 2015年 Javan chen. All rights reserved.
//

import UIKit
import SpriteKit

var menuScene: SKScene!
var islandsScene: SKScene!
var islandScene: SKScene!
var upgradeScene: SKScene!
var reserchScene: SKScene!

class GameViewController: UIViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        let skView = self.view as! SKView
        if (skView.scene == nil) {
            let scale:CGFloat = UIScreen.mainScreen().scale
            let size = CGSizeMake(skView.frame.width * scale, skView.frame.height * scale)
            menuScene = MenuScene(size: size)
            islandsScene = IslandsScene(size: size)
            islandScene = IslandScene(size: size)
            upgradeScene = UpgradeScene(size: size)
            reserchScene = ReserchScene(size: size)
            // Configure the view
            menuScene.scaleMode = .AspectFill
            islandsScene.scaleMode = .AspectFill
            islandScene.scaleMode = .AspectFill
            upgradeScene.scaleMode = .AspectFill
            reserchScene.scaleMode = .AspectFill
            skView.showsFPS = true
            skView.showsNodeCount = true
            skView.ignoresSiblingOrder = true
            skView.presentScene(menuScene)
        }
    }

    override func shouldAutorotate() -> Bool {
        return true
    }

    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            return .AllButUpsideDown
        } else {
            return .All
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}
