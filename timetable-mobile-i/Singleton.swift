//
//  Singleton.swift
//  timetable-mobile-i
//
//  Created by Andrey Sukhanov on 19.04.2020.
//  Copyright © 2020 Andrey Sukhanov. All rights reserved.
//

import Foundation

func anyIntToString(val: Optional<Any>) -> Optional<String> {
    return (val as? Int)?.description
}
