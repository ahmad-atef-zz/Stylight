//
//  BrandCell.swift
//  Stylight Technical Task
//
//  Created by Ahmad Atef on 7/18/17.
//  Copyright © 2017 Ahmad Atef. All rights reserved.
//

import UIKit
import BEMCheckBox

protocol BrandCheckBoxDelegate {
    func onBrandDidChecked(cell : BrandCell)
}

class BrandCell: UITableViewCell {
    var delegate : BrandCheckBoxDelegate?
    
    @IBOutlet weak var brandName: UILabel!
    @IBOutlet weak var checkBox: BEMCheckBox!
    @IBAction func chechBoxDidTapped(_ sender: Any) {
        delegate?.onBrandDidChecked(cell: self)
    }
}
