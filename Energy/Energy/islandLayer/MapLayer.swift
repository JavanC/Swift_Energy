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
        
        if buildType == .Land || buildType == .Ocean || buildType == .Rock {
            activate = false
        }
        
        // Add progress
        if buildingData.progress != nil {
            addProgress()
        }
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
        
        if buildingData.buildType == .Land || buildingData.buildType == .Ocean || buildingData.buildType == .Rock {
            activate = false
        }
        
        // Add progress
        if buildingData.progress != nil && progressBack == nil {
            addProgress()
        }
    }
    
    // MARK: add progress
    func addProgress() {
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
    var tickAddDone: Bool = false
    var energy: Double = 0
    var energyMax: Double = 100
    
    // MARK: Configure At Position
    func configureAtPosition(position: CGPoint, mapNumber: Int) {
        self.mapNumber = mapNumber
        self.position = position
        self.color = SKColor.whiteColor()
        self.size = CGSize(width: tileSize.width * mapSize.width, height: tileSize.height * mapSize.height)
        self.anchorPoint = CGPoint(x: 0, y: 1)
        self.name = "MapLayer \(mapNumber)"
        
        // Initialization map
        for _ in 0 ..< Int(mapSize.height) {
            buildings.append(Array(count: Int(mapSize.width), repeatedValue: nil))
        }
        initialMapData()
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
    
    // MARK: Reset Map Data
    func initialMapData() {
        self.energy = 0
        for y in 0 ..< Int(mapSize.height) {
            for x in 0 ..< Int(mapSize.width) {
                let coord = CGPoint(x: x, y: y)
                setTileMapElement(coord: coord, buildType: .Land)
            }
        }
        for y in 0 ..< 3 {
            for x in 0 ..< 9 {
                let coord = CGPoint(x: x, y: y)
                setTileMapElement(coord: coord, buildType: .Ocean)
            }
        }
        
        for x in 0..<9 {
            let coord = CGPoint(x: x, y: 5)
            setTileMapElement(coord: coord, buildType: .Rock)
        }
    }
    
    // MARK: Load Map Data By Array
//    func loadMapArray(array: [String]) {
//        for y in 0..<11 {
//            for x in 0..<9 {
//                switch array[y * 9 + x] {
//                case "Land":
//                    setTileMapElement(coord: CGPoint(x: x, y: y), buildType: .Land)
//                case "Ocean":
//                    setTileMapElement(coord: CGPoint(x: x, y: y), buildType: .Ocean)
//                default:break
//                }
//            }
//        }
//    }

    // MARK: Reload Map Upgrade Data
    func reloadMap() {
        for line in buildings {
            for building in line {
                building?.buildingData.reloadUpgradeAndResearchData()
            }
        }
    }
    
    // MARK: Save Map Data
    func saveMapData() {
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
    func loadMapData() {
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
    func aroundCoordBuildingData(coord coord: CGPoint) -> [BuildingData] {
        let x = Int(coord.x)
        let y = Int(coord.y)
        var data: [BuildingData] = []
        if y - 1 >= 0 { data.append(buildings[y-1][x]!.buildingData) }
        if y + 1 < Int(mapSize.height) { data.append(buildings[y+1][x]!.buildingData) }
        if x - 1 >= 0 { data.append(buildings[y][x-1]!.buildingData) }
        if x + 1 < Int(mapSize.width) { data.append(buildings[y][x+1]!.buildingData) }
        return data
    }
    
    // MARK: Return Around BuildingDatas Matrix
    func aroundBuildingDataMatrix() -> [[[BuildingData]]] {
        var matrix:[[[BuildingData]]] = [[[BuildingData]]]()
        for y in 0..<11 {
            var row:[[BuildingData]] = [[BuildingData]]()
            for x in 0..<9 {
                let buildingDatas = aroundCoordBuildingData(coord: CGPoint(x: x, y: y))
                row.append(buildingDatas)
            }
            matrix.append(row)
        }
        return matrix
    }
    
    // MARK: Explode Emitter
    func explodeBuilding(building: SKNode) {
        let emitter = SKEmitterNode(fileNamed: "Explode.sks")!
        let pos = CGPoint(x: building.position.x + 32, y: building.position.y - 32)
        emitter.position = pos
        emitter.zPosition = 1
        addChild(emitter)
        if !isSoundMute{ runAction(soundExplosion) }
    }
    
    // MARK: BuildingMap Update
    func Update() {
        
        var energy2MoneyAmount: Double = 0
        research_TickAdd = 0
        energy_TickAdd = 0
        money_TickAdd = 0
        energyMax = 100
        
        
        
        
        
        var heatSystemElements       = [Building]()
        var timeSysTemElements       = [Building]()
        
        var waterSystemElements      = [Building]()
        var waterProduceElements     = [Building]()
        var watertransportElements   = [Building]()

        var heatProduceElements      = [Building]()
        var heatInletHeatElements    = [Building]()
        var heatOutletHeatSystems    = [HeatSystem]()
        var heatExchangerElements    = [Building]()
        var heatCoolingElements      = [Building]()
        var heatSinkElements         = [Building]()
        var heatToMoneyElements      = [Building]()

        var energyProduceElements    = [Building]()
        var energyConversionElements = [Building]()

        var officeElements           = [Building]()
        var researchCenterElements   = [Building]()
        
        for line in buildings {
            for building in line {
                if building!.buildingData.timeSystem != nil {
                    timeSysTemElements.append(building!)
                }
                if building!.activate {
                    if building!.buildingData.heatSystem != nil {
                        heatSystemElements.append(building!)
                    }
                    let type = building!.buildingData.buildType
                    switch type {
                    case .WaterPump, .GroundwaterPump:
                        waterSystemElements.append(building!)
                        waterProduceElements.append(building!)
                        watertransportElements.append(building!)
                        
                    case .WaterPipe:
                        waterSystemElements.append(building!)
                        watertransportElements.append(building!)
                        
                    case .SmallGenerator, .MediumGenerator, .LargeGenerator:
                        waterSystemElements.append(building!)
                        heatCoolingElements.append(building!)
                        energyConversionElements.append(building!)
                        
                    case .WindTurbine, .WaveCell:
                        energyProduceElements.append(building!)
                        
                    case .SolarCell, .CoalBurner, .GasBurner, .NuclearCell, .FusionCell:
                        heatProduceElements.append(building!)
                        
                    case .HeatInlet:
                        heatInletHeatElements.append(building!)
                        
                    case .HeatOutlet:
                        heatOutletHeatSystems.append(building!.buildingData.heatSystem)
                        heatCoolingElements.append(building!)
                        
                    case .HeatExchanger:
                        heatExchangerElements.append(building!)
                        
                    case .BoilerHouse, .LargeBoilerHouse:
                        heatCoolingElements.append(building!)
                        heatToMoneyElements.append(building!)
                        
                    case .HeatSink:
                        heatSinkElements.append(building!)
                        
                    case .SmallOffice, .MediumOffice, .LargeOffice:
                        officeElements.append(building!)
                        
                    case .ResearchCenter, .AdvancedResearchCenter:
                        researchCenterElements.append(building!)
                        
                    // Calculate energyMax
                    case .Battery:
                        energyMax += building!.buildingData.batteryEnergySize
                    default: break
                    }
                }
            }
        }
        
        /*
        // Water System
        */
        
        // 1. Production
        for element in waterProduceElements {
            element.buildingData.waterSystem.produceWater()
        }
        // 2. transport & Update Progress-heat,time
        for element in watertransportElements {
            var waterSystems: [WaterSystem] = [element.buildingData.waterSystem]
            for buildingData in aroundCoordBuildingData(coord: element.coord) {
                if buildingData.waterSystem != nil {
                    waterSystems.append(buildingData.waterSystem)
                }
            }
            element.buildingData.waterSystem.balanceWithOtherWaterSystem(waterSystems)
            element.progressUpdate()
        }
        // 3. Caculate water overflow
        for element in waterSystemElements {
            element.buildingData.waterSystem.overflow()
        }
        
        /*
        //  Heat System && Calculate money_TickAdd
        */
        
        // 1. Isolation Multiply and Production Output
        for element in heatProduceElements {
            element.buildingData.heatSystem.produceMultiply = 1
            for buildingData in aroundCoordBuildingData(coord: element.coord) {
                if buildingData.buildType == .Isolation {
                    element.buildingData.heatSystem.produceMultiply += buildingData.isolationPercent
                }
            }
            
            element.buildingData.heatSystem.produceHeat()
            var heatSystems = [HeatSystem]()
            for buildingData in aroundCoordBuildingData(coord: element.coord) {
                if buildingData.heatSystem != nil && !buildingData.heatSystem.output{
                    heatSystems.append(buildingData.heatSystem)
                }
            }
            element.buildingData.heatSystem.outputHeatToOtherHeatSystem(heatSystems)
        }
        // 2. Heat Inlet to Outlet
        for element in heatInletHeatElements {
            element.buildingData.heatSystem.heatInletToOutletHeatSystem(heatOutletHeatSystems)
        }
        // 3. Heat exchanger
        for element in heatExchangerElements {
            var heatSystems: [HeatSystem] = [element.buildingData.heatSystem]
            for buildingData in aroundCoordBuildingData(coord: element.coord) {
                if buildingData.heatSystem != nil && !buildingData.heatSystem.output {
                    heatSystems.append(buildingData.heatSystem)
                }
            }
            element.buildingData.heatSystem.exchangerHeatToOtherHeatSystem(heatSystems)
        }
        // 4. Heat Cooling transport
        for element in heatCoolingElements {
            var heatSystems = [HeatSystem]()
            for buildingData in aroundCoordBuildingData(coord: element.coord) {
                if buildingData.buildType == .HeatSink {
                    heatSystems.append(buildingData.heatSystem)
                }
            }
            element.buildingData.heatSystem.coolingHeatToHeatSink(heatSystems)
        }
        // 5. Heat Sink Cooling
        for element in heatSinkElements {
            element.buildingData.heatSystem.coolingHeat()
        }
        // 6. Heat Conversion Money
        for element in heatToMoneyElements {
            element.buildingData.heatTransformMoney()
            money_TickAdd += element.buildingData.moneySystem.inAmount
            element.buildingData.moneySystem.inAmount = 0
        }
        
        /*
        // Energy System && Calculate energy_TickAdd
        */
        
        // 1. Production
        for element in energyProduceElements {
            element.buildingData.energySystem.produceEnergy()
            energy_TickAdd += element.buildingData.energySystem.inAmount
            element.buildingData.energySystem.inAmount = 0
        }
        // 2. Energy Conversion
        for element in energyConversionElements {
            element.buildingData.heatTransformEnergy()
            element.buildingData.waterTransformEnergy()
            energy_TickAdd += element.buildingData.energySystem.inAmount
            element.buildingData.energySystem.inAmount = 0
        }
        
        /*
        // Destroy & Activate & Rebuild & Update Progress-heat,time
        */
        
        // 1. Destroy
        for element in heatSystemElements {
            if element.buildingData.heatSystem.overflow() {
                explodeBuilding(element)
                setTileMapElement(coord: element.coord, buildType: .Land)
            }
            element.progressUpdate()
        }
        
        // 2. Activate and Rebuild
        for element in timeSysTemElements {
            if element.activate {
                if !element.buildingData.timeSystem.tick() {
                    element.activate = false
                    element.alpha = 0.5
                }
            } else {
                if isRebuild && element.buildingData.timeSystem.rebuild {
                    let price = element.buildingData.buildPrice
                    if money >= price {
                        money -= price
                        element.buildingData.timeSystem.resetTime()
                        element.activate = true
                        element.alpha = 1
                    }
                }
            }
            element.progressUpdate()
        }
        
        /*
        // Bank && Library multiply && Calculate energy2MoneyAmount && Calculate research_TickAdd
        */
        
        // 1. officeElements
        for element in officeElements {
            element.buildingData.moneySystem.multiply = 1
            for buildingData in aroundCoordBuildingData(coord: element.coord) {
                if buildingData.buildType == .Bank {
                    element.buildingData.moneySystem.multiply += buildingData.bankAddPercent
                }
            }
            energy2MoneyAmount += element.buildingData.moneySystem.energy2MoneyMultiplyAmount()
        }
        // 2. researchCenterElements
        for element in researchCenterElements {
            element.buildingData.researchSystem.multiply = 1
            for buildingData in aroundCoordBuildingData(coord: element.coord) {
                if buildingData.buildType == .Library {
                    element.buildingData.researchSystem.multiply += buildingData.libraryAddPercent
                }
            }
            research_TickAdd += element.buildingData.researchSystem.researchMultiplyAmount()
        }
        
        /*
        // Calculate final energy, research and money tick add
        */
        
        // 1. Calculate energy
        energy += energy_TickAdd
        // 2. Calculate money tick add and energy left
        if energy >= energy2MoneyAmount {
            energy -= energy2MoneyAmount
            money_TickAdd += energy2MoneyAmount
            if energy > energyMax { energy = energyMax }
        } else {
            money_TickAdd += energy
            energy = 0
        }
        
        tickAddDone = true
    }
}