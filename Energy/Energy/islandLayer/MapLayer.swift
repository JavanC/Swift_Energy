//
//  Building.swift
//  Energy
//
//  Created by javan.chen on 2015/12/9.
//  Copyright © 2015年 Javan chen. All rights reserved.
//

import SpriteKit

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
        buildingNode = SKSpriteNode(texture: buildingAtlas.textureNamed(buildingData.imageName))
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
            case .Heat:
                progressBack.color = SKColor.redColor()
                progress.color = SKColor.redColor()
            case .Water:
                progressBack.color = colorEnergy
                progress.color = colorEnergy
            }
        }
        
        progressUpdate()
    }
    
    func loadBuildingData(buildingData: BuildingData) {
        name = String(buildingData.buildType.hashValue)
        
        self.buildingData = buildingData
        buildingNode.runAction(SKAction.setTexture(buildingAtlas.textureNamed(buildingData.imageName)))
        buildingNode.alpha = 1
        activate = true
        if buildingData.timeSystem != nil {
            activate = buildingData.timeSystem.inAmount == 0 ? false : true
            buildingNode.alpha = activate ? 1 : 0.5
        }
        
        if buildingData.buildType == .Land {
            buildingNode.alpha = 0.2
            activate = false
        }
        
        // Add progress
        if progressBack == nil && buildingData.progress != nil {
            progressBack = SKSpriteNode()
            progressBack.size = CGSize(width: 56, height: 5)
            progressBack.anchorPoint = CGPoint(x: 0, y: 0)
            progressBack.position = CGPoint(x: 4, y: -60)
            progressBack.alpha = 0.3
            progressBack.zPosition = 1
            addChild(progressBack)
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
            case .Heat:
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
                let persent = CGFloat(buildingData.timeSystem.inAmount) / CGFloat(buildingData.timeSystem.size)
                progress.xScale = persent
            case .Heat:
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
    
    var mapNumber: Int!
    var tileSize: CGSize = CGSizeMake(64, 64)
    var mapSize: CGSize = CGSizeMake(9, 11)
    var buildings = Array<Array<Building?>>()
    var money_TickAdd: Double = 0
    var research_TickAdd: Double = 0
    var energy_TickAdd: Double = 0
    var energy: Double = 0
    var energyMax: Double = 100
    var autoRebuild: Bool = true
    
    // MARK: Configure At Position
    func configureAtPosition(position: CGPoint, mapNumber: Int) {
        self.mapNumber = mapNumber
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
    
    // MARK: Reload Map Upgrade Data
    func reloadMap() {
        for line in buildings {
            for building in line {
                building?.buildingData.reloadUpgradeAndResearchData()
            }
        }
    }
    
    // MARK: Save Map Data
    func saveGameData() {
        NSUserDefaults.standardUserDefaults().setDouble(energy, forKey: "map\(mapNumber)_Energy")
        for y in 0..<11 {
            for x in 0..<9 {
                let buildingData = buildingForCoord(CGPoint(x: x, y: y))!.buildingData
                let savedData = NSKeyedArchiver.archivedDataWithRootObject(buildingData)
                NSUserDefaults.standardUserDefaults().setObject(savedData, forKey: "\(mapNumber)_\(x)_\(y)_Data")
            }
        }
    }
    
    // MARK: Load Map Data
    func loadGameData() {
        energy = NSUserDefaults.standardUserDefaults().doubleForKey("map\(mapNumber)_Energy")
        for y in 0..<11 {
            for x in 0..<9 {
                if let loadData = NSUserDefaults.standardUserDefaults().objectForKey("\(mapNumber)_\(x)_\(y)_Data") as? NSData {
                    let buildingData = NSKeyedUnarchiver.unarchiveObjectWithData(loadData) as? BuildingData
                    buildingForCoord(CGPoint(x: x, y: y))?.loadBuildingData(buildingData!)
                }
            }
        }
    }
    
    // MARK: Return Around Coord BuildingData
    func aroundCoordBuildingData(x x: Int, y: Int) -> [BuildingData] {
        var data: [BuildingData] = []
        if y - 1 >= 0 { data.append(buildings[y-1][x]!.buildingData) }
        if y + 1 < Int(mapSize.height) { data.append(buildings[y+1][x]!.buildingData) }
        if x - 1 >= 0 { data.append(buildings[y][x-1]!.buildingData) }
        if x + 1 < Int(mapSize.width) { data.append(buildings[y][x+1]!.buildingData) }
        return data
    }
    
    // MARK: BuildingMap Update
    func Update() {

        /**
        *  Water System
        */
        
        // 1. Production
        for line in buildings {
            for building in line {
                if building!.buildingData.waterSystem != nil {
                    building!.buildingData.waterSystem.produceWater()
                }
            }
        }
        // 2. transport
        for (y, line) in buildings.enumerate() {
            for (x, building) in line.enumerate() {
                if building!.buildingData.waterSystem != nil && building!.buildingData.waterSystem.output {
                    var waterSystems = [WaterSystem]()
                    for buildingData in aroundCoordBuildingData(x: x, y: y) {
                        if buildingData.waterSystem != nil {
                            waterSystems.append(buildingData.waterSystem)
                        }
                    }
                    building!.buildingData.waterSystem.balanceWithOtherWaterSystem(waterSystems)
                }
            }
        }
        // 3. Caculate water overflow
        for line in buildings {
            for building in line {
                if building!.buildingData.waterSystem != nil {
                    building!.buildingData.waterSystem.overflow()
                }
            }
        }
    
        /**
        *  Heat System
        */
        
        // 1. Isolation Multiply
        for (y, line) in buildings.enumerate() {
            for (x, building) in line.enumerate() {
                let isolationArray: [BuildingType] = [.SolarCell, .CoalBurner, .GasBurner, .NuclearCell, .FusionCell]
                if isolationArray.contains(building!.buildingData.buildType) {
                    building!.buildingData.heatSystem.produceMultiply = 1
                    for buildingData in aroundCoordBuildingData(x: x, y: y) {
                        if buildingData.buildType == .Isolation {
                            building!.buildingData.heatSystem.produceMultiply += buildingData.isolationPercent
                        }
                    }
                }
            }
        }
        // 2. Production
        for line in buildings {
            for building in line {
                if building!.activate && building!.buildingData.heatSystem != nil {
                    building!.buildingData.heatSystem.produceHeat()
                }
            }
        }
        // 3. output transport
        for (y, line) in buildings.enumerate() {
            for (x, building) in line.enumerate() {
                if building!.buildingData.heatSystem != nil && building!.buildingData.heatSystem.output {
                    var heatSystems = [HeatSystem]()
                    for buildingData in aroundCoordBuildingData(x: x, y: y) {
                        if buildingData.heatSystem != nil {
                            heatSystems.append(buildingData.heatSystem)
                        }
                    }
                    if heatSystems.count > 0 {
                        building!.buildingData.heatSystem.outputHeatToOtherHeatSystem(heatSystems)
                    }
                }
            }
        }
        // 4. Heat inlet to out let
        var heatOutletHeatSystems = [HeatSystem]()
        for line in buildings {
            for building in line {
                if building!.buildingData.buildType == .HeatOutlet {
                    heatOutletHeatSystems.append(building!.buildingData.heatSystem)
                }
            }
        }
        for line in buildings {
            for building in line {
                if building!.buildingData.buildType == .HeatInlet {
                    if heatOutletHeatSystems.count > 0 {
                        building!.buildingData.heatSystem.heatInletToOutletHeatSystem(heatOutletHeatSystems)
                    }
                }
            }
        }
        // 5. Heat exchanger
        for (y, line) in buildings.enumerate() {
            for (x, building) in line.enumerate() {
                if building!.buildingData.buildType == .HeatExchanger {
                    var heatSystems: [HeatSystem] = [building!.buildingData.heatSystem]
                    for buildingData in aroundCoordBuildingData(x: x, y: y) {
                        if buildingData.heatSystem != nil && !buildingData.heatSystem.output {
                            heatSystems.append(buildingData.heatSystem)
                        }
                    }
                    building!.buildingData.heatSystem.exchangerHeatToOtherHeatSystem(heatSystems)
                }
            }
        }
        // 6. Heat Cooling transport
        for (y, line) in buildings.enumerate() {
            for (x, building) in line.enumerate() {
                let coolingArray:[BuildingType] = [.SmallGenerator, .MediumGenerator, .LargeGenerator, .BoilerHouse, .LargeBoilerHouse, .HeatOutlet]
                if coolingArray.contains(building!.buildingData.buildType){
                    var heatSystems = [HeatSystem]()
                    for buildingData in aroundCoordBuildingData(x: x, y: y) {
                        if buildingData.buildType == .HeatSink {
                            heatSystems.append(buildingData.heatSystem)
                        }
                    }
                    if heatSystems.count > 0 {
                        building!.buildingData.heatSystem.coolingHeatToHeatSink(heatSystems)
                    }
                }
            }
        }
        // 7. Heat Cooling
        for line in buildings {
            for building in line {
                if building!.buildingData.buildType == .HeatSink {
                    building!.buildingData.heatSystem.coolingHeat()
                }
            }
        }
        
        /**
        *  Energy && Money System
        */
        
        for line in buildings {
            for building in line {
                if building!.activate {
                    // Energy
                    if building!.buildingData.energySystem != nil {
                        // 1. Production
                        building!.buildingData.energySystem.produceEnergy()
                        // 2. Heat transform energy
                        if building!.buildingData.energySystem.isHeat2Energy() {
                            building!.buildingData.heatTransformEnergy()
                        }
                        // 3. Water transform energy
                        if building!.buildingData.energySystem.water2Energy {
                            building!.buildingData.waterTransformEnergy()
                        }
                    }
                    // Money
                    if building!.buildingData.moneySystem != nil {
                        // 1. Heat transform money
                        if building!.buildingData.moneySystem.isHeat2Money() {
                            building!.buildingData.heatTransformMoney()
                        }
                    }
                }
            }
        }
        
        /**
        *  EDestroy & Activate & Rebuild & Update Progress
        */
        
        for (y, line) in buildings.enumerate() {
            for (x, building) in line.enumerate() {
                let buildingData = building!.buildingData
                if building!.activate {
                    // 1. Destroy
                    if buildingData.heatSystem != nil && buildingData.heatSystem.overflow() {
                        let coord = CGPoint(x: x, y: y)
                        removeBuilding(coord)
                        setTileMapElement(coord: coord, buildType: .Land)
                    }
                    // 2. Activate
                    if buildingData.timeSystem != nil && !buildingData.timeSystem.tick(){
                        building!.activate = false
                        building!.alpha = 0.5
                    }
                } else {
                    // 3. Rebuild
                    if autoRebuild && buildingData.timeSystem != nil && buildingData.timeSystem.rebuild {
                        let price = building!.buildingData.buildPrice
                        if money >= price {
                            money -= price
                            building!.buildingData.timeSystem.resetTime()
                            building!.activate = true
                            building!.alpha = 1
                        }
                    }
                }
                // 4. Update progress
                building!.progressUpdate()
            }
        }
        
        /**
        *  Bank && Library multiply
        */
        
        for (y, line) in buildings.enumerate() {
            for (x, building) in line.enumerate() {
                // Bank
                let bankArray:[BuildingType] = [.SmallOffice, .MediumOffice, .LargeOffice]
                if bankArray.contains(building!.buildingData.buildType){
                    building!.buildingData.moneySystem.multiply = 1
                    
                    for buildingData in aroundCoordBuildingData(x: x, y: y) {
                        if buildingData.buildType == .Bank {
                            building!.buildingData.moneySystem.multiply += buildingData.bankAddPercent
                        }
                    }
                }
                // Library
                let libraryArray:[BuildingType] = [.ResearchCenter, .AdvancedResearchCenter]
                if libraryArray.contains(building!.buildingData.buildType){
                    building!.buildingData.researchSystem.multiply = 1
                    for buildingData in aroundCoordBuildingData(x: x, y: y) {
                        if buildingData.buildType == .Library {
                            building!.buildingData.moneySystem.multiply += buildingData.libraryAddPercent
                        }
                    }
                }
            }
        }
        
        /**
         *  Calculate research, energy, money tick add
         */
        
        var energy2MoneyAmount: Double = 0
        research_TickAdd = 0
        energy_TickAdd = 0
        money_TickAdd = 0
        energyMax = 100
        // 1. statistics
        for line in buildings {
        for building in line {
            // research
            if building!.buildingData.researchSystem != nil {
                research_TickAdd += building!.buildingData.researchSystem.researchMultiplyAmount()
            }
            // energy
            if building!.buildingData.energySystem != nil {
                energy_TickAdd += building!.buildingData.energySystem.inAmount
                building!.buildingData.energySystem.inAmount = 0
            }
            // money
            if building!.buildingData.moneySystem != nil {
                money_TickAdd += building!.buildingData.moneySystem.inAmount
                building!.buildingData.moneySystem.inAmount = 0
                energy2MoneyAmount += building!.buildingData.moneySystem.energy2MoneyMultiplyAmount()
            }
            // battery
            if building!.buildingData.buildType == .Battery {
                energyMax += Double(building!.buildingData.batteryEnergySize)
            }
        }}
        // 2. Calculate energy
        energy += energy_TickAdd
        // 3. Calculate money tick add and energy left
        if energy >= Double(energy2MoneyAmount) {
            energy -= Double(energy2MoneyAmount)
            money_TickAdd += energy2MoneyAmount
            if energy > energyMax { energy = energyMax }
        } else {
            money_TickAdd += energy
            energy = 0
        }
    }
}