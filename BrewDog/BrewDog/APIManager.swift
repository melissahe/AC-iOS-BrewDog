//
//  APIManager.swift
//  BrewDog
//
//  Created by C4Q on 11/17/17.
//  Copyright © 2017 AC-iOS. All rights reserved.
//

import Foundation

class APIManager {
    func getData(endpoint: String, completionHandler: @escaping (Data?) -> () ) {
        
            guard let url = URL(string: endpoint) else {
                return
            }
            
            let request = URLRequest(url: url)
            let task = URLSession.shared.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
                
                if let error = error {
                    print(error)
                    completionHandler(nil)
                    return
                }
        
                if let data = data {
                    completionHandler(data)
                    //so you would write what happens here whenever you call this function
                }
        }
        task.resume()
    }
}
