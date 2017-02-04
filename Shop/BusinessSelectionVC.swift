//
//  BusinessSelectionVC.swift
//  Shop
//
//  Created by Donovan Cotter on 2/4/17.
//  Copyright © 2017 DonovanCotter. All rights reserved.
//

import UIKit
import AlamofireImage

class BusinessSelectionVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    fileprivate let BusinessCellIdentifier = "BusinessCell"
    fileprivate var businesses = [Business]()
    
    override func viewDidLoad() {
        businesses = BusinessList.getAllBusinesses()
        super.viewDidLoad()
        RealmManager().setCurrentUserProfileWithRealm()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return businesses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let businessCell = tableView.dequeueReusableCell(withIdentifier: BusinessCellIdentifier, for: indexPath) as! BusinessCell
        let business = businesses[indexPath.row]
        businessCell.nameLabel.text = business.name
        businessCell.logoImageView.image = business.logo.af_imageRoundedIntoCircle()
        
        return businessCell
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

    
    }

}
