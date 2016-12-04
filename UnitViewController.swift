//
//  UnitViewController.swift
//  The API Awakens
//
//  Created by Alexey Papin on 01.12.16.
//  Copyright © 2016 zzheads. All rights reserved.
//

import UIKit

class UnitViewController: UIViewController {
    let unitType: UnitType

    enum Currency {
        case Credits
        case USD
    }
    
    var currentItem = 0 {
        didSet {
            if (!resourceArray.isEmpty) {
                tableView.header.text = resourceArray[currentItem].name
                for i in 0..<resourceArray[currentItem].labelNames.count {
                    tableView.labelNames[i].text = resourceArray[currentItem].labelNames[i]
                    tableView.labelValues[i].text = resourceArray[currentItem].labelValues[i]
                }
            }
        }
    }
    
    lazy var activity: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
        activity.isHidden = true
        activity.hidesWhenStopped = true
        activity.color = AppColor.Blue.color
        activity.translatesAutoresizingMaskIntoConstraints = false
        return activity
    }()
    
    lazy var pickerView: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.dataSource = self
        pickerView.delegate = self
        pickerView.backgroundColor = .white
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        return pickerView
    }()
    
    lazy var tableView: SimpleTableView = {
        let tableView = SimpleTableView(headerTitle: "Loading...", labelNames: [" ", " ", " ", " ", " "], labelValues: [" ", " ", " ", " ", " "])
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    lazy var smallestLargest: SmallestLargestView = {
        let smallestLargest = SmallestLargestView()
        smallestLargest.translatesAutoresizingMaskIntoConstraints = false
        return smallestLargest
    }()
    
    lazy var usdButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .clear
        button.setTitleColor(AppColor.Dark.color, for: .normal)
        button.setTitle("USD", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(translateCost(sender:)), for: .touchUpInside)
        return button
    }()
    
    lazy var creditsButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .clear
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Credits", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(translateCost(sender:)), for: .touchUpInside)
        return button
    }()

    lazy var englishButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .clear
        button.setTitleColor(AppColor.Dark.color, for: .normal)
        button.setTitle("English", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(translateMeasure(sender:)), for: .touchUpInside)
        return button
    }()
    
    lazy var metricsButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .clear
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Metrics", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(translateMeasure(sender:)), for: .touchUpInside)
        return button
    }()    
    
    var resourceArray: [Resource] = []
    
    init(unitType: UnitType) {
        self.unitType = unitType
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = AppColor.Black.color
        navigationController?.navigationBar.barStyle = .blackOpaque
        self.navigationItem.title = "\(self.unitType.rawValue)s"
        
        self.view.addSubview(activity)
        NSLayoutConstraint.activate([
            activity.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            activity.centerYAnchor.constraint(equalTo: self.view.topAnchor, constant: UIScreen.main.bounds.size.height / 4)
            ])
        activity.startAnimating()

        self.view.addSubview(pickerView)
        NSLayoutConstraint.activate([
            pickerView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            pickerView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            pickerView.topAnchor.constraint(equalTo: self.view.centerYAnchor),
            pickerView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -SmallestLargestView.height)
            ])
        
        self.view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 80),
            tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor)
            ])
        
        self.view.addSubview(smallestLargest)
        NSLayoutConstraint.activate([
            smallestLargest.topAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -SmallestLargestView.height),
            smallestLargest.heightAnchor.constraint(equalToConstant: SmallestLargestView.height),
            smallestLargest.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            smallestLargest.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.size.width)
            ])

        self.view.addSubview(creditsButton)
        NSLayoutConstraint.activate([
            creditsButton.centerYAnchor.constraint(equalTo: self.tableView.labelValues[1].centerYAnchor),
            creditsButton.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -SimpleTableView.offsetX),
            ])
        
        self.view.addSubview(usdButton)
        NSLayoutConstraint.activate([
            usdButton.centerYAnchor.constraint(equalTo: self.tableView.labelValues[1].centerYAnchor),
            usdButton.rightAnchor.constraint(equalTo: self.creditsButton.leftAnchor, constant: -SimpleTableView.offsetX),
            ])
        
        self.view.addSubview(metricsButton)
        NSLayoutConstraint.activate([
            metricsButton.centerYAnchor.constraint(equalTo: self.tableView.labelValues[2].centerYAnchor),
            metricsButton.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -SimpleTableView.offsetX),
            ])
        
        self.view.addSubview(englishButton)
        NSLayoutConstraint.activate([
            englishButton.centerYAnchor.constraint(equalTo: self.tableView.labelValues[2].centerYAnchor),
            englishButton.rightAnchor.constraint(equalTo: self.creditsButton.leftAnchor, constant: -SimpleTableView.offsetX),
            ])

        switch self.unitType {
        case .Character:
            self.tableView.header.text = "Loading Characters..."
            ResourcePage.fetchArray(resourceClass: Character.self) { characters in
                self.tableView.header.text = "Loading Planets..."
                ResourcePage.fetchArray(resourceClass: Planet.self) { planets in
                    for i in 0..<characters.count {
                        var character = characters[i]
                        let url = character.home
                        if let home = planets.findNameByUrl(url: url) {
                            character.home = home
                        } else {
                            character.home = "Unknown planet (\(url))"
                        }
                        self.resourceArray.append(character)
                    }
                    self.calcSmallestLargest()
                    self.currentItem = 0
                    self.pickerView.reloadAllComponents()
                    self.activity.stopAnimating()
                }
            }
        case .Vehicle:
            self.tableView.header.text = "Loading Vehicles..."
            ResourcePage.fetchArray(resourceClass: Vehicle.self) { vehicles in
                for vehicle in vehicles {
                    self.resourceArray.append(vehicle)
                }
                self.calcSmallestLargest()
                self.currentItem = 0
                self.pickerView.reloadAllComponents()
                self.activity.stopAnimating()
            }
        case .Starship:
            self.tableView.header.text = "Loading Starships..."
            ResourcePage.fetchArray(resourceClass: Starship.self) { starships in
                for starship in starships {
                    self.resourceArray.append(starship)
                }
                self.calcSmallestLargest()
                self.currentItem = 0
                self.pickerView.reloadAllComponents()
                self.activity.stopAnimating()
            }
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

//MARK: -- PICKER VIEW

extension UnitViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    //MARK: - PickerView DataSource
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return resourceArray.count
    }
    
    //MARK: - PickerView Delegates
        
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let title = NSAttributedString(string: resourceArray[row].name, attributes: [NSForegroundColorAttributeName : UIColor.black])
        return title
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.currentItem = row
    }
}

//MARK: - Helpers

extension UnitViewController {
    func calcSmallestLargest() {
        var smallest: Double
        var largest: Double
        
        if (!self.resourceArray.isEmpty) {
            smallest = resourceArray[0].measured
            largest = resourceArray[0].measured
        } else {
            return
        }
        
        var smallestName: String = ""
        var largestName: String = ""
        for resource in self.resourceArray {
            if resource.measured > largest {
                largest = resource.measured
                largestName = resource.name
            }
            if resource.measured < smallest {
                smallest = resource.measured
                smallestName = resource.name
            }
        }
        self.smallestLargest.smallestValueLabel.text = smallestName
        self.smallestLargest.largestValueLabel.text = largestName
    }

    
//      MARK: -Translate Galaxy Credits in USDollars
//      Source: http://www.swtor.com/community/showthread.php?t=442915
//      Now, we have picked the Sliders which generally sell for 6.7 Galactic Credit Standard (GCS), as they generally seem to use the same type of
//      food stock as the MacD [s]bread and butter[/s] Burger.
//      In the US the Big-Mac on average sell for 4.2 dollars in 2012. (8)
//      the price of a Big Mac was 6.7 GCS in the Galaxy (At Dex's Diner)
//      the price of a Big Mac was 4.2 USD in the United States (Varies by Store)
//      the implied purchasing power parity was 1.6 GCS to 1 USD , that is 6.7/4.2 = 1.59
//      In the Euro-zone the Big-Mac price varies, but on average sell for 4.43 USD.
    
    func translateCost(sender: UIButton) {
        let CURRENCY_MULTIPLIER = 1.59 // 1 USD = 1.59 Credits, see above
        guard let costInCredits = self.resourceArray[self.currentItem].costInCredits, let senderTitle = sender.titleLabel?.text else {
            return
        }
        let costInUSD = costInCredits / CURRENCY_MULTIPLIER
        let creditsString = NSString(format: "%.2f", costInCredits)
        let usdString = NSString(format: "$ %.2f", costInUSD)
        
        switch senderTitle {
        case "Credits":
            self.tableView.labelValues[1].text = creditsString as String
            self.creditsButton.setTitleColor(.white, for: .normal)
            self.usdButton.setTitleColor(AppColor.Dark.color, for: .normal)
        case "USD":
            self.tableView.labelValues[1].text = usdString as String
            self.creditsButton.setTitleColor(AppColor.Dark.color, for: .normal)
            self.usdButton.setTitleColor(.white, for: .normal)
        default:
            break
        }
    }
    
    func translateMeasure(sender: UIButton) {
        guard let senderTitle = sender.titleLabel?.text else {
            return
        }
        let cm = self.resourceArray[self.currentItem].measured
        let yard = Int(cm / 91.44)
        let feet = Int((cm - (Double(yard) * 91.44)) / 30.48)
        let inches = Int((cm - (Double(yard) * 91.44) - (Double(feet) * 30.48)) / 2.54)
        
        let cmString = NSString(format: "%.0f", cm)
        let mString = NSString(format: "%.0f", cm / 100)
        var englishString: NSString
        if yard > 0 {
            englishString = NSString(format: "%d yd %d ft %d in", yard, feet, inches)
        } else {
            if feet > 0 {
                englishString = NSString(format: "%d ft %d in", feet, inches)
            } else {
                englishString = NSString(format: "%d in", inches)
            }
        }
        
        switch senderTitle {
        case "Metrics":
            if self.unitType == .Character {
                self.tableView.labelValues[2].text = cmString as String
            } else {
                self.tableView.labelValues[2].text = mString as String
            }
            self.metricsButton.setTitleColor(.white, for: .normal)
            self.englishButton.setTitleColor(AppColor.Dark.color, for: .normal)
        case "English":
            self.tableView.labelValues[2].text = englishString as String
            self.metricsButton.setTitleColor(AppColor.Dark.color, for: .normal)
            self.englishButton.setTitleColor(.white, for: .normal)
        default:
            break
        }
    }
}
