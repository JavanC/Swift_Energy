//
//  GameScene.swift
//  Energy
//
//  Created by javan.chen on 2015/12/25.
//  Copyright (c) 2015年 Javan chen. All rights reserved.
//

import SpriteKit
// Game UI Data
var colorMoney = UIColor(red: 0.855, green: 0.847, blue: 0.314, alpha: 1.000)
var colorResearch = UIColor(red: 0.596, green: 0.894, blue: 0.000, alpha: 1.000)
var colorEnergy = UIColor(red: 0.519, green: 0.982, blue: 1.000, alpha: 1.000)
// Game Data
enum BuildingType: Int {
    case Ocean, Land, WindTurbine, SolarCell, CoalBurner, WaveCell, GasBurner, NuclearCell, FusionCell, SmallGenerator, MediumGenerator, LargeGenerator, BoilerHouse, LargeBoilerHouse, Isolation, Battery, HeatExchanger, HeatSink, HeatInlet, HeatOutlet, WaterPump, GroundwaterPump, WaterPipe, SmallOffice, MediumOffice, LargeOffice, Bank, ResearchCenter, AdvancedResearchCenter, Library, BuildingTypeLength
}
enum UpgradeType: Int {
    case OfficeSellEnergy, BankEffectiveness, ResearchCenter, LibraryEffectiveness, BoilerHouseMaxHeat, BoilerHouseSellAmount, GeneratorMaxHeat, GeneratorEffectiveness, HeatExchangerMaxHeat, HeatSinkMaxHeat, EnergyBatterySize, IsolationEffectiveness, WaterPumpProduction, GroundwaterPumpProduction, WaterElementMaxWater, GeneratorMaxWater, HeatInletOutletMaxHeat, HeatInletMaxTransfer, FusionCellEffectiveness, FusionCellLifetime, NuclearCellEffectiveness, NuclearCellLifetime, GasBurnerEffectiveness, GasBurnerLifetime, WaveCellEffectiveness, WaveCellLifetime, CoalBurnerEffectiveness, CoalBurnerLifetime, SolarCellEffectiveness, SolarCellLifetime, WindTurbineEffectiveness, WindTurbineLifetime, UpgradeTypeLength
}
enum ResearchType: Int {
    case ResearchCenterResearch, AdvancedResearchCenterResearch, LibraryResearch, SmallOfficeResearch, MediumOfficeResearch, LargeOfficeResearch, BankResearch, ChronometerUpdateResearch, SmallGeneratorResearch, MediumGeneratorResearch, LargeGeneratorResearch, BoilerHouseResearch, LargeBoilerHouseResearch, WaterPumpResearch, GroundwaterPumpResearch, WaterPipeResearch, BatteryResearch, IsolationResearch, HeatExchangerResearch, HeatSinkResearch, HeatInletResearch, HeatOutletResearch, FusionCellResearch, FusionCellRebuild, NuclearCellResearch, NuclearCellRebuild, GasBurnerResearch, GasBurnerRebuild, WaveCellResearch, WaveCellRebuild, CoalBurnerResearch, CoalBurnerRebuild, SolarCellResearch, SolarCellRebuild, WindTurbineResearch, WindTurbineRebuild, ResearchTypeLength
}
// User Data
var money: Int = 1000
var research: Int = 1000
var upgradeLevel = [UpgradeType: Int]()
var researchLevel = [ResearchType: Int]()
var maps = [BuildingMapLayer]()
var nowMapNumber: Int = 0
var isPause: Bool = false

class MenuScene: SKScene {
    
    var contentCreated: Bool = false
//    var startGameButton: SKMultilineLabel!
    var startGameButton: SKLabelNode!

    override func didMoveToView(view: SKView) {
        if !contentCreated {
            
            self.backgroundColor = SKColor.whiteColor()
        
            startGameButton = SKLabelNode(fontNamed: "SanFranciscoText-BoldItalic")
            startGameButton.text = "Play"
            startGameButton.fontSize = 50
            startGameButton.fontColor = SKColor.blackColor()
            startGameButton.position = CGPoint(x: CGRectGetMidX(frame), y: CGRectGetMidY(frame))
            self.addChild(startGameButton)
            
            initialLevelData()

            contentCreated = true
        }
    }
    
    func initialLevelData() {
        for count in 0..<UpgradeType.UpgradeTypeLength.hashValue {
            upgradeLevel[UpgradeType(rawValue: count)!] = 0
        }
        for count in 0..<ResearchType.ResearchTypeLength.hashValue {
            researchLevel[ResearchType(rawValue: count)!] = 1
        }
        researchLevel[ResearchType.WindTurbineResearch] = 1
        for _ in 0..<8 {
            let buildingMapLayer = BuildingMapLayer()
            buildingMapLayer.configureAtPosition(CGPoint(x: 0, y: 0))
            maps.append(buildingMapLayer)
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch in touches {
            let location = touch.locationInNode(self)
            if startGameButton.containsPoint(location) {
                print("tap")
                let doors = SKTransition.revealWithDirection(SKTransitionDirection.Left, duration: 0.3)
                self.view?.presentScene(islandsScene, transition: doors)
            }
        }
    }
   
    override func update(currentTime: CFTimeInterval) {
        
    }
}
