//
//  GameViewController.swift
//  Energy
//
//  Created by javan.chen on 2015/12/25.
//  Copyright (c) 2015年 Javan chen. All rights reserved.
//

import UIKit
import SpriteKit
import AVFoundation

// Game Scene
var islandsScene: SKScene!
var islandScene: SKScene!
var upgradeScene: SKScene!
var researchScene: SKScene!

// Game UI Data
var tilesScaleSize: CGSize!
var framescale: CGFloat!
let door_Fade = SKTransition.fadeWithDuration(2)
let door_Float = SKTransition.moveInWithDirection(SKTransitionDirection.Down, duration: 0.3)

// Game Atlas
let buildingAtlas = SKTextureAtlas(named: "building")
let iconAtlas = SKTextureAtlas(named: "icon")
let mapsAtlas = SKTextureAtlas(named: "maps")
let backgroundAtlas = SKTextureAtlas(named: "background")

// Game Sound
var backgroundMusicPlayer: AVAudioPlayer!
let soundTap = SKAction.playSoundFileNamed("tap.mp3", waitForCompletion: false)
let soundSell = SKAction.playSoundFileNamed("sell.wav", waitForCompletion: false)
let soundPlacing = SKAction.playSoundFileNamed("placing.wav", waitForCompletion: false)
let soundExplosion = SKAction.playSoundFileNamed("explosion.mp3", waitForCompletion: false)
let soundLevelup = SKAction.playSoundFileNamed("levelup.wav", waitForCompletion: false)
let soundSlide = SKAction.playSoundFileNamed("slide.wav", waitForCompletion: false)
let soundClick = SKAction.playSoundFileNamed("click.wav", waitForCompletion: false)
let soundSelect = SKAction.playSoundFileNamed("select.wav", waitForCompletion: false)
let soundAction = SKAction.playSoundFileNamed("action.wav", waitForCompletion: false)

// Game Color
var colorMoney = UIColor(red: 0.855, green: 0.847, blue: 0.314, alpha: 1.000) // #DAD74E
var colorResearch = UIColor(red: 0.596, green: 0.894, blue: 0.000, alpha: 1.000)
var colorEnergy = UIColor(red: 0.000, green: 0.698, blue: 0.875, alpha: 1.000)
var colorBlue1 = UIColor(red: 0.519, green: 0.982, blue: 1.000, alpha: 1.000)
var colorBlue2 = UIColor(red: 0.208, green: 0.455, blue: 0.635, alpha: 1.000) // #3474A2
var colorBlue3 = UIColor(red: 0.067, green: 0.310, blue: 0.490, alpha: 1.000)
var colorBlue4 = UIColor(red: 0.008, green: 0.216, blue: 0.294, alpha: 1.000) // #02374B
var colorBoost = UIColor(red: 1.000, green: 0.600, blue: 0.000, alpha: 1.000) // #FF9800
var colorCancel = UIColor(red: 0.898, green: 0.224, blue: 0.282, alpha: 1.000)

// Game Level
enum BuildingType: Int {
    case WindTurbine, SolarCell, CoalBurner, WaveCell, GasBurner, NuclearCell, FusionCell, SmallGenerator, MediumGenerator, LargeGenerator, BoilerHouse, LargeBoilerHouse, Isolation, Battery, HeatExchanger, HeatSink, HeatInlet, HeatOutlet, WaterPump, GroundwaterPump, WaterPipe, SmallOffice, MediumOffice, LargeOffice, Bank, ResearchCenter, AdvancedResearchCenter, Library, Ocean, Land, BuildingTypeLength
}
enum UpgradeType: Int {
    case OfficeSellEnergy, BankEffectiveness, ResearchCenterEffectiveness, LibraryEffectiveness, BoilerHouseMaxHeat, BoilerHouseSellAmount, GeneratorMaxHeat, GeneratorEffectiveness, HeatExchangerMaxHeat, HeatSinkMaxHeat, EnergyBatterySize, IsolationEffectiveness, WaterPumpProduction, GroundwaterPumpProduction, WaterElementMaxWater, GeneratorMaxWater, HeatInletOutletMaxHeat, HeatInletMaxTransfer, FusionCellEffectiveness, FusionCellLifetime, NuclearCellEffectiveness, NuclearCellLifetime, GasBurnerEffectiveness, GasBurnerLifetime, WaveCellEffectiveness, WaveCellLifetime, CoalBurnerEffectiveness, CoalBurnerLifetime, SolarCellEffectiveness, SolarCellLifetime, WindTurbineEffectiveness, WindTurbineLifetime, UpgradeTypeLength
}
enum ResearchType: Int {
    case ResearchCenterResearch, AdvancedResearchCenterResearch, LibraryResearch, SmallOfficeResearch, MediumOfficeResearch, LargeOfficeResearch, BankResearch, SmallGeneratorResearch, MediumGeneratorResearch, LargeGeneratorResearch, BoilerHouseResearch, LargeBoilerHouseResearch, WaterPumpResearch, GroundwaterPumpResearch, WaterPipeResearch, BatteryResearch, IsolationResearch, HeatExchangerResearch, HeatSinkResearch, HeatInletResearch, HeatOutletResearch, FusionCellResearch, FusionCellRebuild, NuclearCellResearch, NuclearCellRebuild, GasBurnerResearch, GasBurnerRebuild, WaveCellResearch, WaveCellRebuild, CoalBurnerResearch, CoalBurnerRebuild, SolarCellResearch, SolarCellRebuild, WindTurbineResearch, WindTurbineRebuild, ResearchTypeLength
}

// User Data
var money: Double = 10
var research: Double = 10
var spendTime: Int = 0
var upgradeLevel = [UpgradeType: Int]()
var researchLevel = [ResearchType: Int]()
var maps = [BuildingMapLayer]()
var nowMapNumber: Int = 0
var isPause: Bool = false
var isRebuild: Bool = true
var isBoost: Bool = false
var isSoundMute: Bool = false
var isMusicMute: Bool = false
var boostTime: Double = 1
var boostTimeLess: Double = 1
var mapUnlockeds = [Bool]()

class GameViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // load game data
        loadGameData()
        
        // play background music
        playBackgroundMusic()
        
        // save game data when app will resign
        let notificationCenter = NSNotificationCenter.defaultCenter()
        notificationCenter.addObserver(self, selector: "saveGameData", name: UIApplicationWillResignActiveNotification, object: nil)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        let skView = self.view as! SKView
        
        if (skView.scene == nil) {
            let scale:CGFloat          = UIScreen.mainScreen().scale
            let size                   = CGSizeMake(skView.frame.width * scale, skView.frame.height * scale)
            framescale                 = size.width / (9 * 64)
            tilesScaleSize             = CGSize(width: 64 * framescale, height: 64 * framescale)

            islandsScene               = IslandsScene(size: size)
            islandScene                = IslandScene(size: size)
            upgradeScene               = UpgradeScene(size: size)
            researchScene              = ResearchScene(size: size)

            // Configure the view
            islandsScene.scaleMode     = .AspectFill
            islandScene.scaleMode      = .AspectFill
            upgradeScene.scaleMode     = .AspectFill
            researchScene.scaleMode    = .AspectFill
            skView.showsFPS            = true
            skView.showsNodeCount      = true
            skView.ignoresSiblingOrder = true
            skView.presentScene(islandsScene)
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
    
    func playBackgroundMusic() {
        let aSound = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("backgroundMusic", ofType: "mp3")!)
        do {
            backgroundMusicPlayer = try AVAudioPlayer(contentsOfURL:aSound)
            backgroundMusicPlayer!.numberOfLoops = -1
            backgroundMusicPlayer!.volume = 0.5
            backgroundMusicPlayer!.prepareToPlay()
            backgroundMusicPlayer!.play()
        } catch {
            print("Cannot play the file")
        }
    }
    
    func loadGameData() {
        print("Load game data")
        let defaults = NSUserDefaults.standardUserDefaults()
        
        // load money, research and spendTime
        money     = defaults.doubleForKey("Money") != 0 ? defaults.doubleForKey("Money") : 1
        research  = defaults.doubleForKey("Research")
        spendTime = defaults.integerForKey("spendTime")
        isPause   = defaults.boolForKey("isPause")
        isRebuild = defaults.boolForKey("isRebuild")

        //1000000000000000
        money     = 1000
//        money     = 1000000000000000
        research  = 1000000000000000
        
        // load maps unlocked
        for count in 0..<6 {
            mapUnlockeds.append(defaults.boolForKey("map\(count)_unlocked"))
        }
        mapUnlockeds[0] = true

        // load upgrade and research level
        for count in 0..<UpgradeType.UpgradeTypeLength.hashValue {
            upgradeLevel[UpgradeType(rawValue: count)!] = defaults.integerForKey("upgradeData_\(count)")
        }
        for count in 0..<ResearchType.ResearchTypeLength.hashValue {
            researchLevel[ResearchType(rawValue: count)!] = defaults.integerForKey("researchData_\(count)")
        }
        researchLevel[ResearchType.WindTurbineResearch] = 1
        
        // load maps data
        for count in 0..<6 {
            let buildingMapLayer = BuildingMapLayer()
            buildingMapLayer.configureAtPosition(CGPoint(x: 0, y: 0), mapNumber: count)
            maps.append(buildingMapLayer)
        }
        for map in maps {
            map.loadMapData()
        }
        // Boost lost time
        if isPause { return }
        dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INTERACTIVE, 0)) {
            print("Start Boost time!")
            isBoost = true
            // load date and update game date
            let lastDate = defaults.objectForKey("Date") as? NSDate
            if let intervall = lastDate?.timeIntervalSinceNow {
                var pastSeconds = -Int(intervall)
                if pastSeconds <= 0 { return }
                if pastSeconds > 3600 {
                    pastSeconds = 3600
                }
                boostTime = Double(pastSeconds)
                boostTimeLess = 0
                print("Boost seconds: \(pastSeconds)")
                for _ in 0..<pastSeconds {
                    ++boostTimeLess
                    ++spendTime
                    for i in 0..<6 {
                        // Update map data
                        maps[i].Update()
                        // Calculate money and research
                        money    += maps[i].money_TickAdd
                        research += maps[i].research_TickAdd
                    }
                }
            }
            isBoost = false
            print("End Boost time!")
        }
    }
    
    func saveGameData() {
        print("Save game data")
        let defaults = NSUserDefaults.standardUserDefaults()
        
        // save money, research, spendTime, pause and rebuild state
        defaults.setDouble(money, forKey: "Money")
        defaults.setDouble(research, forKey: "Research")
        defaults.setInteger(spendTime, forKey: "spendTime")
        defaults.setBool(isPause, forKey: "isPause")
        defaults.setBool(isRebuild, forKey: "isRebuild")
        
        // save maps unlocked
        for count in 0..<mapUnlockeds.count {
            defaults.setBool(mapUnlockeds[count], forKey: "map\(count)_unlocked")
        }
        
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
            map.saveMapData()
        }
        
        // save now date
        let now = NSDate(timeInterval: -3600, sinceDate: NSDate())
        defaults.setObject(now, forKey: "Date")
    }
}
