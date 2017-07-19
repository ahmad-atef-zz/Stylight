//
//  Extentions.swift
//  Stylight Technical Task
//
//  Created by Ahmad Atef on 7/18/17.
//  Copyright © 2017 Ahmad Atef. All rights reserved.
//

import UIKit
import Foundation


public enum Result <T> {
    case Success(T)
    case Failuer (Error)
    
    func map<P>(f: (T)-> P) -> Result<P> {
        switch self {
        case .Success(let value):
            return .Success(f(value))
        case .Failuer(let error):
            return .Failuer(error)
        }
    }
}


//MARK: - Protocol-Oriented Programming -

/// Adding Shared Properties to UITableViewCell Using POP.
public protocol ResuableView : class{}


/// Adding reuseIdentifier Property to Every UITableViewCell instance.
public extension ResuableView where Self : UIView{
    static var reuseIdentifier : String{
        return String(describing: self)
    }
}
extension UITableViewCell : ResuableView{}


/// Custome dequeueReusableCell method to every UITableView Instance.
public extension UITableView{
    func dequeueReusableCell<T : UITableViewCell>(forIndexPath indexPath: IndexPath) -> T where T: ResuableView  {
        guard let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Couldn't dequeueReusableCell with Identifier : \(T.reuseIdentifier)")
        }
        
        return cell
    }
}



