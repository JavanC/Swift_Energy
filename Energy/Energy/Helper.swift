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
    let P = (number / 1000000000000000)
    let T = (number % 1000000000000000) / 100000000000
    let G = (number % 1000000000000) / 1000000000
    let M = (number % 1000000000) / 1000000
    let K = (number % 1000000) / 1000
    let N = (number % 1000)
    var L = Int((value % 1) * 1000)
    if L % 10 == 0 { L = L / 10 }
    if L % 10 == 0 { L = L / 10 }
    
    if P > 0 {
        return "\(P)" + (isInt ? "P" : ".\(T)P")
    }
    if T > 0 {
        return "\(T)" + (isInt ? "T" : ".\(G)T")
    }
    if G > 0 {
        return "\(G)" + (isInt ? "G" : ".\(M)G")
    }
    if M > 0 {
        return "\(M)" + (isInt ? "M" : ".\(K)M")
    }
    if K > 0 {
        return "\(K)" + (isInt ? "K" : ".\(N)K")
    }
    return "\(N)" + (isInt ? "" : ".\(L)")
//
//    let day = value / 86400
//    let hour = (value % 86400) / 3600
//    let min = (value % 3600) / 60
//    let sec = value % 60
//    
//    var timeString = ""
//    if day > 0 {
//        timeString += "\(day) day" + (day == 1 ? " " : "s ")
//    }
//    if hour < 10 { timeString += "0" }
//    timeString += "\(hour):"
//    if min < 10 { timeString += "0" }
//    timeString += "\(min):"
//    if sec < 10 { timeString += "0" }
//    timeString += "\(sec)"
//    return timeString
    
//    let number = Int(value)
//    let less = value % 1
//    if number >= 1000000 {
//        let million = number / 1000000
//        var residue = number % 1000000
//        if million >= 1000 {
//            let billion = million / 1000
//            residue = million % 1000
//            if billion >= 1000 {
//                let trillion = billion / 1000
//                residue = billion % 1000
//                return (residue == 0 ? "\(trillion) T" : "\(trillion).\(residue / 100) T")
//            }
//            return (residue == 0 ? "\(billion) B" : "\(billion).\(residue / 100) B")
//        }
//        return (residue == 0 ? "\(million) M" : "\(million).\(residue / 10000) M")
//    }
//    if isInt {
//        return String(number)
//    } else {
//        if less == 0 {
//            return String(number)
//        } else {
//            return "\(number).\(Int(less * 100))"
//        }
//    }
}