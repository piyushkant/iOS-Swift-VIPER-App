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
    
    func getMoviePoster(id: Int) -> UIImage? {
        let emptyImage = UIImage(named: "empty")
        
        guard let allPosterData: [PosterData] = self.interactor?.allPosterData else {return emptyImage}
        
        for posterData in allPosterData {
            if posterData.id == id {
                return UIImage(data: posterData.data)
            }
        }
        
        return emptyImage
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
