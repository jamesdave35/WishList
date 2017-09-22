//
//  WishCell.swift
//  WishList
//
//  Created by James Meli on 2/28/17.
//  Copyright © 2017 James Meli. All rights reserved.
//

import UIKit

class WishCell: UITableViewCell {

    @IBOutlet weak var wishDetails: UILabel!
    @IBOutlet weak var wishPrice: UILabel!
    @IBOutlet weak var wishTitle: UILabel!
    @IBOutlet weak var wishImage: UIImageView!
    
    
    
    func configureCell(item: Item){
        
        wishTitle.text = item.name
        wishPrice.text = "$\(item.price)"
        wishDetails.text = item.details
        wishImage.layer.cornerRadius = 12
        wishImage.image = item.toImage?.image as? UIImage
        

        
    }
    
}
