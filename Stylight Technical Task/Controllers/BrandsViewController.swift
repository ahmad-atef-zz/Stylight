//
//  ViewController.swift
//  Stylight Technical Task
//
//  Created by Ahmad Atef on 7/17/17.
//  Copyright © 2017 Ahmad Atef. All rights reserved.
//

import UIKit

class BrandsViewController: UIViewController {

    //MARK: - Properties -
    fileprivate var viewModel : DataCollectorDelegate = BrandsViewModel()
    
    //MARK: - Outlets -
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - View Life Cycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

//MARK : - UITableViewDelegate -
extension BrandsViewController : UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsForSection(section: section)
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let brand = viewModel.itemAtIndex(indexPath: indexPath) as! Brand
        let cell = tableView.dequeueReusableCell(withIdentifier: BrandCell.reuseIdentifier) as! BrandCell
        cell.brandName.text = brand.name
        return cell
    }
    
    func feedCellWithData() {
    }
}



