//
//  BrandsServiceTests.swift
//  Stylight Technical Task
//
//  Created by Ahmad Atef on 7/20/17.
//  Copyright © 2017 Ahmad Atef. All rights reserved.
//

import XCTest
@testable import Stylight_Technical_Task

class BrandsServiceTests: XCTestCase {
    
    var viewModel : DataCollectorDelegate!
    var brandService: BrandSerive!
    
    override func setUp() {
        // given
        viewModel = BrandsViewModel()
        brandService = LocalBrandService()
        viewModel.listItems(brandsService: brandService)
    }
    
    func testLocalBrandServiceHasExpectedItemsCount() {
        // then
        XCTAssert(viewModel.numberOfSections() == 2, "Local Brand Service dosn't contain Expected Items Count.")
    }
    
    func testFirstLocalBrandServiceHasExpectedNameValue() {
        // where
        brandService.listBrands { (result) in
            switch result{
            case .Success(let brands):
                // then
                XCTAssert(brands[0].name == "KOKO", "First Local Brand Service dosn't have Expected Name Value")
            case .Failuer(let error):
                // then
                XCTFail(error.localizedDescription)
            }
        }
    }
}
