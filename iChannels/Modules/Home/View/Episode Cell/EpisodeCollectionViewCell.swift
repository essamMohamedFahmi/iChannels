//
//  EpisodeCollectionViewCell.swift
//  ElKady
//
//  Created by Essam Mohamed Fahmi on 11/14/20.
//  Copyright © 2020 Hmaserv. All rights reserved.
//

import UIKit

class EpisodeCollectionViewCell: UICollectionViewCell, Configurable
{
    // MARK: Outlets
    
    @IBOutlet weak var imageViewCover: UIImageView!
    @IBOutlet weak var labelEpisodeName: UILabel!
    
    @IBOutlet weak var constraintImageHeight: NSLayoutConstraint!

    // MARK: Init
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
    }
    
    // MARK: Methods
    
    func configure(with model: ChannelViewModel)
    {
        imageViewCover.uploadImage(from: model.imageCoverURL)
        labelEpisodeName.text = model.title
        setImageHeight(to: model.constraintImageHeight)
    }
    
    private func setImageHeight(to value: Int)
    {
        constraintImageHeight.constant = CGFloat(value)
        layoutIfNeeded()
    }
}
