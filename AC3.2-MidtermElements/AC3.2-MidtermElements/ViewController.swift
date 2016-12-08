//
//  ViewController.swift
//  AC3.2-MidtermElements
//
//  Created by Simone on 12/8/16.
//  Copyright © 2016 Simone. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var elementDetails: Elements?
    @IBOutlet weak var elementNameLabel: UILabel!
    @IBOutlet weak var elementDetailsText: UITextView!
    @IBOutlet weak var fullImage: UIImageView!
    @IBOutlet weak var addToFavorites: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadLabels()
    }
    
    func loadLabels() {
        if let name = elementDetails?.name, let weight = elementDetails?.weight {
            elementNameLabel.text = "\(name)\n\(weight)"
        }
        if let id = elementDetails?.id, let weight = elementDetails?.weight, let number = elementDetails?.weight, let melting = elementDetails?.meltingC, let boiling = elementDetails?.boilingC, let density = elementDetails?.density, let discovery = elementDetails?.discoveryYear {
            elementDetailsText.text = "ID: \(id)\nWeight: \(weight)\nNumber: \(number)\nMelting Point: \(melting)\nBoiling Point: \(boiling)\nDensity: \(density)\n\nDiscovery: \(discovery)"
        }
        if let symbol = elementDetails?.symbol {
            let fullPicture = "https://s3.amazonaws.com/ac3.2-elements/\(symbol).png"
            //Image
            APIRequestManager.manager.getData(endPoint: fullPicture) { (data) in
                if let validData = data,
                    let validImage = UIImage(data: validData) {
                    DispatchQueue.main.async {
                        self.fullImage.image = validImage
                        self.fullImage.setNeedsLayout()
                    }
                }
            }
        }
    }
    
    @IBAction func postAction(_ sender: UIButton) {
        //attempted post but couldn't actually get it to work without crashing
        print("faux post")
    }
}

