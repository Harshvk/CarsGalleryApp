//
//  ListCell.swift
//  ListToGridApp
//
//  Created by appinventiv on 13/02/17.
//  Copyright © 2017 appinventiv. All rights reserved.
//

import UIKit

class ListCell: UICollectionViewCell {
    
    @IBOutlet weak var carPic: UIImageView!
    
    
    @IBOutlet weak var carName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func prepareForReuse() {
     self.backgroundColor = nil
    }
       
    func configureCell(withCar car: CarModel){
        
        carPic.image = UIImage(named: car.image)
        carName.text = car.name
        
        carPic.layer.borderWidth = 1
        carPic.layer.borderColor = UIColor.darkGray.cgColor

        
    }
   

}

class ProductsListFlowLayout: UICollectionViewFlowLayout {
    
    override init() {
        super.init()
        setupLayout()
    }
    
    /**
     Init method
     
     - parameter aDecoder: aDecoder
     
     - returns: self
     */
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupLayout()
    }
    
    /**
     Sets up the layout for the collectionView. 0 distance between each cell, and vertical layout
     */
    func setupLayout() {
        minimumInteritemSpacing = 0
        minimumLineSpacing = 1
        scrollDirection = .vertical
    }
    
    func itemWidth() -> CGFloat {
        return collectionView!.frame.width
    }
    
    override var itemSize: CGSize {
        set {
            self.itemSize = CGSize(width: itemWidth(), height: 89)
        }
        get {
            return CGSize(width: itemWidth(), height: 89)
        }
    }
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint) -> CGPoint {
        return collectionView!.contentOffset
    }
}

