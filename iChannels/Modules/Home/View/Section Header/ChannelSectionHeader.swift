//
//  ChannelSectionHeader.swift
//
//  Created by Essam Mohamed Fahmi on 11/14/20.
//  Copyright © 2020 Hmaserv. All rights reserved.
//

import UIKit

class ChannelSectionHeader: UICollectionReusableView, Configurable
{
    // MARK:- Outlets
    
    @IBOutlet weak var imageViewIcon: UIImageView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelSubTitle: UILabel!
    
    // MARK:- Class Methods
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        
        labelTitle.adjustsFontSizeToFitWidth = true
        labelTitle.minimumScaleFactor = 0.5
    }
    
    // MARK:- Methods
    
    func configure(with model: ChannelSectionHeaderViewModel)
    {
        imageViewIcon.uploadImage(from: model.imageIconURL)
        labelTitle.text = model.title
        labelSubTitle.text = model.subTitle
    }
}
