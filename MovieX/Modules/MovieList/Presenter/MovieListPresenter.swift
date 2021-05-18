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
    
    func save(movie: Movie) {
        self.interactor?.storeMovieToDb(movie: movie)
    }
    
    func remove(movie: Movie) {
        self.interactor?.removeMovieFromDb(movie: movie)
    }
}

extension MovieListPresenter: InteractorToPresenterMovieListProtocol {
    func noticeFetchedSuccess(movieArray: Array<Movie>, isModified: Bool) {
        view?.showMovieList(movieArray: movieArray, isModified: isModified)
    }
    
    func noticeFetchFailed() {
        view?.showError()
    }
}
