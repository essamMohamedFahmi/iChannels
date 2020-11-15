//
//  CategoryCollectionViewCell.swift
//  ElKady
//
//  Created by Essam Mohamed Fahmi on 11/14/20.
//  Copyright © 2020 Hmaserv. All rights reserved.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell, Configurable
{
    // MARK: Outlets
    
    @IBOutlet weak var labelCategoryName: UILabel!
    
    // MARK: Init
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
    }
    
    // MARK: Methods
    
    func configure(with model: CategoryViewModel)
    {
        labelCategoryName.text = model.name
    }
}
