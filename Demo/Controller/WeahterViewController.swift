//
//  WeahterViewController.swift
//  Demo
//
//  Created by udn on 2019/10/29.
//  Copyright © 2019 udn. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {
  
  let weatherClient = WeatherClient()
  
  @IBOutlet weak var tempLabel: UILabel!
  @IBOutlet weak var descriptionLabel: UILabel!
  
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
    
    weatherClient.getWeather(city: pickedCity) { result in
      DispatchQueue.main.async {
        switch result {
        case .success(let weatherInfo):
          self.tempLabel.text = String(format: "%.2f", weatherInfo.temp - 273.15) + "°C"
          self.descriptionLabel.text = weatherInfo.descriptiveWeather
        case .failure(let error):
          self.tempLabel.text = "Error"
          self.descriptionLabel.text = error.localizedDescription
        }
      }
    }
  }
}
