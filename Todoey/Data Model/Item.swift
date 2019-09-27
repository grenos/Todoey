//
//  Item.swift
//  Todoey
//
//  Created by apple on 27/09/19.
//  Copyright © 2019 VasilisGreen. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var done: Bool = false
    
    /// define inverse relationship between Item and Category
    // LinkingObjects is an auto-updating container type.
    // It represents zero or more objects that are linked to its
    // owning model object through a property relationship.
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
