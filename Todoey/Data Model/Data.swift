//
//  Data.swift
//  Todoey
//
//  Created by apple on 27/09/19.
//  Copyright © 2019 VasilisGreen. All rights reserved.
//

import Foundation
import RealmSwift


// class data is subclassing class object
class Data: Object {
    // dynamic is a declaration modifier
    // it basically means that allows the var name to be monitored
    // for changes live while they are happening
    // @obj when we use something from objective-c
    @objc dynamic var name: String = ""
    @objc dynamic var age: Int = 0
}
