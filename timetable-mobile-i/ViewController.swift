//
//  ViewController.swift
//  timetable classic
//
//  Created by Andru on 12.03.2020.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

//import SwiftyJSON
// pod deintegrate
// SwiftyJSON

class ViewController: UIViewController {

    @IBOutlet weak var checkConn: UIButton!
    @IBOutlet weak var sendReq: UIButton!
    @IBOutlet weak var logsBrowser: UITextView!
    @IBOutlet weak var clearLogs: UIButton!
    
    
    @IBAction func checkConnAct(_ sender: Any) {
        logsBrowser.text = "Try check connection action..."
        
        let flt = ["name": "Andru"] as Dictionary<String, Any>
        doGetRequest(
            params: flt,
            callback: {(json) in
                self.logsBrowser.text = json["comment"] as? String
            },
            errback: { (err) in
                self.logsBrowser.text = err
            }
        )
    }
    
    
    @IBAction func sendReqAct(_ sender: Any) {
        logsBrowser.text = "Send request action..."
        
        enum PrinterError: Error {
            case outOfPaper
            case noToner
            case onFire
        }
        func send(job: Int, toPrinter printerName: String) throws -> String {
            if printerName == "Never Has Toner" {
                throw PrinterError.noToner
            }
            return "Job sent"
        }
        do {
            let printerResponse = try send(job: 1040, toPrinter: "Never Has Toner")
            print(printerResponse)
        } catch {
            print(error)
        }
    }
    @IBAction func clearLogsAct(_ sender: Any) {
        logsBrowser.text = "Logs"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

}

