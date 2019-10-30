//
//  APIClient.swift
//  Weather
//
//  Created by udn on 2019/4/17.
//  Copyright © 2019 dengli. All rights reserved.
//

import Foundation


class APIClient {
  
  enum APIError: Error {
    case invalidURL
    case requestFailed
  }
  
  let defaultSession: DHURLSession
  
  init(session: DHURLSession = URLSession(configuration: URLSessionConfiguration.default)) {
    self.defaultSession = session
  }
  
  func getData(from urlString: String,
               headers: [String: String]? = nil,
               completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
    
    guard let url = URL(string: urlString) else {
      completion(nil, nil, APIError.invalidURL)
      return
    }
    
    var request = URLRequest(url: url)
    request.httpMethod = "GET"
    headers?.forEach { (key, value) in
      request.setValue(value, forHTTPHeaderField: key)
    }
    
    let task = defaultSession.dataTask(with: request) { (data, response, error) in
      completion(data, response, error)
    }
    
    task.resume()
  }
}
