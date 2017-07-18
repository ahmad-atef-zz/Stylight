//
//  Extentions.swift
//  Stylight Technical Task
//
//  Created by Ahmad Atef on 7/18/17.
//  Copyright © 2017 Ahmad Atef. All rights reserved.
//

import UIKit
import Foundation

//MARK: - Protocol-Oriented Programming -
public protocol ResuableView : class{}

public extension ResuableView where Self : UIView{
    static var reuseIdentifier : String{
        return String(describing: self)
    }
}

extension UITableViewCell : ResuableView{}

public extension UITableView{
    func dequeueReusableCell<T : UITableViewCell>(forIndexPath indexPath: IndexPath) -> T where T: ResuableView  {
        guard let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Couldn't dequeueReusableCell with Identifier : \(T.reuseIdentifier)")
        }
        
        return cell
    }
}

