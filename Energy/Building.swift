//
//  Building.swift
//  Energy
//
//  Created by javan.chen on 2015/12/9.
//  Copyright © 2015年 Javan chen. All rights reserved.
//

import SpriteKit

enum Level {
    case One, Two
}
enum BuildMenu: Int {
    case Nil, Wind, Fire, Generator, Office, BuildMenuLength
}

class BuildingData {
    
    var imageName: String!
    var price: Int!
    var rebuild: Bool = true
    
    var time_Progress: Bool = false
    var time_Max: Int = 0
    var time_Current: Int = -1
    var reserch_Produce: Int = 0
    var money_Sales: Int = 0

    var energy_Produce_Max: Int = 0
    var energy_produce: Int = 0
    var energy_current: Int = 0
    
    var hot_Progress: Bool = false
    var hot_CanBeEnergy: Bool = false
    var hot_IsOutput: Bool = false
    var hot_IsInput: Bool = false
    var hot_Produce: Int = 0
    var hot_Current: Int = 0
    var hot_Max: Int = 0
    
    var water_Progress: Bool = false
    var water_CanBeEnergy: Bool = false
    var water_IsOutput: Bool = false
    var water_IsInput: Bool = false
    var water_Produce: Int = 0
    var water_Current: Int = 0
    var water_Max: Int = 0
    
    init(building: BuildMenu, level: Int) {
        if building == .Nil {
            imageName = "block"
            rebuild = false
        }
        if building == .Wind {
            imageName = "風力"
            price = 1
            
            time_Max = 5
            time_Current = 5
            time_Progress = true
            
            energy_produce = 1
            energy_current = 0
        }
        if building == .Fire {
            imageName = "火力"
            price = 20
            
            time_Max = 10
            time_Current = 10
            time_Progress = true
        
            
            hot_IsOutput = true
            hot_Produce = 20
            hot_Max = 400
            hot_Current = 0
            hot_Progress = true
        }
        if building == .Generator {
            imageName = "發電機1"
            price = 50

            energy_Produce_Max = 100
            
            hot_CanBeEnergy = true
            hot_IsInput = true
            hot_Max = 1000
            hot_Current = 0
//            hot_Progress = true
            
            energy_current = 0
        }
        if building == .Office {
            imageName = "辦公室1"
            price = 10
            money_Sales = 5
        }
    }
}

class Building: SKNode {
    
    var coord: CGPoint!
    var buildingNode: SKSpriteNode!
    var level: Int!

    var activate: Bool = true
    var buildingData: BuildingData!
    
    var timeProgressBack: SKShapeNode!
    var timeProgress: SKShapeNode!
    var hotProgressBack: SKShapeNode!
    var hotProgress: SKShapeNode!
    var waterProgressBack: SKShapeNode!
    var waterProgress: SKShapeNode!

    func configureAtCoord(coord: CGPoint, buildMenu: BuildMenu, level: Int) {
        self.coord = coord
        name = String(buildMenu.hashValue)
        
        buildingData = BuildingData(building: buildMenu, level: level)
        buildingNode = SKSpriteNode(imageNamed: buildingData.imageName)
        buildingNode.anchorPoint = CGPoint(x: 0, y: 1)
        addChild(buildingNode)
        
        if buildMenu == .Nil {
            buildingNode.alpha = 0.2
            activate = false
        }
        
        // add time progress
        if buildingData.time_Progress {
            timeProgressBack = SKShapeNode(rect: CGRect(x: 4, y: -60, width: 56, height: 5), cornerRadius: 2)
            timeProgressBack.fillColor = SKColor.redColor()
            timeProgressBack.zPosition = 1
            addChild(timeProgressBack)
            timeProgress = SKShapeNode(rect: CGRect(x: 4, y: -60, width: 56, height: 5), cornerRadius: 2)
            timeProgress.fillColor = SKColor.greenColor()
            timeProgress.zPosition = 2
            addChild(timeProgress)
        }
        
        // add hot progress
        if buildingData.hot_Progress {
            hotProgressBack = SKShapeNode(rect: CGRect(x: 4, y: -50, width: 56, height: 5), cornerRadius: 2)
            hotProgressBack.fillColor = SKColor.redColor()
            hotProgressBack.zPosition = 1
            addChild(hotProgressBack)
            hotProgress = SKShapeNode(rect: CGRect(x: 4, y: -50, width: 56, height: 5), cornerRadius: 2)
            hotProgress.fillColor = SKColor.greenColor()
            hotProgress.zPosition = 2
            addChild(hotProgress)
        }
    }
    
    func progressUpdate() {
        // update Time progress
        if buildingData.time_Progress {
            let persent = CGFloat(buildingData.time_Current) / CGFloat(buildingData.time_Max)
            timeProgress.xScale = persent
        }
        // update Hot progress
        if buildingData.hot_Progress {
            let persent = CGFloat(buildingData.hot_Current) / CGFloat(buildingData.hot_Max)
            hotProgress.xScale = persent
        }
    }
}

class BuildingMap: SKNode {
    
    var tileSize: CGSize = CGSizeMake(64, 64)
    var mapSize: CGSize = CGSizeMake(9, 11)
    var buildings = Array< Array<Building?>>()
    var buildingsNumber = [String: Int]()
    
    // MARK: Configure At Position
    func configureAtPosition(position: CGPoint, level: Level) {
        self.position = position
        
        if level == .One {
            self.name = "level_One"
        }
        
        // Initialization map
        for _ in 0 ..< Int(mapSize.height) {
            buildings.append(Array(count: Int(mapSize.width), repeatedValue: nil))
        }
        for y in 0 ..< Int(mapSize.height) {
            for x in 0 ..< Int(mapSize.width) {
                let coord = CGPoint(x: x, y: y)
                setTileMapElement(coord: coord, build: .Nil)
            }
        }
        resetBuildingNumber()
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
    func setTileMapElement(coord coord: CGPoint, build: BuildMenu) {
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
            building.configureAtCoord(coord, buildMenu: build, level: 1)
            building.position = coord2Position(coord)
            addChild(building)
        }
    }
    
    // MARK: BuildingMap Update
    func Update() {
        
        
        // 1. produce Update
        for (_, line) in buildings.enumerate() {
            for (_, building) in line.enumerate() {
                if building!.activate {
                    let buildingData = building!.buildingData
                    // priduce energy
                    buildingData.energy_current += buildingData.energy_produce
                    // produce hot
                    buildingData.hot_Current += buildingData.hot_Produce
                }
            }
        }
        
        // 2. transport Hot
        for (y, line) in buildings.enumerate() {
            for (x, building) in line.enumerate() {
                // if building was hot output
                if (building!.activate && building!.buildingData.hot_IsOutput) {
                    // get around coord
                    var aroundCoords = [CGPoint]()
                    if (y - 1 >= 0 && buildings[y-1][x]!.activate && buildings[y-1][x]!.buildingData.hot_IsInput) {
                        aroundCoords.append(CGPoint(x: x, y: y - 1))
                    }
                    if (y + 1 <= 11 && buildings[y+1][x]!.activate && buildings[y+1][x]!.buildingData.hot_IsInput ) {
                        aroundCoords.append(CGPoint(x: x, y: y + 1))
                    }
                    if (x - 1 >= 0 && buildings[y][x-1]!.activate && buildings[y][x-1]!.buildingData.hot_IsInput ) {
                        aroundCoords.append(CGPoint(x: x - 1, y: y))
                    }
                    if (x + 1 <= 9 && buildings[y][x+1]!.activate && buildings[y][x+1]!.buildingData.hot_IsInput ) {
                        aroundCoords.append(CGPoint(x: x + 1, y: y))
                    }
                    // according coord number, calculate hot balance
                    if aroundCoords.count > 0 {
                        let balancehot = building!.buildingData.hot_Current / aroundCoords.count
                        for coord in aroundCoords {
                            buildings[Int(coord.y)][Int(coord.x)]!.buildingData.hot_Current += balancehot
                        }
                        building!.buildingData.hot_Current = 0
                    }
                }
            }
        }
        
        // 3. Consume Hot
        for (_, line) in buildings.enumerate() {
            for (_, building) in line.enumerate() {
                if (building!.activate && building!.buildingData.hot_CanBeEnergy) {
                    let buildingData = building!.buildingData
                    
                    if buildingData.hot_Current >= buildingData.energy_Produce_Max {
                        buildingData.energy_current += buildingData.energy_Produce_Max
                        buildingData.hot_Current -= buildingData.energy_Produce_Max
                    } else {
                        buildingData.energy_current += buildingData.hot_Current
                        buildingData.hot_Current = 0
                    }
                }
            }
        }
        
        // 4. Destroy & Activate & Caculate & Rebuild
        resetBuildingNumber()
        for (y, line) in buildings.enumerate() {
            for (x, building) in line.enumerate() {
                let buildingData = building!.buildingData
                if building!.activate {
                    // A. Destroy
                    if buildingData.hot_Max > 0 {
                        if buildingData.hot_Current > buildingData.hot_Max {
                            let coord = CGPoint(x: x, y: y)
                            removeBuilding(coord)
                            setTileMapElement(coord: coord, build: .Nil)
                        }
                    }
                    // B. Activate
                    if buildingData.time_Max > 0 {
                        buildingData.time_Current--
                        if buildingData.time_Current == 0 {
                            building!.activate = false
                            building!.alpha = 0.5
                            buildingData.hot_Current = 0
                            buildingData.water_Current = 0
                            buildingData.energy_current = 0
                        }
                        building!.progressUpdate()
                    }
                    // C. Caculater Building Number
                    addBuildingNumber(building!.name!)
                } else {
                    // D. Rebuild
                    if buildingData.rebuild {
                        buildingData.time_Current = buildingData.time_Max
                        building!.activate = true
                        building!.alpha = 1
                        building!.progressUpdate()
                    }
                }
            }
        }
    }
    // Reset Building Number
    func resetBuildingNumber() {
        for count in 0..<BuildMenu.BuildMenuLength.hashValue {
            let name = String(count)
            buildingsNumber[name] = 0
        }
    }
    func addBuildingNumber(name: String) {
        buildingsNumber[name] = buildingsNumber[name]! + 1
    }
    func getBuildingNumber(Building: BuildMenu) -> Int {
        return buildingsNumber[String(Building.hashValue)]!
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