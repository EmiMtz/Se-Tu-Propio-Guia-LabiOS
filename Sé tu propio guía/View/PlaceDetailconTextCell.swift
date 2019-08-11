//
//  PlaceDetailconTextCell.swift
//  Sé tu propio guía
//
//  Created by Tania Rossainz on 8/9/19.
//  Copyright © 2019 Emiliano Martínez. All rights reserved.
//

import UIKit

class PlaceDetailconTextCell: UITableViewCell {
    
    @IBOutlet var iconImageView: UIImageView!
    @IBOutlet var shortTextLabel: UILabel! {
        didSet {
            shortTextLabel.numberOfLines = 0
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
