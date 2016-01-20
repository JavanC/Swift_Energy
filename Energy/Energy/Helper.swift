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
    let number = Int(value)
    let less = value % 1
    if number >= 1000000 {
        let million = number / 1000000
        var residue = number % 1000000
        if million >= 1000 {
            let billion = million / 1000
            residue = million % 1000
            if billion >= 1000 {
                let trillion = billion / 1000
                residue = billion % 1000
                return (residue == 0 ? "\(trillion) Trillion" : "\(trillion).\(residue / 100) Trillion")
            }
            return (residue == 0 ? "\(billion) Billion" : "\(billion).\(residue / 100) Billion")
        }
        return (residue == 0 ? "\(million) Million" : "\(million).\(residue / 10000) Million")
    }
    if isInt {
        return String(number)
    } else {
        if less == 0 {
            return String(number)
        } else {
            return "\(number).\(Int(less * 100))"
        }
    }
}