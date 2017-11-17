//
//  BeerDetailViewController.swift
//  BrewDog
//
//  Created by Tom Seymour on 11/17/17.
//  Copyright © 2017 AC-iOS. All rights reserved.
//

import UIKit

class BeerDetailViewController: UIViewController {
    
    @IBOutlet weak var beerImageView: UIImageView!
    
    @IBOutlet weak var taglineLabel: UILabel!
    
    @IBOutlet weak var abvLabel: UILabel!
    
    @IBOutlet weak var descriptionTextView: UITextView!
    
    var thisBeer: Beer!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    func setupUI() {
        navigationItem.title = thisBeer.name
        taglineLabel.text = thisBeer.tagline
        descriptionTextView.text = thisBeer.beerDescription
        getImageData()
    }
    
    func getImageData() {
        guard let url = URL(string: thisBeer.imageUrlString) else { return }
        
        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            
            if let error = error {
                print(error)
                return
            }
            
            if let data = data {
                if let image = UIImage(data: data) {
                    
                    DispatchQueue.main.async {
                        self.beerImageView.image = image
                    }
                }
            }
        }
        task.resume()
    }
    
}



