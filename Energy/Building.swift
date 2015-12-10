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
    case Wind, Fire, Office, BuildMenuLength
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
    var produceEnergy: Int = -1
    var produceReserch: Int = -1
    var ProduceMoney: Int = -1
    var produceHot: Int = -1
    var maxHot: Int = -1
    var currentHot: Int = -1
    var produceWater: Int = -1
    var maxWater: Int = -1
    var currentWater: Int = -1

    init(building: BuildMenu, level: Int) {
        if building == .Wind {
            imageName = "風力"
            price = 1
            maxTime = 5
            currentTime = maxTime
            produceEnergy = 1
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
    var destroy: Bool = false
    var buildingData: BuildinfData!

    
    func configureAtCoord(coord: CGPoint, build: BuildMenu, level: Int) {
        self.coord = coord
        name = String(build.hashValue)
        
        buildingData = BuildinfData(building: build, level: level)
        buildingNode = SKSpriteNode(imageNamed: buildingData.imageName)
        buildingNode.anchorPoint = CGPoint(x: 0, y: 1)
        addChild(buildingNode)
    }
    
    func update() {
        if Activate {
            // 更新當前資訊
            
            // 更新當前週期
            if buildingData.currentTime > 0 {
                buildingData.currentTime -= 1
            } else if buildingData.currentTime == 0 {
                buildingData.currentTime -= 1
                Activate = false
                alpha = 0.5
            } else {
                if rebuild {
                    buildingData.currentTime = buildingData.maxTime
                    Activate = true
                    alpha = 1
                }
            }
            // 判斷是否爆炸
            if buildingData.maxHot > 0 {
                if buildingData.currentHot >= buildingData.maxHot {
                    destroy = true
                }
            }
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
        let building = BuildingForCoord(coord)
        if building != nil {
            buildings[Int(coord.y)][Int(coord.x)]!.removeFromParent()
            buildings[Int(coord.y)][Int(coord.x)] = nil
        }
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
        
        ResetBuildingNumber()
        
        for (y, line) in buildings.enumerate() {
            for (x, building) in line.enumerate() {
                if building != nil {
                    // building data updata
                    building!.update()
                    // destroy building
                    if building!.destroy {
                        let coord = CGPoint(x: x, y: y)
                        RemoveBuilding(coord)
                    }
                    // calculate buildings count
                    if building!.Activate {
                        AddBuildingNumber(building!.name!)
                    }
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