//
//  GameScene.swift
//  Energy
//
//  Created by javan.chen on 2015/12/25.
//  Copyright (c) 2015年 Javan chen. All rights reserved.
//

import SpriteKit
// Game UI Data

var colorMoney = UIColor(red: 0.855, green: 0.847, blue: 0.314, alpha: 1.000) // #DAD74E
var colorResearch = UIColor(red: 0.596, green: 0.894, blue: 0.000, alpha: 1.000)
var colorEnergy = UIColor(red: 0.000, green: 0.698, blue: 0.875, alpha: 1.000)
var colorBlue1 = UIColor(red: 0.519, green: 0.982, blue: 1.000, alpha: 1.000)
var colorBlue2 = UIColor(red: 0.208, green: 0.455, blue: 0.635, alpha: 1.000) // #3474A2
var colorBlue3 = UIColor(red: 0.067, green: 0.310, blue: 0.490, alpha: 1.000)
var colorBlue4 = UIColor(red: 0.008, green: 0.216, blue: 0.294, alpha: 1.000) // #02374B
var colorBoost = UIColor(red: 1.000, green: 0.600, blue: 0.000, alpha: 1.000) // #FF9800
var colorCancel = UIColor(red: 0.898, green: 0.224, blue: 0.282, alpha: 1.000)
let door_Up = SKTransition.pushWithDirection(SKTransitionDirection.Up, duration: 3)
let door_Fade = SKTransition.fadeWithDuration(2)
let door_Float = SKTransition.moveInWithDirection(SKTransitionDirection.Down, duration: 0.3)

// Game Data
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

class MenuScene: SKScene {
    
    var firstLoad: Bool = true
    var contentCreated: Bool = false
    var background: SKSpriteNode!
    
    override func didMoveToView(view: SKView) {
        if !contentCreated {

            self.backgroundColor = SKColor.whiteColor()
        
            background = SKSpriteNode(color: SKColor.whiteColor(), size: frame.size)
            background.name = "background"
            background.position = CGPoint(x: frame.width / 2, y: frame.height / 2)
            addChild(background)
            
            let startGameButton = SKLabelNode(fontNamed: "SanFranciscoRounded-Black")
            startGameButton.text = "touch to continute"
            startGameButton.fontSize = 40 * framescale
            startGameButton.fontColor = SKColor.blackColor()
            startGameButton.position = CGPoint(x: 0, y: -frame.height * 2 / 6)
            let fadeinfadeout = SKAction.sequence([SKAction.fadeOutWithDuration(0.5), SKAction.fadeInWithDuration(0.5)])
            startGameButton.runAction(SKAction.repeatActionForever(fadeinfadeout))
            background.addChild(startGameButton)
            
            contentCreated = true
            // remove first touch delay
//            dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INTERACTIVE, 0)) {
            
                self.background.containsPoint(CGPoint(x: 0, y: 0))
//            }
            // first load remove delay
            print("load 1")
            self.view?.presentScene(researchScene)
        }
        if firstLoad {
            print("load 6")
            firstLoad = false
        } else {
            print("load 11")
            RunAfterDelay(1){
                print("load atlas done!")
                self.view?.presentScene(islandsScene, transition: door_Up)
            }
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.locationInNode(self)
        if background.containsPoint(location) {
            let doors = SKTransition.pushWithDirection(SKTransitionDirection.Up, duration: 3)
            self.view?.presentScene(islandsScene, transition: doors)
        }
    }
    
    override func update(currentTime: CFTimeInterval) {
    
    }
}
