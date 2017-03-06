//
//  BotProductsResponseCell.swift
//  Shop
//
//  Created by Donovan Cotter on 3/4/17.
//  Copyright © 2017 DonovanCotter. All rights reserved.
//

import UIKit

fileprivate let kProductCollectionCellIdentifier = "ProductCollectionCell"

class BotProductsResponseCell: UITableViewCell {
    @IBOutlet weak var productCollectionView: UICollectionView!
    @IBOutlet weak var logoImageView: UIImageView!

    var products = [Product]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
                
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func setCellAttributes(withMessage message: BotProductsMessage, business: Business) {
        self.logoImageView.image = business.logo
        products = message.products
        self.productCollectionView.reloadData()
    }
    
}

extension BotProductsResponseCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let product = products[indexPath.item]

        let productCell = collectionView.dequeueReusableCell(withReuseIdentifier: kProductCollectionCellIdentifier, for: indexPath) as! ProductCollectionViewCell

        configureStyle(for: productCell)
        
        productCell.setProductDetails(withProduct: product)
        
        return productCell
    }
    
    fileprivate func configureStyle(for cell: ProductCollectionViewCell) {
        cell.layer.borderWidth = 2.0
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.cornerRadius = 5.0
        cell.layer.masksToBounds = true
        cell.productImageView.clipsToBounds = true
    }
    
}
