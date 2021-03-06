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
import GoogleMobileAds

// Game Scene
var islandsScene:    SKScene!
var islandScene:     SKScene!
var upgradeScene:    SKScene!
var researchScene:   SKScene!

// Game UI Data
var tilesScaleSize:  CGSize!
var framescale:      CGFloat!
let door_Fade        = SKTransition.fadeWithDuration(2)
let door_Float       = SKTransition.moveInWithDirection(SKTransitionDirection.Down, duration: 0.5)
let door_reveal      = SKTransition.revealWithDirection(SKTransitionDirection.Down, duration: 0.5)

// Game Atlas
let buildingAtlas    = SKTextureAtlas(named: "building")
let iconAtlas        = SKTextureAtlas(named: "icon")

// Game Sound
var backgroundMusics = [AVAudioPlayer]()
let soundTap         = SKAction.playSoundFileNamed("tap.wav", waitForCompletion: false)
let soundSell        = SKAction.playSoundFileNamed("sell.wav", waitForCompletion: false)
let soundPlacing     = SKAction.playSoundFileNamed("placing.wav", waitForCompletion: false)
let soundExplosion   = SKAction.playSoundFileNamed("explosion.mp3", waitForCompletion: false)
let soundLevelup     = SKAction.playSoundFileNamed("levelup.wav", waitForCompletion: false)
let soundSlide       = SKAction.playSoundFileNamed("slide.wav", waitForCompletion: false)
let soundClick       = SKAction.playSoundFileNamed("click.wav", waitForCompletion: false)
let soundSelect      = SKAction.playSoundFileNamed("select.wav", waitForCompletion: false)
let soundAction      = SKAction.playSoundFileNamed("action.wav", waitForCompletion: false)
let soundBuyIsland   = SKAction.playSoundFileNamed("buyIsland.wav", waitForCompletion: false)
let soundWhoosh      = SKAction.playSoundFileNamed("whoosh.mp3", waitForCompletion: false)
let soundFirework1   = SKAction.playSoundFileNamed("firework1.wav", waitForCompletion: false)
let soundFirework2   = SKAction.playSoundFileNamed("firework2.wav", waitForCompletion: false)
let soundFinish      = SKAction.playSoundFileNamed("finish.wav", waitForCompletion: false)

// Game Color
var colorMoney       = UIColor(red: 0.855, green: 0.847, blue: 0.314, alpha: 1.000)// #DAD74E
var colorResearch    = UIColor(red: 0.596, green: 0.894, blue: 0.000, alpha: 1.000)
var colorEnergy      = UIColor(red: 0.000, green: 0.698, blue: 0.875, alpha: 1.000)
var colorBlue1       = UIColor(red: 0.519, green: 0.982, blue: 1.000, alpha: 1.000)
var colorBlue2       = UIColor(red: 0.208, green: 0.455, blue: 0.635, alpha: 1.000)// #3474A2
var colorBlue3       = UIColor(red: 0.067, green: 0.310, blue: 0.490, alpha: 1.000)
var colorBlue4       = UIColor(red: 0.008, green: 0.216, blue: 0.294, alpha: 1.000)// #02374B
var colorBoost       = UIColor(red: 1.000, green: 0.600, blue: 0.000, alpha: 1.000)// #FF9800
var colorCancel      = UIColor(red: 0.898, green: 0.224, blue: 0.282, alpha: 1.000)
var colorBrown       = UIColor(red: 0.323, green: 0.113, blue: 0.034, alpha: 1.000)

// Game Level
enum BuildingType: Int {
    case WindTurbine, SolarCell, CoalBurner, WaveCell, GasBurner, NuclearCell, FusionCell, SmallGenerator, MediumGenerator, LargeGenerator, BoilerHouse, LargeBoilerHouse, Isolation, Battery, HeatExchanger, HeatSink, HeatInlet, HeatOutlet, WaterPump, GroundwaterPump, WaterPipe, SmallOffice, MediumOffice, LargeOffice, Bank, ResearchCenter, AdvancedResearchCenter, Library, Garbage, Ocean, Land, Rock, BuildingTypeLength
}
enum UpgradeType: Int {
    case OfficeSellEnergy, BankEffectiveness, ResearchCenterEffectiveness, LibraryEffectiveness, BoilerHouseMaxHeat, BoilerHouseSellAmount, GeneratorMaxHeat, GeneratorEffectiveness, HeatExchangerMaxHeat, HeatSinkMaxHeat, EnergyBatterySize, IsolationEffectiveness, WaterPumpProduction, GroundwaterPumpProduction, WaterElementMaxWater, GeneratorMaxWater, HeatInletOutletMaxHeat, HeatInletMaxTransfer, FusionCellEffectiveness, FusionCellLifetime, NuclearCellEffectiveness, NuclearCellLifetime, GasBurnerEffectiveness, GasBurnerLifetime, WaveCellEffectiveness, WaveCellLifetime, CoalBurnerEffectiveness, CoalBurnerLifetime, SolarCellEffectiveness, SolarCellLifetime, WindTurbineEffectiveness, WindTurbineLifetime, UpgradeTypeLength
}
enum ResearchType: Int {
    case ResearchCenterResearch, AdvancedResearchCenterResearch, LibraryResearch, SmallOfficeResearch, MediumOfficeResearch, LargeOfficeResearch, BankResearch, SmallGeneratorResearch, MediumGeneratorResearch, LargeGeneratorResearch, BoilerHouseResearch, LargeBoilerHouseResearch, WaterPumpResearch, GroundwaterPumpResearch, WaterPipeResearch, BatteryResearch, IsolationResearch, HeatExchangerResearch, HeatSinkResearch, HeatInletResearch, HeatOutletResearch, FusionCellResearch, FusionCellRebuild, NuclearCellResearch, NuclearCellRebuild, GasBurnerResearch, GasBurnerRebuild, WaveCellResearch, WaveCellRebuild, CoalBurnerResearch, CoalBurnerRebuild, SolarCellResearch, SolarCellRebuild, WindTurbineResearch, WindTurbineRebuild, ResearchTypeLength
}

// User Data
var saveDataTimer         = NSTimer()
var money: Double         = 1
var research: Double      = 0
var spendTime: Int        = 0
var finishBuilding: Int   = 0
var finishExplosion: Int  = 0
var finishTime: Int       = 0
var GADTime: Int          = 0
var upgradeLevel          = [UpgradeType: Int]()
var researchLevel         = [ResearchType: Int]()
var maps                  = [BuildingMapLayer]()
var nowMapNumber: Int     = 0
var isHaveTeach: Bool     = false
var isPause: Bool         = false
var isRebuild: Bool       = true
var isBoost: Bool         = false
var isSoundMute: Bool     = false
var isMusicMute: Bool     = false
var isMusicContinue:Bool  = false
var hasTouchAd: Bool      = false
var isFinishTarget: Bool  = false
var boostTime: Double     = 1
var boostTimeLess: Double = 1

class GameViewController: UIViewController, GADBannerViewDelegate {
    
    @IBOutlet weak var bannerView: GADBannerView!
    @IBOutlet weak var hideAdLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // load game data
        loadGameData()
        
        // background music
        backgroundMusicInit()
        let notificationCenter = NSNotificationCenter.defaultCenter()
        notificationCenter.addObserver(self, selector: #selector(GameViewController.playBackgroundMusic), name: "playMusic", object: nil)
        
        // save game data when app will resign, boost when app active and every 1 min
        notificationCenter.addObserver(self, selector: #selector(GameViewController.resignActive), name: UIApplicationWillResignActiveNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(GameViewController.becomeActive), name: UIApplicationDidBecomeActiveNotification, object: nil)

        
        // google mobile ad
        self.hideAdLabel.hidden = true
        self.bannerView.adUnitID = "ca-app-pub-6777277453719401/5818649975"
        self.bannerView.delegate = self
        self.bannerView.rootViewController = self
        let request: GADRequest  = GADRequest()
        // request.testDevices = ["d868130e73c7b6a9e776f9a6706450bd11fe77d7"]
        self.bannerView.loadRequest(request)
        self.bannerView.hidden = true
        notificationCenter.addObserver(self, selector: #selector(GameViewController.hideBannerView), name: "hideAd", object: nil)
        notificationCenter.addObserver(self, selector: #selector(GameViewController.showBannerView), name: "showAd", object: nil)
        
        // hide Ad Label
        hideAdLabel.layer.borderWidth = 1
        hideAdLabel.layer.borderColor = UIColor.whiteColor().CGColor
    }
    override func viewWillDisappear(animated: Bool) {
        print("view will disappear")
    }
    func adViewWillLeaveApplication(bannerView: GADBannerView!) {
        print("has touch ad")
        hasTouchAd = true
        
        // hide ad space
        NSNotificationCenter.defaultCenter().postNotificationName("hideAdSpace", object: nil)
        
        // save new ad date
        print("reset ad time")
        let defaults = NSUserDefaults.standardUserDefaults()
        let now = NSDate(timeInterval: 0, sinceDate: NSDate())
        defaults.setObject(now, forKey: "adDate")
    }
    func hideBannerView(){
        self.hideAdLabel.hidden = true
        self.bannerView.hidden  = true
    }
    func showBannerView(){
        self.hideAdLabel.hidden = false
        self.bannerView.hidden  = false
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        let skView = self.view as! SKView
        
        if (skView.scene == nil) {
            let scale:CGFloat          = UIScreen.mainScreen().scale
            let size                   = CGSizeMake(skView.frame.width * scale, skView.frame.height * scale)
            framescale                 = size.height / (16 * 64)
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
            //skView.showsFPS            = true
            //skView.showsNodeCount      = true
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
    
    func backgroundMusicInit() {
        for i in 0...6 {
            let aSound = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("music-\(i)", ofType: "mp3")!)
            do {
                let music = try AVAudioPlayer(contentsOfURL:aSound)
                music.numberOfLoops = -1
                music.volume = isMusicMute ? 0 : 0.5
                music.prepareToPlay()
                backgroundMusics.append(music)
                print("Preload music \(i)")
            } catch {
                print("Cannot play the file")
            }
        }
    }
    
    func playBackgroundMusic(notifaction: NSNotification) {
        if isMusicContinue {
            isMusicContinue = false
            return
        } else {
            for backgroundMusic in backgroundMusics {
                backgroundMusic.currentTime = 0
                backgroundMusic.stop()
            }
            let playNumber = notifaction.object as! Int
            print("play music \(playNumber)")
            backgroundMusics[playNumber].play()
        }
    }
    
    func loadGameData() {
        print("Load game data")
        let defaults = NSUserDefaults.standardUserDefaults()
        
        // load money, research and spendTime
        money           = defaults.doubleForKey("Money") != 0 ? defaults.doubleForKey("Money") : 1
        research        = defaults.doubleForKey("Research")
        spendTime       = defaults.integerForKey("spendTime")
        finishBuilding  = defaults.integerForKey("finishBuilding")
        finishExplosion = defaults.integerForKey("finishExplosion")
        finishTime      = defaults.integerForKey("finishTime")
        isHaveTeach     = defaults.boolForKey("isHaveTeach")
        isPause         = defaults.boolForKey("isPause")
        isRebuild       = defaults.boolForKey("isRebuild")
        isSoundMute     = defaults.boolForKey("isSoundMute")
        isMusicMute     = defaults.boolForKey("isMusicMute")
        isFinishTarget  = defaults.boolForKey("isFinishTarget")
        
        //money = 100000000000000000
        //research = 100000000000000000
        
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
            buildingMapLayer.loadMapData()
            maps.append(buildingMapLayer)
        }
        maps[0].isSold = true
        
        // check ad time is over 12 hour
        let lastADDate = defaults.objectForKey("adDate") as? NSDate
        if let intervall = lastADDate?.timeIntervalSinceNow {
            let pastSeconds = -Int(intervall)
            print("ad past seconds: \(pastSeconds)")
            if pastSeconds <= 43200 {
                print("No AD")
                hasTouchAd = true
            } else {
                print("Show AD")
                hasTouchAd = false
            }
        }
    }
    
    func becomeActive() {
        loadTime()
        autoSaveData(true)
    }
    
    func resignActive() {
        saveGameData()
        autoSaveData(false)
    }
    
    func loadTime() {
        // if in pause, no load time
        if isPause { return }
        // if in last boost, no load time
        if isBoost { return }
        // Boost lost time
        dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INTERACTIVE, 0)) {
            print("Start Boost time!")
            isBoost = true
            // load date and update game date
            let defaults = NSUserDefaults.standardUserDefaults()
            let lastDate = defaults.objectForKey("Date") as? NSDate
            if let intervall = lastDate?.timeIntervalSinceNow {
                var pastSeconds = -Int(intervall)
                if pastSeconds <= 0 {
                    isBoost = false
                    return
                }
                if pastSeconds > 3600 {
                    pastSeconds = 3600
                }
                boostTime = Double(pastSeconds)
                boostTimeLess = 0
                print("Boost seconds: \(pastSeconds)")
                for _ in 0..<pastSeconds {
                    boostTimeLess += 1
                    spendTime += 1
                    for i in 0..<6 {
                        if maps[i].isSold {
                            // Update map data
                            maps[i].Update()
                            // Calculate money and research
                            money    += maps[i].money_TickAdd
                            research += maps[i].research_TickAdd
                        }
                    }
                }
            }
            isBoost = false
            print("End Boost time!")
        }
    }
    
    func autoSaveData(enable: Bool) {
        if enable {
            print("enable save data timer")
            saveDataTimer = NSTimer.scheduledTimerWithTimeInterval(60, target: self, selector: #selector(GameViewController.saveGameData), userInfo: nil, repeats: true)
        } else {
            print("unabel save data timer")
            saveDataTimer.invalidate()
        }
    }
    
    func saveGameData() {
        print("Save game data")
        let defaults = NSUserDefaults.standardUserDefaults()
        
        // save money, research, spendTime, pause and rebuild state
        defaults.setDouble(money, forKey: "Money")
        defaults.setDouble(research, forKey: "Research")
        defaults.setInteger(spendTime, forKey: "spendTime")
        defaults.setInteger(finishBuilding, forKey: "finishBuilding")
        defaults.setInteger(finishExplosion, forKey: "finishExplosion")
        defaults.setInteger(finishTime, forKey: "finishTime")
        defaults.setBool(isHaveTeach, forKey: "isHaveTeach")
        defaults.setBool(isPause, forKey: "isPause")
        defaults.setBool(isRebuild, forKey: "isRebuild")
        defaults.setBool(isSoundMute, forKey: "isSoundMute")
        defaults.setBool(isMusicMute, forKey: "isMusicMute")
        defaults.setBool(isFinishTarget, forKey: "isFinishTarget")
        
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
        let now = NSDate(timeInterval: 0, sinceDate: NSDate())
        defaults.setObject(now, forKey: "Date")
    }
}
