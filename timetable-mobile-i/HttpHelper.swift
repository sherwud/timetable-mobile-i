//
//  HttpHelper.swift
//  timetable-mobile-i
//
//  Created by Andrey Sukhanov on 21.04.2020.
//  Copyright © 2020 Andrey Sukhanov. All rights reserved.
//

import Foundation


enum HttpHelperError: Error {
  case UnsuportedProtocol(string: String)
}

extension HttpHelperError: CustomStringConvertible {
    var description: String {
        switch self {
        case .UnsuportedProtocol(let string):
            return "You try using unsuported protocol \(string)."
        }
    }
}


func _initGetRequest(host: String, params: Dictionary<String, Any>) -> URLRequest {
    
    // если идем на рабочую машину не забыть подключить cisco на телефоне
    // let url = URL(string: "http://usd-suhanov.corp.tensor.ru:1444/")!
    // var url = URLComponents(string: "http://localhost:1444/test_page/")!
    
    var url = URLComponents(string: host)!
    url.queryItems = params.map { (key, value) in
        URLQueryItem(name: key, value: value as? String)
    }
    url.percentEncodedQuery = url.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")
    
    var request = URLRequest(url: url.url!)
    request.httpMethod = "GET"
    
    return request
}


func _initPostRequest(host: String, params: Dictionary<String, Any>) -> URLRequest {
    
    // если идем на рабочую машину не забыть подключить cisco на телефоне
    // let url = URL(string: "http://usd-suhanov.corp.tensor.ru:1444/")!
    // let url = URL(string: "http://localhost:1444/test_page/")!
    
    let url = URL(string: host)!
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    
    return request
}


func doHttpRequest(
    type: String,
    host: String,
    params: Dictionary<String, Any>,
    callback: @escaping (Dictionary<String, Any>) -> Void,
    errback: @escaping (String?) -> Void
) throws {
    
    var request: URLRequest
    
    if type == "GET" {
       request = _initGetRequest(host: host, params: params)
    }
    else if type == "POST" {
        request = _initPostRequest(host: host, params: params)
    }
    else {
        throw HttpHelperError.UnsuportedProtocol(string: type)
    }
    
    let task = URLSession.shared.dataTask(with: request) {(data, response, error) in
        DispatchQueue.main.async {
            
            if error != nil {
                errback(error?.localizedDescription ?? "Can't get internal server error description.")
                return
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data!) as! Dictionary<String, AnyObject>
                callback(json)
            } catch {
                errback("Can't convert internal server response to JSON format.")
            }
        }
    }
    task.resume()
}
