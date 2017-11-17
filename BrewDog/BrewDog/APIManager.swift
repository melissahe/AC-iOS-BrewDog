//
//  APIManager.swift
//  BrewDog
//
//  Created by C4Q on 11/17/17.
//  Copyright © 2017 AC-iOS. All rights reserved.
//

import Foundation


//completion handler needs to be @escaping because you're dealing with data, which be used to do stuff asynchronously (not in time with the function, so the closure might complete its processes AFTER the function returns; which is why "self." is needed in all closures passed in); by default, closures are @nonescaping, meaning your closure will complete before the function returns
    //basically @escaping if closure completes after function returns
        //OR if closure will be stored in a variable that was defined outside of the function
    //@nonescaping if closure completes before function returns
class APIManager {
    func getData(endpoint: String, completionHandler: @escaping (Data?) -> () )
    {
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
