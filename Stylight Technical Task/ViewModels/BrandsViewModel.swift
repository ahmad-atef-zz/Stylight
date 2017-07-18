//
//  BrandsViewModel.swift
//  Stylight Technical Task
//
//  Created by Ahmad Atef on 7/18/17.
//  Copyright © 2017 Ahmad Atef. All rights reserved.
//
import UIKit
import Foundation

public protocol DataCollectorDelegate {
    func numberOfSections() -> Int
    func numberOfRowsForSection(section: Int) -> Int
    func itemAtIndex(indexPath: IndexPath) -> Any
}


public struct BrandsViewModel : DataCollectorDelegate{
    private var dataSource : [[Brand]] = [[Brand(id: 1, name: "1IKEA", logo: ""),Brand(id: 1, name: "12IKEA", logo: "")],
                                          [Brand(id: 1, name: "2IKEA", logo: "")]]
    
    public func numberOfSections() -> Int {
        return dataSource.count
    }
    
    public func numberOfRowsForSection(section: Int) -> Int {
        return dataSource[section].count
    }
    
    public func itemAtIndex(indexPath: IndexPath) -> Any{
        return dataSource[indexPath.section][indexPath.row] as Brand
    }
}


