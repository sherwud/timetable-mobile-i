//
//  User.swift
//  timetable-mobile-i
//
//  Created by Andrey Sukhanov on 23.04.2020.
//  Copyright © 2020 Andrey Sukhanov. All rights reserved.
//
import Foundation

import RealmSwift


let time_periods = ["05:00", "07:00", "08:00", "10:00", "11:00", "13:00", "15:00"]

class Users: Object {
    @objc dynamic var idnew = 0
    @objc dynamic var login = ""
    @objc dynamic var name = ""
    @objc dynamic var iswork = true
    @objc dynamic var changedate = NSDate()
    
    func incrementID() -> Int {
        let realm = try! Realm()
        return (realm.objects(Users.self).max(ofProperty: "idnew") as Int? ?? 0) + 1
    }
}



//class User: Object {
//    @objc dynamic var id: Int32 = 0
//    dynamic var login = ""
//    dynamic var block = false
//    dynamic var firstname = ""
//    dynamic var surname = ""
//
//    // primary key
//    override static func primaryKey() -> String? {
//        return "id"
//    }
//    func incrementID() -> Int {
//        let realm = try! Realm()
//        return (realm.objects(User.self).max(ofProperty: "id") as Int? ?? 0) + 1
//    }
//}
//
//class Period: Object {
//    @objc dynamic var id: Int32 = 0
//    dynamic var date = NSDate()
//    dynamic var time = ""
//
//    // primary key
//    override static func primaryKey() -> String? {
//        return "id"
//    }
//}
//
//class Timetable: Object {
//    @objc dynamic var id: Int64 = 0
//    dynamic var comment = ""
//    dynamic var date = NSDate()
//
//    dynamic var boss: User?
//    dynamic var period: Period?
//
//    // primary key
//    override static func primaryKey() -> String? {
//        return "id"
//    }
//    // indexing properties
//    override static func indexedProperties() -> [String] {
//        return ["boss", "period", "comment"]
//    }
//}

