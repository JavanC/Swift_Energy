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
enum testenum: Int {
    case test1 = 1
    case test2 = 2
}

class BuildinfData {
    
    var imageName: String!
    var price: Int!
    var maxTime: Int = -1
    var currentTime: Int = -1
    var produceReserch: Int = -1
    var ProduceMoney: Int = -1

    var maxProduceEnergy: Int = 0
    var produceEnergy: Int = 0
    var currentEnergy: Int = 0
    
    var hot2Energy: Bool = false
    var HotOutput: Bool = false
    var HotInput: Bool = false
    var produceHot: Int = 0
    var currentHot: Int = 0
    var maxHot: Int = 0
    
    var WaterInput: Bool = false
    var produceWater: Int = 0
    var currentWater: Int = 0
    var maxWater: Int = 0

    init(building: BuildMenu, level: Int) {
        if building == .Nil {
            imageName = "block"
        }
        if building == .Wind {
            imageName = "風力"
            price = 1
            
            maxTime = 5
            currentTime = 5
            
            produceEnergy = 1
            currentEnergy = 0
        }
        if building == .Fire {
            imageName = "火力"
            price = 20
            
            maxTime = 100
            currentTime = 100
            
            HotOutput = true
            produceHot = 20
            maxHot = 400
            currentHot = 0
        }
        if building == .Generator {
            imageName = "發電機1"
            price = 50

            maxProduceEnergy = 100
            
            hot2Energy = true
            HotInput = true
            maxHot = 1000
            currentHot = 0
            
            currentEnergy = 0
        }
        
        
        if building == .Office {
            imageName = "辦公室1"
            price = 10
            ProduceMoney = 5
        }
    }
}

class Building: SKNode {
    
    var coord: CGPoint!
    var buildingNode: SKSpriteNode!
    var level: Int!
    var rebuild: Bool = false
    var Activate: Bool = true
    var buildingData: BuildinfData!

    func configureAtCoord(coord: CGPoint, build: BuildMenu, level: Int) {
        self.coord = coord
        name = String(build.hashValue)
        
        buildingData = BuildinfData(building: build, level: level)
        buildingNode = SKSpriteNode(imageNamed: buildingData.imageName)
        buildingNode.anchorPoint = CGPoint(x: 0, y: 1)
        addChild(buildingNode)
        
        if build == .Nil {
            buildingNode.alpha = 0.2
            Activate = false
        }
    }
}

class BuildingMap: SKNode {
    
    var tileSize: CGSize = CGSizeMake(64, 64)
    var mapSize: CGSize = CGSizeMake(9, 11)
    var buildings = Array< Array<Building?>>()
    
    var BuildingsNumber = [String: Int]()
    
    func configureAtPosition(position: CGPoint, level: Level) {
        self.position = position
        
        if level == .One {
            self.name = "level_One"
        }
        
        for _ in 0 ..< Int(mapSize.height) {
            buildings.append(Array(count: Int(mapSize.width), repeatedValue: nil))
        }
        for y in 0 ..< Int(mapSize.height) {
            for x in 0 ..< Int(mapSize.width) {
                let coord = CGPoint(x: x, y: y)
                SetTileMapElement(coord: coord, build: .Nil)
            }
        }
        ResetBuildingNumber()
    }
    // MARK: Coord transfer to position
    func Coord2Position(coord: CGPoint) -> CGPoint {
        let x = tileSize.width * coord.x
        let y = tileSize.height * -coord.y
        return CGPoint(x: x, y: y)
    }
    // MARK: Position transfer to Coord
    func Position2Coord(tilemapPosition: CGPoint) -> CGPoint {
        let x = tilemapPosition.x / tileSize.width
        let y = tilemapPosition.y / -tileSize.height
        return CGPoint(x: Int(x), y: Int(y))
    }
    // MARK: Return the building by coord
    func BuildingForCoord(coord: CGPoint) -> Building? {
        if coord.x < 0 || coord.x > mapSize.width - 1 || coord.y < 0 || coord.y > mapSize.height - 1 {
            return nil
        }
        return buildings[Int(coord.y)][Int(coord.x)]
    }
    // MARK: Remove building from coord
    func RemoveBuilding(coord: CGPoint) {
        buildings[Int(coord.y)][Int(coord.x)]!.removeFromParent()
        buildings[Int(coord.y)][Int(coord.x)] = nil
    }
    // MARK: Set tiles by word in coord
    func SetTileMapElement(coord coord: CGPoint, build: BuildMenu) {
        let x = Int(coord.x)
        let y = Int(coord.y)
        
        // Have Building and not Activate, remove!
        if (buildings[y][x] != nil && !buildings[y][x]!.Activate) {
            RemoveBuilding(coord)
        }
        // if nil, build
        if (buildings[y][x] == nil) {
            let building = Building()
            buildings[y][x] = building
            building.configureAtCoord(coord, build: build, level: 1)
            building.position = Coord2Position(coord)
            addChild(building)
        }
    }
    
    // MARK: BuildingMap Update
    func Update() {
        
        
        // 1. produce Update
        for (_, line) in buildings.enumerate() {
            for (_, building) in line.enumerate() {
                if building!.Activate == true {
                    let buildingData = building!.buildingData
                    // 產生能源
                    buildingData.currentEnergy += buildingData.produceEnergy
                    // 產生熱量
                    buildingData.currentHot += buildingData.produceHot
                }
            }
        }
        
        // 2. transport Hot
        for (y, line) in buildings.enumerate() {
            for (x, building) in line.enumerate() {
                //判斷是否為熱輸出
                if (building!.Activate == true && building?.buildingData.HotOutput == true) {
                    //取得周遭熱平衡建築座標
                    var aroundCoords = [CGPoint]()
                    if (y - 1 >= 0 && buildings[y-1][x]?.Activate == true && buildings[y-1][x]?.buildingData.HotInput == true) {
                        aroundCoords.append(CGPoint(x: x, y: y - 1))
                    }
                    if (y + 1 <= 11 && buildings[y+1][x]?.Activate == true && buildings[y+1][x]?.buildingData.HotInput == true) {
                        aroundCoords.append(CGPoint(x: x, y: y + 1))
                    }
                    if (x - 1 >= 0 && buildings[y][x-1]?.Activate == true && buildings[y][x-1]?.buildingData.HotInput == true) {
                        aroundCoords.append(CGPoint(x: x - 1, y: y))
                    }
                    if (x + 1 <= 9 && buildings[y][x+1]?.Activate == true && buildings[y][x+1]?.buildingData.HotInput == true) {
                        aroundCoords.append(CGPoint(x: x + 1, y: y))
                    }
                    //根據座標數量，算出熱平衡量
                    if aroundCoords.count > 0 {
                        let balancehot = building!.buildingData.currentHot / aroundCoords.count
                        for coord in aroundCoords {
                            buildings[Int(coord.y)][Int(coord.x)]!.buildingData.currentHot += balancehot
                        }
                        building!.buildingData.currentHot = 0
                    }
                }
            }
        }
        
        // 3. Consume Hot
        for (_, line) in buildings.enumerate() {
            for (_, building) in line.enumerate() {
                if (building!.Activate == true && building!.buildingData.hot2Energy == true) {
                    let buildingData = building!.buildingData
                    
                    if buildingData.currentHot >= buildingData.maxProduceEnergy {
                        buildingData.currentEnergy += buildingData.maxProduceEnergy
                        buildingData.currentHot -= buildingData.maxProduceEnergy
                    } else {
                        buildingData.currentEnergy += buildingData.currentHot
                        buildingData.currentHot = 0
                    }
                }
            }
        }
        
        // 4. Destroy & Activate & Caculate
        ResetBuildingNumber()
        for (y, line) in buildings.enumerate() {
            for (x, building) in line.enumerate() {
                if building!.Activate == true {
                    let buildingData = building!.buildingData
                    // Destroy
                    if buildingData.maxHot > 0 {
                        if buildingData.currentHot > buildingData.maxHot {
                            let coord = CGPoint(x: x, y: y)
                            RemoveBuilding(coord)
                            SetTileMapElement(coord: coord, build: .Nil)
                        }
                    }
                    // Activate
                    if buildingData.currentTime > 0 {
                        buildingData.currentTime -= 1
                    } else if buildingData.currentTime == 0 {
                        buildingData.currentTime -= 1
                        building!.Activate = false
                        building!.alpha = 0.5
                    } else {
                        if building!.rebuild {
                            buildingData.currentTime = buildingData.maxTime
                            building!.Activate = true
                            building!.alpha = 1
                        }
                    }
                    // Caculater Building Number
                    AddBuildingNumber(building!.name!)
                }
            }
        }
    }
    // Reset Building Number
    func ResetBuildingNumber() {
        for count in 0..<BuildMenu.BuildMenuLength.hashValue {
            let name = String(count)
            BuildingsNumber[name] = 0
        }
    }
    func AddBuildingNumber(name: String) {
        BuildingsNumber[name] = BuildingsNumber[name]! + 1
    }
    func GetBuildingNumber(Building: BuildMenu) -> Int {
        return BuildingsNumber[String(Building.hashValue)]!
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