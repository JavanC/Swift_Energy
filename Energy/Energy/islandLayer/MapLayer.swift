//
//  Building.swift
//  Energy
//
//  Created by javan.chen on 2015/12/9.
//  Copyright © 2015年 Javan chen. All rights reserved.
//

import SpriteKit

class BuildingData {

    // all
    var imageName: String!
    var buildType: BuildingType = .Land
    var buildPrice: Int!
    enum ProgressType { case Time, Hot, Water }
    var progress: ProgressType!
    var energy_Current: Int = 0
    
    // Time
    var rebuild: Bool = true
    var time_Max: Int!
    var time_Current: Int!
    
    // Heat
    var heat_Max: Int!
    var heat_Current: Int!
    var heat_Produce: Int!
    var heat_IsOutput: Bool = false
    var heat_IsInput: Bool = false
    var isHeat2Energy: Bool = false
    var heat2Energy_Max: Int!
    
    // Water
    var water_Max: Int!
    var water_Current: Int!
    var water_Produce: Int!
    var water_IsOutput: Bool = false
    var water_IsInput: Bool = false
    
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
         
            heat_Produce = 1
            heat_Max = 10
            heat_Current = 0
            isHeat2Energy = true
            heat2Energy_Max = 1
        }
        if buildType == .CoalBurner {
            imageName = "CoalBurner"
            buildPrice = 20
            progress = .Time
            
            time_Max = 10
            time_Current = 10
            
            heat_IsOutput = true
            heat_Produce = 20
            heat_Max = 1
            heat_Current = 0
        }
        if buildType == .SmallGenerator {
            imageName = "SmallGenerator"
            buildPrice = 50
            progress = .Hot

            heat_Max = 400
            heat_Current = 100
            heat_IsInput = true
            isHeat2Energy = true
            heat2Energy_Max = 10
            
            water_Current = 0
            water_Max = 500
            water_IsInput = true
        }
        if buildType == .SmallOffice {
            imageName = "SmallOffice"
            buildPrice = 10
            
            heat_Max = 10
            heat_Current = 0
            heat_IsInput = true
            
            money_Sales = 5
        }
        if buildType == .WaterPump {
            imageName = "電池"
            buildPrice = 10
            progress = .Water
            
            water_Max = 1000
            water_Current = 0
            water_Produce = 100
            water_IsOutput = true
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
            info.append("Produce Energy: \(heat2Energy_Max)")
            info.append("Sell Money: \(buildPrice)")
        }
        if buildType == .CoalBurner {
            info.append("Time: \(time_Current) / \(time_Max)")
            info.append("Produce Hot: \(heat_Produce)")
            info.append("Sell Money: \(buildPrice)")
        }
        if buildType == .SmallGenerator {
            info.append("Hot: \(heat_Current) / \(heat_Max)")
            info.append("Water: \(water_Current) / \(water_Max)")
            info.append("Converted Energy: \(heat2Energy_Max)")
            info.append("Sell Money: \(buildPrice)")
        }
        if buildType == .SmallOffice {
            info.append("Hot: \(heat_Current) / \(heat_Max)")
            info.append("Produce Money: \(money_Sales)")
            info.append("Sell Money: \(buildPrice)")
        }
        if buildType == .WaterPump {
            info.append("Water: \(water_Current) / \(water_Max)")
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
                let persent = CGFloat(buildingData.heat_Current) / CGFloat(buildingData.heat_Max)
                progress.xScale = persent
            case .Water:
                let persent = CGFloat(buildingData.water_Current) / CGFloat(buildingData.water_Max)
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
        
        // Have Building and not Activate, remove!
        if (buildings[y][x] != nil && !buildings[y][x]!.activate) {
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
        
        // 1. Production
        for (_, line) in buildings.enumerate() {
            for (_, building) in line.enumerate() {
                if building!.activate {
                    let buildingData = building!.buildingData
                    // produce hot
                    if buildingData.heat_Produce != nil {
                        buildingData.heat_Current! += buildingData.heat_Produce
                    }
                    // production water
                    if buildingData.water_Produce != nil {
                        buildingData.water_Current! += buildingData.water_Produce
                    }
                }
            }
        }
        
        // 2. Hot transport
        for (y, line) in buildings.enumerate() {
            for (x, building) in line.enumerate() {
                // if building was hot output
                if (building!.activate && building!.buildingData.heat_IsOutput) {
                    // get around coord
                    var aroundCoords = [CGPoint]()
                    if (y - 1 >= 0 && buildings[y-1][x]!.activate && buildings[y-1][x]!.buildingData.heat_IsInput) {
                        aroundCoords.append(CGPoint(x: x, y: y - 1))
                    }
                    if (y + 1 <= 11 && buildings[y+1][x]!.activate && buildings[y+1][x]!.buildingData.heat_IsInput ) {
                        aroundCoords.append(CGPoint(x: x, y: y + 1))
                    }
                    if (x - 1 >= 0 && buildings[y][x-1]!.activate && buildings[y][x-1]!.buildingData.heat_IsInput ) {
                        aroundCoords.append(CGPoint(x: x - 1, y: y))
                    }
                    if (x + 1 <= 9 && buildings[y][x+1]!.activate && buildings[y][x+1]!.buildingData.heat_IsInput ) {
                        aroundCoords.append(CGPoint(x: x + 1, y: y))
                    }
                    // according coord number, calculate hot balance
                    if aroundCoords.count > 0 {
                        let balancehot = building!.buildingData.heat_Current / aroundCoords.count
                        for coord in aroundCoords {
                            buildings[Int(coord.y)][Int(coord.x)]!.buildingData.heat_Current! += balancehot
                        }
                        building!.buildingData.heat_Current = 0
                    }
                }
            }
        }
        
        // 3. Water transport
        for (y, line) in buildings.enumerate() {
            for (x, building) in line.enumerate() {
                // if building was hot output
                if (building!.activate && building!.buildingData.water_IsOutput) {
                    // get around coord
                    var aroundCoords = [CGPoint]()
                    if (y - 1 >= 0 && buildings[y-1][x]!.activate && buildings[y-1][x]!.buildingData.water_IsInput) {
                        aroundCoords.append(CGPoint(x: x, y: y - 1))
                    }
                    if (y + 1 <= 11 && buildings[y+1][x]!.activate && buildings[y+1][x]!.buildingData.water_IsInput ) {
                        aroundCoords.append(CGPoint(x: x, y: y + 1))
                    }
                    if (x - 1 >= 0 && buildings[y][x-1]!.activate && buildings[y][x-1]!.buildingData.water_IsInput ) {
                        aroundCoords.append(CGPoint(x: x - 1, y: y))
                    }
                    if (x + 1 <= 9 && buildings[y][x+1]!.activate && buildings[y][x+1]!.buildingData.water_IsInput ) {
                        aroundCoords.append(CGPoint(x: x + 1, y: y))
                    }
                    // according coord number, calculate water balance
                    for (count, coord) in aroundCoords.enumerate() {
                        if buildings[Int(coord.y)][Int(coord.x)]!.buildingData.water_Current == buildings[Int(coord.y)][Int(coord.x)]!.buildingData.water_Max {
                            aroundCoords.removeAtIndex(count)
                        }
                    }
                    while(true) {
                        for (count, coord) in aroundCoords.enumerate() {
                            building!.buildingData.water_Current! -= 1
                            buildings[Int(coord.y)][Int(coord.x)]!.buildingData.water_Current! += 1
                            if buildings[Int(coord.y)][Int(coord.x)]!.buildingData.water_Current == buildings[Int(coord.y)][Int(coord.x)]!.buildingData.water_Max {
                                aroundCoords.removeAtIndex(count)
                            }
                        }
                        if aroundCoords.count == 0 { break }
                        if building!.buildingData.water_Current == 0 { break }
                    }
                }
            }
        }
        
        // 4. Caculate water current
        for (_, line) in buildings.enumerate() {
            for (_, building) in line.enumerate() {
                if (building!.activate && building!.buildingData.water_Current != nil) {
                    if building!.buildingData.water_Current > building!.buildingData.water_Max {
                        building!.buildingData.water_Current = building!.buildingData.water_Max
                    }
                }
            }
        }

        // 5. Heat Consume
        for (_, line) in buildings.enumerate() {
            for (_, building) in line.enumerate() {
                if (building!.activate && building!.buildingData.isHeat2Energy) {
                    let buildingData = building!.buildingData
                    // heat to energy
                    if buildingData.heat_Current >= buildingData.heat2Energy_Max {
                        buildingData.energy_Current += buildingData.heat2Energy_Max
                        buildingData.heat_Current! -= buildingData.heat2Energy_Max
                    } else {
                        buildingData.energy_Current += buildingData.heat_Current
                        buildingData.heat_Current = 0
                    }
                    // water to energy
                    let water2energy = buildingData.water_Current * 100
                    if buildingData.heat_Current >= water2energy {
                        buildingData.energy_Current += water2energy
                        buildingData.heat_Current! -= water2energy
                        buildingData.water_Current = 0
                    } else {
                        buildingData.energy_Current += buildingData.heat_Current
                        buildingData.water_Current! -= (buildingData.heat_Current) / 100
                        buildingData.heat_Current = 0
                    }
                }
            }
        }
        
        // 4. Destroy & Activate & Rebuild & Update Progress
        for (y, line) in buildings.enumerate() {
            for (x, building) in line.enumerate() {
                let buildingData = building!.buildingData
                if building!.activate {
                    // A. Destroy
                    if buildingData.heat_Max != nil {
                        if buildingData.heat_Current > buildingData.heat_Max {
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
                            buildingData.heat_Current = 0
                            buildingData.water_Current = 0
                            buildingData.energy_Current = 0
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
            }
        }
        
        // 5. Calculate research, energy, money tick add
        research_TickAdd = 0
        energy_TickAdd = 0
        money_TickAdd = 0
        for (_, line) in buildings.enumerate() {
            for (_, building) in line.enumerate() {
                if building!.activate == true {
                    // research
                    if building!.buildingData.research_Produce != nil {
                        research_TickAdd += (building?.buildingData.research_Produce)!
                    }
                    // energy
                    if building?.buildingData.energy_Current != nil {
                        energy_TickAdd += (building?.buildingData.energy_Current)!
                        building?.buildingData.energy_Current = 0
                    }
                    // money
                    if building?.buildingData.money_Sales != nil {
                        money_TickAdd += (building?.buildingData.money_Sales)!
                    }
                }
            }
        }
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