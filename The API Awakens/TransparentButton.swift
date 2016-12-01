//
//  TransparentButton.swift
//  The API Awakens
//
//  Created by Alexey Papin on 01.12.16.
//  Copyright © 2016 zzheads. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    convenience init(parentView: UIView, imageView: UIImageView) {
        self.init()
        parentView.addSubview(self)
        self.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.leftAnchor.constraint(equalTo: imageView.leftAnchor),
            self.rightAnchor.constraint(equalTo: imageView.rightAnchor),
            self.topAnchor.constraint(equalTo: imageView.topAnchor),
            self.bottomAnchor.constraint(equalTo: imageView.bottomAnchor)
            ])
    }
}
