//
//  ProductCollectionViewCell.swift
//  Shop
//
//  Created by Donovan Cotter on 3/4/17.
//  Copyright © 2017 DonovanCotter. All rights reserved.
//

import UIKit

fileprivate let kProductDetailCellIdentifier = "ProductDetailTableCell"

class ProductCollectionViewCell: UICollectionViewCell, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var productDetailsTableView: UITableView!
    @IBOutlet weak var productImageButton: UIButton!

    fileprivate var productDetails = [String]()

    override func awakeFromNib() {
    }
    
    func setProductDetails(withProduct product: Product) {
        if let url = URL(string: product.displayImage) {
            productImageButton.imageView?.af_setImage(withURL: url, placeholderImage: nil, filter: nil, progress: nil, progressQueue: DispatchQueue.main, imageTransition: .noTransition, runImageTransitionIfCached: true) { (data) in
            }
        }
    }
    
    fileprivate func populateProductDetails(product: Product) {
        productDetails.append(product.name)
        productDetails.append(product.salePrice)
        productDetails.append(product.rating)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productDetails.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kProductDetailCellIdentifier, for: indexPath)
        cell.textLabel?.text = productDetails[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.productDetailsTableView.frame.size.height / CGFloat(productDetails.count)
    }
    
}
