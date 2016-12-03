//
//  Resource.swift
//  The API Awakens
//
//  Created by Alexey Papin on 02.12.16.
//  Copyright © 2016 zzheads. All rights reserved.
//

import Foundation

struct Property {
    let description: String
    let type: String
}

struct Schema {
    let title: String
    let description: String
    let type: String
    let required: [String]
    var properties: [String: Property]
}

extension Property: JSONDecodable {
    init?(JSON: JSON) {
        guard
            let description = JSON["description"] as? String,
            let type = JSON["type"] as? String
            else {
                return nil
        }
        self.description = description
        self.type = type
    }
}

extension Schema: JSONDecodable {
    init?(JSON: JSON) {
        guard
            let title = JSON["title"] as? String,
            let description = JSON["description"] as? String,
            let type = JSON["type"] as? String,
            let required = JSON["required"] as? [String],
            let properties = JSON["properties"] as? JSON
            else {
                return nil
        }
        self.title = title
        self.description = description
        self.type = type
        self.required = required
        self.properties = [:]
        for (key, value) in properties {
            let property = Property(JSON: value as! JSON)
            self.properties.updateValue(property!, forKey: key)
        }
    }
}
