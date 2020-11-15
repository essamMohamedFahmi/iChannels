//
//  Created by Essam Mohamed Fahmi.
//

import Foundation

class HomeBuilder: HomeModuleBuilder
{
    static func createHomeModule(around view: HomeVC)
    {
        let presenter = HomePresenter()
        let interactor = HomeInteractor()
        
        view.interactor = interactor
        interactor.presenter = presenter
        presenter.view = view
    }
}
