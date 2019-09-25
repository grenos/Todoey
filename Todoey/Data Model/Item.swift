//
//  Item.swift
//  Todoey
//
//  Created by apple on 25/09/19.
//  Copyright © 2019 VasilisGreen. All rights reserved.
//

import Foundation

// declare that the Item class is conforming
// to the protocols of Encoder and Decoder
// i.e. the Item type can encode itself so it can be written in the plist file
// for a class to be encodable or decodable all of its properties (var, let)
// must have primitive values
class Item: Codable {
    
    var title : String = ""
    var done : Bool = false
    
}
