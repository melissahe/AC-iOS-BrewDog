//
//  BeersTableViewController.swift
//  BrewDog
//
//  Created by Tom Seymour on 11/16/17.
//  Copyright © 2017 AC-iOS. All rights reserved.
//

import UIKit

class BeersTableViewController: UIViewController {
    
    let beerEndpoint = "https://api.punkapi.com/v2/beers?page=1&per_page=80"
    
    var beers: [Beer] = []

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        getData()
    }

    func getData() {
        guard let url = URL(string: beerEndpoint) else { return }
        let request = URLRequest(url: url)

        let task = URLSession.shared.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in

            if let error = error {
                print(error)
                return
            }
            if let data = data {
                do {
                    guard let jsonArray = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]] else { return }

                    for beerDict in jsonArray {
                        if let beer = Beer(from: beerDict) {
                            self.beers.append(beer)
                        }
                    }
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
                catch let error {
                    print(error)
                }
            }
        }
        task.resume()
    }
    
//    func getData() {
//        let manager = APIManager()
//        manager.getData(endpoint: beerEndpoint) { (data: Data?) in
//            if let data = data {
//
//            }
//        }
//    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let beerCell = sender as? UITableViewCell,
            let thisIndexPath = tableView.indexPath(for: beerCell),
            let beerDVC = segue.destination as? BeerDetailViewController {
            
            let thisBeer = beers[thisIndexPath.row]
            beerDVC.thisBeer = thisBeer
        }
    }
}

extension BeersTableViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return beers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "beerCell", for: indexPath)
        let beer = beers[indexPath.row]
        cell.textLabel?.text = beer.name
        cell.detailTextLabel?.text = "abv: \(beer.abv)%"
        return cell
    }
}
