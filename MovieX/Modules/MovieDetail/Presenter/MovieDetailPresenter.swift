//
//  MovieDetailPresenter.swift
//  MovieX
//
//  Created by Piyush Kant on 2021/04/13.
//

import Foundation
import UIKit

class MovieDetailPresenter: ViewToPresenterMovieDetailProtocol {

    var view: PresenterToViewMovieDetailProtocol?
    
    var interactor: PresenterToInteractorMovieDetailProtocol?
    
    var router: PresenterToRouterMovieDetailProtocol?
    
    func startFetchingMovieDetail(id: Int) {
        self.interactor?.fetchMovieDetail(id: id)
    }
}

extension MovieDetailPresenter: InteractorToPresenterMovieDetailProtocol {
    func noticeFetchedSuccess(detail: MovieDetail) {
        view?.showMovieDetail(detail: detail)
    }
    
    func noticeFetchFailed() {
        view?.showError()
    }
}
