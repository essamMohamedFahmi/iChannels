//
//  EpisodeCollectionViewCell.swift
//
//  Created by Essam Mohamed Fahmi.
//

import UIKit

class NewEpisodeCollectionViewCell: UICollectionViewCell, Configurable
{
    // MARK: Outlets
    
    @IBOutlet weak var imageViewCover: UIImageView!
    @IBOutlet weak var labelChannelName: UILabel!
    @IBOutlet weak var labelEpisodeName: UILabel!
    
    // MARK: Init
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
    }
    
    // MARK: Methods
    
    func configure(with model: NewEpisodeViewModel)
    {
        imageViewCover.uploadImage(from: model.imageCoverURL)
        labelChannelName.text = model.channel
        labelEpisodeName.text = model.title
    }
}

