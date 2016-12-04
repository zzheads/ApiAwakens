//
//  SmallestLargestView.swift
//  The API Awakens
//
//  Created by Alexey Papin on 04.12.16.
//  Copyright © 2016 zzheads. All rights reserved.
//

import Foundation
import UIKit

class SmallestLargestView: UIView {
    let smallestTitleLabel: UILabel
    let smallestValueLabel: UILabel
    let largestTitleLabel: UILabel
    let largestValueLabel: UILabel
    let line: Line
    
    static let offsetX: CGFloat = 10
    
    static let fontTitle = UIFont.boldSystemFont(ofSize: 16)
    static let fontValue = UIFont.boldSystemFont(ofSize: 16)
    
    static let paddingY: CGFloat = 6
    static var height: CGFloat {
        return self.fontTitle.lineHeight * 2 + self.paddingY * 2
    }
    
    init(){
        self.smallestTitleLabel = UILabel()
        self.smallestValueLabel = UILabel()
        self.largestTitleLabel = UILabel()
        self.largestValueLabel = UILabel()
        
        self.smallestTitleLabel.font = SmallestLargestView.fontTitle
        self.largestTitleLabel.font = SmallestLargestView.fontTitle
        self.smallestValueLabel.font = SmallestLargestView.fontValue
        self.largestValueLabel.font = SmallestLargestView.fontValue
        
        self.smallestTitleLabel.textColor = .gray
        self.largestTitleLabel.textColor = .gray
        self.smallestValueLabel.textColor = .black
        self.largestValueLabel.textColor = .black
        self.smallestTitleLabel.backgroundColor = .white
        self.smallestValueLabel.backgroundColor = .white
        self.largestTitleLabel.backgroundColor = .white
        self.largestValueLabel.backgroundColor = .white
        
        self.smallestTitleLabel.text = "Smallest:"
        self.smallestValueLabel.text = " "
        self.largestTitleLabel.text = "Largest:"
        self.largestValueLabel.text = " "
        
        self.line = Line(xStart: 0, xEnd: Int(UIScreen.main.bounds.size.width), y: 0, color: AppColor.Silver.color)
        
        let rect = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: SmallestLargestView.height)
        super.init(frame: rect)
        self.backgroundColor = .white
        
        self.addSubview(smallestTitleLabel)
        self.addSubview(smallestValueLabel)
        self.addSubview(largestTitleLabel)
        self.addSubview(largestValueLabel)
        self.addSubview(line)
        
        let screenWidth = UIScreen.main.bounds.size.width
        let titleWidth = screenWidth / 4
        
        smallestTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            smallestTitleLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: SmallestLargestView.offsetX),
            smallestTitleLabel.widthAnchor.constraint(equalToConstant: titleWidth),
            smallestTitleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: SmallestLargestView.paddingY)
            ])
        
        smallestValueLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            smallestValueLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: titleWidth),
            smallestValueLabel.widthAnchor.constraint(equalToConstant: screenWidth - titleWidth - SmallestLargestView.offsetX),
            smallestValueLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: SmallestLargestView.paddingY)
            ])
        
        largestTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            largestTitleLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: SmallestLargestView.offsetX),
            largestTitleLabel.widthAnchor.constraint(equalToConstant: titleWidth),
            largestTitleLabel.topAnchor.constraint(equalTo: smallestTitleLabel.bottomAnchor)
            ])
        
        largestValueLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            largestValueLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: titleWidth),
            largestValueLabel.widthAnchor.constraint(equalToConstant: screenWidth - titleWidth - SmallestLargestView.offsetX),
            largestValueLabel.topAnchor.constraint(equalTo: smallestValueLabel.bottomAnchor)
            ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
