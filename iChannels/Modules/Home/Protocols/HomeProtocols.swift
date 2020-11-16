//
//  HomeProtocols.swift
//
//  Created by Essam Mohamed Fahmi.
//

import UIKit

// MARK: VIP Protocols

// MARK: View

protocol HomeViewDelegate: class
{
    var interactor: HomeInteractorDelegate? { get set }

    func display(message: String)
    
    func displayNewEpisodes(from dataSource: CollectionViewDataSource<NewEpisodeViewModel, NewEpisodeCollectionViewCell>)
    
    func displayEpisodes(from dataSource: MultiSectionCollectionViewDataSource<ChannelViewModel, ChannelSectionHeaderViewModel, EpisodeCollectionViewCell, ChannelSectionHeader>)
    
    func displayCategories(from dataSource: CollectionViewDataSource<CategoryViewModel, CategoryCollectionViewCell>)
}

// MARK: Interactor

protocol HomeInteractorDelegate: class
{
    var presenter: HomePresenterDelegate? { get set }
    
    func getNewEpisodes()
    func getChannels()
    func getCategories()
    
    func getSizeOfNewEpisode(at index: IndexPath) -> CGSize
    func getSizeOfChannelItem(at index: IndexPath) -> CGSize
}

// MARK: Presenter

protocol HomePresenterDelegate: class
{
    var view: HomeViewDelegate? { get set }

    func error(_ error: Error)
    
    func didReceiveNewEpisodes(_ newEpisodes: [Media])
    func didReceiveChannels(_ channels: [Channel])
    func didReceiveCategories(_ categories: [Category])
}

// MARK: Builder

protocol HomeModuleBuilder: class
{
    static func createHomeModule(around view: HomeVC)
}
