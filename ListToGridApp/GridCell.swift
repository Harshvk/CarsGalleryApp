//
//  GridCell.swift
//  ListToGridApp
//
//  Created by appinventiv on 13/02/17.
//  Copyright © 2017 appinventiv. All rights reserved.
//

import UIKit

class GridCell: UICollectionViewCell {

    
    @IBOutlet weak var carPic: UIImageView!
    
    @IBOutlet weak var carName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
      
    
    func configureCell(withCar car: CarModel){
        
        carPic.image = UIImage(named: car.image)
        carName.text = car.name
        
        carPic.layer.borderWidth = 1
        carPic.layer.borderColor = UIColor.darkGray.cgColor
    }

}
