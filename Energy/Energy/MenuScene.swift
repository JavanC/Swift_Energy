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

class MenuScene: SKScene {
    
    var contentCreated: Bool = false
    var startGameButton: SKLabelNode!
    var testbutton: SKMultilineLabel!
    
    override func didMoveToView(view: SKView) {
        if !contentCreated {

            self.backgroundColor = SKColor.whiteColor()
        
            startGameButton = SKLabelNode(fontNamed: "SanFranciscoText-BoldItalic")
            startGameButton.text = "Play"
            startGameButton.fontSize = 50 * framescale
            startGameButton.fontColor = SKColor.blackColor()
            startGameButton.position = CGPoint(x: CGRectGetMidX(frame), y: CGRectGetMidY(frame))
            self.addChild(startGameButton)
//            
//            testbutton = SKMultilineLabel(text: "abc ccdd aher. \n asdf", labelWidth: Int(frame.size.width), pos: CGPoint(x: CGRectGetMidX(frame), y: frame.size.height / 3), fontSize: 50, fontColor: SKColor.redColor(), leading: 60,  shouldShowBorder: true)
//            self.addChild(testbutton)
            
            contentCreated = true
            
            // first load remove delay
            self.view?.presentScene(islandsScene)
        }
        RunAfterDelay(2) {
            let doors = SKTransition.pushWithDirection(SKTransitionDirection.Up, duration: 3)
            self.view?.presentScene(islandsScene, transition: doors)
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch in touches {
            let location = touch.locationInNode(self)
            if startGameButton.containsPoint(location) {
                print("play")
                if !isSoundMute{ runAction(soundTap) }
                let doors = SKTransition.revealWithDirection(SKTransitionDirection.Left, duration: 0.3)
                self.view?.presentScene(islandsScene, transition: doors)
            }
        }
    }
   
    override func update(currentTime: CFTimeInterval) {
        
    }
}
