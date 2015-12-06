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
    var texture: SKTexture
    let sprite: SKSpriteNode
    
    // MARK: Initialization
    init(coord: CGPoint, texture: SKTexture) {
        self.coord = coord
        self.texture = texture
        self.sprite = SKSpriteNode(texture: texture)
        
        super.init()
        
        sprite.anchorPoint = CGPoint(x: 0, y: 1)
        addChild(sprite)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class Tileset {
    // MARK: Properties
    let name: String
    let tileSize: CGSize
    var tileData = [String: SKTexture]()
    
    // MARK: Initialization
    init(name: String, tileSize: CGSize) {
        self.name = name
        self.tileSize = tileSize
    }
    // MARK: Add Tile Data function
    func addTileData(word: String, imageName: String) {
        let texture = SKTexture(imageNamed: imageName)
        tileData[word] = texture
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
        
        // Set tiles Array initial
        for _ in 0 ..< Int(mapSize.height) {
            tiles.append(Array(count: Int(mapSize.width), repeatedValue: nil))
        }
        // Set all tile initial
        for x in  0...Int(mapSize.width - 1) {
            for y in 0...Int(mapSize.height - 1) {
                let coord = CGPoint(x: x, y: y)
                let texture = SKTexture()
                let tile = Tile(coord: coord, texture: texture)
                addChild(tile)
            }
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
    // MARK: Set tile in coord
    func SetTileMapElement(coord: CGPoint, word: String) {
        if let texture = tileset.tileData[word] {
            let tile = Tile(coord: coord, texture: texture)
            tiles[Int(coord.y)][Int(coord.x)] = tile
            tile.position = Coord2Position(coord)
            addChild(tile)
        }
    }
    
    // test
    func creatBlankMap() {
        for x in 0...3 {
            for y in 0...2 {
                let coord = CGPoint(x: x, y: y)
                if let tile = TileForCoord(coord) {
                    if let texture = tileset.tileData["x"] {
                        tile.texture = texture
                    }
                }
//                
//                if let data = tileset.tileData["x"] {
//                    let coord = CGPoint(x: x, y: y)
//                    let tile = Tile(coord: coord, texture: data)
//                    tile.position = Coord2Position(coord)
//                    addChild(tile)
//                    tiles[y][x] = tile
//                }
            }
        }
        print(tiles.count)
    }
}
