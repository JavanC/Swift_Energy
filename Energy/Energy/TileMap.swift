//
//  TileMap.swift
//  Energy
//
//  Created by javan.chen on 2015/12/4.
//  Copyright © 2015年 Javan chen. All rights reserved.
//

import SpriteKit

class Tile : SKNode {
    // MARK: Properties
    let coord: CGPoint
    var data: TileData
    let sprite: SKSpriteNode
    
    // MARK: Initialization
    init(name: String, coord: CGPoint, data: TileData) {
        self.coord = coord
        self.data = data
        self.sprite = SKSpriteNode(texture: data.texture)
        
        super.init()
        self.name = "Tile_\(name)"
        sprite.anchorPoint = CGPoint(x: 0, y: 1)
        addChild(sprite)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class TileData {
    // MARK: properties
    let name: String
    let texture: SKTexture
    
    var produceEnergySpeed: Int
    
    // MARK: Initialization
    init(name: String, imageNamed: String, produceEnergySpeed: Int) {
        self.name = name
        self.texture = SKTexture(imageNamed: imageNamed)
        self.produceEnergySpeed = produceEnergySpeed
    }
}

class Tileset {
    // MARK: Properties
    let name: String
    let tileSize: CGSize
    var tileData = [String: TileData]()
    
    // MARK: Initialization
    init(name: String, tileSize: CGSize) {
        self.name = name
        self.tileSize = tileSize
    }
    // MARK: Add Tile Data function
    func addTileData(word word: String, imageName: String, produceEnergySpeed: Int) {
        
        let data = TileData(name: word, imageNamed: imageName, produceEnergySpeed: produceEnergySpeed)
        tileData[word] = data
    }
}

class TileMap : SKNode {
    // MARK: Properties
    let mapSize: CGSize
    var tileset: Tileset
    var tiles = Array< Array<Tile?>>()
    
    // MARK: Initialization
    init(name: String, mapSize: CGSize, tileset: Tileset) {
        
        self.mapSize = mapSize
        self.tileset = tileset
        
        super.init()
        self.name = name
        
        // Set tiles Array initial
        for _ in 0 ..< Int(mapSize.height) {
            tiles.append(Array(count: Int(mapSize.width), repeatedValue: nil))
        }
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Coord transfer to position
    func Coord2Position(coord: CGPoint) -> CGPoint {
        let x = tileset.tileSize.width * coord.x
        let y = tileset.tileSize.height * -coord.y
        return CGPoint(x: x, y: y)
    }
    // MARK: Position transfer to Coord
    func Position2Coord(tilemapPosition: CGPoint) -> CGPoint {
        let x = tilemapPosition.x / tileset.tileSize.width
        let y = tilemapPosition.y / -tileset.tileSize.height
        return CGPoint(x: Int(x), y: Int(y))
    }
    // MARK: Return the tile by coord
    func TileForCoord(coord: CGPoint) -> Tile? {
        if coord.x < 0 || coord.x > mapSize.width - 1 || coord.y < 0 || coord.y > mapSize.height - 1 {
            return nil
        }
        return tiles[Int(coord.y)][Int(coord.x)]
    }
    // MARK: Set tiles by word in coord
    func SetTileMapElement(coord coord: CGPoint, word: String) {
        if let Tile = TileForCoord(coord) {
            Tile.removeFromParent()
        }
        
        if let data = tileset.tileData[word] {
            let tile = Tile(name: word, coord: coord, data: data)
            tile.position = Coord2Position(coord)
            addChild(tile)
            tiles[Int(coord.y)][Int(coord.x)] = tile
        }
    }
    // MARK: Load Tile Map by word array
    func LoadTileMap(array array: Array<Array<String>>) {
        for (row, line) in array.enumerate() {
            for (colume, letter) in line.enumerate() {
                let coord = CGPoint(x: colume, y: row)
                SetTileMapElement(coord: coord, word: letter)
            }
        }
    }
    // MARK: Check building Number
    func checkBuildNumber(word: String) -> Int {
        var num = 0
        for (_, line) in tiles.enumerate() {
            for (_, tile) in line.enumerate() {
                if tile?.name == "Tile_\(word)" {
                    num++
                }
            }
        }
        return num
    }
}
