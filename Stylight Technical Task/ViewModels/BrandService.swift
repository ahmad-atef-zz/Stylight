//
//  BrandService.swift
//  Stylight Technical Task
//
//  Created by Ahmad Atef on 7/19/17.
//  Copyright © 2017 Ahmad Atef. All rights reserved.
//

import Foundation


public protocol BrandSerive {
    func listBrands(completionHandeler: @escaping (Result<[Brand]>) -> Void)
}

public struct RemoteBrandService : BrandSerive{
    public func listBrands(completionHandeler: @escaping (Result<[Brand]>) -> Void)  {
        print("RemoteBrandService 🚀🚀")
        
        var request = URLRequest(url: URL(string: "https://api.stylight.com/rest/brands?apiKey=C6490912AB3211E680F576304DEC7EB7")!)
        request.httpMethod = "GET"
        let session = URLSession.shared
        session.dataTask(with: request) {data, response, error in
            guard let data = data, error == nil else { completionHandeler(.Failuer(error!)); return }
            do {
                var result : [Brand] = []
                let jsonDictionary = try(JSONSerialization.jsonObject(with: data, options: .mutableContainers)) as![String:AnyObject]
                if let brands = jsonDictionary["brands"] as? [[String : AnyObject]]{
                    for brand in brands{
                        if let id = brand["id"] as? Int, let name = brand["name"] as? String,let logo = brand["logo"] as? String{
                            let brandObject = Brand(id: id, name: name, logo: logo)
                            result.append(brandObject)
                        }
                    }
                    completionHandeler(.Success(result))
                }
            } catch let error as NSError {
                completionHandeler(.Failuer(error))
            }
            
            }.resume()
    }
    
    
}

public struct LocalBrandService : BrandSerive {
    public func listBrands(completionHandeler: @escaping (Result<[Brand]>) -> Void) {
        let brands : [Brand] = [Brand(id: 1, name: "KOKO", logo: "KOKO"),Brand(id: 2, name: "WAWA", logo: "")]
        completionHandeler(.Success(brands))
    }
}

enum BrandServiceType {
    case Local , Remote
}

struct BrandSrviceFactory {
    
    static func getServiceType(serviceType : BrandServiceType) -> BrandSerive {
        switch serviceType {
        case .Local:
            return LocalBrandService()
        case .Remote:
            return RemoteBrandService()
        }
    }
}
