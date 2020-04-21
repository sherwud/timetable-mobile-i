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
        
        let flt = ["action": "Get Request", "name": "Andru"] as Dictionary<String, Any>
        doGetRequest(
            params: flt,
            callback: {(res) in
                self.logsBrowser.text = res["comment"] as? String
            },
            errback: { (err) in
                self.logsBrowser.text = err
            }
        )
    }
    
    
    @IBAction func sendReqAct(_ sender: Any) {
        logsBrowser.text = "Send request action..."
        
        let flt = ["action": "Post Request", "name": "Andru"] as Dictionary<String, Any>
        doPostRequest(
            params: flt,
            callback: {(res) in
                self.logsBrowser.text = res["comment"] as? String
            },
            errback: { (err) in
                self.logsBrowser.text = err
            }
        )
    }
    
    
    @IBAction func clearLogsAct(_ sender: Any) {
        logsBrowser.text = ""
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

}

