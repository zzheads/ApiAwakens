//
//  Line.swift
//  The API Awakens
//
//  Created by Alexey Papin on 01.12.16.
//  Copyright © 2016 zzheads. All rights reserved.
//

import Foundation
import UIKit

class Line: UIView {
    
    init(xStart: Int, xEnd: Int, y: Int, color: UIColor) {
        let rect = CGRect(x: xStart, y: y, width: xEnd - xStart, height: 1)
        super.init(frame: rect)
        self.backgroundColor = color
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
