//
//  SectionData.swift
//  Stylight Technical Task
//
//  Created by Ahmad Atef on 7/19/17.
//  Copyright © 2017 Ahmad Atef. All rights reserved.
//

import Foundation



/// Use this class to init Objectes for Sections in Brands TableView.
public class SectionData {
    var title: String = ""
    var brands : [Brand] = []
    init(title: String, brands: [Brand]) {
        self.title = title
        self.brands = brands
    }
    var numberOfItems: Int {
        return brands.count
    }
}
