//
//  WeatherClientTests.swift
//  DemoTests
//
//  Created by udn on 2019/10/29.
//  Copyright © 2019 udn. All rights reserved.
//
@testable import Demo
import XCTest

class WeatherClientTests: XCTestCase {
  
  var sut: WeatherClient!
  
  override func setUp() {
    super.setUp()
    sut = WeatherClient()
  }
  
  override func tearDown() {
    sut = nil
    super.tearDown()
  }
  
  func test_givenValidCity_callsToCompletionWithWeatherInfo() throws {
    // given
    let validCity = "London"
    var expectedCity: String?
    let exp = expectation(description: "Parse to closure")
    
    // when
    sut.getWeather(city: validCity) { result in
      switch result {
      case .success(let weatherInfo):
        expectedCity = weatherInfo.cityName
      default:
        XCTFail()
      }
      exp.fulfill()
    }
    
    waitForExpectations(timeout: 1)
    XCTAssertNotNil(expectedCity)
    XCTAssertEqual(expectedCity, validCity)
  }

  func test_givenInvalidCity_callsToCompletionWithError() throws {
    // given
    let invalidCity = "invalid"
    var expectedError: Error?
    let exp = expectation(description: "Parse to closure")
    
    // when
    sut.getWeather(city: invalidCity) { result in
      switch result {
      case .failure(let error):
        print(error)
        expectedError = error
      default:
        XCTFail()
      }
      exp.fulfill()
    }
    
    waitForExpectations(timeout: 1)
    XCTAssertNotNil(expectedError)
    XCTAssertTrue(expectedError.debugDescription.contains("inValidCity"))
  }

}
