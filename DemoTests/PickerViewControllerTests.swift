//
//  DemoTests.swift
//  DemoTests
//
//  Created by udn on 2019/10/29.
//  Copyright © 2019 udn. All rights reserved.
//

import XCTest
@testable import Demo

class PickerViewControllerTests: XCTestCase {
  
  private var userDefaults: UserDefaults!
  var sut: PickerViewController!
  
  override func setUp() {
    super.setUp()
    
    userDefaults = UserDefaults(suiteName: #file)
    userDefaults.removePersistentDomain(forName: #file)
    
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    sut = storyboard.instantiateViewController(withIdentifier: "PickerViewController") as? PickerViewController
    sut.userDefaults = userDefaults
    sut.loadView()
    sut.viewDidLoad()
  }
  
  override func tearDown() {
    super.tearDown()
    sut = nil
  }

  
  func testStorePickedCityToUserdefaults() {
    // given
    let pickedCity = "台北"
    
    // when
    sut.storePickedCityToUserdefaults(city: pickedCity)
    
    // then
    XCTAssertEqual(pickedCity, userDefaults.value(forKey: UserDefaultsKey.City.rawValue) as? String)
  }
  
  func testConfirmCityPressed() {
    // given
    let row = 2
    let pickedCity = sut.cities[row]
    sut.cityPicker.selectRow(row, inComponent: 0, animated: false)
    
    // when
    sut.confirmCityPressed(UIButton())
    
    // then
    XCTAssertEqual(pickedCity, userDefaults.value(forKey: UserDefaultsKey.City.rawValue) as? String)
  }
}
