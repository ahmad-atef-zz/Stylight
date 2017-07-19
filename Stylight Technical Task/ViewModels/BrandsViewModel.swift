//
//  BrandsViewModel.swift
//  Stylight Technical Task
//
//  Created by Ahmad Atef on 7/18/17.
//  Copyright © 2017 Ahmad Atef. All rights reserved.
//
import UIKit
import Foundation


//MARK: - DataCollectorDelegate -
public protocol DataCollectorDelegate {
    var viewDelegate : BrandViewDelegate {get}
    func listItems(brandsService: BrandSerive)
    func numberOfSections() -> Int
    func numberOfRowsForSection(section: Int) -> Int
    func itemAtIndex(indexPath: IndexPath) -> Any
    func titleForHeaderInSection(section : Int) -> String
    func itemDidSelectedAtIndexPath(indexPath : IndexPath, onFinish : () -> Void)
}

//MARK: - BrandViewDelegate -
public protocol BrandViewDelegate {
    func onDidSuccessLoadingData()
    func onDidFailLoadingData()
}



//MARK: - BrandsViewModel -
/// Use this View model to support the Data work and UI work for Brands Controller.
public class BrandsViewModel : DataCollectorDelegate{
    
    /// Injected Properties.
    public var viewDelegate: BrandViewDelegate
    
    init(viewDelegate: BrandViewDelegate) {
        self.viewDelegate = viewDelegate
    }
    
    /// Private Properties.
    private var dataSource : [SectionData] = [SectionData(title : "Selected Brands", brands: []),
                                              SectionData(title : "All Brands", brands: [])]
    
    
    /// Use this Method to List Items using Brands Service Object.
    ///
    /// - Parameter brandsService: this objects is responsbile for listing the Brands.
    public func listItems(brandsService: BrandSerive) {
        brandsService.listBrands { (result) in
            switch result{
            case .Success(let brands):
                self.dataSource[1].brands = brands
                self.viewDelegate.onDidSuccessLoadingData()
            case .Failuer(let error):
                print(error)
                self.viewDelegate.onDidSuccessLoadingData()
            }
        }
    }
    
    
    /// Use this method to calculate number Of Sections for Brands UI Consumer.
    ///
    /// - Returns: Int represnts number Of Sections to be displayed
    public func numberOfSections() -> Int {
        return dataSource.count
    }

    /// Use this method to calculate numberOfRowsForSection for Brands UI Consumer.
    ///
    /// - Returns: Int represnts number Of Row for Section to be displayed
    public func numberOfRowsForSection(section: Int) -> Int {
        return dataSource[section].brands.count
    }
    
    
    /// Use this method to get item at specific Index.
    ///
    /// - Parameter indexPath: for specif index path
    /// - Returns: item at specific location
    public func itemAtIndex(indexPath: IndexPath) -> Any{
        return dataSource[indexPath.section].brands[indexPath.row] as Brand
    }
    
    
    /// Helper method to list Selected Brands
    ///
    /// - Returns: the Selected Brands.
    private func listSelectedBrands() -> [Brand] {
        return dataSource[0].brands
    }
    
    
    /// Use this method to get titles for Headers.
    ///
    /// - Parameter section: the section to get header for it.
    /// - Returns: title for section.
    public func titleForHeaderInSection(section : Int) -> String{
        return dataSource[section].title
    }
    
    
    /// Use this method to handel the Selection / Un Selection Actions.
    ///
    /// - Parameters:
    ///   - indexPath: selected index path
    ///   - onFinish: Completion Block after finishing the selction.
    public func itemDidSelectedAtIndexPath(indexPath: IndexPath, onFinish: () -> Void) {
        let brand = itemAtIndex(indexPath: indexPath) as! Brand
        
        if brand.isSelected{
            brand.isSelected = false
            if let index = dataSource[0].brands.index(where: {$0.id == brand.id}){
                dataSource[0].brands.remove(at: index)
            }
            
        }else{
            brand.isSelected = true
            dataSource[0].brands.append(brand)
        }
        
        onFinish()
    }
}


