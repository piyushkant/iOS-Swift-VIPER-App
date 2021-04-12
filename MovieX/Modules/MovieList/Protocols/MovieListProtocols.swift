//
//  MovieListProtocols.swift
//  MovieX
//
//  Created by Piyush Kant on 2021/04/12.
//

import Foundation
import UIKit

protocol ViewToPresenterProtocol: class {
    var view: PresenterToViewProtocol? {get set}
    var interactor: PresenterToInteractorProtocol? {get set}
    var router: PresenterToRouterProtocol? {get set}
    func startFetchingMovieList(category: MovieListCategory, page: Int)
    func showMovieDetailsController(navigationController:UINavigationController)
}

protocol PresenterToViewProtocol: class {
    func showMovieList(movieArray:Array<Movie>)
    func showError()
}

protocol PresenterToRouterProtocol: class {
    static func createModule()-> MovieListViewController
    func pushToMovieDetailsScreen(navigationConroller:UINavigationController)
}

protocol PresenterToInteractorProtocol: class {
    var presenter:InteractorToPresenterProtocol? {get set}
    func fetchMovieList(category: MovieListCategory, page: Int)
}

protocol InteractorToPresenterProtocol: class {
    func noticeFetchedSuccess(movieArray:Array<Movie>)
    func noticeFetchFailed()
}
