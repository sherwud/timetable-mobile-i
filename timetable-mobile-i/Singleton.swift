//
//  Singleton.swift
//  timetable-mobile-i
//
//  Created by Andrey Sukhanov on 19.04.2020.
//  Copyright © 2020 Andrey Sukhanov. All rights reserved.
//

import Foundation

func doGetRequest(
        params: Dictionary<String, Any>,
        callback:  @escaping (_ json: Dictionary<String, Any>) -> Void,
        errback: @escaping (_ error: String?) -> Void
) {
    
    // если идем на рабочую машину не забыть подключить cisco на телефоне
    // let url = URL(string: "http://usd-suhanov.corp.tensor.ru:1444/")!
    
    let url = URL(string: "http://localhost:1444/test_page/")!
    var request = URLRequest(url: url)
    request.httpMethod = "GET"
    
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


func doPostRequest (
        params: Dictionary<String, Any>,
        callback:  @escaping (_ json: Dictionary<String, Any>) -> Void,
        errback: @escaping (_ error: String?) -> Void
) {
    
    // если идем на рабочую машину не забыть подключить cisco на телефоне
    // let url = URL(string: "http://usd-suhanov.corp.tensor.ru:1444/")!
    
    let url = URL(string: "http://localhost:1444/test_page/")!
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")

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
