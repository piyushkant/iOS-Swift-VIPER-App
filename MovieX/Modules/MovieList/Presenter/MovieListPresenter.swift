//
//  MovieListPresenter.swift
//  MovieX
//
//  Created by Piyush Kant on 2021/04/12.
//

import Foundation
import UIKit

class MovieListPresenter: ViewToPresenterMovieListProtocol {
    var view: PresenterToViewMovieListProtocol?
    
    var interactor: PresenterToInteractorMovieListProtocol?
    
    var router: PresenterToRouterMovieListProtocol?
        
    func startFetchingMovieList(category: MovieListCategory, page: Int) {
        self.interactor?.fetchMovieList(category: category, page: page)
    }
    
    func showMovieDetailsController(navigationController: UINavigationController) {
        self.router?.pushToMovieDetailsScreen(navigationConroller: navigationController)
    }
}

extension MovieListPresenter: InteractorToPresenterMovieListProtocol {
    func noticeFetchedSuccess(movieArray: Array<Movie>) {
        view?.showMovieList(movieArray: movieArray)
    }
    
    func noticeFetchFailed() {
        view?.showError()
    }
}
