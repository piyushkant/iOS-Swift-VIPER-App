//
//  MovieListPresenter.swift
//  MovieX
//
//  Created by Piyush Kant on 2021/04/12.
//

import Foundation
import UIKit

class MovieListPresenter: ViewToPresenterProtocol {
    var view: PresenterToViewProtocol?
    
    var interactor: PresenterToInteractorProtocol?
    
    var router: PresenterToRouterProtocol?
    
    func startFetchingMovieList(category: MovieListCategory, page: Int) {
        self.interactor?.fetchMovieList(category: category, page: page)
    }
    
    func showMovieDetailsController(navigationController: UINavigationController) {
        self.router?.pushToMovieDetailsScreen(navigationConroller: navigationController)
    }
}

extension MovieListPresenter: InteractorToPresenterProtocol {
  
    func noticeFetchedSuccess(movieArray: Array<Movie>) {
        view?.showMovieList(movieArray: movieArray)
    }
    
    func noticeFetchFailed() {
        view?.showError()
    }
}
