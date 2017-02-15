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


class ProductsGridFlowLayout: UICollectionViewFlowLayout {

    
    override init() {
        super.init()
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupLayout()
    }
    
    /**
     Sets up the layout for the collectionView. 1pt distance between each cell and 1pt distance between each row plus use a vertical layout
     */
    func setupLayout() {
        minimumInteritemSpacing = 1
        minimumLineSpacing = 1
        scrollDirection = .vertical
    }
    
    /// here we define the width of each cell, creating a 2 column layout. In case you would create 3 columns, change the number 2 to 3
    func itemWidth() -> CGFloat {
        return (collectionView!.frame.width/2)-1
    }
    
    override var itemSize: CGSize {
        set {
            self.itemSize = CGSize(width: itemWidth(), height: 120)
        }
        get {
            return CGSize(width: itemWidth(), height: 120)
        }
    }
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint) -> CGPoint {
        return collectionView!.contentOffset
    }
}
