//
//  WeahterViewController.swift
//  Demo
//
//  Created by udn on 2019/10/29.
//  Copyright © 2019 udn. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {
  
  var userDefaults: UserDefaults = .standard
  
  var pickedCity: String {
    guard let city = userDefaults.value(forKey: UserDefaultsKey.City.rawValue) as? String else {
        return "Taipei"
    }
    return city
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    navigationItem.title = "\(pickedCity)'s Weather"
    
  }
  
  
  
}
