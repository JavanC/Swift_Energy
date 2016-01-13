//
//  BuildingData.swift
//  Energy
//
//  Created by javan.chen on 2016/1/5.
//  Copyright © 2016年 Javan chen. All rights reserved.
//

import SpriteKit

class TimeSystem {
    var size: Int
    var inAmount: Int
    var rebuild: Bool
    
    init(size: Int, initAmount: Int, rebuild: Bool) {
        self.size = size
        self.inAmount = initAmount
        self.rebuild = rebuild
    }
    func tick() -> Bool{
        if inAmount > 0 { --inAmount }
        if inAmount == 0 { return false }
        return true
    }
    func resetTime() {
        inAmount = size
    }
}

class ResearchSystem {
    var addAmount: Int = 0
    var multiply: CGFloat = 1
    
    init(amount: Int, multiply: CGFloat = 1) {
        self.addAmount = amount
        self.multiply = multiply
    }
    func researchMultiplyAmount() -> Int {
        return (addAmount * Int(multiply * 100)) / 100
    }
}

class MoneySystem {
    var inAmount: Int = 0
    var energy2MoneyAmount: Int
    var heat2MoneyAmount: Int
    var multiply: CGFloat = 1
    
    init(initAmount: Int, energy2MoneyAmount: Int = 0, heat2MoneyAmount: Int = 0) {
        self.inAmount = initAmount
        self.energy2MoneyAmount = energy2MoneyAmount
        self.heat2MoneyAmount = heat2MoneyAmount
    }
    func isHeat2Money() -> Bool {
        if heat2MoneyAmount > 0 { return true }
        return false
    }
    func energy2MoneyMultiplyAmount() -> Int {
        return (energy2MoneyAmount * Int(multiply * 100)) / 100
    }
}

class EnergySystem {
    var inAmount: Int = 0
    var produce: Int
    var heat2EnergyAmount: Int
    var water2Energy: Bool
    
    init(initAmount: Int, produce: Int = 0, heat2EnergyAmount: Int = 0, water2Energy: Bool = false) {
        self.inAmount = initAmount
        self.produce = produce
        self.heat2EnergyAmount = heat2EnergyAmount
        self.water2Energy = water2Energy
    }
    func produceEnergy() {
        inAmount += produce
    }
    func isHeat2Energy() -> Bool {
        if heat2EnergyAmount > 0 { return true }
        return false
    }
}

class HeatSystem {
    var size: Int
    var inAmount: Int
    var produce: Int
    var produceMultiply: CGFloat = 1.0
    var output: Bool
    var coolingRate: CGFloat
    
    init(size: Int, initAmount: Int = 0, produce: Int = 0, output: Bool = false, coolingRate: CGFloat = 0) {
        self.size = size
        self.inAmount = initAmount
        self.produce = produce
        self.output = output
        self.coolingRate = coolingRate
    }
    func produceHeatValue() -> Int {
        return (produce * Int(produceMultiply * 100)) / 100
    }
    func produceHeat() {
        inAmount += (produce * Int(produceMultiply * 100)) / 100
    }
    func overflow() -> Bool {
        if inAmount > size { return true }
        else { return false }
    }
    func outputHeatToOtherHeatSystem(heatSystems:[HeatSystem]) {
        while inAmount > 0 {
            for heatSystem in heatSystems {
                if inAmount == 0 { break }
                ++heatSystem.inAmount
                --inAmount
            }
        }
    }
    func exchangerHeatToOtherHeatSystem(heatSystems:[HeatSystem]) {
        var allHeat = 0
        for heatSystem in heatSystems {
            allHeat += heatSystem.inAmount
            heatSystem.inAmount = 0
        }
        while allHeat > 0{
            for heatSystem in heatSystems {
                if allHeat == 0 { break }
                ++heatSystem.inAmount
                --allHeat
            }
        }
    }
    func coolingHeatToHeatSink(heatSystems:[HeatSystem]) {
        let outputHeat = inAmount / (heatSystems.count + 1)
        for HeatSystem in heatSystems {
            HeatSystem.inAmount += outputHeat
        }
        inAmount = outputHeat
    }
    func coolingHeat() {
        inAmount = (inAmount * Int((1 - coolingRate) * 100)) / 100
    }
}

class WaterSystem {
    var size: Int
    var inAmount: Int
    var produce: Int
    var output: Bool
    
    init(size: Int, initAmount: Int = 0, produce: Int = 0, output: Bool = false){
        self.size = size
        self.inAmount = initAmount
        self.produce = produce
        self.output = output
    }
    func produceWater() {
        inAmount += produce
    }
    func overflow() {
        if inAmount > size { inAmount = size }
    }
    func add(amount:Int) -> Bool {
        if inAmount + amount <= size{
            inAmount += amount
            return true
        }
        return false
    }
    func balanceWithOtherWaterSystem(var waterSystems:[WaterSystem]) {
        while waterSystems.count > 0 && inAmount > 0{
            var index = 0
            for waterSystem in waterSystems {
                if inAmount == 0 { break }
                if !waterSystem.add(1) {
                    waterSystems.removeAtIndex(index)
                    break
                } else {
                    --self.inAmount
                }
                index++
            }
        }
    }
}

class BuildingData {
    
    var imageName: String!
    var buildType: BuildingType = .Land
    var buildPrice: Int!
    enum ProgressType { case Time, Heat, Water }
    var progress: ProgressType!
    var timeSystem: TimeSystem!
    var heatSystem: HeatSystem!
    var waterSystem: WaterSystem!
    var moneySystem: MoneySystem!
    var energySystem: EnergySystem!
    var researchSystem: ResearchSystem!
    
    // Other
    var batteryEnergySize: Int!
    var isolationPercent: CGFloat!
    var bankAddPercent: CGFloat!
    var libraryAddPercent: CGFloat!
    
    init(buildType: BuildingType) {
        self.buildType = buildType
        switch buildType {
        case .Land:
            imageName = "Land"

        case .WindTurbine:
            imageName = "WindTurbine"
            buildPrice = 1
            progress = .Time
            timeSystem = TimeSystem(size: 5, initAmount: 5, rebuild: false)
            energySystem = EnergySystem(initAmount: 0, produce: 1)
            
        case .SolarCell:
            imageName = "SolarCell"
            buildPrice = 1
            progress = .Time
            timeSystem = TimeSystem(size: 5, initAmount: 5, rebuild: false)
            heatSystem = HeatSystem(size: 150, produce: 3, output: true)
            
        case .CoalBurner:
            imageName = "CoalBurner"
            buildPrice = 20
            progress = .Time
            timeSystem = TimeSystem(size: 10, initAmount: 10, rebuild: false)
            heatSystem = HeatSystem(size: 150, produce: 100, output: true)
            
        case .WaveCell:
            imageName = "WaveCell"
            buildPrice = 10
            progress = .Time
            timeSystem = TimeSystem(size: 10, initAmount: 10, rebuild: false)
            energySystem = EnergySystem(initAmount: 0, produce: 5)
            
        case .GasBurner:
            imageName = "GasBurner"
            buildPrice = 10
            progress = .Time
            timeSystem = TimeSystem(size: 20, initAmount: 20, rebuild: false)
            heatSystem = HeatSystem(size: 200, produce: 50, output: true)
            
        case .NuclearCell:
            imageName = "NuclearCell"
            buildPrice = 10
            progress = .Time
            timeSystem = TimeSystem(size: 30, initAmount: 30, rebuild: false)
            heatSystem = HeatSystem(size: 300, produce: 30, output: true)
            
        case .FusionCell:
            imageName = "FusionCell"
            buildPrice = 10
            progress = .Time
            timeSystem = TimeSystem(size: 40, initAmount: 40, rebuild: false)
            heatSystem = HeatSystem(size: 400, produce: 40, output: true)
            
        case .SmallGenerator:
            imageName = "SmallGenerator"
            buildPrice = 50
            progress = .Heat
            energySystem = EnergySystem(initAmount: 0, heat2EnergyAmount: 40, water2Energy: true)
            heatSystem = HeatSystem(size: 400, initAmount: 100)
            waterSystem = WaterSystem(size: 100, initAmount: 10)
            
        case .MediumGenerator:
            imageName = "MediumGenerator"
            buildPrice = 50
            progress = .Heat
            energySystem = EnergySystem(initAmount: 0, heat2EnergyAmount: 40, water2Energy: true)
            heatSystem = HeatSystem(size: 400, initAmount: 100)
            waterSystem = WaterSystem(size: 100, initAmount: 10)
            
        case .LargeGenerator:
            imageName = "LargeGenerator"
            buildPrice = 50
            progress = .Heat
            energySystem = EnergySystem(initAmount: 0, heat2EnergyAmount: 40, water2Energy: true)
            heatSystem = HeatSystem(size: 400, initAmount: 100)
            waterSystem = WaterSystem(size: 100, initAmount: 10)
            
        case .BoilerHouse:
            imageName = "BoilerHouse"
            buildPrice = 50
            progress = .Heat
            heatSystem = HeatSystem(size: 400, initAmount: 100)
            moneySystem = MoneySystem(initAmount: 0, heat2MoneyAmount: 10)
            
        case .LargeBoilerHouse:
            imageName = "LargeBoilerHouse"
            buildPrice = 50
            progress = .Heat
            heatSystem = HeatSystem(size: 400, initAmount: 100)
            moneySystem = MoneySystem(initAmount: 0, heat2MoneyAmount: 100)
            
        case .Isolation:
            imageName = "Isolation"
            buildPrice = 10
            isolationPercent = 0.5
            
        case .Battery:
            imageName = "Battery"
            buildPrice = 10
            batteryEnergySize = 1000

        case .HeatExchanger:
            imageName = "HeatExchanger"
            buildPrice = 10
            progress = .Heat
            heatSystem = HeatSystem(size: 1000, initAmount: 0)
            
        case .HeatSink:
            imageName = "HeatSink"
            buildPrice = 10
            progress = .Heat
            heatSystem = HeatSystem(size: 1000, coolingRate: 0.1)
            
            // HeatInlet, HeatOutlet,
            
        case .WaterPump:
            imageName = "WaterPump"
            buildPrice = 10
            progress = .Water
            waterSystem = WaterSystem(size: 100, produce: 3, output: true)
 
        case .GroundwaterPump:
            imageName = "GroundwaterPump"
            buildPrice = 10
            progress = .Water
            waterSystem = WaterSystem(size: 100, produce: 3, output: true)

        case .WaterPipe:
            imageName = "WaterPipe"
            buildPrice = 10
            progress = .Water
            waterSystem = WaterSystem(size: 100, output: true)
            
        case .SmallOffice:
            imageName = "SmallOffice"
            buildPrice = 10
            heatSystem = HeatSystem(size: 10)
            moneySystem = MoneySystem(initAmount: 0, energy2MoneyAmount: 5)
            
        case .MediumOffice:
            imageName = "MediumOffice"
            buildPrice = 10
            heatSystem = HeatSystem(size: 10)
            moneySystem = MoneySystem(initAmount: 0, energy2MoneyAmount: 50)
            
        case .LargeOffice:
            imageName = "LargeOffice"
            buildPrice = 10
            heatSystem = HeatSystem(size: 10)
            moneySystem = MoneySystem(initAmount: 0, energy2MoneyAmount: 500)
            
        case .Bank:
            imageName = "Bank"
            buildPrice = 10
            heatSystem = HeatSystem(size: 10)
            bankAddPercent = 0.5
            
        case .ResearchCenter:
            imageName = "ResearchCenter"
            buildPrice = 10
            heatSystem = HeatSystem(size: 10)
            researchSystem = ResearchSystem(amount: 10)
            
        case .AdvancedResearchCenter:
            imageName = "AdvancedResearchCenter"
            buildPrice = 10
            heatSystem = HeatSystem(size: 10)
            researchSystem = ResearchSystem(amount: 100)
            
        case .Library:
            imageName = "Library"
            buildPrice = 10
            heatSystem = HeatSystem(size: 10)
            libraryAddPercent = 0.5
            
        default:
            imageName = "WindTurbine"
            buildPrice = 1
        }
        
        reloadUpgradeAndResearchData()
    }
    
    func reloadUpgradeAndResearchData() {
        switch buildType {
        case .WindTurbine:
            energySystem.produce = upgradeLevel[UpgradeType.WindTurbineEffectiveness]! * 1
            timeSystem.rebuild = (researchLevel[ResearchType.WindTurbineRebuild] > 0 ? true : false)
        default: break
        }
        //
        //
        //
        //
        //
        //
        //
        //
        //
        //
        //
        //
        //
        //
    }
    
    func heatTransformEnergy() {
        if heatSystem != nil && energySystem != nil && energySystem.isHeat2Energy() {
            if heatSystem.inAmount >= energySystem.heat2EnergyAmount {
                energySystem.inAmount += energySystem.heat2EnergyAmount
                heatSystem.inAmount -= energySystem.heat2EnergyAmount
            } else {
                energySystem.inAmount += heatSystem.inAmount
                heatSystem.inAmount = 0
            }
        }
    }
    
    func waterTransformEnergy() {
        if waterSystem != nil && energySystem != nil && energySystem.water2Energy {
            if heatSystem.inAmount >= waterSystem.inAmount * 100 {
                energySystem.inAmount += waterSystem.inAmount * 100
                heatSystem.inAmount -= waterSystem.inAmount * 100
                waterSystem.inAmount = 0
            } else {
                energySystem.inAmount += heatSystem.inAmount
                if heatSystem.inAmount > 0 {
                    waterSystem.inAmount -= heatSystem.inAmount / 100 + 1
                }
                heatSystem.inAmount = 0
            }
        }
    }
    
    func heatTransformMoney() {
        if heatSystem != nil && moneySystem != nil && moneySystem.isHeat2Money() {
            if heatSystem.inAmount >= moneySystem.heat2MoneyAmount {
                moneySystem.inAmount += moneySystem.heat2MoneyAmount
                heatSystem.inAmount -= moneySystem.heat2MoneyAmount
            } else {
                moneySystem.inAmount += heatSystem.inAmount
                heatSystem.inAmount = 0
            }
        }
    }
    
    func image(name: String) -> SKSpriteNode {
        let buildingImage = SKSpriteNode(imageNamed: imageName)
        buildingImage.name = name
        buildingImage.size = tilesScaleSize
        return buildingImage
    }
    
    func buildingInfo() -> [String] {
        var info = [String]()
        if timeSystem != nil {
            info.append("Time: \(timeSystem.inAmount) / \(timeSystem.size)")
        }
        if heatSystem != nil {
            info.append("Heat: \(heatSystem.inAmount) / \(heatSystem.size)")
        }
        if waterSystem != nil {
            info.append("Water: \(waterSystem.inAmount) / \(waterSystem.size)")
        }
        if ([.WindTurbine, .WaveCell]).contains(buildType) {
            info.append("Produce Energy: \(energySystem.produce)")
        }
        if ([.SolarCell, .CoalBurner, .GasBurner, .NuclearCell, .FusionCell]).contains(buildType) {
            info.append("Produce Heat: \(heatSystem.produceHeatValue())")
        }
        if ([.SmallGenerator, .MediumGenerator, .LargeGenerator]).contains(buildType) {
            info.append("Converted Energy: \(energySystem.heat2EnergyAmount)")
        }
        if ([.SmallOffice, .MediumOffice, .LargeOffice]).contains(buildType) {
            info.append("Produce Money: \(moneySystem.heat2MoneyAmount)")
        }
        if !([.WindTurbine, .SolarCell, .CoalBurner, .WaveCell, .GasBurner, .NuclearCell, .FusionCell]).contains(buildType) {
            info.append("Sell Money: 0")
        } else {
            info.append("Sell Money: \(buildPrice)")
        }
        return info
    }
}
