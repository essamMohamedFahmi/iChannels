//
//  Wajeez
//
//  Created by Essam Mohamed Fahmi.
//  Copyright © 2020 Faylasof. All rights reserved.
//

import UIKit

// MARK:- HomeViewDelegate

extension HomeVC: HomeViewDelegate
{    
    func display(message: String)
    {
        Notifiy.shared.toast(toastMessage: message)
    }
    
    func displayNewEpisodes(from dataSource: CollectionViewDataSource<NewEpisodeViewModel, NewEpisodeCollectionViewCell>)
    {
        newEpisodesCollectionView.dataSource = dataSource
        refreshNewEpisodesCollectionView()
    }
    
    func displayEpisodes(from dataSource: MultiSectionCollectionViewDataSource<ChannelViewModel, ChannelSectionHeaderViewModel, EpisodeCollectionViewCell, ChannelSectionHeader>)
    {
        episodesCollectionView.dataSource = dataSource
        refreshEpisodesCollectionView()
    }
    
    func displayCategories(from dataSource: CollectionViewDataSource<CategoryViewModel, CategoryCollectionViewCell>)
    {
        categoriesCollectionView.dataSource = dataSource
        refreshCategoriesCollectionView()
    }
}

// MARK:- UICollectionViewDelegate

extension HomeVC: UICollectionViewDelegate
{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}

// MARK:- UICollectionViewDelegateFlowLayout

extension HomeVC: UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        if collectionView == newEpisodesCollectionView
        {
            return interactor?.getSizeOfNewEpisode(at: indexPath) ?? CGSize(width: 0.0, height: 0.0)
        }
        
        if collectionView == episodesCollectionView
        {
            return interactor?.getSizeOfChannelItem(at: indexPath) ?? CGSize(width: 0.0, height: 0.0)
        }
        
        if collectionView == categoriesCollectionView
        {
            let width = (categoriesCollectionView.frame.width - (collectionViewLayoutProperties.hSpaceBetweenTwoCells + collectionViewLayoutProperties.sectionLeftSpace + collectionViewLayoutProperties.sectionRightSpace))
                / 2.0

            return CGSize(width: width, height: 70.0)
        }
        
        return CGSize(width: 0.0, height: 0.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat
    {
        return collectionViewLayoutProperties.vSpaceBetweenTwoCells
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat
    {
        return collectionViewLayoutProperties.hSpaceBetweenTwoCells
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets
    {
        return UIEdgeInsets(top: collectionViewLayoutProperties.sectionTopSpace, left: collectionViewLayoutProperties.sectionLeftSpace,
                            bottom: collectionViewLayoutProperties.sectionBottomSpace, right: collectionViewLayoutProperties.sectionRightSpace)
    }
}

