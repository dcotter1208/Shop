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
        self.productImageButton.imageView?.contentMode = .scaleAspectFill
    }

    func setProductDetails(withProduct product: Product) {
        let safeURL = product.displayImage.replacingOccurrences(of: "http://img.bbystatic.com/", with: "https://img-ssl.bbystatic.com/")
        if let url = URL(string: safeURL) {
            productImageButton.af_setBackgroundImage(for: .normal, url: url, placeholderImage: #imageLiteral(resourceName: "best_buy_logo"), filter: nil, progress: nil, progressQueue: DispatchQueue.main, completion: { (data) in
            })
        }
        populateProductDetails(product: product)
    }
    
    fileprivate func populateProductDetails(product: Product) {
        productDetails.append(product.name)
        productDetails.append("$\(product.salePrice)")
        productDetails.append("Rating: \(product.rating)")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.productImageButton.setBackgroundImage(nil, for: .normal)
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
