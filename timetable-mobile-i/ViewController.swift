//
//  ViewController.swift
//  timetable classic
//
//  Created by Andru on 12.03.2020.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

import RealmSwift
//import SwiftyJSON

class ViewController: UIViewController,
                      UIPickerViewDelegate,
                      UIPickerViewDataSource {
    
    @IBOutlet weak var checkConn: UIButton!
    @IBOutlet weak var sendReq: UIButton!
    @IBOutlet weak var logsBrowser: UITextView!
    @IBOutlet weak var clearLogs: UIButton!
    @IBOutlet weak var userValueFld: UITextField!
    @IBOutlet weak var addUserValBtn: UIButton!
    @IBOutlet weak var bossFilterBtn: UIButton!
    @IBOutlet weak var bossPickerToolbar: UIToolbar!
    @IBOutlet weak var bossFilterPicker: UIPickerView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // todo: Предварительная очистка локальной базы. Только для отладки!
        // clearRealmModel()
        
        // Настройка пикера выбора руководителя
        setBossList()
        bossFilterPicker.delegate = self
        bossFilterPicker.dataSource = self
    }
    
    /// Функция для предварительной очистки базы в новой версии приложения
    /// Только для отладки
    func clearRealmModel() {
        let realm = try! Realm()
        let users = realm.objects(Users.self)
        
        for row in users {
            try! realm.write {
                realm.delete(row)
            }
        }
    }
    /// Функция загрузки списка руководителей
    func setBossList() {
        let realm = try! Realm()
        let users_list = realm.objects(Users.self)
        for row in users_list {
            boss_list.append((row["name"] as! String))
        }
    }
    
    
    // Настройка пикера выбора руководителя
    var boss_list:[String] = []
    
    @IBAction func changeBossFilterAct(_ sender: Any) {
        if boss_list.count != 0 {
            bossFilterPicker.isHidden = false
            bossPickerToolbar.isHidden = false
        }
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return boss_list.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
           self.view.endEditing(true)
           return boss_list[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        bossFilterBtn.setTitle(self.boss_list[row], for: bossFilterBtn.state)
        //bossFilterPicker.isHidden = true
    }
    @IBAction func bossPickerToolbarDoneBtn(_ sender: Any) {
        bossFilterPicker.isHidden = true
        bossPickerToolbar.isHidden = true
    }
    
    
    @IBAction func checkConnAct(_ sender: Any) {
        logsBrowser.text = "Try check connection action..."
                
        do {
            try doHttpRequest(
                    type: "GET",
                    host: "http://localhost:1444/fvds/",
                    params: [:],
                    callback: {(res) in
                        var msg = "List from server:\n"
                        
                        let realm = try! Realm()

                        try! realm.write() {
                            for (login, name) in res {
                                msg += login + "\t-\t" + (name as! String) + "\n"
                                
                                let newuser = Users()
                                newuser.idnew = newuser.incrementID()
                                newuser.login = login
                                newuser.name = name as! String
                                
                                realm.add(newuser)
                            }
                        }
                        
                        let users_list = realm.objects(Users.self)
                        msg += "\nList from database:\n"
                        for row in users_list {
                            msg += (row["login"] as! String) + "\t-\t" + (row["name"] as! String) + "\n"
                        }
                        self.logsBrowser.text = msg
                    },
                    errback: { (err) in
                        self.logsBrowser.text = err
                    }
            )
        } catch {
            self.logsBrowser.text = "Ooops! Something went wrong.."
        }
    }
    
    
    @IBAction func sendReqAct(_ sender: Any) {
        logsBrowser.text = "Send request action..."
        
        let flt = ["action": "Post Request", "name": "Andru"] as Dictionary<String, Any>
        
        do {
            try doHttpRequest(type: "POST",
                    host: "http://localhost:1444/test_page/",
                    params: flt,
                    callback: {(res) in
                        self.logsBrowser.text = anyIntToString(val: res["age"])
                    },
                    errback: { (err) in
                        self.logsBrowser.text = err
                    }
            )
        } catch {
            self.logsBrowser.text = "Ooops! Something went wrong.."
        }
    }
    
    @IBAction func addRecAct(_ sender: Any) {
        
        if userValueFld.text == "" {
            logsBrowser.text = "You should enter some text in the field on the left."
            return
        }
        
        let usersList = Users()
        usersList.idnew = usersList.incrementID()
        usersList.name = userValueFld.text!
        
        let realm = try! Realm()
        
        try! realm.write() {
            realm.add(usersList)
            logsBrowser.text = "User with name " + userValueFld.text! + " was added."
            userValueFld.text = ""
        }
    }
    
    @IBAction func clearLogsAct(_ sender: Any) {
        logsBrowser.text = ""
    }
}

