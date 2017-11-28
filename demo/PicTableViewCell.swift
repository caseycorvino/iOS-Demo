//
//  PicTableViewCell.swift
//  demo
//
//  Created by Casey Corvino on 11/16/17.
//  Copyright © 2017 corvino. All rights reserved.
//

import UIKit

class PicTableViewCell: UITableViewCell {

    @IBOutlet var postImageView: UIImageView!
    
    @IBOutlet var ownerLabel: UILabel!
    
    @IBOutlet var captionTextView: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
