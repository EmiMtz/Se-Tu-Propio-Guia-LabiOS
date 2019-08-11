//
//  PlaceDetailHeaderView.swift
//  Sé tu propio guía
//
//  Created by Tania Rossainz on 8/9/19.
//  Copyright © 2019 Emiliano Martínez. All rights reserved.
//

import UIKit

class PlaceDetailHeaderView: UIView {
    
    @IBOutlet var headerImageView: UIImageView!
    
    @IBOutlet var nameLabel: UILabel! {
        didSet {
            nameLabel.numberOfLines = 0
        }
    }
    
    @IBOutlet var typeLabel: UILabel! {
        didSet {
            typeLabel.layer.cornerRadius = 5.0
            typeLabel.layer.masksToBounds = true
        }
    }
    
}
