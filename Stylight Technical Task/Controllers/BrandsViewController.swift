//
//  ViewController.swift
//  Stylight Technical Task
//
//  Created by Ahmad Atef on 7/17/17.
//  Copyright © 2017 Ahmad Atef. All rights reserved.
//

import UIKit
import BEMCheckBox

class BrandsViewController: UIViewController {

    //MARK: - Properties -
    fileprivate var viewModel : DataCollectorDelegate!
    
    //MARK: - Outlets -
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - View Life Cycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = BrandsViewModel(viewDelegate: self)
        let brandService = BrandSrviceFactory.getServiceType(serviceType: .Remote)
        viewModel.listItems(brandsService: brandService)
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
        cell.checkBox.on = brand.isSelected
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.titleForHeaderInSection(section: section)
    }
}

//MARK: - BrandCheckBoxDelegate -
extension BrandsViewController : BrandCheckBoxDelegate{
    func onBrandDidChecked(cell : BrandCell){
        
        if let indexPath = tableView.indexPath(for: cell){
            
            viewModel.itemDidSelectedAtIndexPath(indexPath: indexPath, onFinish: { 
                UIView.animate(withDuration: 1.0, delay: 0, options: .curveLinear, animations: { 
                    
                }, completion: { (_) in
                    self.tableView.reloadData()
                })
            })
        }
        
    }
}


//MARK: - BrandViewDelegate -
extension BrandsViewController : BrandViewDelegate{
    func onDidSuccessLoadingData() {
        
        DispatchQueue.main.async(){
            self.tableView.reloadData()
        }
    }
    
    func onDidFailLoadingData() {
        
    }
}



