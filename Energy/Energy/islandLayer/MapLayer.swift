//
//  Building.swift
//  Energy
//
//  Created by javan.chen on 2015/12/9.
//  Copyright © 2015年 Javan chen. All rights reserved.
//

import SpriteKit

class EnergySystem {
    var inAmount: Int = 0
    var produce: Int
    var isHeat2Energy: Bool
    var heat2EnergyAmount: Int
    var isWater2Energy: Bool
    var water2EnergyAmount: Int
    
    init(initAmount: Int, produce: Int = 0, isHeat2Energy: Bool = false, heat2EnergyAmount: Int = 0, isWater2Energy: Bool = false, water2EnergyAmount: Int = 0) {
        self.inAmount = initAmount
        self.produce = produce
        self.isHeat2Energy = isHeat2Energy
        self.heat2EnergyAmount = heat2EnergyAmount
        self.isWater2Energy = isWater2Energy
        self.water2EnergyAmount = water2EnergyAmount
    }
    func produceEnergy() {
        inAmount += produce
    }
}

class HeatSystem {
    var size: Int
    var inAmount: Int
    var produce: Int
    var output: Bool
    
    init(size: Int, initAmount: Int = 0, produce: Int = 0, output: Bool = false) {
        self.size = size
        self.inAmount = initAmount
        self.produce = produce
        self.output = output
    }
    func produceHeat() {
        inAmount += produce
    }
    func overflow() -> Bool {
        if inAmount > size { return true }
        else { return false }
    }
    func outputHeatToOtherHeatSystem(heatSystems:[HeatSystem]){
        while inAmount > 0 {
            for heatSystem in heatSystems {
                if inAmount == 0 { break }
                ++heatSystem.inAmount
                --inAmount
            }
        }
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
    func balanceWithOtherWaterSystem(var waterSystems:[WaterSystem]){
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
    enum ProgressType { case Time, Hot, Water }
    var progress: ProgressType!
    
    var energySystem: EnergySystem!
    var waterSystem: WaterSystem!
    var heatSystem: HeatSystem!
    
    // Time
    var rebuild: Bool = true
    var time_Max: Int!
    var time_Current: Int!
    
    // Other
    var research_Produce: Int!
    var money_Sales: Int!
    
    init(buildType: BuildingType) {
        self.buildType = buildType
        if buildType == .Land {
            imageName = "Land"
            rebuild = false
        }
        if buildType == .WindTurbine {
            imageName = "WindTurbine"
            buildPrice = 1
            progress = .Time
            
            time_Max = 5
            time_Current = 5
         
            energySystem = EnergySystem(initAmount: 0, produce: 1)
        }
        if buildType == .CoalBurner {
            imageName = "CoalBurner"
            buildPrice = 20
            progress = .Time
            
            time_Max = 10
            time_Current = 10
            
            heatSystem = HeatSystem(size: 150, produce: 20, output: true)
        }
        if buildType == .SmallGenerator {
            imageName = "SmallGenerator"
            buildPrice = 50
            progress = .Hot

            energySystem = EnergySystem(initAmount: 0, isHeat2Energy: true, heat2EnergyAmount: 8)
            heatSystem = HeatSystem(size: 400, initAmount: 100)
            waterSystem = WaterSystem(size: 100)
        }
        if buildType == .SmallOffice {
            imageName = "SmallOffice"
            buildPrice = 10
            
            heatSystem = HeatSystem(size: 10)
            money_Sales = 5
        }
        if buildType == .WaterPump {
            imageName = "電池"
            buildPrice = 10
            progress = .Water
            
            waterSystem = WaterSystem(size: 100, initAmount: 0, produce: 10, output: true)
        }
    }
    
    func heatTransformEnergy() {
        if heatSystem == nil { return }
        if energySystem == nil { return }
        if !energySystem.isHeat2Energy { return }
        if heatSystem.inAmount >= energySystem.heat2EnergyAmount {
            energySystem.inAmount += energySystem.heat2EnergyAmount
            heatSystem.inAmount -= energySystem.heat2EnergyAmount
        } else {
            energySystem.inAmount += heatSystem.inAmount
            heatSystem.inAmount = 0
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
        if buildType == .WindTurbine {
            info.append("Time: \(time_Current) / \(time_Max)")
            info.append("Produce Energy: \(energySystem.produce)")
            info.append("Sell Money: \(buildPrice)")
        }
        if buildType == .CoalBurner {
            info.append("Time: \(time_Current) / \(time_Max)")
            info.append("Heat: \(heatSystem.inAmount) / \(heatSystem.size)")
            info.append("Produce Hot: \(heatSystem.produce)")
            info.append("Sell Money: \(buildPrice)")
        }
        if buildType == .SmallGenerator {
            info.append("Heat: \(heatSystem.inAmount) / \(heatSystem.size)")
            info.append("Water: \(waterSystem.inAmount) / \(waterSystem.size)")
            info.append("Converted Energy: \(energySystem.heat2EnergyAmount)")
            info.append("Sell Money: \(buildPrice)")
        }
        if buildType == .SmallOffice {
            info.append("Heat: \(heatSystem.inAmount) / \(heatSystem.size)")
            info.append("Produce Money: \(money_Sales)")
            info.append("Sell Money: \(buildPrice)")
        }
        if buildType == .WaterPump {
            info.append("Water: \(waterSystem.inAmount) / \(waterSystem.size)")
            info.append("Sell Money: \(buildPrice)")
        }
        return info
    }
}

class Building: SKNode {
    
    var coord: CGPoint!
    var buildingNode: SKSpriteNode!
    
    var buildingData: BuildingData!
    var activate: Bool = true
    
    var progressBack: SKSpriteNode!
    var progress: SKSpriteNode!

    func configureAtCoord(coord: CGPoint, buildType: BuildingType) {
        self.coord = coord
        name = String(buildType.hashValue)

        buildingData = BuildingData(buildType: buildType)
        buildingNode = SKSpriteNode(imageNamed: buildingData.imageName)
        buildingNode.anchorPoint = CGPoint(x: 0, y: 1)
        addChild(buildingNode)
        
        if buildType == .Land {
            buildingNode.alpha = 0.2
            activate = false
        }
        
        // Add progress
        if buildingData.progress != nil {
            progressBack = SKSpriteNode()
            progressBack.size = CGSize(width: 56, height: 5)
            progressBack.anchorPoint = CGPoint(x: 0, y: 0)
            progressBack.position = CGPoint(x: 4, y: -60)
            progressBack.alpha = 0.3
            progressBack.zPosition = 1
            addChild(progressBack)
            progress = SKSpriteNode()
            progress = SKSpriteNode()
            progress.size = CGSize(width: 56, height: 5)
            progress.anchorPoint = CGPoint(x: 0, y: 0)
            progress.position = CGPoint(x: 4, y: -60)
            progress.alpha = 0.7
            progress.zPosition = 1
            addChild(progress)
            switch buildingData.progress! {
            case .Time:
                progressBack.color = SKColor.yellowColor()
                progress.color = SKColor.yellowColor()
            case .Hot:
                progressBack.color = SKColor.redColor()
                progress.color = SKColor.redColor()
            case .Water:
                progressBack.color = colorEnergy
                progress.color = colorEnergy
            }
        }
        progressUpdate()
    }
    
    // MARK: progress update
    func progressUpdate() {
        if buildingData.progress != nil {
            switch buildingData.progress! {
            case .Time:
                let persent = CGFloat(buildingData.time_Current) / CGFloat(buildingData.time_Max)
                progress.xScale = persent
            case .Hot:
                let persent = CGFloat(buildingData.heatSystem.inAmount) / CGFloat(buildingData.heatSystem.size)
                progress.xScale = persent
            case .Water:
                let persent = CGFloat(buildingData.waterSystem.inAmount) / CGFloat(buildingData.waterSystem.size)
                progress.xScale = persent
            }
        }
    }
}

class BuildingMapLayer: SKSpriteNode {
    
    var origin: CGPoint!
    var tileSize: CGSize = CGSizeMake(64, 64)
    var mapSize: CGSize = CGSizeMake(9, 11)
    var buildings = Array<Array<Building?>>()
    var money_TickAdd: Int = 0
    var research_TickAdd: Int = 0
    var energy_TickAdd: Int = 0
    var energy: Int = 0
    var energyMax: Int = 100
    var autoRebuild: Bool = true
    
    // MARK: Configure At Position
    func configureAtPosition(position: CGPoint) {
        self.origin = position
        self.position = position
        self.color = SKColor.whiteColor()
        self.size = CGSize(width: tileSize.width * mapSize.width, height: tileSize.height * mapSize.height)
        self.anchorPoint = CGPoint(x: 0, y: 1)
        self.name = "MapLayer"
        
        // Initialization map
        for _ in 0 ..< Int(mapSize.height) {
            buildings.append(Array(count: Int(mapSize.width), repeatedValue: nil))
        }
        for y in 0 ..< Int(mapSize.height) {
            for x in 0 ..< Int(mapSize.width) {
                let coord = CGPoint(x: x, y: y)
                setTileMapElement(coord: coord, buildType: .Land)
            }
        }
    }
    
    // MARK: Coord transfer to position
    func coord2Position(coord: CGPoint) -> CGPoint {
        let x = tileSize.width * coord.x
        let y = tileSize.height * -coord.y
        return CGPoint(x: x, y: y)
    }
    
    // MARK: Position transfer to Coord
    func position2Coord(mapPosition: CGPoint) -> CGPoint {
        let x = mapPosition.x / tileSize.width
        let y = mapPosition.y / -tileSize.height
        return CGPoint(x: Int(x), y: Int(y))
    }
    
    // MARK: Return the building by coord
    func buildingForCoord(coord: CGPoint) -> Building? {
        if coord.x < 0 || coord.x > mapSize.width - 1 || coord.y < 0 || coord.y > mapSize.height - 1 {
            return nil
        }
        return buildings[Int(coord.y)][Int(coord.x)]
    }
    
    // MARK: Remove building from coord
    func removeBuilding(coord: CGPoint) {
        buildings[Int(coord.y)][Int(coord.x)]!.removeFromParent()
        buildings[Int(coord.y)][Int(coord.x)] = nil
    }
    
    // MARK: Set tiles by word in coord
    func setTileMapElement(coord coord: CGPoint, buildType: BuildingType) {
        let x = Int(coord.x)
        let y = Int(coord.y)
        
        // Have Building, remove!
        if (buildings[y][x] != nil) {
            removeBuilding(coord)
        }
        // if nil, build
        if (buildings[y][x] == nil) {
            let building = Building()
            buildings[y][x] = building
            building.configureAtCoord(coord, buildType: buildType)
            building.position = coord2Position(coord)
            addChild(building)
        }
    }
    
    // MARK: Reload building Map
    func reloadBuildingMap() {
        for (y, line) in buildings.enumerate() {
            for (x, building) in line.enumerate() {
                let buildType = building?.buildingData.buildType
                let coord = CGPoint(x: x, y: y)
                removeBuilding(coord)
                setTileMapElement(coord: coord, buildType: buildType!)
            }
        }
    }
    
    // MARK: BuildingMap Update
    func Update() {
        
        // Water System
        
        // 1. Production
        for (_, line) in buildings.enumerate() {
        for (_, building) in line.enumerate() {
            if building!.buildingData.waterSystem != nil {
                building!.buildingData.waterSystem.produceWater()
            }
        }}
        // 2. transport
        for (y, line) in buildings.enumerate() {
        for (x, building) in line.enumerate() {
            if building!.buildingData.waterSystem != nil && building!.buildingData.waterSystem.output {
                var waterSystems = [WaterSystem]()
                if (y - 1 >= 0 && buildings[y-1][x]!.buildingData.waterSystem != nil) {
                    waterSystems.append(buildings[y-1][x]!.buildingData.waterSystem)
                }
                if (y + 1 <= 10 && buildings[y+1][x]!.buildingData.waterSystem != nil ) {
                    waterSystems.append(buildings[y+1][x]!.buildingData.waterSystem)
                }
                if (x - 1 >= 0 && buildings[y][x-1]!.buildingData.waterSystem != nil ) {
                    waterSystems.append(buildings[y][x-1]!.buildingData.waterSystem)
                }
                if (x + 1 <= 8 && buildings[y][x+1]!.buildingData.waterSystem != nil ) {
                    waterSystems.append(buildings[y][x+1]!.buildingData.waterSystem)
                }
                building!.buildingData.waterSystem.balanceWithOtherWaterSystem(waterSystems)
            }
        }}
        // 3. Caculate water overflow
        for (_, line) in buildings.enumerate() {
        for (_, building) in line.enumerate() {
            if building!.buildingData.waterSystem != nil {
                building!.buildingData.waterSystem.overflow()
            }
        }}
        
        // Heat System
        
        // 1. Production
        for (_, line) in buildings.enumerate() {
        for (_, building) in line.enumerate() {
            if building!.buildingData.heatSystem != nil {
                building!.buildingData.heatSystem.produceHeat()
            }
        }}
        // 2. output transport
        for (y, line) in buildings.enumerate() {
        for (x, building) in line.enumerate() {
            if building!.buildingData.heatSystem != nil && building!.buildingData.heatSystem.output {
                var heatSystems = [HeatSystem]()
                if (y - 1 >= 0 && buildings[y-1][x]!.buildingData.heatSystem != nil) {
                    heatSystems.append(buildings[y-1][x]!.buildingData.heatSystem)
                }
                if (y + 1 <= 10 && buildings[y+1][x]!.buildingData.heatSystem != nil ) {
                    heatSystems.append(buildings[y+1][x]!.buildingData.heatSystem)
                }
                if (x - 1 >= 0 && buildings[y][x-1]!.buildingData.heatSystem != nil ) {
                    heatSystems.append(buildings[y][x-1]!.buildingData.heatSystem)
                }
                if (x + 1 <= 8 && buildings[y][x+1]!.buildingData.heatSystem != nil ) {
                    heatSystems.append(buildings[y][x+1]!.buildingData.heatSystem)
                }
                if heatSystems.count > 0 {
                    building!.buildingData.heatSystem.outputHeatToOtherHeatSystem(heatSystems)
                }
            }
        }}
        // 3. Heat transform energy
        for (_, line) in buildings.enumerate() {
        for (_, building) in line.enumerate() {
            if building!.buildingData.energySystem != nil && building!.buildingData.energySystem.isHeat2Energy {
                building!.buildingData.heatTransformEnergy()
            }
        }}
        
        // Destroy & Activate & Rebuild & Update Progress
        for (y, line) in buildings.enumerate() {
        for (x, building) in line.enumerate() {
            let buildingData = building!.buildingData
            if building!.activate {
                // A. Destroy
                if buildingData.heatSystem != nil {
                    if buildingData.heatSystem.inAmount > buildingData.heatSystem.size {
                        let coord = CGPoint(x: x, y: y)
                        removeBuilding(coord)
                        setTileMapElement(coord: coord, buildType: .Land)
                    }
                }
                // B. Activate
                if buildingData.time_Max != nil {
                    buildingData.time_Current!--
                    if buildingData.time_Current < 0 {
                        building!.activate = false
                        building!.alpha = 0.5
                        buildingData.time_Current = 0
                    }
                }
            } else {
                // C. Rebuild
                if buildingData.rebuild && autoRebuild {
                    let price = building!.buildingData.buildPrice!
                    if price <= money {
                        money -= price
                        buildingData.time_Current = buildingData.time_Max
                        building!.activate = true
                        building!.alpha = 1
                    }
                }
            }
            // D. Update progress
            building!.progressUpdate()
        }}
        
        // 5. Calculate research, energy, money tick add
        research_TickAdd = 0
        energy_TickAdd = 0
        money_TickAdd = 0
        for (_, line) in buildings.enumerate() {
        for (_, building) in line.enumerate() {
        if building!.activate {
            // research
            if building!.buildingData.research_Produce != nil {
                research_TickAdd += (building?.buildingData.research_Produce)!
            }
            // energy
            if building!.buildingData.energySystem != nil {
                energy_TickAdd += building!.buildingData.energySystem.inAmount
                building!.buildingData.energySystem.inAmount = 0
            }
            // money
            if building?.buildingData.money_Sales != nil {
                money_TickAdd += (building?.buildingData.money_Sales)!
            }
        }}}
        // 6. Calculate energy
        energy += energy_TickAdd
        
        // 7. Calculate real money tick add and energy left
        if energy >= money_TickAdd {
            energy -= money_TickAdd
            if energy > energyMax { energy = energyMax }
        } else {
            money_TickAdd = energy
            energy = 0
        }
    }
    
    // MARK: Load Tile Map by word array
//    func LoadTileMap() {
//        for (row, line) in buildings.enumerate() {
//            for (colume, letter) in line.enumerate() {
//                let coord = CGPoint(x: colume, y: row)
//                let build = Building()
//                build.configureAtCoord(coord, build: BuildMenu.Wind)
//                build.position = Coord2Position(coord)
//                buildings[Int(coord.y)][Int(coord.x)] = build
//                addChild(build)
//            }
//        }
//    }
}