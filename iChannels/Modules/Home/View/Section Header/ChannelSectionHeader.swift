//
//  ChannelSectionHeader.swift
//  ElKady
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
    
    // MARK: Methods
    
    func configure(with model: ChannelViewModel)
    {
        imageViewIcon.uploadImage(from: model.imageIconURL)
        labelTitle.text = model.title
        labelSubTitle.text = model.mediaCount
    }
}
