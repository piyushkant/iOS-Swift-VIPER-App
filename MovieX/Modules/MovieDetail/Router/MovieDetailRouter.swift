//
//  MovieDetailRouter.swift
//  MovieX
//
//  Created by Piyush Kant on 2021/04/13.
//

import Foundation
import UIKit

class MovieDetailRouter: PresenterToRouterMovieDetailProtocol {
    
    static func createModule() -> MovieDetailViewController {
        let view = mainStoryboard.instantiateViewController(withIdentifier: "MovieDetailViewController") as! MovieDetailViewController
        
        let presenter: ViewToPresenterMovieDetailProtocol & InteractorToPresenterMovieDetailProtocol = MovieDetailPresenter()
        let interactor: PresenterToInteractorMovieDetailProtocol = MovieDetailInteractor()
        let router: PresenterToRouterMovieDetailProtocol = MovieDetailRouter()
        
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
}
