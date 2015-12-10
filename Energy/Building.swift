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
    case Wind, Fire, Default, BuildMenuLength
//    static var BuildMenuLength: Int { return Default.hashValue + 1 }
}
enum testenum: Int {
    case test1 = 1
    case test2 = 2
}

class Building: SKNode {
    
    var coord: CGPoint!
    var buildingNode: SKSpriteNode!
    var buildingLevel: Int!
    var level: Int!
    var price: Int!
    var rebuild: Bool = false
    var Activate: Bool = true
    var destroy: Bool = false
    
    var maxTime: Int = -1
    var currentTime: Int = -1
    var produceEnergy: Int = -1
    var produceHot: Int = -1
    var maxHot: Int = -1
    var currentHot: Int = -1
    var produceWater: Int = -1
    var maxWater: Int = -1
    var currentWater: Int = -1
    
    
    func configureAtCoord(coord: CGPoint, build: BuildMenu, buildLevel: Int) {
        self.coord = coord
        
        if build == .Wind {
            buildingNode = SKSpriteNode(imageNamed: "風力")
            name = String(build.hashValue)
            buildingLevel = level
            level = buildLevel
            price = 1
            
            maxTime = 5
            currentTime = maxTime
            produceEnergy = 1
        }
        buildingNode.anchorPoint = CGPoint(x: 0, y: 1)
        addChild(buildingNode)
    }
    
    func update() {
        if Activate {
            // 更新當前資訊
            
            // 更新當前週期
            if currentTime > 0 {
                currentTime -= 1
            } else if currentTime == 0 {
                currentTime -= 1
                Activate = false
                alpha = 0.5
            } else {
                if rebuild {
                    currentTime = maxTime
                    Activate = true
                    alpha = 1
                }
            }
            // 判斷是否爆炸
            if maxHot > 0 {
                if currentHot >= maxHot {
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
        
        // 如果有建築，且不活躍，移除
        if (buildings[y][x] != nil && !buildings[y][x]!.Activate) {
            RemoveBuilding(coord)
        }
        // 如果為空，建造
        if (buildings[y][x] == nil) {
            let building = Building()
            buildings[y][x] = building
            building.configureAtCoord(coord, build: build, buildLevel: 1)
            building.position = Coord2Position(coord)
            addChild(building)
        }
    }
    
    // MARK: BuildingMap Update
    func Update() {
        //重置建築計數
        ResetBuildingNumber()
        //逐一檢查
        for (y, line) in buildings.enumerate() {
            for (x, building) in line.enumerate() {
                if building != nil {
                    //更新
                    building!.update()
                    //判斷爆炸
                    if building!.destroy {
                        let coord = CGPoint(x: x, y: y)
                        RemoveBuilding(coord)
                    }
                    //計算各建築數量
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