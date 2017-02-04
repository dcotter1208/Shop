//
//  BusinessSelectionVC.swift
//  Shop
//
//  Created by Donovan Cotter on 2/4/17.
//  Copyright © 2017 DonovanCotter. All rights reserved.
//

import UIKit

class BusinessSelectionVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    fileprivate let BusinessCellIdentifier = "BusinessCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        RealmManager().setCurrentUserProfileWithRealm()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let businessCell = tableView.dequeueReusableCell(withIdentifier: BusinessCellIdentifier, for: indexPath) as! BusinessCell
        businessCell.nameLabel.text = ""
        return businessCell
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

    
    }

}
