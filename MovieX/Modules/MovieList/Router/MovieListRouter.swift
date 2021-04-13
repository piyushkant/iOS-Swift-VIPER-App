//
//  MovieListRouter.swift
//  MovieX
//
//  Created by Piyush Kant on 2021/04/12.
//

import Foundation
import UIKit

class MovieListRouter: PresenterToRouterProtocol {
    
    static func createModule() -> MovieListViewController {        
        let view = mainStoryboard.instantiateViewController(withIdentifier: "MovieListViewController") as! MovieListViewController
        
        let presenter: ViewToPresenterProtocol & InteractorToPresenterProtocol = MovieListPresenter()
        let interactor: PresenterToInteractorProtocol = MovieListInteractor()
        let router: PresenterToRouterProtocol = MovieListRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        return view
    }
    
    static var mainStoryboard: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }
    
    func pushToMovieDetailsScreen(navigationConroller: UINavigationController) {
//        let movieDetailsModule = MovieDetailsRouter.createMovieDetailsModule()
//        navigationController.pushViewController(movieDetailsModule, animated: true)
    }
    
}
