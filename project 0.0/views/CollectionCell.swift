//
//  CollectionCell.swift
//  project 0.0
//
//  Created by BA-link on 16/12/2021.
//  Copyright © 2021 BA-link. All rights reserved.
//

import UIKit

class CollectionCell: UICollectionViewCell {
    
    
    @IBOutlet weak var imageCell: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var wishButton: UIButton!
    
    @IBAction func wishButton(_ sender: UIButton) {
        wishButton.imageView?.image = #imageLiteral(resourceName: "markedeHeart")
    }
    
    func configure(_ type: String, _ index: Int){

        var products = Products.getAllTProductsByType(type)
        
        titleLabel.text = products[index].title
        wishButton.imageView?.image = #imageLiteral(resourceName: "heart")
        priceLabel.text = String(products[index].price)
        
        let url = URL(string: products[index].imageUrl)!
        if let data = try? Data(contentsOf: url){
            imageCell.image = UIImage(data: data)
        }
        
        
    }
    
}

