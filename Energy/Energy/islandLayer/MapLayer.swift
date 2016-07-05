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
    
    func changeActivate(isActivate: Bool) {
        activate = isActivate
        self.alpha = activate ? 1 : 0.5
    }
    
    func loadBuildingData(buildingData: BuildingData) {
        name = String(buildingData.buildType.hashValue)
        
        self.buildingData = buildingData
        buildingNode.runAction(SKAction.setTexture(buildingAtlas.textureNamed(buildingData.imageName)))
        changeActivate(true)
        if buildingData.timeSystem != nil {
            changeActivate(buildingData.timeSystem.inAmount == 0 ? false : true)
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
        if !isBoost && buildingData.progress != nil {
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
    var islandImage: SKSpriteNode!
    var isSold: Bool = false
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
        self.islandImage = SKSpriteNode(imageNamed: "Island\(mapNumber + 1)")
        self.islandImage.name = "island\(mapNumber)Image"
        self.islandImage.setScale(576 / 360)
        self.islandImage.anchorPoint = CGPoint(x: 0, y: 1)
        self.islandImage.zPosition = -1
        addChild(islandImage)
        self.isSold = mapNumber == 0
        self.position = position
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
        var stringArray = Array<String>()
        switch mapNumber {
        case 0:
            stringArray = ["R","O","O","O","O","O","O","O","O",
                           "O","O","O","O","O","O","O","L","O",
                           "O","O","R","L","O","R","O","O","O",
                           "O","O","L","L","O","L","L","R","O",
                           "O","R","O","O","O","L","L","O","O",
                           "O","O","O","L","R","L","L","O","O",
                           "O","O","O","L","L","L","L","O","O",
                           "O","O","L","L","L","L","O","R","O",
                           "O","O","L","L","O","L","O","O","O",
                           "O","O","O","O","O","O","L","O","O",
                           "O","O","R","O","O","O","O","O","O"]
        case 1:
            stringArray = ["O","R","O","O","O","L","O","O","O",
                           "O","O","O","R","R","O","L","O","O",
                           "O","O","R","R","L","L","L","R","O",
                           "O","O","R","L","L","L","R","O","O",
                           "R","L","L","L","L","L","L","G","O",
                           "O","L","G","L","R","L","L","O","O",
                           "O","O","L","L","L","R","G","O","O",
                           "O","O","R","L","L","G","G","O","O",
                           "O","O","O","L","L","G","O","L","O",
                           "O","L","O","R","L","O","O","L","O",
                           "L","R","O","O","O","O","O","O","R"]
        case 2:
            stringArray = ["O","O","O","L","O","O","O","O","O",
                           "O","O","G","L","L","R","L","L","O",
                           "O","L","L","G","L","L","G","L","O",
                           "O","R","L","L","L","L","L","R","O",
                           "L","G","L","R","R","R","R","R","O",
                           "R","R","R","R","R","G","G","O","O",
                           "L","L","L","L","L","L","L","L","O",
                           "R","L","G","L","L","L","L","G","L",
                           "O","R","L","L","L","L","L","L","R",
                           "O","O","R","L","G","L","L","R","O",
                           "O","O","R","L","L","L","R","O","O"]
        case 3:
            stringArray = ["O","G","G","R","O","O","L","O","O",
                           "G","G","G","G","O","R","L","L","O",
                           "G","G","G","G","O","L","G","L","R",
                           "G","G","G","L","O","O","G","L","L",
                           "O","G","R","O","O","L","L","G","L",
                           "O","O","O","O","R","L","L","L","L",
                           "O","R","L","O","L","G","L","L","L",
                           "R","L","L","O","O","R","G","L","L",
                           "L","G","L","L","O","O","L","L","G",
                           "L","L","L","L","R","O","L","L","L",
                           "O","L","G","L","R","O","O","G","L"]
        case 4:
            stringArray = ["L","L","L","L","L","L","L","O","O",
                           "L","G","L","L","L","L","L","L","O",
                           "L","L","L","L","L","L","L","L","L",
                           "L","L","L","L","L","G","L","L","L",
                           "L","L","L","L","L","L","L","L","L",
                           "L","L","L","L","L","L","L","G","L",
                           "L","G","L","L","L","L","L","L","L",
                           "L","L","L","G","L","L","L","L","L",
                           "L","L","L","L","L","L","L","L","L",
                           "O","L","L","L","L","L","G","L","L",
                           "O","O","O","L","L","L","L","L","L"]
        case 5:
            stringArray = ["G","G","G","G","G","G","G","G","G",
                           "G","G","G","G","G","G","G","G","G",
                           "G","G","G","G","G","G","G","G","G",
                           "G","G","G","G","G","G","G","G","G",
                           "G","G","G","G","G","G","G","G","G",
                           "G","G","G","G","L","G","G","G","G",
                           "G","G","G","G","G","G","G","G","G",
                           "G","G","G","G","G","G","G","G","G",
                           "G","G","G","G","G","G","G","G","G",
                           "G","G","G","G","G","G","G","G","G",
                           "G","G","G","G","G","G","G","G","G"]
        default: break
        }
        loadMapArray(stringArray)
    }
    
    // MARK: Load Map Data By String Array
    func loadMapArray(array: [String]) {
        for y in 0..<11 {
            for x in 0..<9 {
                switch array[y * 9 + x] {
                case "L":
                    setTileMapElement(coord: CGPoint(x: x, y: y), buildType: .Land)
                case "O":
                    setTileMapElement(coord: CGPoint(x: x, y: y), buildType: .Ocean)
                case "R":
                    setTileMapElement(coord: CGPoint(x: x, y: y), buildType: .Rock)
                case "G":
                    setTileMapElement(coord: CGPoint(x: x, y: y), buildType: .Garbage)
                    buildingForCoord(CGPoint(x: x, y: y))!.buildingData.heatSystem = HeatSystem(size: 10)
                default:break
                }
            }
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
    func saveMapData() {
        NSUserDefaults.standardUserDefaults().setBool(isSold, forKey: "map\(mapNumber)_isSold")
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
        isSold = NSUserDefaults.standardUserDefaults().boolForKey("map\(mapNumber)_isSold")
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
    
    // MARK: Explode Emitter
    func explodeBuilding(building: SKNode) {
        let emitter = SKEmitterNode(fileNamed: "Explode.sks")!
        let pos = CGPoint(x: building.position.x + 32, y: building.position.y - 32)
        emitter.position = pos
        emitter.zPosition = 1
        addChild(emitter)
        if !isSoundMute{ runAction(soundExplosion) }
        if !isFinishTarget {
            finishExplosion += 1
        }
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

        var heatIsolationElements    = [Building]()
        var heatProduceElements      = [Building]()
        var heatInletHeatElements    = [Building]()
        var heatOutletHeatSystems    = [HeatSystem]()
        var heatExchangerElements    = [Building]()
        var heatSinkElements         = [Building]()
        var heatToMoneyElements      = [Building]()

        var energyProduceElements    = [Building]()
        var energyConversionElements = [Building]()

        var officeElements           = [Building]()
        var bankElements             = [Building]()
        var researchCenterElements   = [Building]()
        var libraryElements          = [Building]()
        
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
                        energyConversionElements.append(building!)
                        
                    case .WindTurbine, .WaveCell:
                        energyProduceElements.append(building!)
                        
                    case .Isolation:
                        heatIsolationElements.append(building!)
                        
                    case .SolarCell, .CoalBurner, .GasBurner, .NuclearCell, .FusionCell:
                        heatProduceElements.append(building!)
                        
                    case .HeatInlet:
                        heatInletHeatElements.append(building!)
                        
                    case .HeatOutlet:
                        heatOutletHeatSystems.append(building!.buildingData.heatSystem)
                        
                    case .HeatExchanger:
                        heatExchangerElements.append(building!)
                        
                    case .BoilerHouse, .LargeBoilerHouse:
                        heatToMoneyElements.append(building!)
                        
                    case .HeatSink:
                        heatSinkElements.append(building!)
                        
                    case .SmallOffice, .MediumOffice, .LargeOffice:
                        officeElements.append(building!)
                        
                    case .Bank:
                        bankElements.append(building!)
                        
                    case .ResearchCenter, .AdvancedResearchCenter:
                        researchCenterElements.append(building!)
                        
                    case .Library:
                        libraryElements.append(building!)
                        
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
        for element in heatIsolationElements {
            for buildingData in aroundCoordBuildingData(coord: element.coord) {
                if [.SolarCell, .CoalBurner, .GasBurner, .NuclearCell, .FusionCell].contains(buildingData.buildType) {
                    buildingData.heatSystem.produceMultiply += element.buildingData.isolationPercent
                }
            }
        }
        for element in heatProduceElements {
            element.buildingData.heatSystem.produceHeat()
            element.buildingData.heatSystem.produceMultiply = 1
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
        // 4. Heat Sink Cooling
        for element in heatSinkElements {
            element.buildingData.heatSystem.coolingHeat()
        }
        // 5. Heat Conversion Money
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
                if !isBoost {
                    let imageNumber = Int(element.buildingData.timeSystem.inAmount) % 4
                    let imageName = "\(element.buildingData.buildType)\(imageNumber)"
                    element.buildingNode.texture = buildingAtlas.textureNamed(imageName)
                }
                if !element.buildingData.timeSystem.tick() {
                    element.changeActivate(false)
                }
            } else {
                if isRebuild && element.buildingData.timeSystem.rebuild {
                    let price = element.buildingData.buildPrice
                    if money >= price {
                        money -= price
                        if !isFinishTarget {
                            finishBuilding += 1
                        }
                        element.buildingData.timeSystem.resetTime()
                        element.changeActivate(true)
                    }
                }
            }
            element.progressUpdate()
        }
        
        /*
        // Bank && Library multiply && Calculate energy2MoneyAmount && Calculate research_TickAdd
        */
        
        // 1. officeElements
        for element in bankElements {
            for buildingData in aroundCoordBuildingData(coord: element.coord) {
                if [.SmallOffice, .MediumOffice, .LargeOffice].contains(buildingData.buildType) {
                    buildingData.moneySystem.multiply += element.buildingData.bankAddPercent
                }
            }
        }
        for element in officeElements {
            energy2MoneyAmount += element.buildingData.moneySystem.energy2MoneyMultiplyAmount()
            element.buildingData.moneySystem.multiply = 1
        }
        // 2. researchCenterElements
        for element in libraryElements {
            for buildingData in aroundCoordBuildingData(coord: element.coord) {
                if buildingData.buildType == .ResearchCenter || buildingData.buildType == .AdvancedResearchCenter {
                    buildingData.researchSystem.multiply += element.buildingData.libraryAddPercent
                }
            }
        }
        for element in researchCenterElements {
            research_TickAdd += element.buildingData.researchSystem.researchMultiplyAmount()
            element.buildingData.researchSystem.multiply = 1
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