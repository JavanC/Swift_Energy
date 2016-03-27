//
//  Helper.swift
//  Project11
//
//  Created by Hudzilla on 22/11/2014.
//  Copyright (c) 2014 Hudzilla. All rights reserved.
//

import Foundation
import UIKit

func RandomInt(min min: Int, max: Int) -> Int {
	if max < min { return min }
	return Int(arc4random_uniform(UInt32((max - min) + 1))) + min
}

func RandomFloat() -> Float {
	return Float(arc4random()) /  Float(UInt32.max)
}

func RandomFloat(min min: Float, max: Float) -> Float {
	return (Float(arc4random()) / Float(UInt32.max)) * (max - min) + min
}

func RandomDouble(min min: Double, max: Double) -> Double {
	return (Double(arc4random()) / Double(UInt32.max)) * (max - min) + min
}

func RandomCGFloat() -> CGFloat {
	return CGFloat(RandomFloat())
}

func RandomColor() -> UIColor {
	return UIColor(red: RandomCGFloat(), green: RandomCGFloat(), blue: RandomCGFloat(), alpha: 1)
}

func RunAfterDelay(delay: NSTimeInterval, block: dispatch_block_t) {
	let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay * Double(NSEC_PER_SEC)))
	dispatch_after(time, dispatch_get_main_queue(), block)
}

func baseToPower(number: Double, base: Double, power: Int) -> Double {
    var answer = number
    if power == 0 {
        return answer
    }
    for _ in 1...power {
        answer *= base
    }
    return answer
}

func numberToString(value: Double, isInt: Bool = true) -> String {
    let number = value
    let P = Int(number/1000000000000000)
    let T = Int((number%1000000000000000)/1000000000000)
    let G = Int(number%1000000000000)/1000000000
    let M = Int(number%1000000000)/1000000
    let K = Int(number%1000000)/1000
    let N = Int(number%1000)
    let L = Int((value % 1) * 10)
    
    if P > 0 {
        return "\(P)" + (isInt ? "P" : ((T / 100) == 0 ? "P" : ".\(T / 100)P"))
    }
    if T > 0 {
        return "\(T)" + (isInt ? "T" : ((G / 100) == 0 ? "T" : ".\(G / 100)T"))
    }
    if G > 0 {
        return "\(G)" + (isInt ? "G" : ((M / 100) == 0 ? "G" : ".\(M / 100)G"))
    }
    if M > 0 {
        return "\(M)" + (isInt ? "M" : ((K / 100) == 0 ? "M" : ".\(K / 100)M"))
    }
    if K > 0 {
        return "\(K)" + (isInt ? "K" : ((N / 100) == 0 ? "K" : ".\(N / 100)K"))
    }
    return "\(N)" + (isInt ? "" : (L == 0 ? "" :".\(L)"))
}