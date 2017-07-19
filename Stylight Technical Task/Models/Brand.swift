//
//  Brand.swift
//  Stylight Technical Task
//
//  Created by Ahmad Atef on 7/18/17.
//  Copyright © 2017 Ahmad Atef. All rights reserved.
//

import Foundation

public class Brand {
    var id : Int
    var name : String
    var logo : String
    var isSelected : Bool
    
    init(id : Int,name : String,logo : String,isSelected : Bool = false) {
        self.id = id
        self.name = name
        self.logo = logo
        self.isSelected = isSelected
    }
}
