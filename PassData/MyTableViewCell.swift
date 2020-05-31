//
//  MyTableViewCell.swift
//  PassData
//
//  Created by mark me on 5/26/20.
//  Copyright © 2020 mark me. All rights reserved.
//

import UIKit

class MyTableViewCell: UITableViewCell {
    @IBOutlet var profileImage: UIImageView!
    @IBOutlet var profileName1: UILabel!
    @IBOutlet var profileName2: UILabel!
    @IBOutlet var profileName3: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        profileImage.layer.cornerRadius = profileImage.bounds.width/2
        
    }

    

}
