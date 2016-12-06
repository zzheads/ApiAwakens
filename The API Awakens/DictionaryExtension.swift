//
//  GetRandomTwoFromMap.swift
//  The API Awakens
//
//  Created by Alexey Papin on 06.12.16.
//  Copyright © 2016 zzheads. All rights reserved.
//

import Foundation

protocol StringConvertible {
    init?(_ string: String)
}

extension String: StringConvertible {}

extension Dictionary where Dictionary.Key: StringConvertible {
    var randomTwoKeys: [StringConvertible]? {
        if self.isEmpty {
            return nil
        }
        let keys = Array(self.keys)
        if keys.count < 2 {
            return nil
        }
        var randNumber = Int(arc4random_uniform(UInt32(keys.count)))
        var keysToShow: [StringConvertible] = [keys[randNumber] as! StringConvertible]
        let usedNumber = randNumber
        repeat {
            randNumber = Int(arc4random_uniform(UInt32(keys.count)))
        } while (usedNumber == randNumber)
        keysToShow.append(keys[randNumber] as! StringConvertible)
        return keysToShow
    }
    
    var randomKey: String? {
        if self.isEmpty {
            return nil
        }
        let keys = Array(self.keys)
        let randNumber = Int(arc4random_uniform(UInt32(keys.count)))
        let keyToShow = keys[randNumber] as! String
        return keyToShow
    }
}
