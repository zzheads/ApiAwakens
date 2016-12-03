//
//  CharacterArray.swift
//  The API Awakens
//
//  Created by Alexey Papin on 03.12.16.
//  Copyright © 2016 zzheads. All rights reserved.
//

import Foundation

struct ResourcePage<T> where T: JSONDecodable {
    let count: Int
    let next: String?
    let previous: String?
    var results: [T] = []
}

extension ResourcePage: JSONDecodable {
    init?(JSON: JSON) {
        guard
        let count = JSON["count"] as? Int,
        let next = JSON["next"] as? String?,
        let previous = JSON["previous"] as? String?,
        let results = JSON["results"] as? [JSON]
            else {
                return nil
        }
        self.count = count
        self.next = next
        self.previous = previous
        for json in results {
            if let value = T(JSON: json) {
                self.results.append(value)
            }
        }
    }
}
