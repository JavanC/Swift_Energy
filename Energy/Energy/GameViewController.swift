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
var researchScene: SKScene!
let buildingAtlas = SKTextureAtlas(named: "building")
let iconAtlas = SKTextureAtlas(named: "icon")

class GameViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // load game data
        loadGameData()
        
        // save game data when app will resign
        let notificationCenter = NSNotificationCenter.defaultCenter()
        notificationCenter.addObserver(self, selector: "saveGameData", name: UIApplicationWillResignActiveNotification, object: nil)
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
            researchScene = ResearchScene(size: size)
            // Configure the view
            menuScene.scaleMode = .AspectFill
            islandsScene.scaleMode = .AspectFill
            islandScene.scaleMode = .AspectFill
            upgradeScene.scaleMode = .AspectFill
            researchScene.scaleMode = .AspectFill
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
    
    func loadGameData() {
        print("Load game data")
        let defaults = NSUserDefaults.standardUserDefaults()
        
        // load money, research and spendTime
        money = defaults.doubleForKey("Money") != 0 ? defaults.doubleForKey("Money") : 1000
        research = defaults.doubleForKey("Research")
        spendTime = defaults.integerForKey("spendTime")
        boostPoint = defaults.doubleForKey("boostPoint")
        
        // load upgrade and research level
        for count in 0..<UpgradeType.UpgradeTypeLength.hashValue {
            upgradeLevel[UpgradeType(rawValue: count)!] = defaults.integerForKey("upgradeData_\(count)")
        }
        for count in 0..<ResearchType.ResearchTypeLength.hashValue {
            researchLevel[ResearchType(rawValue: count)!] = defaults.integerForKey("researchData_\(count)")
        }
        researchLevel[ResearchType.WindTurbineResearch] = 1
        
        // load maps data
        for count in 0..<8 {
            let buildingMapLayer = BuildingMapLayer()
            buildingMapLayer.configureAtPosition(CGPoint(x: 0, y: 0), mapNumber: count)
            maps.append(buildingMapLayer)
        }
        for map in maps {
            map.loadGameData()
        }
        
        // load date and update game date
        let lastDate = defaults.objectForKey("Date") as? NSDate
        if let intervall = lastDate?.timeIntervalSinceNow {
            let pastSeconds = -Int(intervall)
            if pastSeconds <= 0 { return }
            boostPoint += Double(pastSeconds) / 5
            if boostPoint > 10000 {
                boostPoint = 10000
            }
        }
    }
    
    func saveGameData() {
        print("Save game data")
        let defaults = NSUserDefaults.standardUserDefaults()
        
        // save money, research and spendTime
        defaults.setDouble(money, forKey: "Money")
        defaults.setDouble(research, forKey: "Research")
        defaults.setInteger(spendTime, forKey: "spendTime")
        defaults.setDouble(boostPoint, forKey: "boostPoint")
        
        // save upgrade and research level
        for count in 0..<UpgradeType.UpgradeTypeLength.hashValue {
            let level = upgradeLevel[UpgradeType(rawValue: count)!]!
            defaults.setInteger(level, forKey: "upgradeData_\(count)")
        }
        for count in 0..<ResearchType.ResearchTypeLength.hashValue {
            let level = researchLevel[ResearchType(rawValue: count)!]!
            defaults.setInteger(level, forKey: "researchData_\(count)")
        }
        
        // save maps data
        for map in maps {
            map.saveGameData()
        }
        
        // save now date
        let now = NSDate()
        defaults.setObject(now, forKey: "Date")
    }
}
