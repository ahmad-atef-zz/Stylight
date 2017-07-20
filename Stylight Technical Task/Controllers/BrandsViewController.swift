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
    private var brandService : BrandSerive!
    fileprivate var refreshControl: UIRefreshControl!
    
    
    //MARK: - Outlets -
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - View Life Cycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = BrandsViewModel(viewDelegate: self)
        brandService = BrandSrviceFactory.getServiceType(serviceType: .Remote)
        addRefreshControll()
        loadBrands()
    }
    
    func loadBrands() {
        refreshControl.beginRefreshing()
        viewModel.listItems(brandsService: brandService)
    }
    
    //MARK: - Helper Methods -
    
    private func addRefreshControll(){
        refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector (loadBrands), for: UIControlEvents.valueChanged)
        tableView.addSubview(refreshControl)
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
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerText = UILabel()
        headerText.adjustsFontSizeToFitWidth = true
        headerText.font = UIFont.boldSystemFont(ofSize: 16.0)
        headerText.textAlignment = .center
        headerText.text = viewModel.titleForHeaderInSection(section: section)
        headerText.backgroundColor = .lightGray
        return headerText
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat(50)
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
            self.refreshControl.endRefreshing()
            self.tableView.reloadData()
        }
    }
    
    func onDidFailLoadingData() {
        refreshControl.endRefreshing()
        UIDecorator.shared.showMessage(title: "Error", body: "Fail Loading Brands", alertType: .error)
    }
}



