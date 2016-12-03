//
//  Planet.swift
//  The API Awakens
//
//  Created by Alexey Papin on 02.12.16.
//  Copyright © 2016 zzheads. All rights reserved.
//

import Foundation

struct Planet: Resource {
    let name: String
}

extension Planet: JSONDecodable {
    init?(JSON: JSON) {
        guard
            let name = JSON["name"] as? String
            else {
                return nil
        }
        self.name = name
    }
}
