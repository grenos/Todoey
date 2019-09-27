//
//  Category.swift
//  Todoey
//
//  Created by apple on 27/09/19.
//  Copyright © 2019 VasilisGreen. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name: String = ""
    // List is the container type in Realm used to define to-many relationships.
    // basically an array that gets initialized
    /// set the forward relationship between Item and Category
    let items = List<Item>()
}
