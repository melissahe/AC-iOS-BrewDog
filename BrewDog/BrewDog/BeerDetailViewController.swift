//
//  BeerDetailViewController.swift
//  BrewDog
//
//  Created by C4Q on 11/17/17.
//  Copyright © 2017 AC-iOS. All rights reserved.
//

import UIKit

class BeerDetailViewController: UIViewController {

    @IBOutlet weak var beerNameNavigationItem: UINavigationItem!
    @IBOutlet weak var beerImageView: UIImageView!
    @IBOutlet weak var beerTaglineLabel: UILabel!
    @IBOutlet weak var beerTextView: UITextView!
    
    var beer: Beer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        beerNameNavigationItem.title = beer.name
        beerTaglineLabel.text = beer.tagline
        beerTextView.text = beer.beerDescription
        getImage()
//        DispatchQueue.main.async {
//            guard
//                let url = URL(string: self.beer.imageUrlString),
//                let data = try? Data(contentsOf: url) else {
//                return
//            }
//            self.beerImageView.image = UIImage(data: data)
//        }
    }
    
    func getImage() {
        let apiManager = APIManager()
        
        apiManager.getData(endpoint: beer.imageUrlString) {
            (data: Data?) in
            if let data = data {
                DispatchQueue.main.async {
                    self.beerImageView.image = UIImage(data: data)
                }
            }
        }

    }

}
