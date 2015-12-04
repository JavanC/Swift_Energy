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
    let sprite: SKSpriteNode
    let data: TileData
    let coord: CGPoint
    
    // MARK: Initialization
    init(coord: CGPoint,data: TileData) {
        self.coord = coord
        self.data = data
        self.sprite = SKSpriteNode(texture: data.texture)

        super.init()
        
        sprite.anchorPoint = CGPoint(x: 0, y: 1)
        addChild(sprite)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class TileData {
    // MARK: Properties
    let name: String
    let texture: SKTexture
    
    // MARK: Initialization
    init(name: String, texture: String) {
        self.name = name
        self.texture = SKTexture(imageNamed: texture)
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
    func addTileData(name: String) {
        let data = TileData(name: name, texture: name)
        tileData[name] = data
    }
}

class TileMap : SKNode {
    // MARK: Properties
    let mapSize: CGSize
    let maxMapSize: Int
    var tileset: Tileset
    var tiles = Array< Array<Tile?>>()
    let tileLayer = SKNode()
    
    
    // MARK: Initialization
    init(name: String, mapSize: CGSize, maxMapSize: Int, tileset: Tileset) {
        self.mapSize = mapSize
        self.maxMapSize = maxMapSize
        self.tileset = tileset
        
        super.init()
        
        for _ in 0 ..< maxMapSize {
            tiles.append(Array(count: maxMapSize, repeatedValue: nil))
        }
        addChild(tileLayer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: Coord transfer position
    func Coord2Position(coord: CGPoint) -> CGPoint {
        let x = tileset.tileSize.width * coord.x
        let y = tileset.tileSize.height * -coord.y
        return CGPoint(x: x, y: y)
    }
    func Position2Coord(tilemapPosition: CGPoint) -> CGPoint {
        let x = tilemapPosition.x / tileset.tileSize.width
        let y = tilemapPosition.y / -tileset.tileSize.height
        return CGPoint(x: Int(x), y: Int(y))
    }
    func tileForCoord(coord: CGPoint) -> Tile? {
        if validCoord(coord) {
            return tiles[Int(coord.x)][Int(coord.y)]
        }
        return nil
    }
    func validCoord(coord: CGPoint) -> Bool {
        if coord.x < 0 || coord.x > CGFloat(maxMapSize) || coord.y < 0 || coord.y > CGFloat(maxMapSize) {
            return false
        }
        return true
    }
    
    // test
    func creatBlankMap() {
        for x in 0...2 {
            for y in 0...2 {
                if let data = tileset.tileData["block"] {
                    let coord = CGPoint(x: x, y: y)
                    let tile = Tile(coord: coord, data: data)
                    tile.position = Coord2Position(coord)
                    tileLayer.addChild(tile)
                    tiles[x][y] = tile
                }
            }
        }
    }
}
