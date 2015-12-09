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
enum BuildMenu {
    case Wind, Fire, Default
}

class Building: SKNode {
    
    var coord: CGPoint!
    var buildingNode: SKSpriteNode!
    
    func configureAtCoord(coord: CGPoint, build: BuildMenu) {
        self.coord = coord
        
        if build == .Wind {
            buildingNode = SKSpriteNode(imageNamed: "風力")
            buildingNode.name = "Wind"
        }
        buildingNode.anchorPoint = CGPoint(x: 0, y: 1)
        addChild(buildingNode)
    }
}

class BuildingMap: SKNode {
    
    var buldingSize: CGSize = CGSizeMake(64, 64)
    var mapSize: CGSize = CGSizeMake(9, 11)
    var buildings = Array< Array<Building?>>()
    
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
        let x = buldingSize.width * coord.x
        let y = buldingSize.height * -coord.y
        return CGPoint(x: x, y: y)
    }
    // MARK: Position transfer to Coord
    func Position2Coord(tilemapPosition: CGPoint) -> CGPoint {
        let x = tilemapPosition.x / buldingSize.width
        let y = tilemapPosition.y / -buldingSize.height
        return CGPoint(x: Int(x), y: Int(y))
    }
    // MARK: Return the building by coord
    func BuildingForCoord(coord: CGPoint) -> Building? {
        if coord.x < 0 || coord.x > mapSize.width - 1 || coord.y < 0 || coord.y > mapSize.height - 1 {
            return nil
        }
        return buildings[Int(coord.y)][Int(coord.x)]
    }
    // MARK: Set tiles by word in coord
    func SetTileMapElement(coord coord: CGPoint, build: BuildMenu) {
        if let building = BuildingForCoord(coord) {
            building.removeFromParent()
        }
        let building = Building()
        buildings[Int(coord.y)][Int(coord.x)] = building
        building.configureAtCoord(coord, build: build)
        building.position = Coord2Position(coord)
        addChild(building)
    }
    
    // MARK: Load Tile Map by word array
    func LoadTileMap() {
        for (row, line) in buildings.enumerate() {
            for (colume, letter) in line.enumerate() {
                let coord = CGPoint(x: colume, y: row)
                let build = Building()
                build.configureAtCoord(coord, build: BuildMenu.Wind)
                build.position = Coord2Position(coord)
                buildings[Int(coord.y)][Int(coord.x)] = build
                addChild(build)
            }
        }
    }
}