//
//  CustomTableViewCell.swift
//  TestApp
//
//  Created by MOUNICA CHOWDARY  YELISETTI on 2018-08-23.
//  Copyright © 2018 MOUNICA CHOWDARY  YELISETTI. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var myImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
