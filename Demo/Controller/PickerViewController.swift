//
//  PickerViewController.swift
//  Demo
//
//  Created by udn on 2019/10/29.
//  Copyright © 2019 udn. All rights reserved.
//

import UIKit

enum UserDefaultsKey: String {
  case City
}

class PickerViewController: UIViewController {

  @IBOutlet weak var cityPicker: UIPickerView!
  
  var userDefaults: UserDefaults = .standard
  
  let cities = ["Taipei", "Kaohsiung", "Tokyo", "Vancouver", "London"]
  
  override func viewDidLoad() {
    super.viewDidLoad()
    cityPicker.dataSource = self
    cityPicker.delegate = self
  }
  
  @IBAction func confirmCityPressed(_ sender: UIButton) {
    let pickedCity = cities[cityPicker.selectedRow(inComponent: 0)]
    storePickedCityToUserdefaults(city: pickedCity)
  }
  
  func storePickedCityToUserdefaults(city: String) {
    userDefaults.set(city, forKey: UserDefaultsKey.City.rawValue)
  }
  
}

extension PickerViewController: UIPickerViewDataSource {
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
  }
  
  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return cities.count
  }
}

extension PickerViewController: UIPickerViewDelegate {
  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    return cities[row]
  }
}
