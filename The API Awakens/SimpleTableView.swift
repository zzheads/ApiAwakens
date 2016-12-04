//
//  SimpleTableView.swift
//  The API Awakens
//
//  Created by Alexey Papin on 04.12.16.
//  Copyright © 2016 zzheads. All rights reserved.
//

import Foundation
import UIKit

class SimpleTableView: UIView {
    let header: UILabel
    var labelNames: [UILabel] = []
    var labelValues: [UILabel] = []
    var lines: [Line] = []
    static let offsetX: CGFloat = 12
    
    init(headerTitle: String, labelNames: [String], labelValues: [String]) {
        var height: CGFloat = 0
        let widthScreen = UIScreen.main.bounds.size.width
        let offsetFromHeader: CGFloat = 20
        let offsetBetweenLines: CGFloat = 16
        
        self.header = UILabel()
        self.header.font = UIFont.boldSystemFont(ofSize: 20)
        self.header.textColor = .white
        self.header.text = headerTitle
        height += self.header.bounds.size.height + offsetFromHeader
        
        for name in labelNames {
            let nameLabel = UILabel()
            nameLabel.font = UIFont.boldSystemFont(ofSize: 17)
            nameLabel.textColor = AppColor.Blue.color
            nameLabel.text = name
            height += nameLabel.bounds.size.height + offsetBetweenLines
            self.labelNames.append(nameLabel)
        }

        for value in labelValues {
            let valueLabel = UILabel()
            valueLabel.font = UIFont.boldSystemFont(ofSize: 17)
            valueLabel.textColor = AppColor.Silver.color
            valueLabel.text = value
            self.labelValues.append(valueLabel)
        }
        
        let rect = CGRect(x: 0, y: 0, width: widthScreen, height: height)
        super.init(frame: rect)
        self.backgroundColor = AppColor.Black.color
        
        self.addSubview(header)
        header.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            header.centerXAnchor.constraint(equalTo: self.leftAnchor, constant: widthScreen / 2),
            header.topAnchor.constraint(equalTo: self.topAnchor)
            ])
        
        var currentBottomAnchor = self.header.bottomAnchor
        
        for i in 0..<self.labelNames.count {
            let labelName = self.labelNames[i]
            let labelValue = self.labelValues[i]
    
            var offset: CGFloat {
                if currentBottomAnchor == self.header.bottomAnchor {
                    return offsetFromHeader
                }
                return offsetBetweenLines
            }
            
            self.addSubview(labelName)
            labelName.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                labelName.leftAnchor.constraint(equalTo: self.leftAnchor, constant: SimpleTableView.offsetX),
                labelName.widthAnchor.constraint(equalToConstant: widthScreen / 5),
                labelName.topAnchor.constraint(equalTo: currentBottomAnchor, constant: offset)
                ])

            self.addSubview(labelValue)
            labelValue.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                labelValue.leftAnchor.constraint(equalTo: self.leftAnchor, constant: widthScreen / 5 + SimpleTableView.offsetX * 2),
                labelValue.widthAnchor.constraint(equalToConstant: widthScreen * 4 / 5 - SimpleTableView.offsetX * 3),
                labelValue.centerYAnchor.constraint(equalTo: labelName.centerYAnchor)
                ])

            let lineHeight = Int(labelName.font.lineHeight + offsetBetweenLines)
            let y = header.font.lineHeight + offsetFromHeader + CGFloat(lineHeight * (i + 1)) - offsetBetweenLines * 3 / 7
            let line = Line(xStart: Int(SimpleTableView.offsetX), xEnd: Int(widthScreen - SimpleTableView.offsetX), y: Int(y), color: AppColor.Dark.color)
            self.addSubview(line)
            self.lines.append(line)

            currentBottomAnchor = labelName.bottomAnchor
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
