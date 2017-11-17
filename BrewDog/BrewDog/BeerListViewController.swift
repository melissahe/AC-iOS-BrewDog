//
//  ViewController.swift
//  BrewDog
//
//  Created by Tom Seymour on 11/16/17.
//  Copyright © 2017 AC-iOS. All rights reserved.
//

import UIKit

class BeerListViewController: UIViewController {
    
    @IBOutlet weak var beerTableView: UITableView!
    
    var beerEndpoint = "https://api.punkapi.com/v2/beers?page=1&per_page=80"
    
    var beerList: [Beer] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        beerTableView.delegate = self
        beerTableView.dataSource = self
        getData()
        print(beerList)
    }

    //how to get json without having to copy and paste json as a file
    //basically get the data from the url, turn it into json, copy the json, and then turn it back into data
    func getData() {
//        //get url from endpoint
//        guard let url = URL(string: beerEndpoint) else {
//            return
//        }
//
//        //make a request using the url - should produce a response of the json file
//        let request = URLRequest(url: url)
//
//        //URLSession provides an API for downloading content
//        //.dataTask retrieves contents of a URL based on the URL request object, then calls a handler that you pass in (the closure below)/ and returns a data task
//        //after creating a task, you must call it with the .resume() method (below)
//        let task = URLSession.shared.dataTask(with: request) {
//            (data: Data?, response: URLResponse?, error: Error?) in
//            //this closure runs when the method datatask finishes, so it's what it will do when it finishes
//
//            //the cloasure has three parameters:
//                //error - if request completes successfully (in retrieving data), the data parameter contains the resource data (the retrieved one) and there is no error; nil is passed for error(so error statement won't get triggered)
//                    //if request was unsuccessful, error parameter is not nil
//                //data - returned by the server (from the API)
//                //response - returns metadata, like headers and status code
//
//            //if there is an error
//            if let error = error {
//                print(error)
//                return
//            }
//
//            //if there is no error, turn it into a json object - json serialization
//            if let data = data {
//                do {
//                    guard let beerJSONArray = try JSONSerialization.jsonObject(with: data, options: []) as? [[String : Any]] else {
//                        return
//                    }
//
//                    for beerDict in beerJSONArray {
//                        if let thisBeer = Beer(from: beerDict) {
//                            self.beerList.append(thisBeer)
//                            print(thisBeer)
//                        }
//                    }
//
//                    DispatchQueue.main.async {
//                        //runs this closure in the main thread, so you can see the table updated in the view, not in the background
//                        self.beerTableView.reloadData()
//                    }
//
//                } catch let error {
//                    print(error)
//                }
//            }
//        }
//        task.resume()
        
        //notes above
        
        //shorter way of doing APIs
        let apiManager = APIManager()
        apiManager.getData(endpoint: beerEndpoint) { (data: Data?) in
            guard
                let data = data,
                let beerList = Beer.createArrayOfBeer(from: data) else {
                return
            }
            self.beerList = beerList
            DispatchQueue.main.async {
                self.beerTableView.reloadData()
            }
        }
    }
    
    //MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard
            let destinationVC = segue.destination as? BeerDetailViewController,
            let beerCell = sender as? UITableViewCell,
            let currentIndexPath = beerTableView.indexPath(for: beerCell)
        else {
            return
        }
        
        destinationVC.beer = beerList[currentIndexPath.row]
        
    }
    
}

extension BeerListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return beerList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "beerCell", for: indexPath)
        let currentBeer = beerList[indexPath.row]
        
        cell.textLabel?.text = currentBeer.name
        cell.detailTextLabel?.text = currentBeer.abv.description + "%"
        
        return cell
    }
    
}
