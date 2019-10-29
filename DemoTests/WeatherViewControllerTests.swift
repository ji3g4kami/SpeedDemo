//
//  WeatherViewControllerTests.swift
//  DemoTests
//
//  Created by udn on 2019/10/29.
//  Copyright © 2019 udn. All rights reserved.
//

import XCTest
@testable import Demo

class WeatherViewControllerTests: XCTestCase {
  
  private var userDefaults: UserDefaults!
  private var sut: WeatherViewController!
  
  override func setUp() {
    super.setUp()
    
    userDefaults = UserDefaults(suiteName: #file)
    userDefaults.removePersistentDomain(forName: #file)
    initController(WithUserDefaults: userDefaults)
  }
  
  func initController(WithUserDefaults userDefaults: UserDefaults) {

    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    sut = storyboard.instantiateViewController(withIdentifier: "WeatherViewController") as? WeatherViewController
    sut.userDefaults = userDefaults
    sut.loadView()
    sut.viewDidLoad()
  }
  
  override func tearDown() {
    super.tearDown()
    userDefaults.removeObject(forKey: UserDefaultsKey.City.rawValue)
    sut = nil
  }
  
  func test_pickedCity_isTaipeiByDefault() {
    // given
    userDefaults.removeObject(forKey: UserDefaultsKey.City.rawValue)
    
    // then
    XCTAssertEqual(sut.pickedCity, "Taipei")
  }
  
  func test_init_navigationTitle_isCitysWeather() {
    // given
    sut = nil
    userDefaults.set("台南", forKey: UserDefaultsKey.City.rawValue)
    
    // when
    initController(WithUserDefaults: userDefaults)
    
    // then
    XCTAssertEqual(sut.navigationItem.title, "台南's Weather")
  }
}
