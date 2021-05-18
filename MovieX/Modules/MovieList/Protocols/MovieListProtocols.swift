//
//  MovieListProtocols.swift
//  MovieX
//
//  Created by Piyush Kant on 2021/04/12.
//

import Foundation
import UIKit
import RealmSwift

protocol ViewToPresenterMovieListProtocol: class {
    var view: PresenterToViewMovieListProtocol? {get set}
    var interactor: PresenterToInteractorMovieListProtocol? {get set}
    var router: PresenterToRouterMovieListProtocol? {get set}
    func startFetchingMovieList(category: MovieListCategory, page: Int)
    func save(movie: Movie)
    func remove(movie: Movie)
    func showMovieDetailsController(navigationController:UINavigationController)
}

protocol PresenterToViewMovieListProtocol: class {
    func showMovieList(movieArray:Array<Movie>, isModified: Bool)
    func showError()
}

protocol PresenterToRouterMovieListProtocol: class {
    static func createModule()-> MovieListViewController
    func pushToMovieDetailsScreen(navigationConroller:UINavigationController)
}

protocol PresenterToInteractorMovieListProtocol: class {
    var presenter:InteractorToPresenterMovieListProtocol? {get set}
    func fetchMovieList(category: MovieListCategory, page: Int)
    func storeMovieToDb(movie: Movie)
    func removeMovieFromDb(movie: Movie)
}

protocol InteractorToPresenterMovieListProtocol: class {
    func noticeFetchedSuccess(movieArray:Array<Movie>, isModified: Bool)
    func noticeFetchFailed()
}
