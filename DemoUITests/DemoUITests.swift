//
//  DemoUITests.swift
//  DemoUITests
//
//  Created by udn on 2019/10/29.
//  Copyright © 2019 udn. All rights reserved.
//

import XCTest

class DemoUITests: XCTestCase {
  
  var app: XCUIApplication!
  
  override func setUp() {
    super.setUp()
    continueAfterFailure = false
    app = XCUIApplication()
    XCUIDevice.shared.orientation = .portrait
    app.launch()
    
  }
  
  override func tearDown() {
    app = nil
    super.tearDown()
  }
  
  func testClickToWeatherView() {
    app.buttons["測試在"].tap()
    app.buttons["我深深的"].tap()
    XCTAssertTrue(app.buttons["頁面裡"].isHittable)
  }
  
  func testClickToWeatherView_Landscape() {
    XCUIDevice.shared.orientation = .landscapeLeft
    testClickToWeatherView()
  }
  
  func testPickedCity_showsCorrespondCity_navTitleAndTempLabel() {
    app.pickerWheels.element.adjust(toPickerWheelValue: "Vancouver")
    app.buttons["Confirm City"].tap()
    app.buttons["測試在"].tap()
    app.buttons["我深深的"].tap()
    
    XCTAssertTrue(app.navigationBars["Vancouver's Weather"].exists)
    let tempLabel = app.staticTexts["tempLabel"]
    
    let predicate = NSPredicate(format: "label ENDSWITH '°C'")
    let exp = expectation(for: predicate, evaluatedWith: tempLabel, handler: nil)
    wait(for: [exp], timeout: 2)
  }
}
