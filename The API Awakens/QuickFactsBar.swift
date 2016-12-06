//
//  FastFact.swift
//  The API Awakens
//
//  Created by Alexey Papin on 05.12.16.
//  Copyright © 2016 zzheads. All rights reserved.
//

import Foundation
import UIKit

class QuickFactsBar: UIView {
    let titleLabel1: UILabel
    let valueLabel1: UILabel
    let titleLabel2: UILabel
    let valueLabel2: UILabel
    let button : UIButton
    let line: Line
    let facts: [String: FactCalculateFunction]
    var resource: [Resource]
    
    static let offsetX: CGFloat = 10
    
    static let fontTitle = UIFont.boldSystemFont(ofSize: 16)
    static let fontValue = UIFont.boldSystemFont(ofSize: 16)
    
    static let paddingY: CGFloat = 6
    static var height: CGFloat {
        return self.fontTitle.lineHeight * 2 + self.paddingY * 2
    }
    
    init(resource: [Resource]){
        self.titleLabel1 = UILabel()
        self.valueLabel1 = UILabel()
        self.titleLabel2 = UILabel()
        self.valueLabel2 = UILabel()
        self.line = Line(xStart: 0, xEnd: Int(UIScreen.main.bounds.size.width), y: 0, color: AppColor.Silver.color)
        self.button = UIButton(type: .system)
        self.facts = Facts.facts
        self.resource = resource
        
        self.titleLabel1.font = QuickFactsBar.fontTitle
        self.titleLabel2.font = QuickFactsBar.fontTitle
        self.valueLabel1.font = QuickFactsBar.fontValue
        self.valueLabel2.font = QuickFactsBar.fontValue
        
        self.titleLabel1.textColor = .gray
        self.titleLabel2.textColor = .gray
        self.valueLabel1.textColor = .black
        self.valueLabel2.textColor = .black
        
        self.button.backgroundColor = .clear
        
        let rect = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: QuickFactsBar.height)
        super.init(frame: rect)
        self.backgroundColor = .white
        
        self.addSubview(titleLabel1)
        self.addSubview(valueLabel1)
        self.addSubview(titleLabel2)
        self.addSubview(valueLabel2)
        self.addSubview(button)
        self.addSubview(line)
        
        let screenWidth = UIScreen.main.bounds.size.width
        let titleWidth = screenWidth / 2
        
        titleLabel1.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel1.leftAnchor.constraint(equalTo: self.leftAnchor, constant: QuickFactsBar.offsetX),
            titleLabel1.widthAnchor.constraint(equalToConstant: titleWidth),
            titleLabel1.topAnchor.constraint(equalTo: self.topAnchor, constant: QuickFactsBar.paddingY)
            ])
        
        valueLabel1.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            valueLabel1.leftAnchor.constraint(equalTo: self.leftAnchor, constant: titleWidth),
            valueLabel1.widthAnchor.constraint(equalToConstant: screenWidth - titleWidth - QuickFactsBar.offsetX),
            valueLabel1.topAnchor.constraint(equalTo: self.topAnchor, constant: QuickFactsBar.paddingY)
            ])
        
        titleLabel2.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel2.leftAnchor.constraint(equalTo: self.leftAnchor, constant: QuickFactsBar.offsetX),
            titleLabel2.widthAnchor.constraint(equalToConstant: titleWidth),
            titleLabel2.topAnchor.constraint(equalTo: titleLabel1.bottomAnchor)
            ])
        
        valueLabel2.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            valueLabel2.leftAnchor.constraint(equalTo: self.leftAnchor, constant: titleWidth),
            valueLabel2.widthAnchor.constraint(equalToConstant: screenWidth - titleWidth - QuickFactsBar.offsetX),
            valueLabel2.topAnchor.constraint(equalTo: valueLabel1.bottomAnchor)
            ])
        
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.leftAnchor.constraint(equalTo: self.leftAnchor),
            button.rightAnchor.constraint(equalTo: self.rightAnchor),
            button.topAnchor.constraint(equalTo: self.topAnchor),
            button.bottomAnchor.constraint(equalTo: self.bottomAnchor)
            ])
        
        self.button.addTarget(self, action: #selector(nextFact(sender:)), for: .touchUpInside)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func nextFact(sender: UIButton?) {
        var usedAndNotValidKeys: [String] = []
        var keysToShow: [String] = []
        
        repeat {
            guard let randomKey = self.facts.randomKey, let function = self.facts[randomKey] else {
                return
            }
            if !usedAndNotValidKeys.contains(randomKey) {
                if isValid(function: function, for: self.resource) {
                    keysToShow.append(randomKey)
                    usedAndNotValidKeys.append(randomKey)
                } else {
                    usedAndNotValidKeys.append(randomKey)
                }
            }
        } while keysToShow.count < 2
        
        let question1 = keysToShow[0]
        let question2 = keysToShow[1]
        guard let answerFunc1 = self.facts[question1], let answerFunc2 = self.facts[question2] else {
            return
        }
        let answer1 = answerFunc1(self.resource)
        let answer2 = answerFunc2(self.resource)
        
        self.titleLabel1.text = question1
        self.valueLabel1.text = answer1
        self.titleLabel2.text = question2
        self.valueLabel2.text = answer2
    }
    
    func isValid(function: FactCalculateFunction, for resource: [Resource]) -> Bool {
        if function(resource) == "n/a" {
            return false
        }
        return true
    }
}
