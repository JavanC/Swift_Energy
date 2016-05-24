//
//  BuildingData.swift
//  Energy
//
//  Created by javan.chen on 2016/1/5.
//  Copyright © 2016年 Javan chen. All rights reserved.
//

import SpriteKit

class TimeSystem: NSObject, NSCoding {
    var size: Double
    var inAmount: Double
    var rebuild: Bool
    
    init(size: Double, rebuild: Bool) {
        self.size = size
        self.inAmount = size
        self.rebuild = rebuild
    }
    func tick() -> Bool{
        if inAmount > 0 { inAmount -= 1 }
        if inAmount == 0 { return false }
        return true
    }
    func resetTime() {
        inAmount = size
    }
    
    // NSCoding
    required convenience init?(coder aDecoder: NSCoder) {
        guard let size = aDecoder.decodeObjectForKey("size") as? Double,
        let inAmount = aDecoder.decodeObjectForKey("inAmount") as? Double,
        let rebuild = aDecoder.decodeObjectForKey("rebuild") as? Bool
            else { return nil }
        self.init(size: size, rebuild: rebuild)
        self.inAmount = inAmount
    }
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(size, forKey: "size")
        aCoder.encodeObject(inAmount, forKey: "inAmount")
        aCoder.encodeObject(rebuild, forKey: "rebuild")
    }
}

class ResearchSystem: NSObject, NSCoding {
    var addAmount: Double = 0
    var multiply: Double = 1
    
    init(addAmount: Double, multiply: Double = 1) {
        self.addAmount = addAmount
        self.multiply = multiply
    }
    func researchMultiplyAmount() -> Double {
        return addAmount * multiply
    }
    
    // NSCoding
    required convenience init?(coder aDecoder: NSCoder) {
        guard let addAmount = aDecoder.decodeObjectForKey("addAmount") as? Double,
            let multiply = aDecoder.decodeObjectForKey("multiply") as? Double
            else { return nil }
        self.init(addAmount: addAmount, multiply: multiply)
    }
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(addAmount, forKey: "addAmount")
        aCoder.encodeObject(multiply, forKey: "multiply")
    }
}

class MoneySystem: NSObject, NSCoding {
    var inAmount: Double = 0
    var energy2MoneyAmount: Double
    var heat2MoneyAmount: Double
    var multiply: Double = 1
    
    init(initAmount: Double, energy2MoneyAmount: Double = 0, heat2MoneyAmount: Double = 0) {
        self.inAmount = initAmount
        self.energy2MoneyAmount = energy2MoneyAmount
        self.heat2MoneyAmount = heat2MoneyAmount
    }
    func isHeat2Money() -> Bool {
        if heat2MoneyAmount > 0 { return true }
        return false
    }
    func energy2MoneyMultiplyAmount() -> Double {
        return energy2MoneyAmount * multiply
    }
    
    // NSCoding
    required convenience init?(coder aDecoder: NSCoder) {
        guard let inAmount = aDecoder.decodeObjectForKey("inAmount") as? Double,
            let energy2MoneyAmount = aDecoder.decodeObjectForKey("energy2MoneyAmount") as? Double,
            let heat2MoneyAmount = aDecoder.decodeObjectForKey("heat2MoneyAmount") as? Double,
            let multiply = aDecoder.decodeObjectForKey("multiply") as? Double
        
            else { return nil }
        self.init(initAmount: inAmount, energy2MoneyAmount: energy2MoneyAmount, heat2MoneyAmount:heat2MoneyAmount)
        self.multiply = multiply
    }
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(inAmount, forKey: "inAmount")
        aCoder.encodeObject(energy2MoneyAmount, forKey: "energy2MoneyAmount")
        aCoder.encodeObject(heat2MoneyAmount, forKey: "heat2MoneyAmount")
        aCoder.encodeObject(multiply, forKey: "multiply")
    }
}

class EnergySystem: NSObject, NSCoding {
    var inAmount: Double = 0
    var produce: Double!
    var heat2EnergyAmount: Double
    var water2Energy: Bool
    
    init(initAmount: Double, produce: Double = 0, heat2EnergyAmount: Double = 0, water2Energy: Bool = false) {
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
    
    // NSCoding
    required convenience init?(coder aDecoder: NSCoder) {
        guard let inAmount = aDecoder.decodeObjectForKey("inAmount") as? Double,
            let produce = aDecoder.decodeObjectForKey("produce") as? Double,
            let heat2EnergyAmount = aDecoder.decodeObjectForKey("heat2EnergyAmount") as? Double,
            let water2Energy = aDecoder.decodeObjectForKey("water2Energy") as? Bool
            
            else { return nil }
        self.init(initAmount: inAmount, produce: produce, heat2EnergyAmount: heat2EnergyAmount, water2Energy: water2Energy)
    }
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(inAmount, forKey: "inAmount")
        aCoder.encodeObject(produce, forKey: "produce")
        aCoder.encodeObject(heat2EnergyAmount, forKey: "heat2EnergyAmount")
        aCoder.encodeObject(water2Energy, forKey: "water2Energy")
    }
}

class HeatSystem: NSObject, NSCoding {
    var size: Double
    var inAmount: Double
    var produce: Double
    var produceMultiply: Double = 1.0
    var output: Bool
    var coolingRate: Double
    var inletTransfer: Double
    
    init(size: Double, initAmount: Double = 0, produce: Double = 0, output: Bool = false, coolingRate: Double = 0, inletTransfer: Double = 0) {
        self.size = size
        self.inAmount = initAmount
        self.produce = produce
        self.output = output
        self.coolingRate = coolingRate
        self.inletTransfer = inletTransfer
    }
    func produceHeatValue() -> Double {
        return produce * produceMultiply
    }
    func produceHeat() {
        inAmount += produce * produceMultiply
    }
    func overflow() -> Bool {
        if inAmount > size { return true }
        else { return false }
    }
    func outputHeatToOtherHeatSystem(heatSystems:[HeatSystem]) {
        if heatSystems.count == 0 { return }
        for heatSystem in heatSystems {
            heatSystem.inAmount += inAmount / Double(heatSystems.count)
        }
        inAmount = 0
    }
    func exchangerHeatToOtherHeatSystem(heatSystems:[HeatSystem]) {
        var allHeat: Double = 0
        for heatSystem in heatSystems {
            allHeat += heatSystem.inAmount
            heatSystem.inAmount = 0
        }
        for heatSystem in heatSystems {
            heatSystem.inAmount = allHeat / Double(heatSystems.count)
        }
    }
    func heatInletToOutletHeatSystem(heatSystems:[HeatSystem]) {
        if heatSystems.count == 0 { return }
        if inAmount >= inletTransfer {
            let outputHeat = inletTransfer / Double(heatSystems.count)
            for HeatSystem in heatSystems {
                HeatSystem.inAmount += outputHeat
            }
            inAmount -= inletTransfer
        } else {
            let outputHeat = inAmount / Double(heatSystems.count)
            for HeatSystem in heatSystems {
                HeatSystem.inAmount += outputHeat
            }
            inAmount = 0
        }
    }
    func coolingHeat() {
        inAmount = inAmount * (1 - coolingRate)
    }
    
    // NSCoding
    required convenience init?(coder aDecoder: NSCoder) {
        guard let size = aDecoder.decodeObjectForKey("size") as? Double,
            let inAmount = aDecoder.decodeObjectForKey("inAmount") as? Double,
            let produce = aDecoder.decodeObjectForKey("produce") as? Double,
            let produceMultiply = aDecoder.decodeObjectForKey("produceMultiply") as? Double,
            let output = aDecoder.decodeObjectForKey("output") as? Bool,
            let coolingRate = aDecoder.decodeObjectForKey("coolingRate") as? Double,
            let inletTransfer = aDecoder.decodeObjectForKey("inletTransfer") as? Double
            else { return nil }
        self.init(size: size, initAmount: inAmount, produce: produce, output: output, coolingRate: coolingRate, inletTransfer: inletTransfer)
        self.produceMultiply = produceMultiply
    }
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(size, forKey: "size")
        aCoder.encodeObject(inAmount, forKey: "inAmount")
        aCoder.encodeObject(produce, forKey: "produce")
        aCoder.encodeObject(produceMultiply, forKey: "produceMultiply")
        aCoder.encodeObject(output, forKey: "output")
        aCoder.encodeObject(coolingRate, forKey: "coolingRate")
        aCoder.encodeObject(inletTransfer, forKey: "inletTransfer")
    }
}

class WaterSystem: NSObject, NSCoding {
    var size: Double
    var inAmount: Double
    var produce: Double
    var output: Bool
    
    init(size: Double, initAmount: Double = 0, produce: Double = 0, output: Bool = false){
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
    func add(amount:Double) -> Bool {
        if inAmount + amount <= size{
            inAmount += amount
            return true
        }
        return false
    }
    func balanceWithOtherWaterSystem(waterSystems:[WaterSystem]) {
        var waterSystems = waterSystems
        
        var allWater: Double = 0
        for waterSystem in waterSystems {
            allWater += waterSystem.inAmount
            waterSystem.inAmount = 0
        }
        
        while waterSystems.count > 0 {
            var minSizeIndex = 0
            var minSize = waterSystems[minSizeIndex].size
            
            for (index, waterSystem) in waterSystems.enumerate() {
                if waterSystem.size < minSize {
                    minSize = waterSystem.size
                    minSizeIndex = index
                }
            }
            
            if allWater > minSize * Double(waterSystems.count) {
                allWater -= minSize
                waterSystems[minSizeIndex].inAmount = minSize
                waterSystems.removeAtIndex(minSizeIndex)
            } else {
                for waterSystem in waterSystems {
                    waterSystem.inAmount = allWater / Double(waterSystems.count)
                }
                break
            }
        }
    }
    
    // NSCoding
    required convenience init?(coder aDecoder: NSCoder) {
        guard let size = aDecoder.decodeObjectForKey("size") as? Double,
            let inAmount = aDecoder.decodeObjectForKey("inAmount") as? Double,
            let produce = aDecoder.decodeObjectForKey("produce") as? Double,
            let output = aDecoder.decodeObjectForKey("output") as? Bool
            
            else { return nil }
        self.init(size: size, initAmount: inAmount, produce: produce, output: output)
    }
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(size, forKey: "size")
        aCoder.encodeObject(inAmount, forKey: "inAmount")
        aCoder.encodeObject(produce, forKey: "produce")
        aCoder.encodeObject(output, forKey: "output")
    }
}

class BuildingData: NSObject, NSCoding {

    var imageName: String = ""
    var name: String = ""
    var comment: String = ""
    var buildType: BuildingType = .Land
    var buildPrice: Double = 0
    enum ProgressType: Int { case Time, Heat, Water}
    var progress: ProgressType!
    var timeSystem: TimeSystem!
    var heatSystem: HeatSystem!
    var waterSystem: WaterSystem!
    var moneySystem: MoneySystem!
    var energySystem: EnergySystem!
    var researchSystem: ResearchSystem!
    
    // Other
    var batteryEnergySize: Double!
    var isolationPercent: Double!
    var bankAddPercent: Double!
    var libraryAddPercent: Double!
    
    init(buildType: BuildingType) {
        super.init()
        self.buildType = buildType
        
        switch buildType {
        case .Land:
            imageName = "Land"
            buildPrice = 0
            
        case .Ocean:
            imageName = "Ocean"
            buildPrice = 0
            
        case .Rock:
            imageName = "Rock"
            buildPrice = 0

        case .WindTurbine:
            imageName = "WindTurbine"
            name = "Wind Turbine".localized
            comment = "Produced energy by the wind.".localized
            buildPrice = 1
            progress = .Time
            let size = baseToPower(20, base: 1.5, power: upgradeLevel[UpgradeType.WindTurbineLifetime]!)
            timeSystem = TimeSystem(size: size, rebuild: false)
            energySystem = EnergySystem(initAmount: 0, produce: 0.1)
            
        case .SolarCell:
            imageName = "SolarCell"
            name = "Solar Plant".localized
            comment = "Produced heat by the solar. Transfer Heat to the surrounding buildings, Such as a generator.".localized
            buildPrice = 100
            progress = .Time
            let size = baseToPower(40, base: 1.5, power: upgradeLevel[UpgradeType.SolarCellLifetime]!)
            timeSystem = TimeSystem(size: size, rebuild: false)
            heatSystem = HeatSystem(size: 10, produce: 3, output: true)
            
        case .CoalBurner:
            imageName = "CoalBurner"
            name = "Coal-Fired Plant".localized
            comment = "Produce heat by burning coal.".localized
            buildPrice = 10000
            progress = .Time
            let size = baseToPower(120, base: 1.5, power: upgradeLevel[UpgradeType.CoalBurnerLifetime]!)
            timeSystem = TimeSystem(size: size, rebuild: false)
            heatSystem = HeatSystem(size: 10, produce: 100, output: true)
            
        case .WaveCell:
            imageName = "WaveCell"
            name = "Wave Energy".localized
            comment = "Produced energy by the ocean wave. Must be placed in water.".localized
            buildPrice = 1000000
            progress = .Time
            let size = baseToPower(400, base: 1.5, power: upgradeLevel[UpgradeType.WaveCellLifetime]!)
            timeSystem = TimeSystem(size: size, rebuild: false)
            energySystem = EnergySystem(initAmount: 10, produce: 2700)
            
        case .GasBurner:
            imageName = "GasBurner"
            name = "Gas-Fired Plant".localized
            comment = "Produce heat by burning gas.".localized
            buildPrice = 100000000
            progress = .Time
            let size = baseToPower(600, base: 1.5, power: upgradeLevel[UpgradeType.GasBurnerLifetime]!)
            timeSystem = TimeSystem(size: size, rebuild: false)
            heatSystem = HeatSystem(size: 10, produce: 200000, output: true)
            
        case .NuclearCell:
            imageName = "NuclearCell"
            name = "Nuclear Plant".localized
            comment = "Produce heat by nuclear fission.".localized
            buildPrice = 10000000000
            progress = .Time
            let size = baseToPower(1200, base: 1.5, power: upgradeLevel[UpgradeType.NuclearCellLifetime]!)
            timeSystem = TimeSystem(size: size, rebuild: false)
            heatSystem = HeatSystem(size: 10, produce: 10000000, output: true)
            
        case .FusionCell:
            imageName = "FusionCell"
            name = "Fusion Plant".localized
            comment = "Produce heat by nuclear fusion.".localized
            buildPrice = 1000000000000
            progress = .Time
            let size = baseToPower(1600, base: 1.5, power: upgradeLevel[UpgradeType.FusionCellLifetime]!)
            timeSystem = TimeSystem(size: size, rebuild: false)
            heatSystem = HeatSystem(size: 10, produce: 2000000000, output: true)
            
        case .SmallGenerator:
            imageName = "SmallGenerator"
            name = "Small Generator".localized
            comment = "Converts heat to energy.".localized
            buildPrice = 300
            progress = .Heat
            energySystem = EnergySystem(initAmount: 0, heat2EnergyAmount: 3, water2Energy: true)
            heatSystem = HeatSystem(size: 20, initAmount: 0)
            waterSystem = WaterSystem(size: 1000, initAmount: 0)
            
        case .MediumGenerator:
            imageName = "MediumGenerator"
            name = "Medium Generator".localized
            comment = "Converts more heat to energy.".localized
            buildPrice = 200000000
            progress = .Heat
            energySystem = EnergySystem(initAmount: 0, heat2EnergyAmount: 12, water2Energy: true)
            heatSystem = HeatSystem(size: 80, initAmount: 0)
            waterSystem = WaterSystem(size: 4000, initAmount: 0)
            
        case .LargeGenerator:
            imageName = "LargeGenerator"
            name = "Large Generator".localized
            comment = "Converts mass heat to energy.".localized
            buildPrice = 5000000000000
            progress = .Heat
            energySystem = EnergySystem(initAmount: 0, heat2EnergyAmount: 48, water2Energy: true)
            heatSystem = HeatSystem(size: 320, initAmount: 0)
            waterSystem = WaterSystem(size: 16000, initAmount: 0)
            
        case .BoilerHouse:
            imageName = "BoilerHouse"
            name = "Boiler House".localized
            comment = "Direct sales store heat.".localized
            buildPrice = 30000
            progress = .Heat
            heatSystem = HeatSystem(size: 2000, initAmount: 0)
            moneySystem = MoneySystem(initAmount: 0, heat2MoneyAmount: 150)
            
        case .LargeBoilerHouse:
            imageName = "LargeBoilerHouse"
            name = "Large Boiler House".localized
            comment = "Direct sales more store heat.".localized
            buildPrice = 500000000
            progress = .Heat
            heatSystem = HeatSystem(size: 8000, initAmount: 0)
            moneySystem = MoneySystem(initAmount: 0, heat2MoneyAmount: 600)
            
        case .Isolation:
            imageName = "Isolation"
            name = "Isolation".localized
            comment = "Increases heat produce of adjacent building.".localized
            buildPrice = 1000
            isolationPercent = 0.1
            
        case .Battery:
            imageName = "Battery"
            name = "Battery".localized
            comment = "Increase the maximum energy that can be stored.".localized
            buildPrice = 50
            batteryEnergySize = 1000

        case .HeatExchanger:
            imageName = "HeatExchanger"
            name = "Heat Exchanger".localized
            comment = "Balance heat between adjacent components.".localized
            buildPrice = 50000
            progress = .Heat
            heatSystem = HeatSystem(size: 500, initAmount: 0)
            
        case .HeatSink:
            imageName = "HeatSink"
            name = "Heat Sink".localized
            comment = "Dissipation heat 10% from store heat. Stable heat source to prevent explosion.".localized
            buildPrice = 50000000
            progress = .Heat
            heatSystem = HeatSystem(size: 500000, coolingRate: 0.1)
            
        case .HeatInlet:
            imageName = "HeatInlet"
            name = "Heat Inlet".localized
            comment = "Heat distributes evenly to every heat outlet.".localized
            buildPrice = 100000000000000
            progress = .Heat
            heatSystem = HeatSystem(size: 8000000000, initAmount: 0, inletTransfer: 5000000000)
            
        case .HeatOutlet:
            imageName = "HeatOutlet"
            name = "Heat Outlet".localized
            comment = "Heat transfer from the heat inlet, heat output need heat exchanger or heat sink.".localized
            buildPrice = 100000000000000
            progress = .Heat
            heatSystem = HeatSystem(size: 8000000000, initAmount: 0)
            
        case .WaterPump:
            imageName = "WaterPump"
            name = "Water Pump".localized
            comment = "Produce Water to cools generators so they produce much more energy. Must be placed next to water.".localized
            buildPrice = 40000000000
            progress = .Water
            waterSystem = WaterSystem(size: 200000, produce: 30000, output: true)
 
        case .GroundwaterPump:
            imageName = "GroundwaterPump"
            name = "Groundwater Pump".localized
            comment = "Produce Water to cools generators so they produce much more energy.".localized
            buildPrice = 10000000000000
            progress = .Water
            waterSystem = WaterSystem(size: 300000, produce: 50000, output: true)

        case .WaterPipe:
            imageName = "WaterPipe"
            name = "Water Pipe".localized
            comment = "Expands water pumps effective area.".localized
            buildPrice = 10000000000
            progress = .Water
            waterSystem = WaterSystem(size: 200000, output: true)
            
        case .SmallOffice:
            imageName = "SmallOffice"
            name = "Small Office".localized
            comment = "Auto selling store of energy.".localized
            buildPrice = 400
            heatSystem = HeatSystem(size: 10)
            moneySystem = MoneySystem(initAmount: 0, energy2MoneyAmount: 5)
            
        case .MediumOffice:
            imageName = "MediumOffice"
            name = "Medium Office".localized
            comment = "Auto selling more store of energy.".localized
            buildPrice = 4000000
            heatSystem = HeatSystem(size: 10)
            moneySystem = MoneySystem(initAmount: 0, energy2MoneyAmount: 100)
            
        case .LargeOffice:
            imageName = "LargeOffice"
            name = "Large Office".localized
            comment = "Auto selling mass store of energy.".localized
            buildPrice = 200000000000
            heatSystem = HeatSystem(size: 10)
            moneySystem = MoneySystem(initAmount: 0, energy2MoneyAmount: 2000)
            
        case .Bank:
            imageName = "Bank"
            name = "Bank".localized
            comment = "Boosts office salse energy speed.".localized
            buildPrice = 10000000000000
            heatSystem = HeatSystem(size: 10)
            bankAddPercent = 0.2
            
        case .ResearchCenter:
            imageName = "ResearchCenter"
            name = "Research Center".localized
            comment = "Production Research points so that you can research new technology.".localized
            buildPrice = 200
            heatSystem = HeatSystem(size: 10)
            researchSystem = ResearchSystem(addAmount: 1)
            
        case .AdvancedResearchCenter:
            imageName = "AdvancedResearchCenter"
            name = "Advanced Research Center".localized
            comment = "Production more Research points so that you can research new technology.".localized
            buildPrice = 2000000
            heatSystem = HeatSystem(size: 10)
            researchSystem = ResearchSystem(addAmount: 6)
            
        case .Library:
            imageName = "Library"
            name = "Library".localized
            comment = "Boosts Research Center production research points speed.".localized
            buildPrice = 400000000000
            heatSystem = HeatSystem(size: 10)
            libraryAddPercent = 0.2
            
        default:
            imageName = "WindTurbine"
            buildPrice = 1
        }
        
        reloadUpgradeAndResearchData()
    }
    
    func reloadUpgradeAndResearchData() {
        switch buildType {
        case .WindTurbine:
            energySystem.produce = baseToPower(0.1, base: 1.5, power: upgradeLevel[UpgradeType.WindTurbineEffectiveness]!)
            timeSystem.size = baseToPower(20, base: 1.5, power: upgradeLevel[UpgradeType.WindTurbineLifetime]!)
            timeSystem.rebuild = (researchLevel[ResearchType.WindTurbineRebuild] > 0 ? true : false)
            
        case .SolarCell:
            heatSystem.produce = baseToPower(3, base: 1.25, power: upgradeLevel[UpgradeType.SolarCellEffectiveness]!)
            timeSystem.size = baseToPower(40, base: 1.5, power: upgradeLevel[UpgradeType.SolarCellLifetime]!)
            timeSystem.rebuild = (researchLevel[ResearchType.SolarCellRebuild] > 0 ? true : false)
            
        case .CoalBurner:
            heatSystem.produce = baseToPower(100, base: 1.25, power: upgradeLevel[UpgradeType.CoalBurnerEffectiveness]!)
            timeSystem.size = baseToPower(120, base: 1.5, power: upgradeLevel[UpgradeType.CoalBurnerLifetime]!)
            timeSystem.rebuild = (researchLevel[ResearchType.CoalBurnerRebuild] > 0 ? true : false)
            
        case .WaveCell:
            energySystem.produce = baseToPower(2700, base: 1.25, power: upgradeLevel[UpgradeType.WaveCellEffectiveness]!)
            timeSystem.size = baseToPower(400, base: 1.5, power: upgradeLevel[UpgradeType.WaveCellLifetime]!)
            timeSystem.rebuild = (researchLevel[ResearchType.WaveCellRebuild] > 0 ? true : false)
            
        case .GasBurner:
            heatSystem.produce = baseToPower(200000, base: 1.25, power: upgradeLevel[UpgradeType.GasBurnerEffectiveness]!)
            timeSystem.size = baseToPower(600, base: 1.5, power: upgradeLevel[UpgradeType.GasBurnerLifetime]!)
            timeSystem.rebuild = (researchLevel[ResearchType.GasBurnerRebuild] > 0 ? true : false)
            
        case .NuclearCell:
            heatSystem.produce = baseToPower(10000000, base: 1.25, power: upgradeLevel[UpgradeType.NuclearCellEffectiveness]!)
            timeSystem.size = baseToPower(1200, base: 1.5, power: upgradeLevel[UpgradeType.NuclearCellLifetime]!)
            timeSystem.rebuild = (researchLevel[ResearchType.NuclearCellRebuild] > 0 ? true : false)

        case .FusionCell:
            heatSystem.produce = baseToPower(2000000000, base: 1.25, power: upgradeLevel[UpgradeType.FusionCellEffectiveness]!)
            timeSystem.size = baseToPower(1600, base: 1.5, power: upgradeLevel[UpgradeType.FusionCellLifetime]!)
            timeSystem.rebuild = (researchLevel[ResearchType.FusionCellRebuild] > 0 ? true : false)
            
        case .SmallGenerator:
            energySystem.heat2EnergyAmount = baseToPower(3, base: 1.25, power: upgradeLevel[UpgradeType.GeneratorEffectiveness]!)
            heatSystem.size = baseToPower(20, base: 1.25, power: upgradeLevel[UpgradeType.GeneratorMaxHeat]!)
            waterSystem.size = baseToPower(1000, base: 1.25, power: upgradeLevel[UpgradeType.GeneratorMaxWater]!)
            
        case .MediumGenerator:
            energySystem.heat2EnergyAmount = baseToPower(12, base: 1.25, power: upgradeLevel[UpgradeType.GeneratorEffectiveness]!)
            heatSystem.size = baseToPower(80, base: 1.25, power: upgradeLevel[UpgradeType.GeneratorMaxHeat]!)
            waterSystem.size = baseToPower(4000, base: 1.25, power: upgradeLevel[UpgradeType.GeneratorMaxWater]!)
            
        case .LargeGenerator:
            energySystem.heat2EnergyAmount = baseToPower(48, base: 1.25, power: upgradeLevel[UpgradeType.GeneratorEffectiveness]!)
            heatSystem.size = baseToPower(320, base: 1.25, power: upgradeLevel[UpgradeType.GeneratorMaxHeat]!)
            waterSystem.size = baseToPower(16000, base: 1.25, power: upgradeLevel[UpgradeType.GeneratorMaxWater]!)
            
        case .BoilerHouse:
            moneySystem.heat2MoneyAmount = baseToPower(150, base: 1.2, power: upgradeLevel[UpgradeType.BoilerHouseSellAmount]!)
            heatSystem.size = baseToPower(2000, base: 1.25, power: upgradeLevel[UpgradeType.BoilerHouseMaxHeat]!)
            
        case .LargeBoilerHouse:
            moneySystem.heat2MoneyAmount = baseToPower(600, base: 1.2, power: upgradeLevel[UpgradeType.BoilerHouseSellAmount]!)
            heatSystem.size = baseToPower(8000, base: 1.25, power: upgradeLevel[UpgradeType.BoilerHouseMaxHeat]!)
            
        case .Isolation:
            isolationPercent = 0.1 * Double(upgradeLevel[UpgradeType.IsolationEffectiveness]! + 1)
            
        case .Battery:
            batteryEnergySize = baseToPower(1000, base: 1.5, power: upgradeLevel[UpgradeType.EnergyBatterySize]!)
            
        case .HeatExchanger:
            heatSystem.size = baseToPower(500, base: 1.5, power: upgradeLevel[UpgradeType.HeatExchangerMaxHeat]!)

        case .HeatSink:
            heatSystem.size = baseToPower(500000, base: 1.5, power: upgradeLevel[UpgradeType.HeatSinkMaxHeat]!)

        case .HeatInlet:
            heatSystem.size = baseToPower(8000000000, base: 1.5, power: upgradeLevel[UpgradeType.HeatInletOutletMaxHeat]!)
            heatSystem.inletTransfer = baseToPower(5000000000, base: 1.5, power: upgradeLevel[UpgradeType.HeatInletMaxTransfer]!)

        case .HeatOutlet:
            heatSystem.size = baseToPower(8000000000, base: 1.5, power: upgradeLevel[UpgradeType.HeatInletOutletMaxHeat]!)
            
        case .WaterPump:
            waterSystem.size = baseToPower(200000, base: 1.5, power: upgradeLevel[UpgradeType.WaterElementMaxWater]!)
            waterSystem.produce = baseToPower(30000, base: 1.25, power: upgradeLevel[UpgradeType.WaterPumpProduction]!)
            
        case .GroundwaterPump:
            waterSystem.size = baseToPower(300000, base: 1.5, power: upgradeLevel[UpgradeType.WaterElementMaxWater]!)
            waterSystem.produce = baseToPower(50000, base: 1.2, power: upgradeLevel[UpgradeType.GroundwaterPumpProduction]!)
            
        case .WaterPipe:
            waterSystem.size = baseToPower(200000, base: 1.5, power: upgradeLevel[UpgradeType.WaterElementMaxWater]!)
            
        case .SmallOffice:
            moneySystem.energy2MoneyAmount = baseToPower(5, base: 1.5, power: upgradeLevel[UpgradeType.OfficeSellEnergy]!)
            
        case .MediumOffice:
            moneySystem.energy2MoneyAmount = baseToPower(100, base: 1.5, power: upgradeLevel[UpgradeType.OfficeSellEnergy]!)

        case .LargeOffice:
            moneySystem.energy2MoneyAmount = baseToPower(2000, base: 1.5, power: upgradeLevel[UpgradeType.OfficeSellEnergy]!)
            
        case .Bank:
            bankAddPercent = 0.2 + 0.1 * Double(upgradeLevel[UpgradeType.BankEffectiveness]! + 1)
            
        case .ResearchCenter:
            researchSystem.addAmount = baseToPower(1, base: 1.25, power: upgradeLevel[UpgradeType.ResearchCenterEffectiveness]!)
            
        case .AdvancedResearchCenter:
            researchSystem.addAmount = baseToPower(6, base: 1.25, power: upgradeLevel[UpgradeType.ResearchCenterEffectiveness]!)
            
        case .Library:
            libraryAddPercent = 0.2  + 0.1 * Double(upgradeLevel[UpgradeType.LibraryEffectiveness]! + 1)
            
        default: break
        }
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
        let buildingImage = SKSpriteNode(texture: buildingAtlas.textureNamed(imageName))
        buildingImage.name = name
        buildingImage.size = tilesScaleSize
        return buildingImage
    }
    
    // NSCoding
    required convenience init?(coder aDecoder: NSCoder) {
        guard let imageName = aDecoder.decodeObjectForKey("imageName") as? String,
        let name = aDecoder.decodeObjectForKey("name") as? String,
        let comment = aDecoder.decodeObjectForKey("comment") as? String,
        let buildType = BuildingType(rawValue: (aDecoder.decodeObjectForKey("buildType") as? Int)!),
        let buildPrice = aDecoder.decodeObjectForKey("buildPrice") as? Double
        else { return nil }
        self.init(buildType: buildType)
        self.imageName = imageName
        self.name = name
        self.comment = comment
        self.buildPrice = buildPrice
        
        if let progress = aDecoder.decodeObjectForKey("progress") as? Int {
            self.progress = ProgressType(rawValue: progress)
        }
        if let timeSystem = aDecoder.decodeObjectForKey("timeSystem") as? TimeSystem {
            self.timeSystem = timeSystem
        }
        if let heatSystem = aDecoder.decodeObjectForKey("heatSystem") as? HeatSystem {
            self.heatSystem = heatSystem
        }
        if let waterSystem = aDecoder.decodeObjectForKey("waterSystem") as? WaterSystem {
            self.waterSystem = waterSystem
        }
        if let moneySystem = aDecoder.decodeObjectForKey("moneySystem") as? MoneySystem {
            self.moneySystem = moneySystem
        }
        if let energySystem = aDecoder.decodeObjectForKey("energySystem") as? EnergySystem {
            self.energySystem = energySystem
        }
        if let researchSystem = aDecoder.decodeObjectForKey("researchSystem") as? ResearchSystem {
            self.researchSystem = researchSystem
        }
        if let batteryEnergySize = aDecoder.decodeObjectForKey("batteryEnergySize") as? Double {
            self.batteryEnergySize = batteryEnergySize
        }
        if let isolationPercent = aDecoder.decodeObjectForKey("isolationPercent") as? Double {
            self.isolationPercent = isolationPercent
        }
        if let bankAddPercent = aDecoder.decodeObjectForKey("bankAddPercent") as? Double {
            self.bankAddPercent = bankAddPercent
        }
        if let libraryAddPercent = aDecoder.decodeObjectForKey("libraryAddPercent") as? Double {
            self.libraryAddPercent = libraryAddPercent
        }
    }
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(imageName, forKey: "imageName")
        aCoder.encodeObject(name, forKey: "name")
        aCoder.encodeObject(comment, forKey: "comment")
        aCoder.encodeObject(buildType.rawValue, forKey: "buildType")
        aCoder.encodeObject(buildPrice, forKey: "buildPrice")
        
        if progress != nil {
            aCoder.encodeObject(progress.rawValue, forKey: "progress")
        }
        if timeSystem != nil {
            aCoder.encodeObject(timeSystem, forKey: "timeSystem")
        }
        if heatSystem != nil {
            aCoder.encodeObject(heatSystem, forKey: "heatSystem")
        }
        if waterSystem != nil {
            aCoder.encodeObject(waterSystem, forKey: "waterSystem")
        }
        if moneySystem != nil {
            aCoder.encodeObject(moneySystem, forKey: "moneySystem")
        }
        if energySystem != nil {
            aCoder.encodeObject(energySystem, forKey: "energySystem")
        }
        if researchSystem != nil {
            aCoder.encodeObject(researchSystem, forKey: "researchSystem")
        }
        if batteryEnergySize != nil {
            aCoder.encodeObject(batteryEnergySize, forKey: "batteryEnergySize")
        }
        if isolationPercent != nil {
            aCoder.encodeObject(isolationPercent, forKey: "isolationPercent")
        }
        if bankAddPercent != nil {
            aCoder.encodeObject(bankAddPercent, forKey: "bankAddPercent")
        }
        if libraryAddPercent != nil {
            aCoder.encodeObject(libraryAddPercent, forKey: "libraryAddPercent")
        }
    }
}
